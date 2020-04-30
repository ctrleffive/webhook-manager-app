import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/models/sync.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/notification.dart';

class SyncService {
  final NotificationService _notfictnSrv = NotificationService();
  final OutgoingService _outgoingSrv = OutgoingService();
  final IncomingService _incomingSrv = IncomingService();

  Future<void> init({bool repeat = false}) async {
    try {
      await this._fetchLocal();
      this._serverSync();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchLocal() async {
    try {
      StreamsService.notfcatns.sink.add(await this._notfictnSrv.all);
      StreamsService.outgoings.sink.add(await this._outgoingSrv.all);
      StreamsService.incomings.sink.add(await this._incomingSrv.all);
    } catch (e) {
      rethrow;
    }
  }

  Future<DateTime> get lastSync async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final String lastSync = preferences.getString('lastSync');
      return DateTime.parse(lastSync ?? "1996-00-00");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setLastSync(DateTime lastSync) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('lastSync', lastSync.toUtc()?.toIso8601String());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearDeleted() async {
    try {
      await this._notfictnSrv.clearDeleted();
      await this._outgoingSrv.clearDeleted();
      await this._incomingSrv.clearDeleted();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _serverSync() async {
    try {
      StreamsService.syncState.sink.add(true);
      final AuthService _authService = AuthService();
      final SyncSendingData data = SyncSendingData(
        idToken: await _authService.token,
        lastSync: await this.lastSync,
        incomings: await this._incomingSrv.mutated,
        outgoings: await this._outgoingSrv.mutated,
        notifications: await this._notfictnSrv.deleted,
      );
      final Response apiResponse = await post(
        '${KeysConstant.api}/sync',
        body: data.toJson(),
      );
      final SyncReceivedData responseData =
          SyncReceivedData.fromJson(apiResponse.body);
      await this._notfictnSrv.addMany(responseData.notifications);
      await this._outgoingSrv.updateMany(responseData.outgoings);
      await this._incomingSrv.updateMany(responseData.incomings);
      await this.setLastSync(responseData.syncTime);
      await this.clearDeleted();
      await this._fetchLocal();
    } catch (e) {
      rethrow;
    } finally {
      StreamsService.syncState.sink.add(false);
    }
  }
}

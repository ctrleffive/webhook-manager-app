import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';
import 'package:webhook_manager/src/models/sync.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/notification.dart';

class SyncService {
  final NotificationService _notificationService = NotificationService();
  final OutgoingService _outgoingService = OutgoingService();
  final IncomingService _incomingService = IncomingService();

  Future<void> init() async {
    try {
      StreamsService.syncState.sink.add(true);

      await this._serverSync();

      final List<NotificationData> allNotifications =
          await this._notificationService.all;
      StreamsService.notifications.sink.add(allNotifications);

      final List<OutgoingData> allOutgoings = await this._outgoingService.all;
      StreamsService.outgoings.sink.add(allOutgoings);

      final List<IncomingData> allIncomings = await this._incomingService.all;
      StreamsService.incomings.sink.add(allIncomings);
    } catch (e) {
      rethrow;
    } finally {
      StreamsService.syncState.sink.add(false);
    }
  }

  Future<DateTime> get lastSync async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int lastSync = preferences.getInt('lastSync');
    return DateTime.fromMillisecondsSinceEpoch(lastSync ?? 0);
  }

  Future<void> setLastSync(DateTime lastSync) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('lastSync', lastSync.millisecondsSinceEpoch);
  }

  Future<void> _serverSync() async {
    try {
      final AuthService _authService = AuthService();
      final SyncSendingData data = SyncSendingData(
        idToken: await _authService.token,
        lastSync: await this.lastSync,
        incomings: await this._incomingService.mutated,
        outgoings: await this._outgoingService.mutated,
        notifications: await this._notificationService.deleted,
      );
      final Response apiResponse = await post(
        '${KeysConstant.api}/sync',
        body: data.toJson(),
      );
      final SyncReceivedData responseData = SyncReceivedData.fromJson(apiResponse.body);
      await this.setLastSync(responseData.syncTime);
      await this._notificationService.addMany(responseData.notifications);
      await this._outgoingService.updateMany(responseData.outgoings);
      await this._incomingService.updateMany(responseData.incomings);
      return;
    } catch (e) {
      rethrow;
    }
  }
}

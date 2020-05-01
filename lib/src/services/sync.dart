import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webhook_manager/src/constants/keys.dart';
import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/notification.dart';
import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/models/sync.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/database.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/notification.dart';

class SyncService {
  final DBService _dbService = DBService();
  final NotificationService _notfictnSrv = NotificationService();
  final OutgoingService _outgoingSrv = OutgoingService();
  final IncomingService _incomingSrv = IncomingService();

  Future<void> init({bool noSync = false}) async {
    try {
      await this._fetchLocal();
      if (!noSync) this._serverSync();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchLocal() async {
    try {
      StreamsService.notfcatns.sink.add(await this._notfictnSrv.all());
      StreamsService.outgoings.sink.add(await this._outgoingSrv.all());
      StreamsService.incomings.sink.add(await this._incomingSrv.all());
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

  Future<void> clearAll() async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(OutgoingData.tableName);
      await dbClient.delete(IncomingData.tableName);
      await dbClient.delete(NotificationData.tableName);
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _serverSync() async {
    if (StreamsService.syncState.value) {
      await Future.delayed(Duration(seconds: 2));
      return await this._serverSync();
    }
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
      await this._outgoingSrv.updateMany(
            responseData.outgoings,
            fromSync: true,
          );
      await this._incomingSrv.updateMany(
            responseData.incomings,
            fromSync: true,
          );
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

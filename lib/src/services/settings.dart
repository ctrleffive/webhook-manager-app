import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/database.dart';

class SettingsService {
  final DBService _dbService = DBService();
  final SyncService _syncService = SyncService();

  Future<void> clearDb() async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(OutgoingData.tableName);
      await dbClient.delete(IncomingData.tableName);
      await dbClient.delete(NotificationData.tableName);
      await this._syncService.init();
    } catch (e) {
      rethrow;
    }
  }
}

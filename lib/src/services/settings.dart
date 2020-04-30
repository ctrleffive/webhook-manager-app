import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/database.dart';

class SettingsService {
  final DBService _dbService = DBService();
  final SyncService _syncService = SyncService();

  Future<void> clearDb() async {
    try {
      StreamsService.loaderState.sink.add(true);
      final Database dbClient = await this._dbService.db;
      await dbClient.update(OutgoingData.tableName, {'deleted': 1});
      await dbClient.update(IncomingData.tableName, {'deleted': 1});
      await dbClient.update(NotificationData.tableName, {'deleted': 1});
      StreamsService.loaderState.sink.add(false);
      await this._syncService.init();
    } catch (e) {
      rethrow;
    }
  }
}

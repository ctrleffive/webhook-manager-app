import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/database.dart';
import 'package:webhook_manager/src/services/streams.dart';

class NotificationService {
  final DBService _dbService = DBService();

  Future<List<NotificationData>> get all async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        NotificationData.tableName,
        where: 'deleted = ?',
        whereArgs: [0],
      );
      final List<NotificationData> listData = queryData.map((Map item) {
        return NotificationData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NotificationData>> get deleted async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        NotificationData.tableName,
        where: 'deleted = ?',
        whereArgs: [1],
      );
      final List<NotificationData> listData = queryData.map((Map item) {
        return NotificationData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(NotificationData data) async {
    try {
      data.deleted = true;
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(
        NotificationData.tableName,
        where: 'id = ?',
        whereArgs: [data.id],
      );
      StreamsService.notifications.sink.add(await this.all);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearDeleted() async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(
        NotificationData.tableName,
        where: 'deleted = ?',
        whereArgs: [1],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMany(List<NotificationData> data) async {
    try {
      final Database dbClient = await this._dbService.db;
      final Batch batch = dbClient.batch();

      for (final NotificationData item in data) {
        batch.insert(NotificationData.tableName, item.toMap());
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}

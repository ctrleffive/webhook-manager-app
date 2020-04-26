import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/database.dart';

class NotificationService {
  final DBService _dbService = DBService();

  Future<List<NotificationData>> get all async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        NotificationData.tableName,
      );
      final List<NotificationData> listData = queryData.map((Map item) {
        return NotificationData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }
}

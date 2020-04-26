import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/database.dart';

class OutgoingService {
  final DBService _dbService = DBService();

  Future<List<OutgoingData>> get all async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        OutgoingData.tableName,
      );
      final List<OutgoingData> listData = queryData.map((Map item) {
        return OutgoingData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }
}
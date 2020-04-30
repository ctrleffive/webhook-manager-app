import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/services/database.dart';
import 'package:webhook_manager/src/services/sync.dart';

class IncomingService {
  final DBService _dbService = DBService();

  Future<List<IncomingData>> get all async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        IncomingData.tableName,
      );
      final List<IncomingData> listData = queryData.map((Map item) {
        return IncomingData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }

  Future<List<IncomingData>> get mutated async {
    try {
      final SyncService _syncService = SyncService();
      final DateTime lastSync = await _syncService.lastSync;
      final List<IncomingData> listData = (await this.all).where((IncomingData item) {
        return item.updatedAt.isAfter(lastSync);
      }).toList();
      return listData;
    } catch (e) {
      return [];
    }
  }
}
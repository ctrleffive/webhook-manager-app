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
      rethrow;
    }
  }

  Future<List<IncomingData>> get mutated async {
    try {
      final SyncService _syncService = SyncService();
      final DateTime lastSync = await _syncService.lastSync;
      final List<IncomingData> listData =
          (await this.all).where((IncomingData item) {
        return item.updatedAt.isAfter(lastSync);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMany(List<IncomingData> data) async {
    try {
      final List<IncomingData> allData = await this.all;

      final Database dbClient = await this._dbService.db;
      final Batch batch = dbClient.batch();

      for (final IncomingData item in data) {
        final IncomingData existingItem = allData.firstWhere(
          (toCheck) => item.id == toCheck.id,
          orElse: () => null,
        );

        if (existingItem != null) {
          batch.update(
            IncomingData.tableName,
            item.toMap(),
            where: 'id = ?',
            whereArgs: [item.id],
          );
        } else {
          batch.insert(IncomingData.tableName, item.toMap());
        }
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}

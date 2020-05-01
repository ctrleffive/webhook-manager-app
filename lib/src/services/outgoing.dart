import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/constants/enums.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/database.dart';

class OutgoingService {
  final DBService _dbService = DBService();

  Future<List<OutgoingData>> all({bool all: false}) async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        OutgoingData.tableName,
        where: all ? null : 'deleted = ?',
        whereArgs: all ? null : [0],
      );
      final List<OutgoingData> listData = queryData.map((Map item) {
        return OutgoingData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(OutgoingData data) async {
    try {
      data.deleted = true;
      await this.updateMany([data]);
      final SyncService _syncService = SyncService();
      _syncService.init();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearDeleted() async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(
        OutgoingData.tableName,
        where: 'deleted = ?',
        whereArgs: [1],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OutgoingData>> get mutated async {
    try {
      final SyncService _syncService = SyncService();
      final DateTime lastSync = await _syncService.lastSync;
      final List<OutgoingData> listData =
          (await this.all(all: true)).where((OutgoingData item) {
        return item.updatedAt.isAfter(lastSync);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(OutgoingData data) async {
    try {
      await this.updateMany([data]);
      final SyncService _syncService = SyncService();
      _syncService.init();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMany(
    List<OutgoingData> data, {
    bool fromSync = false,
  }) async {
    try {
      final List<OutgoingData> allData = await this.all(all: true);

      final Database dbClient = await this._dbService.db;
      final Batch batch = dbClient.batch();

      for (final OutgoingData item in data) {
        final OutgoingData existingItem = allData.firstWhere(
          (toCheck) => item.eventName == toCheck.eventName,
          orElse: () => null,
        );

        if (!fromSync) item.updatedAt = DateTime.now();
        if (existingItem != null) {
          batch.update(
            OutgoingData.tableName,
            item.toMap(),
            where: 'eventName = ?',
            whereArgs: [item.eventName],
          );
        } else {
          batch.insert(OutgoingData.tableName, item.toMap());
        }
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> excecute(OutgoingData data) async {
    try {
      switch (data.method) {
        case RequestMethod.get:
          await http.get(data.url, headers: json.decode(data.headers));
          break;
        default:
          throw Exception('Invalid method!');
      }
    } catch (e) {
      rethrow;
    }
  }
}

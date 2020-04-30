import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/constants/enums.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/database.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/sync.dart';

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
      rethrow;
    }
  }

  Future<void> addNew(OutgoingData data) async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.insert(OutgoingData.tableName, data.toMap());
      StreamsService.outgoings.sink.add(await this.all);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateExisting(OutgoingData data) async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.update(
        OutgoingData.tableName,
        data.toMap(),
        where: 'id = ?',
        whereArgs: [data.id],
      );
      StreamsService.outgoings.sink.add(await this.all);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(
        OutgoingData.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      StreamsService.outgoings.sink.add(await this.all);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OutgoingData>> get mutated async {
    try {
      final SyncService _syncService = SyncService();
      final DateTime lastSync = await _syncService.lastSync;
      final List<OutgoingData> listData = (await this.all).where((OutgoingData item) {
        return item.updatedAt.isAfter(lastSync);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMany(List<OutgoingData> data) async {
    try {
      final List<OutgoingData> allData = await this.all;

      final Database dbClient = await this._dbService.db;
      final Batch batch = dbClient.batch();

      for (final OutgoingData item in data) {
        final OutgoingData existingItem = allData.firstWhere(
          (toCheck) => item.id == toCheck.id,
          orElse: () => null,
        );

        if (existingItem != null) {
          batch.update(
            OutgoingData.tableName,
            item.toMap(),
            where: 'id = ?',
            whereArgs: [item.id],
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

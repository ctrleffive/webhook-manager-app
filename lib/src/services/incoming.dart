import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/database.dart';

class IncomingService {
  final DBService _dbService = DBService();

  Future<List<IncomingData>> all({bool all: false}) async {
    try {
      final Database dbClient = await this._dbService.db;
      final List<Map> queryData = await dbClient.query(
        IncomingData.tableName,
        where: all ? null : 'deleted = ?',
        whereArgs: all ? null : [0],
      );
      final List<IncomingData> listData = queryData.map((Map item) {
        return IncomingData.fromMap(item);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(IncomingData data) async {
    try {
      data.deleted = true;
      await this.updateMany([data]);
      StreamsService.incomings.sink.add(await this.all(all: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearDeleted() async {
    try {
      final Database dbClient = await this._dbService.db;
      await dbClient.delete(
        IncomingData.tableName,
        where: 'deleted = ?',
        whereArgs: [1],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IncomingData>> get mutated async {
    try {
      final SyncService _syncService = SyncService();
      final DateTime lastSync = await _syncService.lastSync;
      final List<IncomingData> listData =
          (await this.all(all: true)).where((IncomingData item) {
        return item.updatedAt.isAfter(lastSync);
      }).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(IncomingData data) async {
    try {
      await this.updateMany([data]);
      final SyncService _syncService = SyncService();
      _syncService.init();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMany(
    List<IncomingData> data, {
    bool fromSync = false,
  }) async {
    try {
      final List<IncomingData> allData = await this.all(all: true);

      final Database dbClient = await this._dbService.db;
      final Batch batch = dbClient.batch();

      for (final IncomingData item in data) {
        final IncomingData existingItem = allData.firstWhere(
          (toCheck) => item.eventName == toCheck.eventName,
          orElse: () => null,
        );

        if (!fromSync) item.updatedAt = DateTime.now();
        if (existingItem != null) {
          batch.update(
            IncomingData.tableName,
            item.toMap(),
            where: 'eventName = ?',
            whereArgs: [item.eventName],
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

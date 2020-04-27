import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/database.dart';
import 'package:webhook_manager/src/services/streams.dart';

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
      return [];
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

  Future<void> deleteItem(int id) async {
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
}

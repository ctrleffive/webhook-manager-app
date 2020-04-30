import 'dart:convert';

import 'package:webhook_manager/src/constants/enums.dart';

class NotificationData {
  String id;
  String eventName;
  String payload;
  bool deleted;
  String headers;
  DateTime createdAt;
  RequestMethod method;

  NotificationData({
    this.id,
    this.deleted = false,
    this.eventName,
    this.headers,
    this.payload,
    this.createdAt,
    this.method,
  });

  static const String tableName = 'notification';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      _id         INTEGER PRIMARY KEY,
      id          TEXT,
      method      TEXT,
      headers     TEXT,
      deleted     INTEGER,
      payload     TEXT,
      eventName   TEXT,
      createdAt   TEXT
    )
  ''';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'headers': headers,
      'payload': payload,
      'deleted': deleted ? 1 : 0,
      'createdAt': createdAt?.toUtc()?.toIso8601String(),
      'method': method.index,
    };
  }

  static NotificationData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return NotificationData(
      id: map['id'],
      eventName: map['eventName'],
      headers: map['headers'],
      payload: map['payload'],
      deleted: map['deleted'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      method: RequestMethod.values[int.parse('${map['method']}')],
    );
  }

  String toJson() => json.encode(toMap());

  static NotificationData fromJson(String source) => fromMap(json.decode(source));
}

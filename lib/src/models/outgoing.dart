import 'dart:convert';

import 'package:webhook_manager/src/constants/enums.dart';

class OutgoingData {
  String id;
  String eventName;
  String payload;
  String headers;
  String url;
  bool deleted;
  DateTime updatedAt;
  RequestMethod method;
  
  OutgoingData({
    this.id,
    this.eventName,
    this.payload,
    this.updatedAt,
    this.deleted = false,
    this.headers,
    this.url,
    this.method,
  });

  static const String tableName = 'outgoing';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      _id           INTEGER PRIMARY KEY,
      id            TEXT,
      url           TEXT,
      deleted       INTEGER,
      updatedAt     TEXT,
      method        TEXT,
      payload       TEXT,
      headers       TEXT,
      eventName     TEXT
    )
  ''';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'payload': payload,
      'headers': headers,
      'updatedAt': updatedAt?.toUtc()?.toIso8601String(),
      'deleted': deleted ? 1 : 0,
      'url': url,
      'method': method.index,
    };
  }

  static OutgoingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OutgoingData(
      id: map['id'],
      eventName: map['eventName'],
      payload: map['payload'],
      headers: map['headers'],
      deleted: map['deleted'] == 1,
      url: map['url'],
      updatedAt: DateTime.parse(map['updatedAt']),
      method: RequestMethod.values[int.parse('${map['method']}')],
    );
  }

  String toJson() => json.encode(toMap());

  static OutgoingData fromJson(String source) => fromMap(json.decode(source));
}

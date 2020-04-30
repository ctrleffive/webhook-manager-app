import 'dart:convert';

import 'package:webhook_manager/src/constants/enums.dart';

class OutgoingData {
  int id;
  String eventName;
  String payload;
  String headers;
  String url;
  bool deleted;
  RequestMethod method;
  
  OutgoingData({
    this.id,
    this.eventName,
    this.payload,
    this.deleted = false,
    this.headers,
    this.url,
    this.method,
  });

  static const String tableName = 'outgoing';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      id            INTEGER PRIMARY KEY,
      url           TEXT,
      deleted       INTEGER,
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
      'deleted': deleted ? 1 : 0,
      'url': url,
      'method': method.index,
    };
  }

  static OutgoingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OutgoingData(
      id: int.parse('${map['id']}'),
      eventName: map['eventName'],
      payload: map['payload'],
      headers: map['headers'],
      deleted: map['deleted'] == 1,
      url: map['url'],
      method: RequestMethod.values[int.parse('${map['method']}')],
    );
  }

  String toJson() => json.encode(toMap());

  static OutgoingData fromJson(String source) => fromMap(json.decode(source));
}

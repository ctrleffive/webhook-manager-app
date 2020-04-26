import 'dart:convert';

import 'package:webhook_manager/src/constants/enums.dart';

class OutgoingData {
  int id;
  String eventName;
  String payload;
  String url;
  RequestMethod method;
  
  OutgoingData({
    this.id,
    this.eventName,
    this.payload,
    this.url,
    this.method,
  });

  static const String tableName = 'outgoing';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      id            INTEGER PRIMARY KEY,
      url           TEXT,
      method        TEXT,
      payload       TEXT,
      eventName     TEXT
    )
  ''';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'payload': payload,
      'payload': url,
      'method': method.index,
    };
  }

  static OutgoingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OutgoingData(
      id: map['id'],
      eventName: map['eventName'],
      payload: map['payload'],
      url: map['url'],
      method: RequestMethod.values[map['method']],
    );
  }

  String toJson() => json.encode(toMap());

  static OutgoingData fromJson(String source) => fromMap(json.decode(source));
}

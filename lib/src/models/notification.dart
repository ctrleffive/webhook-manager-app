import 'dart:convert';

import 'package:webhook_manager/src/constants/enums.dart';

class NotificationData {
  int id;
  String eventName;
  String payload;
  String headers;
  DateTime receivedTime;
  RequestMethod method;

  NotificationData({
    this.id,
    this.eventName,
    this.headers,
    this.payload,
    this.receivedTime,
    this.method,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'headers': headers,
      'payload': payload,
      'receivedTime': receivedTime?.millisecondsSinceEpoch,
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
      receivedTime: DateTime.fromMillisecondsSinceEpoch(map['receivedTime']),
      method: RequestMethod.values[map['method']],
    );
  }

  String toJson() => json.encode(toMap());

  static NotificationData fromJson(String source) => fromMap(json.decode(source));
}

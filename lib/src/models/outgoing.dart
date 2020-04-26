import 'dart:convert';
import 'dart:ui';

import 'package:webhook_manager/src/constants/enums.dart';

class OutgoingData {
  int id;
  Color color;
  String eventName;
  String payload;
  String url;
  RequestMethod method;
  
  OutgoingData({
    this.id,
    this.color,
    this.eventName,
    this.payload,
    this.url,
    this.method,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color?.value,
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
      color: Color(map['color']),
      eventName: map['eventName'],
      payload: map['payload'],
      url: map['url'],
      method: RequestMethod.values[map['method']],
    );
  }

  String toJson() => json.encode(toMap());

  static OutgoingData fromJson(String source) => fromMap(json.decode(source));
}

import 'dart:convert';
import 'dart:ui';

enum RequestMethod {
  get,
  put,
  post,
  patch,
  delete,
  option,
}

class NotificationData {
  Color color;
  String eventName;
  String payload;
  DateTime receivedTime;
  RequestMethod method;

  NotificationData({
    this.color,
    this.eventName,
    this.payload,
    this.receivedTime,
    this.method,
  });

  NotificationData copyWith({
    Color color,
    String eventName,
    String payload,
    DateTime receivedTime,
    RequestMethod method,
  }) {
    return NotificationData(
      color: color ?? this.color,
      eventName: eventName ?? this.eventName,
      payload: payload ?? this.payload,
      receivedTime: receivedTime ?? this.receivedTime,
      method: method ?? this.method,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'eventName': eventName,
      'payload': payload,
      'receivedTime': receivedTime.millisecondsSinceEpoch,
      'method': method.index,
    };
  }

  static NotificationData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return NotificationData(
      color: Color(map['color']),
      eventName: map['eventName'],
      payload: map['payload'],
      receivedTime: DateTime.fromMillisecondsSinceEpoch(map['receivedTime']),
      method: RequestMethod.values[map['method']],
    );
  }

  String toJson() => json.encode(toMap());

  static NotificationData fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is NotificationData &&
      o.color == color &&
      o.eventName == eventName &&
      o.payload == payload &&
      o.receivedTime == receivedTime &&
      o.method == method;
  }

  @override
  int get hashCode {
    return color.hashCode ^
      eventName.hashCode ^
      payload.hashCode ^
      receivedTime.hashCode ^
      method.hashCode;
  }
}

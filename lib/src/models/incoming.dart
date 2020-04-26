import 'dart:convert';

class IncomingData {
  int id;
  String eventName;
  IncomingData({
    this.id,
    this.eventName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
    };
  }

  static IncomingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return IncomingData(
      id: map['id'],
      eventName: map['eventName'],
    );
  }

  String toJson() => json.encode(toMap());

  static IncomingData fromJson(String source) => fromMap(json.decode(source));
}

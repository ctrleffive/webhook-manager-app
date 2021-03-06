import 'dart:convert';

class IncomingData {
  String id;
  bool deleted;
  String eventName;
  String hookId;
  DateTime updatedAt;
  IncomingData({
    this.id,
    this.deleted = false,
    this.hookId,
    this.eventName,
    this.updatedAt,
  });

  static const String tableName = 'incoming';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      _id           INTEGER PRIMARY KEY,
      id            TEXT,
      hookId        TEXT,
      updatedAt     TEXT,
      deleted       INTEGER,
      eventName     TEXT
    )
  ''';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deleted': deleted ? 1 : 0,
      'hookId': hookId,
      'eventName': eventName,
      'updatedAt': updatedAt?.toUtc()?.toIso8601String(),
    };
  }

  static IncomingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return IncomingData(
      id: map['id'],
      deleted: map['deleted'] == 1,
      hookId: map['hookId'],
      eventName: map['eventName'],
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  static IncomingData fromJson(String source) => fromMap(json.decode(source));
}

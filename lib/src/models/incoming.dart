import 'dart:convert';

class IncomingData {
  int id;
  bool deleted;
  String eventName;
  IncomingData({
    this.id,
    this.deleted = false,
    this.eventName,
  });

  static const String tableName = 'incoming';
  static const String tableSchema = '''
    CREATE TABLE $tableName (
      id            INTEGER PRIMARY KEY,
      deleted       INTEGER,
      eventName     TEXT
    )
  ''';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deleted': deleted ? 1 : 0,
      'eventName': eventName,
    };
  }

  static IncomingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return IncomingData(
      id: int.parse('${map['id']}'),
      deleted: map['deleted'] == 1,
      eventName: map['eventName'],
    );
  }

  String toJson() => json.encode(toMap());

  static IncomingData fromJson(String source) => fromMap(json.decode(source));
}

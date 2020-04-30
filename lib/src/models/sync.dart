import 'dart:convert';

import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/notification.dart';
import 'package:webhook_manager/src/models/outgoing.dart';

class SyncSendingData {
  String idToken;
  DateTime lastSync;
  List<OutgoingData> outgoings;
  List<IncomingData> incomings;
  List<NotificationData> notifications;
  SyncSendingData({
    this.idToken,
    this.lastSync,
    this.outgoings,
    this.incomings,
    this.notifications,
  });

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
      'lastSync': lastSync?.millisecondsSinceEpoch,
      'outgoings': outgoings?.map((x) => x?.toMap())?.toList(),
      'incomings': incomings?.map((x) => x?.toMap())?.toList(),
      'notifications': notifications?.map((x) => x?.toMap())?.toList(),
    };
  }

  static SyncSendingData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SyncSendingData(
      idToken: map['idToken'],
      lastSync: DateTime.fromMillisecondsSinceEpoch(map['lastSync']),
      outgoings: List<OutgoingData>.from(map['outgoings']?.map((x) => OutgoingData.fromMap(x))),
      incomings: List<IncomingData>.from(map['incomings']?.map((x) => IncomingData.fromMap(x))),
      notifications: List<NotificationData>.from(map['notifications']?.map((x) => NotificationData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static SyncSendingData fromJson(String source) => fromMap(json.decode(source));
}

class SyncReceivedData {
  DateTime syncTime;
  List<OutgoingData> outgoings;
  List<IncomingData> incomings;
  List<NotificationData> notifications;
  SyncReceivedData({
    this.syncTime,
    this.outgoings,
    this.incomings,
    this.notifications,
  });

  Map<String, dynamic> toMap() {
    return {
      'syncTime': syncTime?.millisecondsSinceEpoch,
      'outgoings': outgoings?.map((x) => x?.toMap())?.toList(),
      'incomings': incomings?.map((x) => x?.toMap())?.toList(),
      'notifications': notifications?.map((x) => x?.toMap())?.toList(),
    };
  }

  static SyncReceivedData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SyncReceivedData(
      syncTime: DateTime.fromMillisecondsSinceEpoch(map['syncTime']),
      outgoings: List<OutgoingData>.from(map['outgoings']?.map((x) => OutgoingData.fromMap(x))),
      incomings: List<IncomingData>.from(map['incomings']?.map((x) => IncomingData.fromMap(x))),
      notifications: List<NotificationData>.from(map['notifications']?.map((x) => NotificationData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static SyncReceivedData fromJson(String source) => fromMap(json.decode(source));
}

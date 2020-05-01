import 'dart:convert';

import 'package:http/http.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/streams.dart';

class FCMService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final AuthService _authService = AuthService();
  final SyncService _syncService = SyncService();

  Future<bool> _requestPermission() async {
    final bool permission = this._fcm.requestNotificationPermissions();
    return permission;
  }

  void _listenForFCM() {
    this._fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        final String data = message['data']['notification'];
        final NotificationData notificationData = NotificationData.fromJson(data);
        final List<NotificationData> itemList = StreamsService.notfcatns.value;
        itemList.insert(0, notificationData);
        StreamsService.notfcatns.sink.add(itemList);
      },
      onLaunch: (Map<String, dynamic> message) async {
        this._syncService.init();
      },
      onResume: (Map<String, dynamic> message) async {
        print('FCM onResume: $message');
      },
    );
  }

  Future<void> register() async {
    try {
      await this._requestPermission();
      final String deviceId = await this._fcm.getToken();
      final Response apiResponse = await post(
        '${KeysConstant.api}/registration',
        body: json.encode({
          'token': deviceId,
          'idToken': await this._authService.token,
        }),
      );
      print('Device registered with ID: $deviceId');
      if (apiResponse.statusCode != 200) throw Exception();
      this._listenForFCM();
    } catch (e) {
      rethrow;
    }
  }
}

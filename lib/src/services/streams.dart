import 'package:rxdart/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';

class StreamsService {
  static final BehaviorSubject<bool> loaderState = BehaviorSubject<bool>.seeded(true);
  static final BehaviorSubject<bool> syncState = BehaviorSubject<bool>.seeded(false);
  static final BehaviorSubject<FirebaseUser> sessionUser = BehaviorSubject<FirebaseUser>();

  static final BehaviorSubject<List<NotificationData>> notifications = BehaviorSubject<List<NotificationData>>.seeded([]);
  static final BehaviorSubject<List<OutgoingData>> outgoings = BehaviorSubject<List<OutgoingData>>.seeded([]);
  static final BehaviorSubject<List<IncomingData>> incomings = BehaviorSubject<List<IncomingData>>.seeded([]);

  static void dispose() {
    outgoings?.close();
    incomings?.close();
    syncState?.close();
    loaderState?.close();
    sessionUser?.close();
    notifications?.close();
  }
}

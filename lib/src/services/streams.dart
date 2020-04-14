import 'package:rxdart/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreamsService {
  static final BehaviorSubject<bool> loaderState = BehaviorSubject<bool>.seeded(true);
  static final BehaviorSubject<FirebaseUser> sessionUser = BehaviorSubject<FirebaseUser>();

  static void dispose() {
    loaderState?.close();
    sessionUser?.close();
  }
}

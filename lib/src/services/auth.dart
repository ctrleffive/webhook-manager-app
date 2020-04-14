import 'package:firebase_auth/firebase_auth.dart';

import 'package:webhook_manager/src/services/streams.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> get session async {
    final FirebaseUser user = await this._firebaseAuth.currentUser();
    StreamsService.sessionUser.sink.add(user);
    return user != null;
  }  
}
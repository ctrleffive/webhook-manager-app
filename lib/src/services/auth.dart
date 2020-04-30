import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:webhook_manager/src/models/user.dart';

import 'package:webhook_manager/src/services/streams.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> get session async {
    final FirebaseUser user = await this._firebaseAuth.currentUser();
    StreamsService.sessionUser.sink.add(user);
    return user != null;
  }

  Future<String> get token async {
    final FirebaseUser user = await this._firebaseAuth.currentUser();
    final IdTokenResult idTokenResult = await user.getIdToken();
    final String token = idTokenResult.token;
    debugPrint('Token: $token');
    return token;
  }

  Future<void> signOut() async {
    try {
      await this._firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Login failed!');
    }
  }

  Future<void> emailLogin(UserData user) async {
    try {
      await this._firebaseAuth.signInWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
      await this.session;
    } catch (e) {
      throw Exception('Email login failed!');
    }
  }

  Future<void> emailSignup(UserData user) async {
    try {
      await this._firebaseAuth.createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
      final FirebaseUser currentUser = await this._firebaseAuth.currentUser();
      final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = user.name;
      await currentUser.updateProfile(userUpdateInfo);
      await this.session;
    } catch (e) {
      throw Exception('Signup failed!');
    }
  }

  Future<void> guestLogin() async {
    try {
      await this._firebaseAuth.signInAnonymously();
      await this.session;
    } catch (e) {
      throw Exception('Guest login failed!');
    }
  }
}

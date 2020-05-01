import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/gravatar.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/welcome.dart';

import 'package:webhook_manager/src/views/components/button.dart';

class SettingsPage extends StatelessWidget {
  final AuthService _authService = AuthService();
  final SyncService _syncService = SyncService();

  Future<void> _signOut(BuildContext context) async {
    await this._authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => WelcomePage(),
      ),
      (_) => false,
    );
  }

  Future<void> _reload(BuildContext context) async {
    await this._syncService.clearAll();
    this._syncService.init();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser sessionData = StreamsService.sessionUser.value;
    final String gravatarUrl = GravatarService.getImageUrl(sessionData.email);

    return PageWrap(
      icon: Icons.settings,
      title: 'Settings',
      isCentered: true,
      noLoader: true,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: gravatarUrl == null
                ? Colors.white10
                : StylesConstant.primaryColor,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white10,
                child: gravatarUrl == null
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black12,
                      )
                    : null,
                backgroundImage: gravatarUrl != null
                    ? CachedNetworkImageProvider(gravatarUrl)
                    : null,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            sessionData.isAnonymous ? 'Guest User' : sessionData.displayName,
            textScaleFactor: 1.5,
          ),
          Text(
            sessionData.isAnonymous ? 'Anonymous' : sessionData.email,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          Button(
            color: Colors.redAccent,
            label: 'Logout',
            isFlat: true,
            onTap: () => this._signOut(context),
          ),
          Button(
            isFlat: true,
            label: 'Reload Data',
            onTap: () => this._reload(context),
          ),
        ],
      ),
    );
  }
}

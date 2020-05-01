import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/sync.dart';

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
    return PageWrap(
      icon: Icons.settings,
      title: 'Settings',
      noLoader: true,
      syncNeeded: true,
      children: <Widget>[
        Button(
          isBlock: true,
          label: 'Logout',
          onTap: () => this._signOut(context),
        ),
        Button(
          isBlock: true,
          color: Colors.redAccent,
          label: 'Reload Data',
          onTap: () => this._reload(context),
        ),
      ],
    );
  }
}
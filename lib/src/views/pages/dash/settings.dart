import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/views/components/button.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/welcome.dart';

class SettingsPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> _signOut(BuildContext context) async {
    await this._authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => WelcomePage(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      isCentered: false,
      icon: Icons.settings,
      title: 'Settings',
      noLoader: true,
      children: <Widget>[
        Button(
          isBlock: true,
          label: 'Logout',
          onTap: () => this._signOut(context),
        ),
      ],
    );
  }
}
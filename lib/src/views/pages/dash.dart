import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/auth.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/welcome.dart';

import 'package:webhook_manager/src/views/components/button.dart';

class DashPage extends StatelessWidget {
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
      title: 'Dash',
      isCentered: false,
      children: <Widget>[
        Button(
          label: 'Logout',
          onTap: () => this._signOut(context),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/welcome.dart';

import 'package:webhook_manager/src/views/components/button.dart';

class DashPage extends StatefulWidget {
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
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
  void initState() {
    StreamsService.loaderState.sink.add(false);
    super.initState();
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

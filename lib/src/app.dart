import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:catcher/core/catcher.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash.dart';
import 'package:webhook_manager/src/views/pages/welcome.dart';

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: StylesConstant.appTheme,
      navigatorKey: Catcher.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({
    Key key,
  }) : super(key: key);

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final AuthService _service = AuthService();

  Future<void> checkSession(Duration duration) async {
    final bool sessionStatus = await this._service.session;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => sessionStatus ? DashPage() : WelcomePage(),
      ),
      (_) => false,
    );
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(this.checkSession);
    super.initState();
  }

  @override
  void dispose() {
    StreamsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      children: <Widget>[
        SizedBox(),
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(),
      ],
    );
  }
}

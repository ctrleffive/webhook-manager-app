import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:catcher/core/catcher.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash.dart';
import 'package:webhook_manager/src/views/pages/welcome.dart';

class FlutterApp extends StatefulWidget {
  @override
  _FlutterAppState createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  @override
  void dispose() {
    StreamsService.dispose();
    super.dispose();
  }

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
  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final AuthService _service = AuthService();

  Future<void> checkSession(Duration duration) async {
    final bool sessionStatus = await this._service.session;
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return sessionStatus ? DashPage() : WelcomePage();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (_) => false,
    );
    StreamsService.loaderState.sink.add(false);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(this.checkSession);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap();
  }
}

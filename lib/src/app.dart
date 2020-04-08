import 'package:flutter/material.dart';

import 'package:catcher/core/catcher.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/pages/root.dart';

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
      navigatorObservers: [
        // FirebaseAnalyticsObserver(
        //   analytics: this._analytics,
        // ),
      ],
      home: RootPage(),
    );
  }
}

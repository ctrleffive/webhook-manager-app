/// Always sort imports like below format
///
/// 1.  Dart Packages
/// 2.  Flutter Packages
/// 3.  Third Party Packages
/// 4.  Constants
/// 5.  Models
/// 6.  Providers
/// 7.  Services
/// 8.  Layouts
/// 9.  Pages
/// 10. Components

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:sentry/sentry.dart';
import 'package:catcher/catcher_plugin.dart';

import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/app.dart';

void main() {
  /// I don't want to add Catcher & Sentry in debug mode.
  if (kReleaseMode) {
    final SentryClient sentryClient = SentryClient(dsn: KeysConstant.sentryDsn);

    Catcher(
      FlutterApp(),
      releaseConfig: CatcherOptions(
        SilentReportMode(),
        [SentryHandler(sentryClient)],
      ),
    );
  } else {
    runApp(FlutterApp());
  }
}

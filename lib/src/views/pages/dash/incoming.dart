import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class IncomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      isCentered: false,
      icon: Icons.cloud_download,
      title: 'Incoming',
      noLoader: true,
      children: <Widget>[],
    );
  }
}
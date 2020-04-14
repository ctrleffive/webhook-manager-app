import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class OutgoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      isCentered: false,
      icon: Icons.cloud_upload,
      title: 'Outgoing',
      children: <Widget>[],
    );
  }
}
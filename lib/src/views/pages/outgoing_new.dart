import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class OutgoingNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.cloud_download,
      title: 'Add New',
      noLoader: true,
      children: <Widget>[],
    );
  }
}
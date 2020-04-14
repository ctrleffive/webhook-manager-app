import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      isCentered: false,
      icon: Icons.notifications_active,
      title: 'Notifications',
      children: <Widget>[],
    );
  }
}
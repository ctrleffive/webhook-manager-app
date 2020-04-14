import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash/incoming.dart';
import 'package:webhook_manager/src/views/pages/dash/outgoing.dart';
import 'package:webhook_manager/src/views/pages/dash/settings.dart';
import 'package:webhook_manager/src/views/pages/dash/notifications.dart';

class DashPage extends StatefulWidget {
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  @override
  void initState() {
    StreamsService.loaderState.sink.add(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      pageView: PageView(
        children: <Widget>[
          NotificationsPage(),
          OutgoingPage(),
          IncomingPage(),
          SettingsPage(),
        ],
      ),
      bottomNav: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: StylesConstant.primaryColor,
        unselectedItemColor: StylesConstant.secondaryColor,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            title: Text('Outgoing'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            title: Text('Incoming'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}

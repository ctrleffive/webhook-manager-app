import 'package:flutter/material.dart';

import 'package:rxdart/subjects.dart';

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
  static const int initialPage = 0;
  final BehaviorSubject<int> _bottomNav =
      BehaviorSubject<int>.seeded(initialPage);
  final PageController _pageController = PageController(
    initialPage: initialPage,
  );

  void _animatePage(int index) {
    this._pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  @override
  void initState() {
    StreamsService.loaderState.sink.add(false);
    super.initState();
  }

  @override
  void dispose() {
    _bottomNav?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      pageView: PageView(
        controller: this._pageController,
        onPageChanged: this._bottomNav.sink.add,
        children: <Widget>[
          NotificationsPage(),
          OutgoingPage(),
          IncomingPage(),
          SettingsPage(),
        ],
      ),
      bottomNav: StreamBuilder<int>(
        stream: this._bottomNav,
        initialData: this._bottomNav.value,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: StylesConstant.primaryColor,
            unselectedItemColor: StylesConstant.secondaryColor,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            currentIndex: snapshot.data,
            backgroundColor: Colors.white,
            elevation: 0,
            onTap: this._animatePage,
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
          );
        },
      ),
    );
  }
}

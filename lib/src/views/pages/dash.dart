import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:rxdart/subjects.dart';

import 'package:webhook_manager/src/constants/styles.dart';
import 'package:webhook_manager/src/services/auth.dart';

import 'package:webhook_manager/src/services/fcm.dart';
import 'package:webhook_manager/src/services/sync.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/incoming_new.dart';
import 'package:webhook_manager/src/views/pages/outgoing_new.dart';
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
  final AuthService _authService = AuthService();
  final SyncService _syncService = SyncService();
  final FCMService _fcmService = FCMService();

  void _animatePage(int index) {
    this._pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  Future<void> _initRegistration(Duration duration) async {
    final FirebaseUser session = await this._authService.session;
    if (session != null && !session.isAnonymous) {
      this._fcmService.register();
    }
    this._syncService.init(noSync: session.isAnonymous);
  }

  @override
  void initState() {
    StreamsService.loaderState.sink.add(false);
    SchedulerBinding.instance.addPostFrameCallback(this._initRegistration);
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
          IncomingPage(),
          OutgoingPage(),
          SettingsPage(),
        ],
      ),
      floatingActionButton: StreamBuilder<int>(
        stream: this._bottomNav,
        initialData: this._bottomNav.value,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Visibility(
            visible: snapshot.data == 1 || snapshot.data == 2,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      if (snapshot.data == 1) {
                        return IncomingNew();
                      } else {
                        return OutgoingNew();
                      }
                    },
                  ),
                );
              },
              elevation: 0,
              backgroundColor: StylesConstant.primaryColor,
            ),
          );
        },
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
                icon: Icon(Icons.notifications_active),
                title: Text('Notifications'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_download),
                title: Text('Incoming'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload),
                title: Text('Outgoing'),
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

import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/enums.dart';
import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/notification_item.dart';

class NotificationsPage extends StatelessWidget {
  final List<NotificationData> items = [
    NotificationData(
      id: 1,
      eventName: 'build_status',
      method: RequestMethod.post,
      receivedTime: DateTime.now(),
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    NotificationData(
      id: 2,
      eventName: 'event_tester',
      method: RequestMethod.put,
      receivedTime: DateTime.now(),
    ),
    NotificationData(
      id: 3,
      eventName: 'build_status',
      method: RequestMethod.post,
      receivedTime: DateTime.now(),
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    NotificationData(
      id: 4,
      eventName: 'event_tester',
      method: RequestMethod.put,
      receivedTime: DateTime.now(),
    ),
    NotificationData(
      id: 5,
      eventName: 'build_status',
      method: RequestMethod.post,
      receivedTime: DateTime.now(),
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    NotificationData(
      id: 6,
      eventName: 'event_tester',
      method: RequestMethod.put,
      receivedTime: DateTime.now(),
    ),
    NotificationData(
      id: 7,
      eventName: 'build_status',
      method: RequestMethod.post,
      receivedTime: DateTime.now(),
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    NotificationData(
      id: 8,
      eventName: 'event_tester',
      method: RequestMethod.put,
      receivedTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.notifications_active,
      title: 'Notifications',
      noLoader: true,
      child: Builder(
        builder: (BuildContext context) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: this.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key('dis$index'),
                dismissThresholds: {
                  DismissDirection.endToStart: 0.8,
                },
                background: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Clear Notification',
                          style: TextStyle(
                            color: StylesConstant.secondaryColor,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.delete_forever,
                          size: 30,
                          color: StylesConstant.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                direction: DismissDirection.endToStart,
                child: NotificationItem(this.items[index]),
              );
            },
          );
        },
      ),
    );
  }
}

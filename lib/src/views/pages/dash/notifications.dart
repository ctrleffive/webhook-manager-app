import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/notification_item.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.notifications_active,
      title: 'Notifications',
      noLoader: true,
      child: StreamBuilder<List<NotificationData>>(
        stream: StreamsService.notifications,
        initialData: StreamsService.notifications.value,
        builder: (_, AsyncSnapshot<List<NotificationData>> snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
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
                child: NotificationItem(snapshot.data[index]),
              );
            },
          );
        },
      ),
    );
  }
}

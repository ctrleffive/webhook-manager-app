import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/notification.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/notification_single.dart';

import 'package:webhook_manager/src/views/components/notification_item.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationService _service = NotificationService();

  Future<void> _deleteItem(BuildContext context, NotificationData data) async {
    try {
      await this._service.deleteItem(data);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error deleting!'),
        ),
      );
    }
  }

  Future<void> _goToDetails(BuildContext context, NotificationData data) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => NotificationSingle(data),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.notifications_active,
      title: 'Notifications',
      noLoader: true,
      syncNeeded: true,
      child: StreamBuilder<List<NotificationData>>(
        stream: StreamsService.notfcatns,
        initialData: StreamsService.notfcatns.value,
        builder: (_, AsyncSnapshot<List<NotificationData>> snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (_) =>
                    this._deleteItem(context, snapshot.data[index]),
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
                child: GestureDetector(
                  onTap: () => this._goToDetails(context, snapshot.data[index]),
                  child: NotificationItem(snapshot.data[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

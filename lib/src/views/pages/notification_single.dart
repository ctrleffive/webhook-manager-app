import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/notification.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/notification_item.dart';

class NotificationSingle extends StatelessWidget {
  final NotificationData data;

  NotificationSingle(this.data);

  final NotificationService _service = NotificationService();

  Future<void> _deleteItem(BuildContext context) async {
    try {
      await this._service.deleteItem(this.data);
      Navigator.of(context).pop();
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error deleting!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: this.data.eventName,
      children: <Widget>[
        NotificationItem(this.data, minmal: true),
        _DataContainer(
          label: 'Headers',
          data: data.headers,
        ),
        if (data.payload != null)
          _DataContainer(
            label: 'Payload',
            data: data.payload,
          ),
        Button(
          label: 'Delete',
          isBlock: true,
          isFlat: true,
          color: Colors.redAccent,
          onTap: () => this._deleteItem(context),
        ),
      ],
    );
  }
}

class _DataContainer extends StatelessWidget {
  final String label;
  final String data;

  const _DataContainer({
    Key key,
    this.label,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            bottom: 10,
          ),
          child: Text(
            this.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: StylesConstant.accentColor.withOpacity(0.05),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Builder(
            builder: (BuildContext context) {
              final Map jsonMap = json.decode(this.data);
              JsonEncoder encoder = JsonEncoder.withIndent('  ');
              String prettyprint = encoder.convert(jsonMap);
              return Text(
                prettyprint,
                style: TextStyle(
                  color: StylesConstant.accentColor,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

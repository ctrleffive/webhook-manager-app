import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/views/components/method_label.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData data;

  NotificationItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: this.data.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MethodLabel(this.data.method),
                    Text(
                      DateFormat('MMM d y - h:mm a')
                          .format(this.data.receivedTime),
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  this.data.eventName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textScaleFactor: 1.5,
                ),
              ],
            ),
          ),
          if (this.data.payload != null)
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Builder(
                builder: (BuildContext context) {
                  final Map jsonMap = json.decode(this.data.payload);
                  JsonEncoder encoder = JsonEncoder.withIndent('  ');
                  String prettyprint = encoder.convert(jsonMap);
                  return Text(
                    prettyprint,
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

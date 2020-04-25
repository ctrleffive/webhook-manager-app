import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/components/method_label.dart';

class OutgoingItem extends StatelessWidget {
  final OutgoingData data;

  OutgoingItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MethodLabel(this.data.method),
            SizedBox(height: 15),
            Text(
              this.data.eventName,
              style: TextStyle(
                color: StylesConstant.accentColor,
              ),
              textScaleFactor: 1.5,
            ),
            SizedBox(height: 10),
            Text(
              this.data.url,
              style: TextStyle(
                color: StylesConstant.accentColor.withOpacity(0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

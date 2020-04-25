import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/components/method_label.dart';

class OutgoingItem extends StatelessWidget {
  final OutgoingData data;

  OutgoingItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.35,
        closeOnScroll: true,
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: StylesConstant.requestColors[this.data.method.index].withAlpha(150),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.done_all, size: 30),
                SizedBox(height: 10),
                Text('Excecute'),
              ],
            ),
          ),
        ],
        child: Container(
          width: MediaQuery.of(context).size.width,
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
        ),
      ),
    );
  }
}

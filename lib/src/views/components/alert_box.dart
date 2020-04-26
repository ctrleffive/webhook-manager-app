import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/views/components/button.dart';

class AlertBoxData {
  IconData icon;
  String title;
  String details;
  Color color;

  AlertBoxData({
    this.icon = Icons.notifications,
    this.title = 'Alert',
    this.details,
    this.color = StylesConstant.primaryColor,
  });
}

class AlertBox extends StatelessWidget {
  final AlertBoxData data;

  AlertBox(this.data);

  static void show(BuildContext context, AlertBoxData data) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertBox(data);
      },
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(StylesConstant.paddingSide),
            padding: EdgeInsets.all(StylesConstant.paddingSide * 1.5)
                .copyWith(bottom: 5),
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
            child: Column(
              children: <Widget>[
                Icon(
                  this.data.icon,
                  size: 60,
                  color: this.data.color,
                ),
                SizedBox(height: 20),
                Text(
                  this.data.title,
                  style: Theme.of(context).textTheme.title,
                ),
                if (this.data.details != null)
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      this.data.details,
                      style: TextStyle(
                        color: StylesConstant.accentColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                SizedBox(height: 5),
                Button(
                  label: 'Ok',
                  onTap: Navigator.of(context).pop,
                  isFlat: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

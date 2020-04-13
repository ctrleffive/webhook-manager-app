import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class AppTitle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isCentered;

  AppTitle({
    Key key,
    this.icon,
    this.isCentered,
    this.label = 'App Title',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: this.isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: <Widget>[
          if (this.icon != null)
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                this.icon,
                size: 30,
                color: StylesConstant.primaryColor,
              ),
            ),
          Text(
            this.label,
            style: Theme.of(context).textTheme.title.copyWith(
                  color: StylesConstant.accentColor,
                  fontWeight: FontWeight.w600,
                ),
            textScaleFactor: 1.1,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

class AppTitle extends StatelessWidget {
  final String label;
  final IconData icon;

  AppTitle({
    Key key,
    this.icon,
    this.label = 'App Title',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.of(context).canPop();

    return Padding(
      padding: EdgeInsets.only(bottom: 30, top: 10),
      child: Stack(
        children: <Widget>[
          if (canPop)
            Positioned(
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: StylesConstant.accentColor,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (this.icon != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Icon(
                    this.icon,
                    size: 30,
                    color: StylesConstant.primaryColor,
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}

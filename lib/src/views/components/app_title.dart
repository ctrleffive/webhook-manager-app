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
            mainAxisAlignment: this.isCentered
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              if (this.icon != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                    left: (canPop && !this.isCentered) ? 50 : 0,
                  ),
                  child: Icon(
                    this.icon,
                    size: 30,
                    color: StylesConstant.primaryColor,
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.only(
                  left: (canPop && !this.isCentered) ? 50 : 0,
                ),
                child: Text(
                  this.label,
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: StylesConstant.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                  textScaleFactor: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

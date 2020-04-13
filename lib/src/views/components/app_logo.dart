import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/assets.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class AppLogo extends StatelessWidget {
  final bool isAccent;

  AppLogo({
    Key key,
    this.isAccent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app_logo',
      child: Image(
        image: AssetImage(AssetsConstant.logo),
        color: this.isAccent ? StylesConstant.accentColor : StylesConstant.primaryColor,
      ),
    );
  }
}

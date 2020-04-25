import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/enums.dart';
import 'package:webhook_manager/src/constants/styles.dart';

class MethodLabel extends StatelessWidget {
  final RequestMethod method;

  MethodLabel(this.method, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: StylesConstant.requestColors[this.method.index],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        this.method.toString().replaceAll('RequestMethod.', '').toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        textScaleFactor: 0.8,
      ),
    );
  }
}

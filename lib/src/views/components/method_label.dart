import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/enums.dart';

class MethodLabel extends StatelessWidget {
  final RequestMethod method;

  MethodLabel(this.method, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name;
    Color color;

    switch (this.method) {
      case RequestMethod.get:
        color = Colors.cyan;
        name = 'GET';
        break;

      case RequestMethod.post:
        color = Colors.greenAccent;
        name = 'POST';
        break;

      case RequestMethod.patch:
        color = Colors.yellowAccent;
        name = 'PATCH';
        break;

      case RequestMethod.delete:
        color = Colors.redAccent;
        name = 'DELETE';
        break;

      case RequestMethod.option:
        color = Colors.white;
        name = 'OPTION';
        break;

      case RequestMethod.put:
        color = Colors.lightBlueAccent;
        name = 'PUT';
        break;

      default:
        color = Colors.grey;
        name = 'UNKNOWN';
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        textScaleFactor: 0.8,
      ),
    );
  }
}

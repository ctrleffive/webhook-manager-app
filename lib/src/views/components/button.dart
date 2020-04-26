import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/styles.dart';

class Button extends StatelessWidget {
  final String label;
  final bool isFlat;
  final bool isBlock;
  final Color color;
  final Function() onTap;

  const Button({
    Key key,
    this.color,
    this.onTap,
    this.label = 'Button',
    this.isFlat = false,
    this.isBlock = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = this.color ?? StylesConstant.primaryColor;
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: this.isBlock ? MediaQuery.of(context).size.width : null,
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        margin: EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: this.isFlat ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (!this.isFlat)
              BoxShadow(
                color: color.withOpacity(0.5),
                offset: Offset(0, 10),
                blurRadius: 25,
              ),
          ],
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            this.label,
            style: TextStyle(
              color: this.isFlat ? color : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

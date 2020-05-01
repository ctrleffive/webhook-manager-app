import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/keys.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/views/pages/incoming_single.dart';

class IncomingItem extends StatelessWidget {
  final IncomingData data;

  IncomingItem(this.data, {Key key}) : super(key: key);

  Future<void> _goToDetails(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => IncomingSingle(this.data),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => this._goToDetails(context),
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
                Text(
                  this.data.eventName,
                  style: TextStyle(
                    color: StylesConstant.accentColor,
                  ),
                  textScaleFactor: 1.5,
                ),
                SizedBox(height: 10),
                Text(
                  '${KeysConstant.api}/hooks/${this.data.hookId}',
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

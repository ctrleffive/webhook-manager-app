import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/pages/outgoing_single.dart';

import 'package:webhook_manager/src/views/components/alert_box.dart';
import 'package:webhook_manager/src/views/components/method_label.dart';

class OutgoingItem extends StatelessWidget {
  final OutgoingData data;

  OutgoingItem(this.data, {Key key}) : super(key: key);

  final SlidableController _slideController = SlidableController();

  Future<void> _goToDetails(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => OutgoingSingle(this.data),
    ));
  }

  Future<void> _excecute(BuildContext context) async {
    try {
      StreamsService.loaderState.sink.add(true);
      await Future.delayed(Duration(seconds: 2));
      this._slideController.activeState.close();
      AlertBox.show(
          context,
          AlertBoxData(
            icon: Icons.done_all,
            title: 'Event Excecuted!',
            color: Colors.greenAccent,
          ));
    } catch (e) {
      AlertBox.show(
          context,
          AlertBoxData(
            icon: Icons.error,
            title: 'Error!',
            details: 'Given URL is not reachable!',
            color: Colors.redAccent,
          ));
    } finally {
      StreamsService.loaderState.sink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Slidable(
        controller: this._slideController,
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.35,
        closeOnScroll: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () => this._excecute(context),
            child: Container(
              decoration: BoxDecoration(
                color: StylesConstant.requestColors[this.data.method.index]
                    .withAlpha(150),
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
          ),
        ],
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
      ),
    );
  }
}

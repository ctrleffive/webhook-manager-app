import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/outgoing_item.dart';

class OutgoingSingle extends StatelessWidget {
  final OutgoingData data;

  OutgoingSingle(this.data);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: this.data.eventName,
      children: <Widget>[
        OutgoingItem(this.data),
        Form(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextInput(
                      label: 'Event Name',
                      placeholder: 'eg. build_status',
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextInput(
                      label: 'Method',
                      placeholder: 'eg. post',
                    ),
                  ),
                ],
              ),
              TextInput(
                label: 'URL',
                placeholder: 'eg. https://api.google.com/..',
              ),
              TextInput(
                lines: 4,
                label: 'Payload',
                placeholder: 'eg. {\n\t"build":true\n}',
              ),
              SizedBox(height: 40),
              Button(
                label: 'Update',
                isBlock: true,
              ),
              Button(
                label: 'Delete',
                isBlock: true,
                isFlat: true,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        SizedBox(),
      ],
    );
  }
}

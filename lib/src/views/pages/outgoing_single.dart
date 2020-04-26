import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class OutgoingSingle extends StatelessWidget {
  final OutgoingData data;

  OutgoingSingle(this.data);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: this.data.eventName,
      child: SizedBox(),
    );
  }
}
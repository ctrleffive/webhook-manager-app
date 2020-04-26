import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/enums.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/outgoing_item.dart';

class OutgoingPage extends StatelessWidget {
  final List<OutgoingData> items = [
    OutgoingData(
      color: Colors.blue,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      color: Colors.green,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      color: Colors.redAccent,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      color: Colors.green,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      color: Colors.blue,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      color: Colors.green,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      color: Colors.redAccent,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      color: Colors.green,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      isCentered: false,
      icon: Icons.cloud_upload,
      title: 'Outgoing',
      noLoader: true,
      child: Builder(
        builder: (BuildContext context) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: this.items.length,
            itemBuilder: (BuildContext context, int index) {
              return OutgoingItem(this.items[index]);
            },
          );
        },
      ),
    );
  }
}

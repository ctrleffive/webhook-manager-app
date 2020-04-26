import 'package:flutter/material.dart';

import 'package:webhook_manager/src/constants/enums.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/outgoing_item.dart';

class OutgoingPage extends StatelessWidget {
  final List<OutgoingData> items = [
    OutgoingData(
      id: 1,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      id: 2,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      id: 3,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      id: 4,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      id: 5,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      id: 6,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
    OutgoingData(
      id: 7,
      eventName: 'build_status',
      method: RequestMethod.post,
      url: 'https://api.google.com/v1/send_fcm',
      payload: '{"event_type":"insomnia","client_payload":{}}',
    ),
    OutgoingData(
      id: 8,
      eventName: 'event_tester',
      method: RequestMethod.put,
      url: 'https://api.google.com/v1/send_fcm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrap(
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

import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/outgoing.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/outgoing_item.dart';

class OutgoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.cloud_upload,
      title: 'Outgoing',
      noLoader: true,
      child: StreamBuilder<List<OutgoingData>>(
        stream: StreamsService.outgoings,
        initialData: StreamsService.outgoings.value,
        builder: (_, AsyncSnapshot<List<OutgoingData>> snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return OutgoingItem(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}

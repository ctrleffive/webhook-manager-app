import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/incoming.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/empty_list_view.dart';

class IncomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      icon: Icons.cloud_download,
      title: 'Incoming',
      noLoader: true,
      child: StreamBuilder<List<IncomingData>>(
        stream: StreamsService.incomings,
        initialData: StreamsService.incomings.value,
        builder: (_, AsyncSnapshot<List<IncomingData>> snapshot) {
          return EmptyListView();
          // return ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: snapshot.data.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return IncomingItem(snapshot.data[index]);
          //   },
          // );
        },
      ),
    );
  }
}
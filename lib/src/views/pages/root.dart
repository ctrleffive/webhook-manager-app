import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class RootPage extends StatelessWidget {
  RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      children: <Widget>[
        SizedBox(),
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(),
      ],
    );
  }
}

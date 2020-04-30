import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      child: Opacity(
        opacity: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.list, size: 60),
            SizedBox(height: 5),
            Text(
              'Empty List!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 5),
            Text('Add Some Events')
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:webhook_manager/src/constants/styles.dart';

import 'package:webhook_manager/src/views/components/button.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: 'Terms',
      children: <Widget>[
        SizedBox(),
        Column(
          children: <Widget>[
            Icon(
              Icons.notifications_active,
              size: 100,
              color: StylesConstant.primaryColor,
            ),
            SizedBox(height: 40),
            Text(
              'After your login, you will be prompted to allow access to show notifications on your device. Please click allow notificatins.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Be aware that your data is safe with us. Please read our Data Handling Policy and see why and how we respect your privacy.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Button(
              label: 'Data Handling Policy',
              isBlock: true,
              isFlat: true,
              onTap: () {
                // TODO: Open Data Handling Policy URL
              },
            ),
          ],
        ),
        SizedBox(),
        Column(
          children: <Widget>[
            Button(
              label: 'Continue',
              isBlock: true,
              onTap: () {
                Navigator.of(context).pop(true);
              },
            ),
            Button(
              label: 'Go Back',
              isBlock: true,
              isFlat: true,
              onTap: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        ),
      ],
    );
  }
}

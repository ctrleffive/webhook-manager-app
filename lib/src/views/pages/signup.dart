import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: 'Signup',
      children: <Widget>[
        Column(
          children: <Widget>[
            AppLogo(),
            SizedBox(height: 20),
            TextInput(
              label: 'Full Name',
              placeholder: 'eg. John Doe',
            ),
            TextInput(
              label: 'Email',
              placeholder: 'eg. johndoe@emai.com',
            ),
            TextInput(
              label: 'Password',
              placeholder: '**********',
            ),
            TextInput(
              label: 'Confirm Password',
              placeholder: '**********',
            ),
            SizedBox(height: 40),
            Button(
              label: 'Signup',
              isBlock: true,
              onTap: () {},
            ),
            Button(
              label: 'Back To Login',
              isFlat: true,
              onTap: Navigator.of(context).pop,
            ),
          ],
        ),
        SizedBox(),
      ],
    );
  }
}

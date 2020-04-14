import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/signup.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: 'Login',
      children: <Widget>[
        Column(
          children: <Widget>[
            AppLogo(),
            SizedBox(height: 20),
            TextInput(
              label: 'Email',
              placeholder: 'eg. johndoe@emai.com',
            ),
            TextInput(
              label: 'Password',
              placeholder: '**********',
            ),
            SizedBox(height: 40),
            Button(
              label: 'Login',
              isBlock: true,
              onTap: () {},
            ),
            Button(
              label: 'Signup',
              isFlat: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SignupPage(),
                  ),
                );
              },
            ),
          ],
        ),
        Button(
          label: 'Forgot Password',
          isFlat: true,
          onTap: () {},
        ),
      ],
    );
  }
}

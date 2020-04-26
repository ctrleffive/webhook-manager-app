import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/user.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash.dart';
import 'package:webhook_manager/src/views/pages/signup.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class LoginPage extends StatelessWidget {
  final AuthService _service = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserData _gateUser = UserData();

  Future<void> _login(BuildContext context) async {
    try {
      this._formKey.currentState.save();
      final bool isFormOk = this._formKey.currentState.validate();
      if (isFormOk) {
        StreamsService.loaderState.sink.add(true);
        await this._service.emailLogin(this._gateUser);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => DashPage(),
          ),
          (_) => false,
        );
      }
    } catch (e) {
      StreamsService.loaderState.sink.add(false);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      title: 'Login',
      isCentered: true,
      children: <Widget>[
        Column(
          children: <Widget>[
            AppLogo(),
            SizedBox(height: 20),
            Form(
              key: this._formKey,
              child: Column(
                children: <Widget>[
                  TextInput(
                    label: 'Email',
                    placeholder: 'eg. johndoe@emai.com',
                    onSave: (value) => this._gateUser.email = value,
                    validator: Validators.required,
                  ),
                  TextInput(
                    label: 'Password',
                    placeholder: '**********',
                    onSave: (value) => this._gateUser.password = value,
                    validator: Validators.required,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Builder(
              builder: (BuildContext context) {
                return Button(
                  label: 'Login',
                  isBlock: true,
                  onTap: () => this._login(context),
                );
              },
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

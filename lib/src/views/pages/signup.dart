import 'package:flutter/material.dart';

import 'package:webhook_manager/src/models/gate_user.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/validators.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash.dart';
import 'package:webhook_manager/src/views/pages/terms.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/inputs.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class SignupPage extends StatelessWidget {
  final AuthService _service = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GateUser _gateUser = GateUser();

  Future<void> _signUp(BuildContext context) async {
    try {
      this._formKey.currentState.save();
      final bool isFormOk = this._formKey.currentState.validate();
      if (isFormOk) {
        final bool termsOk = (await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TermsPage(),
                fullscreenDialog: true,
              ),
            )) ??
            false;
        if (termsOk) {
          StreamsService.loaderState.sink.add(true);
          await this._service.emailSignup(this._gateUser);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => DashPage(),
            ),
            (_) => false,
          );
        } else {
          throw Exception('You have to agree to our terms first!');
        }
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
      title: 'Signup',
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
                    label: 'Full Name',
                    placeholder: 'eg. John Doe',
                    onSave: (value) => this._gateUser.name = value,
                    validator: Validators.required,
                  ),
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
                  TextInput(
                    label: 'Confirm Password',
                    placeholder: '**********',
                    // onSave: (value) => this._gateUser.email = value,
                    // validator: Validators.required,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Builder(
              builder: (BuildContext context) {
                return Button(
                  label: 'Signup',
                  isBlock: true,
                  onTap: () => this._signUp(context),
                );
              }
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

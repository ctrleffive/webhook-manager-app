import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/auth.dart';
import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/pages/dash.dart';
import 'package:webhook_manager/src/views/pages/login.dart';
import 'package:webhook_manager/src/views/pages/terms.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key key}) : super(key: key);

  final AuthService _authService = AuthService();
  final List<_Intro> intros = [
    _Intro(
      image: AppLogo(),
      title: 'Webhook Manager',
      body: 'Swipe to learn more',
    ),
    _Intro(
      image: AppLogo(isAccent: true),
      title: 'Sample Heading',
      body:
          'lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.',
    ),
  ];

  Future<void> _emailLogin(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
    );
  }

  Future<void> _guestLogin(BuildContext context) async {
    try {
      final bool termsOk = (await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TermsPage(),
              fullscreenDialog: true,
            ),
          )) ??
          false;
      if (termsOk) {
        StreamsService.loaderState.sink.add(true);
        await this._authService.guestLogin();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => DashPage(),
          ),
          (_) => false,
        );
        StreamsService.loaderState.sink.add(false);
      } else {
        throw Exception('You have to agree to our terms first!');
      }
    } catch (e) {
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
      isCentered: true,
      children: <Widget>[
        SizedBox(),
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: this.intros.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  this.intros[index].image,
                  SizedBox(height: 20),
                  Text(
                    this.intros[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 20),
                  Text(
                    this.intros[index].body,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                Button(
                  label: 'Continue As Guest',
                  isFlat: true,
                  onTap: () => this._guestLogin(context),
                ),
                Button(
                  label: 'Continue With Email',
                  isBlock: true,
                  onTap: () => this._emailLogin(context),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Intro {
  Widget image;
  String title;
  String body;

  _Intro({
    this.image,
    this.title,
    this.body,
  });
}

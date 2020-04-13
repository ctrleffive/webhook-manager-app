import 'package:flutter/material.dart';

import 'package:webhook_manager/src/views/layouts/page_wrap.dart';

import 'package:webhook_manager/src/views/components/button.dart';
import 'package:webhook_manager/src/views/components/app_logo.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key key}) : super(key: key);

  final List<_Intro> intros = [
    _Intro(
      image: AppLogo(),
      title: 'Webhook Manager',
      body: 'Swipe to learn more',
    ),
    _Intro(
      image: AppLogo(isAccent: true),
      title: 'Sample Heading',
      body: 'lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageWrap(
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
        Column(
          children: <Widget>[
            Button(
              label: 'Continue As Guest',
              isFlat: true,
            ),
            Button(
              label: 'Continue With Email',
              isBlock: true,
            ),
          ],
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

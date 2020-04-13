import 'package:flutter/material.dart';
import 'package:webhook_manager/src/views/components/app_title.dart';

class PageWrap extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final IconData icon;
  final bool isCentered;

  const PageWrap({
    Key key,
    this.icon,
    this.title,
    this.children,
    this.isCentered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: this.isCentered ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            crossAxisAlignment: this.isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (this.title != null) 
              AppTitle(
                icon: this.icon,
                label: this.title,
                isCentered: this.isCentered,
              ),
              ...this.children,
            ],
          ),
        ),
      ),
    );
  }
}

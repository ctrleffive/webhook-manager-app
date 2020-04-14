import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/streams.dart';

import 'package:webhook_manager/src/views/components/app_title.dart';

class PageWrap extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final IconData icon;
  final bool isCentered;
  final PageView pageView;
  final Widget bottomNav;

  const PageWrap({
    Key key,
    this.icon,
    this.title,
    this.children,
    this.pageView,
    this.bottomNav,
    this.isCentered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (this.pageView != null) return this.pageView;
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: this.isCentered
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        crossAxisAlignment: this.isCentered
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
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
              },
            ),
          ),
          StreamBuilder<bool>(
            stream: StreamsService.loaderState,
            initialData: StreamsService.loaderState.value,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.data,
                child: AnimatedOpacity(
                  opacity: snapshot.data ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        color: Colors.white10,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: this.bottomNav,
    );
  }
}

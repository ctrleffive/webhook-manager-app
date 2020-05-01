import 'package:flutter/material.dart';

import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/sync.dart';

import 'package:webhook_manager/src/views/components/app_title.dart';

class PageWrap extends StatelessWidget {
  final List<Widget> children;
  final Widget child;
  final String title;
  final IconData icon;
  final bool noLoader;
  final bool isCentered;
  final PageView pageView;
  final Widget bottomNav;
  final bool syncNeeded;
  final Widget floatingActionButton;

  PageWrap({
    Key key,
    this.icon,
    this.title,
    this.child,
    this.children,
    this.pageView,
    this.syncNeeded = false,
    this.isCentered = false,
    this.noLoader = false,
    this.bottomNav,
    this.floatingActionButton,
  }) : super(key: key);

  final SyncService _syncService = SyncService();

  @override
  Widget build(BuildContext context) {
    final Widget everything = Stack(
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (this.pageView != null) return this.pageView;
                return SingleChildScrollView(
                  physics:
                      this.syncNeeded ? AlwaysScrollableScrollPhysics() : null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Builder(
                        builder: (BuildContext context) {
                          final List<Widget> newChildren = [];
                          if (this.child != null) {
                            newChildren.add(this.child);
                          } else if (this.children != null) {
                            newChildren.addAll(this.children);
                          }
                          if (this.title != null) {
                            newChildren.insert(
                              0,
                              AppTitle(
                                icon: this.icon,
                                label: this.title,
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: this.isCentered
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: newChildren,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: this.bottomNav,
          floatingActionButton: this.floatingActionButton,
        ),
        if (!this.noLoader)
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
                  child: Container(
                    color: Colors.white.withOpacity(0.95),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
    if (this.syncNeeded) {
      return RefreshIndicator(
        onRefresh: this._syncService.init,
        child: everything,
      );
    }
    return everything;
  }
}

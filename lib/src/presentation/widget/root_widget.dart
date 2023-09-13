import 'package:flutter/material.dart';

class AlvaRootWidget extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  final Widget? bottomSheet;
  final String titlePage;

  const AlvaRootWidget({super.key, required this.child, required this.titlePage, this.appBar, this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return Title(
        color: Colors.black, title: titlePage, child: Scaffold(body: child, appBar: appBar, bottomSheet: bottomSheet));
  }
}

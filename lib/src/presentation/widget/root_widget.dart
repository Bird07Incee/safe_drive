import 'package:flutter/material.dart';

class RootWidget extends StatelessWidget {
  final Widget child;
  final String titlePage;

  const RootWidget({super.key, required this.child, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Title(color: Colors.black, title: titlePage, child: Scaffold(body: child));
  }
}

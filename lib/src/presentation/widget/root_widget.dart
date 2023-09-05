import 'package:flutter/material.dart';

class AlvaRootWidget extends StatelessWidget {
  final Widget child;
  final String titlePage;

  const AlvaRootWidget({super.key, required this.child, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Title(color: Colors.black, title: titlePage, child: Scaffold(body: child));
  }
}

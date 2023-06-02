// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';

class Landing extends StatefulWidget {
  const Landing({
    Key? key,
  }) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  String greetingMsg = "Checking ...";

  @override
  void initState() {
    super.initState();

    // FlutterLineLiff().ready.then((_) {
    //   if (!FlutterLineLiff().isLoggedIn) {
    //     FlutterLineLiff().login();
    //     greetingMsg = 'Sign-in...';
    //   } else {
    //     greetingMsg = 'Welcome to Landing!';
    //   }
    // });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landing', style: TextStyle(fontSize: 24),),),
      body: Center(
        child: Text(
          greetingMsg,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

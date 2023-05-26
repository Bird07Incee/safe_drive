// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:mkp_line_web/Pages/landing.dart';

class Default extends StatefulWidget {
  const Default({Key? key}) : super(key: key);

  @override
  State<Default> createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  bool isLoading = false;
  int codeDuplicated = 0;

  @override
  void initState() {
    super.initState();

    FlutterLineLiff().ready.then((_) {
      print('Default >>>> Line Ready');

      if (!FlutterLineLiff().isLoggedIn) {
        FlutterLineLiff().login();
        print('Default >>>> login');
      } else {
        print('Default >>>> Redirect to Landing');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Landing()),
            ModalRoute.withName('/'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
      return const MaterialApp(
        home: Scaffold(
        body: Center(
          child: Text(
            'checking ..',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

}

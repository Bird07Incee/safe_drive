

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/auth_controller.dart';

class Default extends StatelessWidget {
  const Default({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (controller) => const Scaffold(
        body: Center(
          child: Text('Default Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      )
    );
  }
}
// // ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches
// import 'package:flutter/material.dart';
// import 'package:flutter_line_liff/flutter_line_liff.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:marketplace_line_oa/views/landing.dart';
//
// class Default extends StatefulWidget {
//   const Default({Key? key}) : super(key: key);
//
//   @override
//   State<Default> createState() => _DefaultState();
// }
//
// class _DefaultState extends State<Default> {
//   bool isLoading = false;
//   int codeDuplicated = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     //Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
//
//     // FlutterLineLiff().ready.then((_) {
//     //   print('Default >>>> Line Ready');
//     //   if (!FlutterLineLiff().isLoggedIn) {
//     //     FlutterLineLiff().login();
//     //     print('Default >>>> login');
//     //   } else {
//     //     print('Default >>>> Redirect to Landing');
//     //     Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
//     //   }
//     // });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//       builder: (controller),
//     );
//       return const Scaffold(
//         body: Center(
//           child: Text(
//             'Default Page',
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       );
//   }
//
// }

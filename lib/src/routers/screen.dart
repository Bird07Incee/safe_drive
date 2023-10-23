import 'package:auth/auth.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:safe_drive/src/routers/extensions.dart';

class HomePlatform {
  static Future<String?> middleware(context, state) async {
    return Future.value();
  }

  static Page loginPage(BuildContext context, GoRouterState state) {
    return const LoginScreen().page();
  }
}

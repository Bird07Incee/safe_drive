import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:safe_drive/src/app.dart';

Future<void> main() async {
  await _di();
  runApp(const MyApp());
}

Future _di()async{
  await diCommonModule();
}
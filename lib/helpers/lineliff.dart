@JS()
library lineliff;

import 'dart:async';
import 'package:js/js.dart';

@JS()
external void lineLogin();
external void lineLogout();
external String lineInfo();
external Future<String> checkLogin();

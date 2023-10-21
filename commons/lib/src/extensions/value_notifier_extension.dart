// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

extension ValueNotifierExtension on ValueNotifier {
  void notifier() {
    // ignore: invalid_use_of_visible_for_testing_member
    notifyListeners();
  }

  void toggleNotifier() {
    if (value is bool || value is bool?) {
      value = !(value ?? false);
    }
  }
}
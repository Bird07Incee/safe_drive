import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/presentation/screens/home.dart';
import 'package:marketplace_line_oa/src/presentation/screens/term_and_con.dart';

enum Routes { initial, termAndCon }

extension TypeCoverter on Routes {
  String toStringPath() {
    switch (this) {
      case Routes.initial:
        return '/';
      case Routes.termAndCon:
        return 'termAndCon';
    }
  }
}

final Map<String, WidgetBuilder> routes = {
  (Routes.initial).toStringPath(): (BuildContext _) => const HomeScreen(),
  (Routes.termAndCon).toStringPath(): (BuildContext _) => const TermAndConScreen()
};

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/home.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/term_and_con.dart';

enum Routes { initial, termAndCon, errorScreen, loadingScreen }

extension TypeCoverter on Routes {
  String toStringPath() {
    switch (this) {
      case Routes.initial:
        return '/';
      case Routes.termAndCon:
        return 'termAndCon';
      case Routes.errorScreen:
        return 'errorScreen';
      case Routes.loadingScreen:
        return 'loadingScreen';
    }
  }
}

final Map<String, WidgetBuilder> routes = {
  (Routes.initial).toStringPath(): (BuildContext _) => const HomeScreen(),
  (Routes.termAndCon).toStringPath(): (BuildContext _) => const TermAndConScreen(),
  (Routes.errorScreen).toStringPath(): (BuildContext _) => const ErrorScreen(),
  (Routes.loadingScreen).toStringPath(): (BuildContext _) => const LoadingScreen()
};

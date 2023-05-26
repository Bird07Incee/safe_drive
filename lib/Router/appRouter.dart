// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:mkp_line_web/Model/lineAuth.dart';
import 'package:mkp_line_web/Model/routingData.dart';
import 'package:mkp_line_web/Pages/Default.dart';
import 'package:mkp_line_web/Pages/landing.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
  }
}

class AppRouter {
  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  Route<dynamic> generateRoute(RouteSettings settings) {
    var routingData = settings.name?.getRoutingData;
    LineAuth lineModel = LineAuth();

    if (routingData?.route == "/landing") {
      lineModel.code = (routingData?["code"] == null) ? "" : routingData?["code"];
      lineModel.state = (routingData?["state"] == null) ? "" : routingData?["state"];
      lineModel.liffClientId = (routingData?["liffClientId"] == null) ? "" : routingData?["liffClientId"];
      lineModel.liffRedirectUri = (routingData?["liffRedirectUri"] == null) ? Uri() : Uri.parse(routingData!["liffRedirectUri"].toString());
    }

    switch (routingData?.route) {
      case '/checking':
        return MaterialPageRoute(builder: (_) => const Default(), settings: settings);
      case '/landing':
        print("1 >>> ${routingData?.route}");
        return MaterialPageRoute(builder: (_) => const Landing(), settings: settings);
      default:
        print("2 >>> ${routingData?.route}");
        return MaterialPageRoute(builder: (_) => const Default(), settings: settings);
    }
  }
}

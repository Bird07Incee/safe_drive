// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:marketplace_line_oa/models/line_auth.dart';
import 'package:marketplace_line_oa/models/routing_data.dart';
import 'package:marketplace_line_oa/views/default.dart';
import 'package:marketplace_line_oa/views/landing.dart';
import 'package:marketplace_line_oa/views/product_detail.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
  }
}

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const Default()),
    GetPage(name: '/landing', page: () => const Landing()),
    GetPage(name: '/product', page: () => const Product()),
  ];
}


// class AppRouter {
//   /// The route generator callback used when the app is navigated to a named
//   /// route. Set it on the [MaterialApp.onGenerateRoute] or
//   /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
//   /// matching.
//   Route<dynamic> generateRoute(RouteSettings settings) {
//     var routingData = settings.name?.getRoutingData;
//     // LineAuth lineModel = LineAuth();
//     //
//     // if (routingData?.route == "/landing") {
//     //   lineModel.code = (routingData?["code"] == null) ? "" : routingData?["code"];
//     //   lineModel.state = (routingData?["state"] == null) ? "" : routingData?["state"];
//     //   lineModel.liffClientId = (routingData?["liffClientId"] == null) ? "" : routingData?["liffClientId"];
//     //   lineModel.liffRedirectUri = (routingData?["liffRedirectUri"] == null) ? Uri() : Uri.parse(routingData!["liffRedirectUri"].toString());
//     // }
//
//     switch (routingData?.route) {
//       case '/landing':
//         print("1 >>> ${routingData?.route}");
//         return MaterialPageRoute(builder: (_) => const Default(), settings: settings);
//       case '/product':
//         print("2 >>> ${routingData?.route}");
//         return MaterialPageRoute(builder: (_) => const ProductDetail(), settings: settings);
//       default:
//         print("0 >>> ${routingData?.route}");
//         return MaterialPageRoute(builder: (_) => const Landing(), settings: settings);
//     }
//   }
// }

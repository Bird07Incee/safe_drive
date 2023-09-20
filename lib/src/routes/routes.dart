import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/home.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/product_detail_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/term_and_con.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

enum Routes { initial, termAndCon, errorScreen, loadingScreen, productDetail }

extension TypeCoverter on Routes {
  String toStringPath() {
    switch (this) {
      case Routes.initial:
        return '/';
      case Routes.termAndCon:
        return '/termAndCon';
      case Routes.errorScreen:
        return '/errorScreen';
      case Routes.loadingScreen:
        return '/loadingScreen';
      case Routes.productDetail:
        return '/productDetail';
    }
  }
}

final Map<String, WidgetBuilder> routes = {
  (Routes.initial).toStringPath(): (BuildContext _) => const HomeScreen(),
  (Routes.termAndCon).toStringPath(): (BuildContext _) => const TermAndConScreen(),
  (Routes.errorScreen).toStringPath(): (BuildContext _) => const ErrorScreen(),
  (Routes.loadingScreen).toStringPath(): (BuildContext _) => const LoadingScreen(),
  (Routes.productDetail).toStringPath(): (BuildContext _) => const ProductDetailScreen()
};

// extension StringExtension on String {
//   RoutingData get getRoutingData {
//     var uriData = Uri.parse(this);
//     return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
//   }
// }

// Route<dynamic> generateRoute(RouteSettings settings) {
//   var routingData = settings.name?.getRoutingData;

//   String code = "empty";
//   String state = "empty";
//   String liffClientId = "empty";
//   Uri liffRedirectUri = Uri();

//   if (routingData?.route == "/auths") {
//     code = (routingData?["code"] == null) ? "" : routingData?["code"];
//     state = (routingData?["state"] == null) ? "" : routingData?["state"];
//     liffClientId = (routingData?["liffClientId"] == null) ? "" : routingData?["liffClientId"];
//     liffRedirectUri =
//         (routingData?["liffRedirectUri"] == null) ? Uri() : Uri.parse(routingData!["liffRedirectUri"].toString());
//   }

//   print(code);
//   print(state);
//   print(liffClientId);
//   print(liffRedirectUri);

//   switch (routingData?.route) {
//     case "/":
//       return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);
//     case "termAndCon":
//       return MaterialPageRoute(builder: (_) => const TermAndConScreen(), settings: settings);
//     case "errorScreen":
//       return MaterialPageRoute(builder: (_) => const ErrorScreen(), settings: settings);
//     case "loadingScreen":
//       return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
//     default:
//       return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);
//   }
// }

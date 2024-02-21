import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/home.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/order_cancel.dart';
import 'package:marketplace_line_oa/src/presentation/screens/order_success.dart';
import 'package:marketplace_line_oa/src/presentation/screens/order_summary_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/product_select_options.dart';
import 'package:marketplace_line_oa/src/presentation/screens/read_term_and_con.dart';
import 'package:marketplace_line_oa/src/presentation/screens/refund_form_tracking_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/shipping_address/shipping_address_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/term_and_con.dart';
import 'package:marketplace_line_oa/src/presentation/screens/tracking_detail_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/tracking_list.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

enum Routes {
  readTermAndCon,
  initial,
  termAndCon,
  errorScreen,
  loadingScreen,
  productDetail,
  selectOptions,
  shippingAddress,
  orderSummary,
  orderSuccess,
  orderCancel,
  trackingList,
  tracking,
  refundFormTracking
}

extension TypeCoverter on Routes {
  String toStringPath() {
    switch (this) {
      case Routes.initial:
        return '/';
      case Routes.termAndCon:
        return '/termAndCon';
      case Routes.readTermAndCon:
        return '/readTermAndCon';
      case Routes.errorScreen:
        return '/errorScreen';
      case Routes.loadingScreen:
        return '/loadingScreen';
      case Routes.productDetail:
        return '/productDetail';
      case Routes.selectOptions:
        return '/selectOptions';
      case Routes.shippingAddress:
        return '/shippingAddress';
      case Routes.orderSummary:
        return '/orderSummary';
      case Routes.orderSuccess:
        return '/orderSuccess';
      case Routes.orderCancel:
        return '/orderCancel';
      case Routes.trackingList:
        return '/trackingList';
      case Routes.tracking:
        return '/tracking';
      case Routes.refundFormTracking:
        return '/refundFormTracking';
    }
  }
}

// final Map<String, WidgetBuilder> routes = {
//   (Routes.initial).toStringPath(): (BuildContext _) => const HomeScreen(),
//   (Routes.termAndCon).toStringPath(): (BuildContext _) => const TermAndConScreen(),
//   (Routes.errorScreen).toStringPath(): (BuildContext _) => const ErrorScreen(),
//   (Routes.loadingScreen).toStringPath(): (BuildContext _) => const LoadingScreen(),
//   (Routes.productDetail).toStringPath(): (BuildContext context) {
//     if (ModalRoute.of(context)!.settings.arguments != null) {
//       return ProductDetailScreen(
//         arguments: ModalRoute.of(context)!.settings.arguments as ProductDetailArgs,
//       );
//     } else {
//       return const ProductDetailScreen();
//     }
//   },
//   (Routes.selectOptions).toStringPath(): (BuildContext context) {
//     if (ModalRoute.of(context)!.settings.arguments != null) {
//       return ProductSelectOptions(
//         arguments: ModalRoute.of(context)!.settings.arguments as ProductDetailArgs,
//       );
//     } else {
//       return const ProductSelectOptions();
//     }
//   }
// };

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name?.getRoutingData;

  // String code = "empty";
  // String state = "empty";
  // String liffClientId = "empty";
  // Uri liffRedirectUri = Uri();
  //
  // if (routingData?.route == "/auths") {
  //   code = (routingData?["code"] == null) ? "" : routingData?["code"];
  //   state = (routingData?["state"] == null) ? "" : routingData?["state"];
  //   liffClientId = (routingData?["liffClientId"] == null) ? "" : routingData?["liffClientId"];
  //   liffRedirectUri =
  //       (routingData?["liffRedirectUri"] == null) ? Uri() : Uri.parse(routingData!["liffRedirectUri"].toString());
  // }
  //
  // print(code);
  // print(state);
  // print(liffClientId);
  // print(liffRedirectUri);
  // String pid = '';
  // if (routingData?.route == "/productDetail" || routingData?.route == "/selectOptions") {
  //   pid = (routingData?["pid"] == null) ? "" : routingData?["pid"];
  // }
  // print(pid);

  switch (routingData?.route) {
    case "/":
      return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);
    case "/termAndCon":
      return MaterialPageRoute(builder: (_) => const TermAndConScreen(), settings: settings);
    case "/readTermAndCon":
      return MaterialPageRoute(builder: (_) => const ReadTermAndConScreen(), settings: settings);
    case "/errorScreen":
      return MaterialPageRoute(builder: (_) => const ErrorScreen(), settings: settings);
    case "/loadingScreen":
      return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
    case "/productDetail":
      return MaterialPageRoute(builder: (_) => const ProductDetailScreen(), settings: settings);
    case "/orderSuccess":
      return MaterialPageRoute(builder: (_) => const OrderSuccessScreen(), settings: settings);
    case "/selectOptions":
      return MaterialPageRoute(builder: (_) => ProductSelectOptions(), settings: settings);
    case "/shippingAddress":
      return MaterialPageRoute(builder: (_) => ShippingAddressScreen(), settings: settings);
    case "/orderSummary":
      return MaterialPageRoute(builder: (_) => OrderSummaryScreen(), settings: settings);
    case "/orderCancel":
      return MaterialPageRoute(builder: (_) => OrderCancelScreen(), settings: settings);
    case "/trackingList":
      return MaterialPageRoute(builder: (_) => TrackingListScreen(), settings: settings);
    case "/tracking":
      return MaterialPageRoute(builder: (_) => TrackingDetailScreen(), settings: settings);
    case "/refundFormTracking":
      return MaterialPageRoute(builder: (_) => RefundFormTrackingScreen(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);
  }
}

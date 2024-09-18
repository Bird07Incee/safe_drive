import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/routes/change_history_url_strategy.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

void setUrlStrategyListener<T extends ChangeHistoryUrlStrategy>(T setUrlDestination, {bool preventGoBack = false}) {
  if (!preventGoBack) {
    urlStrategyPromptBuy = setUrlDestination;
  }
}

refreshRoute(
    {required BuildContext context,
    required String currentRoute,
    required String queryParams,
    List<ProductionOptionals>? listOption,
    bool dontNavigate = false,
    bool fromDialog = false}) {
  switch (currentRoute) {
    case "summary":
      if (CurrentRouteObserver.instance.stack.contains('${Routes.productDetail.toStringPath()}?$queryParams')) {
        // Navigator.popUntil(context, (route) {
        //   print("route $route");
        //   if (CurrentRouteObserver.instance.stack.contains('${Routes.selectOptions.toStringPath()}?$queryParams')) {
        //     CurrentRouteObserver.instance.stack.removeRange(
        //         CurrentRouteObserver.instance.stack.indexWhere((element) => element.contains('${Routes.selectOptions.toStringPath()}?$queryParams')),
        //         CurrentRouteObserver.instance.stack.length);
        //   }
        //   return route.settings.name!.contains('${Routes.productDetail.toStringPath()}?$queryParams');
        // });
        Navigator.pop(context);
      } else {
        CurrentRouteObserver.instance.stack.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
        Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      }
      break;
    case "selectOption":
      if (CurrentRouteObserver.instance.stack.contains('${Routes.productDetail.toStringPath()}?$queryParams')) {
        Navigator.pop(context);
      } else {
        CurrentRouteObserver.instance.stack.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
        Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      }
      break;
    case "address":
      if (CurrentRouteObserver.instance.stack.contains(Routes.orderSummary.toStringPath())) {
        Navigator.pop(context);
      } else {
        CurrentRouteObserver.instance.stack.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
        Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
        Navigator.pushNamed(context, '${Routes.selectOptions.toStringPath()}?$queryParams');
        Navigator.pushNamed(context, '${Routes.orderSummary.toStringPath()}?$queryParams');
      }

      break;
    case "initial" || "orderSuccess":
      parallelUrlStrategy(context, Routes.initial.name, Routes.initial.toStringPath());
      break;
    case "refundSuccess":
      // parallelUrlStrategy(context, Routes.initial.name, Routes.initial.toStringPath());
      parallelUrlStrategy(context, Routes.trackingList.name, Routes.trackingList.toStringPath());
      //  parallelUrlStrategy(context, Routes.tracking.name, '${Routes.tracking.toStringPath()}?$queryParams');
      break;
    default:
      break;
  }
}

void parallelUrlStrategy(BuildContext context, String title, String url) {
  setUrlStrategyListener(ChangeHistoryUrlStrategy(title: title, urlPromptBuy: url));

  if (url == Routes.initial.toStringPath()) {
    Navigator.pushNamedAndRemoveUntil(context, url, (routes) => false);
  } else {
    Navigator.pushNamed(context, url);
  }
}

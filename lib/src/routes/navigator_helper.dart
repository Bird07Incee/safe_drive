import 'package:flutter/material.dart';
import 'package:autoStation_promptBuy/main.dart';
import 'package:autoStation_promptBuy/src/model/product_list.dart';
import 'package:autoStation_promptBuy/src/routes/change_history_url_strategy.dart';
import 'package:autoStation_promptBuy/src/routes/routes.dart';

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
  CurrentRouteObserver.instance.stack.clear();
  switch (currentRoute) {
    case "summary":
      Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      break;
    case "selectOption":
      Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      break;
    case "address":
      Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      Navigator.pushNamed(context, '${Routes.selectOptions.toStringPath()}?$queryParams');
      Navigator.pushNamed(context, '${Routes.orderSummary.toStringPath()}?$queryParams');
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

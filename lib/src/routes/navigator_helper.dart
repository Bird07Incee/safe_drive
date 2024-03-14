import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

void refreshRoute({required BuildContext context, required String currentRoute, required String queryParams, List<ProductionOptionals>? listOption}) {
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
      Navigator.pushNamed(context, '${Routes.orderSummary.toStringPath()}?$queryParams');
      Navigator.pushNamed(context, '${Routes.selectOptions.toStringPath()}?$queryParams');
      break;
    case "refundSuccess":
      Navigator.pushNamedAndRemoveUntil(context, '/', (routes) => false);
      Navigator.pushNamed(context, Routes.trackingList.toStringPath());
      Navigator.pushNamed(context, '${Routes.tracking.toStringPath()}?$queryParams');
      break;
    default:
      break;
  }
}

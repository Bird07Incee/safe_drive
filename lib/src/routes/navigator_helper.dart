import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

void refreshRoute({required BuildContext context, required String currentRoute, required String queryParams}) {
  switch (currentRoute) {
    case "summary":
      Navigator.pushNamed(context, '/');
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      break;
    case "selectOption":
      Navigator.pushNamed(context, '/');
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      break;
    case "address":
      Navigator.pushNamed(context, '/');
      Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?$queryParams');
      Navigator.pushNamed(context, '${Routes.orderSummary.toStringPath()}?$queryParams');
      Navigator.pushNamed(context, '${Routes.selectOptions.toStringPath()}?$queryParams');
      break;
    default:
      break;
  }
}

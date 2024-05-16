import 'package:autoStation_promptBuy/src/model/product_list.dart';

double getDisplayPrice(double price, List<ProductionOptionals> option) {
  var result = price;

  if (option.isNotEmpty) {
    option.sort((a, b) => a.price.compareTo(b.price));
    result = option.first.price;
  }

  return result;
}

import 'package:marketplace_line_oa/src/model/product_list.dart';

int getDisplayPrice(int price, List<ProductionOptionals> option) {
  var result = price;
  var optionList = option.toList();

  if (optionList.isNotEmpty) {
    option.sort((a, b) => a.price.compareTo(b.price));
    result = option.first.price;
  }

  return result;
}

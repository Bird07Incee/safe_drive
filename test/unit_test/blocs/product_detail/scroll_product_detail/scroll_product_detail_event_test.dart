import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';

void main() {
  group("ScrollProductDetailEvent state", (){
    test("ProductDetailScrollAction supports comparisons", (){
      expect(ProductDetailScrollAction(0.0, 0.0, ""), ProductDetailScrollAction(0.0, 0.0, ""));
    });
  });
}
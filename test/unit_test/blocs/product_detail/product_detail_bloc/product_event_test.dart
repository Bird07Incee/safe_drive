import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';

void main() {
  group("ProductDetail state", (){
    test("SetProduct supports comparisons", (){
      expect(const SetProduct(product: Product.empty).props, const SetProduct(product: Product.empty).props);
    });

    test("GetProductById supports comparisons", (){
      expect(const GetProductByID(pid: 'test').props, const GetProductByID(pid: 'test').props);
    });

    test("SetClickFromImage supports comparisons", (){
      expect(const SetClickFromImage(isClickFromImage: true).props, const SetClickFromImage(isClickFromImage: true).props);
    });
  });
}
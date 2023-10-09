import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';

void main() {
  group("ProductDetail state", (){
    test("SetProduct supports comparisons", (){
      expect(const SetProduct(product: Product.empty), const SetProduct(product: Product.empty));
    });

    test("GetProductById supports comparisons", (){
      expect(const GetProductByID(pid: 'test'), const GetProductByID(pid: 'test'));
    });

    test("SetClickFromImage supports comparisons", (){
      expect(const SetClickFromImage(isClickFromImage: true), const SetClickFromImage(isClickFromImage: true));
    });
  });
}
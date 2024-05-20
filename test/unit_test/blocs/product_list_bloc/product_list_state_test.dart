import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';

void main() {
  group("ContactState", (){
    test('supports comparisons', () {
      expect(const ProductListState(), const ProductListState().copyWith());
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';

void main() {
  group('XProductDetailStatus ', () {
    test('returns correct values for ProductDetailStatus.initial', () {
      const status = ProductDetailStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for ProductDetailStatus.success', () {
      const status = ProductDetailStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
    });

    test('returns correct values for ProductDetailStatus.loading', () {
      const status = ProductDetailStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for ProductDetailStatus.error', () {
      const status = ProductDetailStatus.error;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
    });
  });

  group("ContactState", (){
    test('supports comparisons', () {
      expect(const ProductDetailState(), const ProductDetailState().copyWith());
    });
  });
}
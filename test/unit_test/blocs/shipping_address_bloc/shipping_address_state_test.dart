import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/shipping_address/shipping_address_bloc.dart';

void main() {
  group('AddressStatusX ', () {
    test('returns correct values for ShippingAddressStatus.initial', () {
      const status = ShippingAddressStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
      expect(status.isFetching, isFalse);
    });

    test('returns correct values for ShippingAddressStatus.success', () {
      const status = ShippingAddressStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
      expect(status.isFetching, isFalse);
    });

    test('returns correct values for ShippingAddressStatus.loading', () {
      const status = ShippingAddressStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
      expect(status.isFetching, isFalse);
    });

    test('returns correct values for ShippingAddressStatus.error', () {
      const status = ShippingAddressStatus.error;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
      expect(status.isFetching, isFalse);
    });

    test('returns correct values for ShippingAddressStatus.isFetching', () {
      const status = ShippingAddressStatus.fetching;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
      expect(status.isFetching, isTrue);
    });
  });

  group("OrderSummaryState", () {
    test('supports comparisons', () {
      expect(const ShippingAddressState(), const ShippingAddressState().copyWith());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/shipping_address/shipping_address_bloc.dart';

void main() {
  group("ShippingAddressEvent state", () {
    test("ShippingAddressEvent supports comparisons", () {
      expect(const ShippingAddressEvent().props, const ShippingAddressEvent().props);
    });

    test("SetFormWidget supports comparisons", () {
      expect(const SetFormWidget(listResult: [], listForm: []).props, const SetFormWidget(listResult: [], listForm: []).props);
    });
  });
}

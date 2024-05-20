import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/model/tracking_model.dart';

// extension StatusNameX on String {
//   bool get isPending => this == "Pending";
//   bool get isPreparing => this == "Preparing/Packed";
//   bool get isPreparingSelfServiceFail => this == "PreparingSelfServiceFail";
//   bool get isShipped => this == "Shipped";
//   bool get isShippingFail => this == "ShippingFail";
//   bool get isReceived => this == "Received";
//   bool get isRefundRequest => this == "RefundRequest";
//   bool get isRefundSuccess => this == "RefundSuccess";
//   bool get isRefundRejected => this == "RefundRejected";
// }

void main() {
  group('StatusNameX ', () {
    test('returns correct bool value for isPending', () {
      const s = "Pending";
      expect(s.isPending, true);
    });

    test('returns correct bool value for "Preparing/Packed"', () {
      const s = "Preparing/Packed";
      expect(s.isPreparing, true);
    });

    test('returns correct bool value for PreparingSelfServiceFail', () {
      const s = "PreparingSelfServiceFail";
      expect(s.isPreparingSelfServiceFail, true);
    });

    test('returns correct bool value for Shipped', () {
      const s = "Shipped";
      expect(s.isShipped, true);
    });

    test('returns correct bool value for ShippingFail', () {
      const s = "ShippingFail";
      expect(s.isShippingFail, true);
    });

    test('returns correct bool value for Received', () {
      const s = "Received";
      expect(s.isReceived, true);
    });

    test('returns correct bool value for RefundRequest', () {
      const s = "RefundRequest";
      expect(s.isRefundRequest, true);
    });

    test('returns correct bool value for RefundSuccess', () {
      const s = "RefundSuccess";
      expect(s.isRefundSuccess, true);
    });

    test('returns correct bool value for RefundRejected', () {
      const s = "RefundRejected";
      expect(s.isRefundRejected, true);
    });
  });

  group('StatX ', () {
    test('returns correct bool value for isActive', () {
      const s = "active";
      expect(s.isActive, true);
    });
  });
}

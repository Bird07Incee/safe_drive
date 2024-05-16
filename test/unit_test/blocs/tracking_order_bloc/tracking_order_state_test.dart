import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';

void main() {
  group("ContactState", (){
    test('supports comparisons', () {
      expect(const TrackingOrderState(), const TrackingOrderState().copyWith());
    });
  });
}
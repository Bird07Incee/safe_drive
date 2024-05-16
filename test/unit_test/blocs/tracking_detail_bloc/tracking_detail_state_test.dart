import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/tracking_detail/tracking_detail_bloc.dart';

void main() {
  group('TrackingDetailStatusX ', () {
    test('returns correct values for TrackingDetailStatus.initial', () {
      const status = TrackingDetailStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for TrackingDetailStatus.success', () {
      const status = TrackingDetailStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
    });

    test('returns correct values for TrackingDetailStatus.loading', () {
      const status = TrackingDetailStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for TrackingDetailStatus.error', () {
      const status = TrackingDetailStatus.error;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
    });
  });
}
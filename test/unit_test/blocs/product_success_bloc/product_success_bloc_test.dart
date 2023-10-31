import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_success/order_success_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

void main() {
  late DioUtilityRepository utilityRepository;
  group('OrderSuccessBloc', () {
    // Test initial state
    setUp(
          () {
            WidgetsFlutterBinding.ensureInitialized();
            utilityRepository = MockDioUtilityRepository();
          }
    );
    test(
      'initial state [ProductDetailStatus.initial]',
          () {
        expect(
          OrderSuccessBloc(utilityRepository: utilityRepository).state.orderSuccessStatus,
          GetOrderSuccessDataStatus.initial,
        );
      },
    );
  });
}
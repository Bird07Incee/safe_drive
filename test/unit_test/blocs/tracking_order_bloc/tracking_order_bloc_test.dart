import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/configs/enivironment_config.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:autoStation_promptBuy/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;

  group('TrackingOrderBloc', () {
    late MockBuildContext mockBuildContext;
    // Test initial state
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
    });
    test(
      'initial state',
      () {
        expect(
          TrackingOrderBloc(utilityRepository: utilityRepository).state.trackingOrderListStatus,
          GetTrackingOrderListStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          TrackingOrderBloc(utilityRepository: utilityRepository).state,
          TrackingOrderBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    // blocTest<TrackingOrderBloc, TrackingOrderState>("getTrackingOrder  success",
    //     setUp: () {
    //       mockBuildContext = MockBuildContext();
    //       SharedPreferences.setMockInitialValues({});
    //       final baseUrl = Environment().getValue("BFF_BASE_URL");
    //       final transactionApiPath =
    //           Environment().getValue("BFF_TRANSACTION_TRACKING_BASE_URL");
    //       String path = "/v1/trackingList";
    //       when(() {
    //         return utilityRepository.getByURL(
    //             "$baseUrl$transactionApiPath$path", {},
    //             headers: {"Authorization": "Bearer "});
    //       }).thenAnswer(
    //         (_) async {
    //           RequestOptions option = RequestOptions(
    //               baseUrl: "$baseUrl$transactionApiPath",
    //               method: "GET",
    //               data: {},
    //               headers: {"Authorization": "Bearer "});
    //           return Response(
    //               requestOptions: option,
    //               data: mockProductListResponse,
    //               statusCode: 200,
    //               statusMessage: "OK");
    //         },
    //       );
    //     },
    //     build: () => TrackingOrderBloc(utilityRepository: utilityRepository),
    //     act: (bloc) =>
    //         bloc.add(GetTrackingOrderListByPage(1, mockBuildContext)),
    //     expect: () => <TrackingOrderState>[
    //           TrackingOrderState(
    //               trackingOrderListStatus: GetTrackingOrderListStatus.loading),
    //           // ProductListState(productListStatus: GetProductListStatus.success, productList: ProductList.fromJson(mockProductListResponse))
    //         ]);

    blocTest<TrackingOrderBloc, TrackingOrderState>("getTrackingOrder error",
        setUp: () {
          mockBuildContext = MockBuildContext();
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_TRACKING_BASE_URL");
          String path = "/v1/trackingList";
          when(() {
            return utilityRepository.getByURL("$baseUrl$transactionApiPath$path", {});
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => TrackingOrderBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetTrackingOrderListByPage(1, mockBuildContext)),
        expect: () => <TrackingOrderState>[
              TrackingOrderState(trackingOrderListStatus: GetTrackingOrderListStatus.loading),
              TrackingOrderState(trackingOrderListStatus: GetTrackingOrderListStatus.error)
            ]);
  });
}

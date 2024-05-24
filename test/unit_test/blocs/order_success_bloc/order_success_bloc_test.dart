import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_success/order_success_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;
  Map<String, dynamic> mockResponse = {
    "status": "Complete",
    "rawData": {
      "invoiceNo": "1234",
      "payment_card": "987654******1234",
      "payment_date": "1 ตุลาคม 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max from mercury-mocker",
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร"],
      "product_price": "56640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "0812345678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address": "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "0918620511",
    }
  };

  Map<String, dynamic> mockResponsePending = {
    "status": "Pending",
    "rawData": {
      "invoiceNo": "1234",
      "payment_card": "987654******1234",
      "payment_date": "1 ตุลาคม 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max from mercury-mocker",
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร"],
      "product_price": "56640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "0812345678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address": "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "0918620511",
    }
  };

  Map<String, dynamic> mockResponseFail = {
    "status": "Fail",
    "rawData": {
      "invoiceNo": "1234",
      "payment_card": "987654******1234",
      "payment_date": "1 ตุลาคม 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max from mercury-mocker",
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร"],
      "product_price": "56640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "0812345678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address": "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "0918620511",
    }
  };

  Map<String, dynamic> mockResponseNoStatus = {
    "status": "",
    "rawData": {
      "invoiceNo": "1234",
      "payment_card": "987654******1234",
      "payment_date": "1 ตุลาคม 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max from mercury-mocker",
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร"],
      "product_price": "56640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "0812345678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address": "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "0918620511"
    }
  };

  final InquiryData inquiryData = InquiryData.fromJson(mockResponse["rawData"]);
  final InquiryData inquiryDataPending = InquiryData.fromJson(mockResponsePending["rawData"]);

  group('OrderSuccessBloc', () {
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
          OrderSuccessBloc(utilityRepository: utilityRepository).state.orderSuccessStatus,
          GetOrderSuccessDataStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          OrderSuccessBloc(utilityRepository: utilityRepository).state,
          OrderSuccessBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    blocTest<OrderSuccessBloc, OrderSuccessState>("set order status",
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(const SetOrderStatus(GetOrderSuccessDataStatus.success)),
        expect: () => <OrderSuccessState>[OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.success)]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          var payload = {"invoiceNo": "1234", "uid": "1234"};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.success, orderSuccessData: inquiryData)
            ]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess success Status Pending then Completed",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          var payload = {"invoiceNo": "1234", "uid": "1234"};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponsePending, statusCode: 200, statusMessage: "OK");
            },
          );
          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload, isRetry: true);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.success, orderSuccessData: inquiryDataPending),
            ]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess success Status Pending then Fail",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          var payload = {"invoiceNo": "1234", "uid": "1234"};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponsePending, statusCode: 200, statusMessage: "OK");
            },
          );
          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload, isRetry: true);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponseFail, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.cancel),
            ]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess fail",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          var payload = {"invoiceNo": "1234", "uid": ""};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponseFail, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.cancel)
            ]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess error NoStatus",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          var payload = {"invoiceNo": "1234", "uid": ""};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: mockResponseNoStatus, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.error)
            ]);

    blocTest<OrderSuccessBloc, OrderSuccessState>("OrderSuccess error catch exception",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_INQUIRY_BASE_URL");
          final inquriyPath = Environment().getValue("INQUIRY_URL");
          var payload = {"invoiceNo": "1234", "uid": ""};

          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$transactionApiPath$inquriyPath", method: "POST", data: payload);
              return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => OrderSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetOrderSuccess(mockBuildContext, "1234", bypassContext: true)),
        expect: () => <OrderSuccessState>[
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.loading),
              OrderSuccessState(orderSuccessStatus: GetOrderSuccessDataStatus.error)
            ]);
  });
}

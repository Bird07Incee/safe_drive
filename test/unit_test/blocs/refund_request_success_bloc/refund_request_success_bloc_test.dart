import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_success_data_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_event.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_state.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;
  Map<String, dynamic> mockResponse = {
    "status": "Complete",
    "refundInfo": {
      "refundNo": "RFLA20240215100358LXVdT",
      "refundDate": "15 กุมภาพันธ์ 2567",
      "refundTime": "10:03:58",
      "reason": "test reason ipp",
      "remark": "test remark ipp"
    },
    "rawData": {
      "invoiceNo": "LA20231121153204CgSTp",
      "cardNo": "439137XXXXXX0006",
      "paymentDate": "21 พฤศจิกายน 2566",
      "paymentTime": "15:34:16",
      "paymentGateway": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)",
      "paymentChannel": "IPP",
      "productImagePath": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_2.jpg",
      "productId": "P005",
      "productName": "Palsar Max EV4",
      "productOption": "",
      "amount": "10000.0",
      "customerFullname": "Mr Ship Add",
      "customerMobile": "0810155211",
      "customerEmail": "atirat.chunsith@gmail.com",
      "customerAddress": "333/23 แขวงทุ่งสองห้อง เขตมีนบุรี จ.กรุงเทพ 10110",
      "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
      "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท เขตพญาไท กทม 10400",
      "merchantMobile": "091-862-5011",
      "paymentChannelText": "ผ่อนชำระ 3 เดือน"
    }
  };

  Map<String, dynamic> mockResponseFail = {
    "status": "Fail",
    "refundInfo": {
      "refundNo": "RFLA20240215100358LXVdT",
      "refundDate": "15 กุมภาพันธ์ 2567",
      "refundTime": "10:03:58",
      "reason": "test reason ipp",
      "remark": "test remark ipp"
    },
    "rawData": {
      "invoiceNo": "LA20231121153204CgSTp",
      "cardNo": "439137XXXXXX0006",
      "paymentDate": "21 พฤศจิกายน 2566",
      "paymentTime": "15:34:16",
      "paymentGateway": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)",
      "paymentChannel": "IPP",
      "productImagePath": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_2.jpg",
      "productId": "P005",
      "productName": "Palsar Max EV4",
      "productOption": "",
      "amount": "10000.0",
      "customerFullname": "Mr Ship Add",
      "customerMobile": "0810155211",
      "customerEmail": "atirat.chunsith@gmail.com",
      "customerAddress": "333/23 แขวงทุ่งสองห้อง เขตมีนบุรี จ.กรุงเทพ 10110",
      "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
      "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท เขตพญาไท กทม 10400",
      "merchantMobile": "091-862-5011",
      "paymentChannelText": "ผ่อนชำระ 3 เดือน"
    }
  };

  RefundSuccessDataModel refundData = RefundSuccessDataModel.fromJson(mockResponse);

  group('RefundSuccessBloc', () {
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
          RefundSuccessBloc(utilityRepository: utilityRepository).state.refundSuccessStatus,
          GetRefundSuccessDataStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          RefundSuccessBloc(utilityRepository: utilityRepository).state,
          RefundSuccessBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    blocTest<RefundSuccessBloc, RefundSuccessState>("RefundRequestSuccess success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
          final inquiryRefundPath = Environment().getValue("INQUIRY_REFUND_URL");

          when(() {
            return utilityRepository.getByURL(
              "$baseUrl$transactionApiPath$inquiryRefundPath",
              {"invoiceNo": "RFLA20240215100358LXVdT"},
            );
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(
                  baseUrl: "$baseUrl$transactionApiPath$inquiryRefundPath", method: "GET", data: {"invoiceNo": "RFLA20240215100358LXVdT"});
              return Response(requestOptions: option, data: mockResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => RefundSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetRefundSuccess(mockBuildContext, "RFLA20240215100358LXVdT", bypassContext: true)),
        expect: () => <RefundSuccessState>[
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.loading),
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.success, refundSuccessData: refundData)
            ]);

    blocTest<RefundSuccessBloc, RefundSuccessState>("RefundRequestSuccess error",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
        },
        build: () => RefundSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetRefundSuccess(mockBuildContext, "RFLA20240215100358LXVdT", bypassContext: true)),
        expect: () => <RefundSuccessState>[
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.loading),
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.error)
            ]);

    blocTest<RefundSuccessBloc, RefundSuccessState>("RefundRequestSuccess clearState",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
        },
        build: () => RefundSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(OnClearState()),
        expect: () => <RefundSuccessState>[
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.initial, refundSuccessData: RefundSuccessDataModel.empty),
            ]);

    blocTest<RefundSuccessBloc, RefundSuccessState>("RefundRequestSuccess status fail",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
          final inquiryRefundPath = Environment().getValue("INQUIRY_REFUND_URL");

          when(() {
            return utilityRepository.getByURL(
              "$baseUrl$transactionApiPath$inquiryRefundPath",
              {"invoiceNo": "RFLA20240215100358LXVdT"},
            );
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(
                  baseUrl: "$baseUrl$transactionApiPath$inquiryRefundPath", method: "GET", data: {"invoiceNo": "RFLA20240215100358LXVdT"});
              return Response(requestOptions: option, data: mockResponseFail, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => RefundSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetRefundSuccess(mockBuildContext, "RFLA20240215100358LXVdT", bypassContext: true)),
        expect: () => <RefundSuccessState>[
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.loading),
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.error)
            ]);

    blocTest<RefundSuccessBloc, RefundSuccessState>("RefundRequestSuccess status 400",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          mockBuildContext = MockBuildContext();
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
          final inquiryRefundPath = Environment().getValue("INQUIRY_REFUND_URL");

          when(() {
            return utilityRepository.getByURL(
              "$baseUrl$transactionApiPath$inquiryRefundPath",
              {"invoiceNo": "RFLA20240215100358LXVdT"},
            );
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(
                  baseUrl: "$baseUrl$transactionApiPath$inquiryRefundPath", method: "GET", data: {"invoiceNo": "RFLA20240215100358LXVdT"});
              return Response(requestOptions: option, data: mockResponseFail, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => RefundSuccessBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetRefundSuccess(mockBuildContext, "RFLA20240215100358LXVdT", bypassContext: true)),
        expect: () => <RefundSuccessState>[
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.loading),
              RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.error)
            ]);
  });
}

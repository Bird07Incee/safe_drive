import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_request/refund_request_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;
  test("RefundRequestEvent supports comparisons", () {
    expect(RefundRequestEvent().props, RefundRequestEvent().props);
  });

  test("SetRefundData supports comparisons", () {
    expect(SetRefundData(orderNo: '', reasonList: const []).props, SetRefundData(orderNo: '', reasonList: const []).props);
  });

  group('RefundRequestBloc', () {
    // Test initial state
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
    });
    test(
      'initial state',
      () {
        expect(
          RefundRequestBloc(utilityRepository: utilityRepository).state.refundRequestStatus,
          GetRefundRequestStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          RefundRequestBloc(utilityRepository: utilityRepository).state,
          RefundRequestBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    var inquiryDataExpected = InquiryData.fromJson(mockInquiry["rawData"] as Map<String, dynamic>);
    var orderNo = "LA202402081707425tpvy";
    List<DropdownAddressModel> mockReasonList = [
      DropdownAddressModel(id: "1", nameTh: "เปลื่ยนใจ"),
      DropdownAddressModel(id: "2", nameTh: "ได้รับสินค้าไม่ตรงตามที่สั่ง"),
      DropdownAddressModel(id: "3", nameTh: "สินค้าสภาพไม่ดี หรือมีความเสียหาย"),
      DropdownAddressModel(id: "4", nameTh: "ฉันไม่ได้รับพัสดุของคำสั่งซื้อนี้"),
      DropdownAddressModel(id: "5", nameTh: "ได้รับสินค้าไม่ครบ หรือชิ้นส่วนไม่สมบูรณ์"),
      DropdownAddressModel(id: "6", nameTh: "การทำงานของสินค้าไม่สมบูรณ์")
    ];

    blocTest<RefundRequestBloc, RefundRequestState>("onSetRefundData Success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
          String path = "/v1/inquiry";
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$path", {"invoiceNo": "LA202402081707425tpvy", "uid": "1234"},
                headers: {"Authorization": "Bearer "});
          }).thenAnswer(
            (_) async {
              RequestOptions option =
                  RequestOptions(baseUrl: "$baseUrl$transactionApiPath", method: "POST", data: mockInquiry, headers: {"Authorization": accessToken});
              return Response(requestOptions: option, data: mockInquiry, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => RefundRequestBloc(utilityRepository: utilityRepository),
        act: (bloc) {
          bloc.add(SetRefundData(orderNo: orderNo, reasonList: mockReasonList));
        },
        expect: () {
          return <RefundRequestState>[
            RefundRequestState(refundRequestStatus: GetRefundRequestStatus.loading, orderNo: '', refundResponse: const {}),
            RefundRequestState(
                refundRequestStatus: GetRefundRequestStatus.success,
                inquiryData: inquiryDataExpected,
                reasonList: mockReasonList,
                getTextReason: "",
                getTextRemark: "",
                orderNo: '',
                refundResponse: const {}),
          ];
        });

    blocTest<RefundRequestBloc, RefundRequestState>("onSelectReason Success",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => RefundRequestBloc(utilityRepository: utilityRepository),
        act: (bloc) {
          bloc.add(OnSelectReason(getTextReason: 'เปลื่ยนใจ', getTextRemark: 'ฉันต้องการสินค้าชิ้นอื่น'));
        },
        expect: () {
          return <RefundRequestState>[
            RefundRequestState(
                getTextReason: "เปลื่ยนใจ",
                getTextRemark: "ฉันต้องการสินค้าชิ้นอื่น",
                orderNo: "",
                refundRequestStatus: GetRefundRequestStatus.success,
                refundResponse: const {}),
          ];
        });

    blocTest<RefundRequestBloc, RefundRequestState>("onEditRemark Success",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => RefundRequestBloc(utilityRepository: utilityRepository),
        act: (bloc) {
          bloc.add(OnEditRemark(getTextReason: 'เปลื่ยนใจ', getTextRemark: 'ฉันต้องการสินค้าชิ้นอื่น'));
        },
        expect: () {
          return <RefundRequestState>[
            RefundRequestState(
                getTextReason: "เปลื่ยนใจ",
                getTextRemark: "ฉันต้องการสินค้าชิ้นอื่น",
                orderNo: "",
                refundRequestStatus: GetRefundRequestStatus.success,
                refundResponse: const {}),
          ];
        });

    blocTest<RefundRequestBloc, RefundRequestState>("onSubmit Success",
        setUp: () async {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
          String path = "/v1/refund";
          final mock = {"uid": "1234"};
          await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
          var data = {"orderNo": "", "reason": "", "remark": ""};
          when(() {
            return utilityRepository.postByURL("$baseUrl$transactionApiPath$path", data, headers: {"Authorization": "Bearer "});
          }).thenAnswer(
            (_) async {
              RequestOptions option =
                  RequestOptions(baseUrl: "$baseUrl$transactionApiPath", method: "POST", data: mockRefund, headers: {"Authorization": accessToken});
              return Response(requestOptions: option, data: mockRefund, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => RefundRequestBloc(utilityRepository: utilityRepository),
        act: (bloc) {
          bloc.add(OnSubmitRefundData());
        },
        expect: () {
          return <RefundRequestState>[
            RefundRequestState(refundRequestStatus: GetRefundRequestStatus.loading, orderNo: '', refundResponse: const {}),
            RefundRequestState(refundRequestStatus: GetRefundRequestStatus.submitSuccess, refundResponse: mockRefund, orderNo: ''),
          ];
        });
  });
}

var accessToken =
    "Bearer AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQEinRtOcLO8057VrfIx9Z14AAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAx4fQl/DQFbtUkupuECARCAggEH6AeT4RzI/DgL+c495y4nsKyyMcrccaZItW7Awu5ZO998o4DR9nCs0SZHfvQS5AQBH8fmYQv0JddWlJ4eaHgulh50/QW778eJZ4z1wL5k3heTxyXn9KO7MxgsuH2nKWWDLWRLQ9MWj5lbGYR2nr51uhhsByKtqhLtXQzQm8HxFZaY9MH1Xe2JB1yChCDN0EktfqQocAQ3NtMxpB2nLWiW5AXmy1VY+/UFDByV3uQ+ukx/4tpkU6QBjfbfw/SoKdOOI9iDK34QLQ6PIf/mslSK9fPmaC5Ar/fvZooMgEvtd4bBx95byPN1nKUh0GPw1yFLRNUUpmFYdS3zgKXJy8vIBPVttKZtcgI=";
var mockInquiry = {
  "status": "Complete",
  "rawData": {
    "invoiceNo": "LA202402081707425tpvy",
    "cardNo": "XXXXXXXXXXXX0006",
    "paymentDate": "8 กุมภาพันธ์ 2567",
    "paymentTime": "17:08:12",
    "paymentGateway": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)",
    "paymentChannel": "CC",
    "productImagePath":
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20231225_035156_Privilege_XK099RS.png?sv=2020-08-04&se=2028-11-28T08%3A51%3A56Z&sr=b&sp=r&sig=1aVZGa3bm5eiP5sU9mwhgw5z5Vb7XBWxwz%2BO6i%2Flghs%3D",
    "productId": "PV_2Q3HC9TC7ONG",
    "productName": "Pulsa Max Kook EV 2 Opt 1 Mer1 ",
    "productOption": " Kook EV 2 Opt 3 Mer1 สายสีน้ำเงิน",
    "amount": "47,890",
    "customerFullname": "callback success",
    "customerMobile": "0810155211",
    "customerEmail": "atirat.chunsith@gmail.com",
    "customerAddress": "67  คันนายาว คันนายาว กรุงเทพมหานคร 10230",
    "merchantFullName": "ChocoCard Store",
    "merchantAddress": "2150/4  ถนนสุขุมวิท บางจาก พระโขนง กรุงเทพมหานคร 10260",
    "merchantMobile": "0123456789",
    "paymentChannelText": "ชำระเต็มจำนวน"
  }
};

var mockRefund = {
  "status": "Complete",
  "refundInfo": {
    "refundNo": "LA202402081707425tpvy",
    "refundDate": "15 กุมภาพันธ์ 2567",
    "refundTime": "10:03:58",
    "reason": "เปลี่ยนใจ",
    "remark": "ฉันต้องการสินค้าชิ้นอื่น"
  },
  "rawData": {
    "invoiceNo": "LA202402081707425tpvy",
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

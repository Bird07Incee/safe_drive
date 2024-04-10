import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_detail/tracking_detail_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;
  test("TrackingDetailEvent supports comparisons", () {
    expect(TrackingDetailEvent().props, TrackingDetailEvent().props);
  });

  test("GetTracking supports comparisons", () {
    expect(GetTracking().props, GetTracking().props);
  });

  group('TrackingOrderBloc', () {
    // Test initial state
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
    });
    test(
      'initial state',
      () {
        expect(
          TrackingDetailBloc(utilityRepository: utilityRepository).state.status,
          TrackingDetailStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          TrackingDetailBloc(utilityRepository: utilityRepository).state,
          TrackingDetailBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    blocTest<TrackingDetailBloc, TrackingDetailState>("onGetTrackingDetail Success",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_TRACKING_BASE_URL");
          String path = "/v1/trackingDetail";
          when(() {
            return utilityRepository.getByURL(
              "$baseUrl$transactionApiPath$path",
              {"orderNo": "LA202402081707425tpvy", "productId": "PV_2Q3HC9TC7ONG"},
            );
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(
                  baseUrl: "$baseUrl$transactionApiPath", method: "GET", data: mockTrackingDetail, headers: {"Authorization": accessToken});
              return Response(requestOptions: option, data: mockTrackingDetail, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => TrackingDetailBloc(utilityRepository: utilityRepository),
        act: (bloc) {
          var orderNo = "LA202402081707425tpvy";
          var productId = "PV_2Q3HC9TC7ONG";
          bloc.add(GetTracking(orderNo: orderNo, productId: productId));
        },
        expect: () => <TrackingDetailState>[
              TrackingDetailState(status: TrackingDetailStatus.loading),
              TrackingDetailState(status: TrackingDetailStatus.success, tracking: TrackingResponseModel.fromJson(mockTrackingDetail).tracking),
            ]);
  });
}

var accessToken =
    "Bearer AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQEinRtOcLO8057VrfIx9Z14AAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAx4fQl/DQFbtUkupuECARCAggEH6AeT4RzI/DgL+c495y4nsKyyMcrccaZItW7Awu5ZO998o4DR9nCs0SZHfvQS5AQBH8fmYQv0JddWlJ4eaHgulh50/QW778eJZ4z1wL5k3heTxyXn9KO7MxgsuH2nKWWDLWRLQ9MWj5lbGYR2nr51uhhsByKtqhLtXQzQm8HxFZaY9MH1Xe2JB1yChCDN0EktfqQocAQ3NtMxpB2nLWiW5AXmy1VY+/UFDByV3uQ+ukx/4tpkU6QBjfbfw/SoKdOOI9iDK34QLQ6PIf/mslSK9fPmaC5Ar/fvZooMgEvtd4bBx95byPN1nKUh0GPw1yFLRNUUpmFYdS3zgKXJy8vIBPVttKZtcgI=";
var mockTrackingDetail = {
  "order_ref": "LA202402081707425tpvy",
  "order_create": "2024-02-08 17:07:44",
  "refund_day": 20,
  "merchant_info": {
    "merchant_id": 4,
    "merchant_ref": "ID_ktXbdh1Eenye",
    "name": "ChocoCard Store",
    "email": "lovememorial.nara@gmail.com",
    "merchant_logo":
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240112_105610_merchant_0IBPRWY.jpg?sv=2020-08-04&se=2028-12-16T03%3A56%3A10Z&sr=b&sp=r&sig=6obayR1LQvADR%2Bu6HDjasFMyxvT7%2BAPjWp7GSzmcUEY%3D",
    "_2c2p_id": "764764000013086",
    "address": null,
    "house_no": "2150/4",
    "village_no": null,
    "building": null,
    "lane": "-",
    "street": " ถนนสุขุมวิท",
    "sub_district": "บางจาก",
    "district": "พระโขนง",
    "province": "กรุงเทพมหานคร",
    "postal_code": "10260",
    "mobile_no": "0123456789",
    "tax_code": "WHT",
    "tax_percent": 2
  },
  "status": [
    {
      "status_name": "RefundSuccess",
      "state": "active",
      "status_date_time": "12 กุมภาพันธ์ 2567 03:00",
      "status_detail": [
        {"labelName": "title", "column1": "คืนเงินสำเร็จ\nการคืนเงินเป็นตามเงื่อนไขข้อตกลงของธนาคาร\nกรุณาตรวจสอบกับธนาคารผู้ออกบัตร"}
      ]
    },
    {
      "status_name": "Preparing/Packed",
      "state": "inactive",
      "service_type": "self",
      "status_date_time": "2 มกราคม 2567 02:00",
      "status_detail": [
        {"labelName": "title", "column1": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ กรุณาติดต่อกลับ"},
        {"labelName": "merchant_name", "column1": "ผู้ขาย", "column2": "ChocoCard Store"},
        {"labelName": "merchant_number", "column1": "เบอร์โทรติดต่อ", "column2": "0123456789"}
      ]
    },
    {
      "status_name": "Pending",
      "state": "inactive",
      "status_date_time": "8 กุมภาพันธ์ 2567 17:08",
      "status_detail": [
        {"labelName": "order_ref", "column1": "หมายเลขอ้างอิง", "column2": "LA202402081707425tpvy"},
        {"labelName": "card_number", "column1": "ชำระเงินโดย", "column2": "XXXXXXXXXXXX0006"},
        {"labelName": "payment_channel", "column1": "ช่องทางการชำระเงิน", "column2": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)"},
        {"labelName": "merchant_name", "column1": "ผู้รับเงิน", "column2": "ChocoCard Store"}
      ]
    }
  ]
};

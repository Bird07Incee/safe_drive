import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;

  List<Order>? listOrder = [];
  Map<String, dynamic> mockTrackingListResponse = {
    "totalCountItems": 51,
    "currentPage": 1,
    "totalPage": 6,
    "orders": [
      {
        "orderNo": "LA202405201616588bKQA",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.05,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_CVN3ZN6NKASD",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT Option",
            "productDescription": "\u0e2a\u0e35: \u0e2a\u0e35\u0e14\u0e33",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_063559_Privilege_7FLLXH5.jpg?sv=2020-08-04&se=2029-02-15T11%3A35%3A59Z&sr=b&sp=r&sig=Arf3UpelB19qNocbgCuEQHDwsBkMJ9RFZ35OjgfaZMI%3D",
            "productQty": 1,
            "price": 40000.05,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T18:35:43.0605627",
            "lastUpdateDate": "2024-05-20T16:22:49.7352078"
          }
        ]
      },
      {
        "orderNo": "LA20240516101418PCdRw",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.55,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_UVJWMDXFY0WU",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e42\u0e19 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT No Option",
            "productDescription": "",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_071133_Privilege_LEN4GFO.png?sv=2020-08-04&se=2029-02-15T12%3A11%3A33Z&sr=b&sp=r&sig=2Sm2qhtOdB6TAD5nri2z0DGM0GzDg5GPHt6ocktFlNI%3D",
            "productQty": 1,
            "price": 40000.55,
            "discountPrice": 2999.45,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T19:09:42.0345368",
            "lastUpdateDate": "2024-05-16T10:15:35.0556615"
          }
        ]
      },
      {
        "orderNo": "LA20240508104540JSNC3",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 3200.08,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_6TNHSHY137GO",
            "productNameTh": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt",
            "productNameEn": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt ",
            "productDescription":
                "\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32\u0e2b\u0e25\u0e31\u0e01 \u0e2a\u0e32\u0e22\u0e2a\u0e35\u0e14\u0e33: \u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt \u0e15\u0e31\u0e27\u0e17\u0e35\u0e48 1",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_111052_Privilege_XVOQ0L4.png?sv=2020-08-04&se=2029-02-15T04%3A10%3A52Z&sr=b&sp=r&sig=c8wFUD8tEpI9BXVjr4a3otuy%2BPKfUc6tW25cz92Bdfk%3D",
            "productQty": 1,
            "price": 3200.08,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T11:04:25.6526671",
            "lastUpdateDate": "2024-05-08T10:51:16.1573463"
          }
        ]
      },
      {
        "orderNo": "LA202405081047247tzcc",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.05,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_CVN3ZN6NKASD",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT Option",
            "productDescription": "\u0e2a\u0e35: \u0e2a\u0e35\u0e14\u0e33",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_063559_Privilege_7FLLXH5.jpg?sv=2020-08-04&se=2029-02-15T11%3A35%3A59Z&sr=b&sp=r&sig=Arf3UpelB19qNocbgCuEQHDwsBkMJ9RFZ35OjgfaZMI%3D",
            "productQty": 1,
            "price": 40000.05,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T18:35:43.0605627",
            "lastUpdateDate": "2024-05-08T10:50:16.4664963"
          }
        ]
      },
      {
        "orderNo": "LA20240507174211Xvv9p",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 3200.08,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_6TNHSHY137GO",
            "productNameTh": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt",
            "productNameEn": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt ",
            "productDescription":
                "\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32\u0e2b\u0e25\u0e31\u0e01 \u0e2a\u0e32\u0e22\u0e2a\u0e35\u0e14\u0e33: \u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt \u0e15\u0e31\u0e27\u0e17\u0e35\u0e48 1",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_111052_Privilege_XVOQ0L4.png?sv=2020-08-04&se=2029-02-15T04%3A10%3A52Z&sr=b&sp=r&sig=c8wFUD8tEpI9BXVjr4a3otuy%2BPKfUc6tW25cz92Bdfk%3D",
            "productQty": 1,
            "price": 3200.08,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T11:04:25.6526671",
            "lastUpdateDate": "2024-05-07T17:46:32.9685943"
          }
        ]
      },
      {
        "orderNo": "LA20240507174349F5v32",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.05,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_CVN3ZN6NKASD",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT Option",
            "productDescription": "\u0e2a\u0e35: \u0e2a\u0e35\u0e14\u0e33",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_063559_Privilege_7FLLXH5.jpg?sv=2020-08-04&se=2029-02-15T11%3A35%3A59Z&sr=b&sp=r&sig=Arf3UpelB19qNocbgCuEQHDwsBkMJ9RFZ35OjgfaZMI%3D",
            "productQty": 1,
            "price": 40000.05,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T18:35:43.0605627",
            "lastUpdateDate": "2024-05-07T17:44:44.003024"
          }
        ]
      },
      {
        "orderNo": "LA202405071722049Mfxi",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.05,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_CVN3ZN6NKASD",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT Option",
            "productDescription": "\u0e2a\u0e35: \u0e2a\u0e35\u0e14\u0e33",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_063559_Privilege_7FLLXH5.jpg?sv=2020-08-04&se=2029-02-15T11%3A35%3A59Z&sr=b&sp=r&sig=Arf3UpelB19qNocbgCuEQHDwsBkMJ9RFZ35OjgfaZMI%3D",
            "productQty": 1,
            "price": 40000.05,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T18:35:43.0605627",
            "lastUpdateDate": "2024-05-07T17:25:21.8710585"
          }
        ]
      },
      {
        "orderNo": "LA20240507172351W9D5G",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 3200.08,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_6TNHSHY137GO",
            "productNameTh": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt",
            "productNameEn": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt ",
            "productDescription":
                "\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32\u0e2b\u0e25\u0e31\u0e01 \u0e2a\u0e32\u0e22\u0e2a\u0e35\u0e14\u0e33: \u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt \u0e15\u0e31\u0e27\u0e17\u0e35\u0e48 1",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_111052_Privilege_XVOQ0L4.png?sv=2020-08-04&se=2029-02-15T04%3A10%3A52Z&sr=b&sp=r&sig=c8wFUD8tEpI9BXVjr4a3otuy%2BPKfUc6tW25cz92Bdfk%3D",
            "productQty": 1,
            "price": 3200.08,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T11:04:25.6526671",
            "lastUpdateDate": "2024-05-07T17:24:47.7324346"
          }
        ]
      },
      {
        "orderNo": "LA20240507165013NC3YU",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 3200.08,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_6TNHSHY137GO",
            "productNameTh": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt",
            "productNameEn": "\u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt ",
            "productDescription":
                "\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32\u0e2b\u0e25\u0e31\u0e01 \u0e2a\u0e32\u0e22\u0e2a\u0e35\u0e14\u0e33: \u0e02\u0e2d\u0e07 Dev \u0e21\u0e35 Opt \u0e15\u0e31\u0e27\u0e17\u0e35\u0e48 1",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_111052_Privilege_XVOQ0L4.png?sv=2020-08-04&se=2029-02-15T04%3A10%3A52Z&sr=b&sp=r&sig=c8wFUD8tEpI9BXVjr4a3otuy%2BPKfUc6tW25cz92Bdfk%3D",
            "productQty": 1,
            "price": 3200.08,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T11:04:25.6526671",
            "lastUpdateDate": "2024-05-07T16:53:37.2249543"
          }
        ]
      },
      {
        "orderNo": "LA20240507165153FHhHk",
        "shippingStatus": "Request Return/Refund",
        "shippingStatusMessage": "\u0e04\u0e37\u0e19\u0e2a\u0e34\u0e19\u0e04\u0e49\u0e32/\u0e04\u0e37\u0e19\u0e40\u0e07\u0e34\u0e19",
        "totalPrice": 40000.05,
        "totalQty": 1,
        "products": [
          {
            "productId": "PV_CVN3ZN6NKASD",
            "productNameTh":
                "\u0e1e\u0e2d\u0e25\u0e0b\u0e48\u0e32 \u0e41\u0e21\u0e47\u0e04 \u0e22\u0e39\u0e40\u0e2d\u0e17\u0e35 \u0e2d\u0e2d\u0e1f\u0e0a\u0e31\u0e48\u0e19",
            "productNameEn": "Pulsar Max UAT Option",
            "productDescription": "\u0e2a\u0e35: \u0e2a\u0e35\u0e14\u0e33",
            "productImageUrl":
                "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_063559_Privilege_7FLLXH5.jpg?sv=2020-08-04&se=2029-02-15T11%3A35%3A59Z&sr=b&sp=r&sig=Arf3UpelB19qNocbgCuEQHDwsBkMJ9RFZ35OjgfaZMI%3D",
            "productQty": 1,
            "price": 40000.05,
            "discountPrice": 0.0,
            "currency": "Baht",
            "channel": "LINE",
            "createDate": "2024-03-13T18:35:43.0605627",
            "lastUpdateDate": "2024-05-07T16:53:02.0948266"
          }
        ]
      }
    ]
  };

  group('TrackingOrderBloc', () {
    late MockBuildContext mockBuildContext;
    // Test initial state
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
      listOrder.clear();
      List<Map<String, dynamic>> order = mockTrackingListResponse["orders"];
      for (int i = 0; i < order.length; i++) {
        listOrder.add(Order.fromJson(order[i]));
      }
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
    //       final transactionApiPath = Environment().getValue("BFF_TRANSACTION_TRACKING_BASE_URL");
    //       String path = "/v1/trackingList";
    //       when(() {
    //         return utilityRepository.getByURL(
    //           "$baseUrl$transactionApiPath$path",
    //           {"itemsPerPage": 10, "page": 1, "customerRef": ""},
    //         );
    //       }).thenAnswer(
    //         (_) async {
    //           RequestOptions option =
    //               RequestOptions(baseUrl: "$baseUrl$transactionApiPath", method: "GET", data: {}, headers: {"Authorization": "Bearer "});
    //           return Response(requestOptions: option, data: mockTrackingListResponse, statusCode: 200, statusMessage: "OK");
    //         },
    //       );
    //     },
    //     build: () => TrackingOrderBloc(utilityRepository: utilityRepository),
    //     act: (bloc) => bloc.add(GetTrackingOrderListByPage(1, mockBuildContext)),
    //     expect: () => <TrackingOrderState>[
    //           TrackingOrderState(trackingOrderListStatus: GetTrackingOrderListStatus.loading),
    //           TrackingOrderState(
    //               trackingOrderListStatus: GetTrackingOrderListStatus.success,
    //               trackingListData: listOrder,
    //               trackingListPage: TrackingListPage(totalCountItems: 51, currentPage: 1, totalPage: 6))
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

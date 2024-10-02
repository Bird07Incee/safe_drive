import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/model/product_summary/create_order_request_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/order_response_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/order_summary_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

void main() {
  late DioUtilityRepository utilityRepository;
  // const mockProductErrResponse = {
  //   "appId": 0,
  //   "channelId": 0,
  //   "merchantId": 0,
  //   "paymentChannelCode": "",
  //   "refundDay": 7,
  //   "postDate": "2023‐09‐01T02:49:06−07:00",
  //   "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
  //   "categoryId": ["CT_9P2UW6F426C6", "CT_2YP8LLQG95FS"],
  //   "productId": "PV_QQZ5W1QWKQC8",
  //   "quantity": 100,
  //   "productName": "Palsar Max",
  //   "productStatus": "Available",
  //   "commissionAmount": 2000,
  //   "serviceFee": 0,
  //   "shippingFee": 0,
  //   "tagline":
  //   "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
  //   "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
  //   "description": "<p>Decription cate1 Innopower 1</p>",
  //   "technicalSpec":
  //   "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
  //   "remark": "<h1>Remark cate1 Innopower 1</h1>",
  //   "currency": "THB",
  //   "price": 56640,
  //   "discountPrice": 59000,
  //   "percentDiscountPrice": 5,
  //   "productionAssets": [
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_BLACK_MONOCHROME_PHONE_1.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_GREY_MONOCHROME_PHONE.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_2.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_3.png",
  //     "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_APP_EURO.png"
  //   ],
  //   "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
  //   "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท\nเขตพญาไท กทม 10400",
  //   "merchantLogo": "Url",
  //   "merchantMobile": "091-862-5011",
  //   "merchantEmail": "",
  //   "productionOptionals": [
  //     {
  //       "label":
  //       "สีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำ",
  //       "levelName": "สี",
  //       "image":
  //       "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  //       "price": 56640,
  //       "subProductId": "P001-1",
  //       "quantity": 200,
  //       "level2": [
  //         {
  //           "label": "3 เมตร",
  //           "levelName": "ความยาวสาย",
  //           "image":
  //           "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  //           "price": 0,
  //           "subProductId": "P001-11",
  //           "quantity": 100
  //         },
  //         {
  //           "label": "5 เมตร",
  //           "levelName": "ความยาวสาย",
  //           "image":
  //           "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  //           "price": 500,
  //           "subProductId": "P001-12",
  //           "quantity": 100
  //         }
  //       ]
  //     },
  //     {
  //       "label": "สีขาว",
  //       "levelName": "สี",
  //       "image":
  //       "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  //       "price": 57640,
  //       "subProductId": "P001-2",
  //       "quantity": 250,
  //       "level2": [
  //         {
  //           "label": "3 เมตร",
  //           "levelName": "ความยาวสาย",
  //           "image":
  //           "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  //           "price": 0,
  //           "subProductId": "P001-21",
  //           "quantity": 50
  //         },
  //         {
  //           "label": "5 เมตร",
  //           "levelName": "ความยาวสาย",
  //           "image":
  //           "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  //           "price": 500,
  //           "subProductId": "P001-22",
  //           "quantity": 80
  //         },
  //         {
  //           "label": "10 เมตร",
  //           "levelName": "ความยาวสาย",
  //           "image":
  //           "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  //           "price": 700,
  //           "subProductId": "P001-23",
  //           "quantity": 120,
  //           "level3": [
  //             {
  //               "label": "สายธรรมดา",
  //               "levelName": "รูปแบบสาย",
  //               "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
  //               "price": 100,
  //               "subProductId": "P001-231",
  //               "quantity": 120,
  //               "level4": [
  //                 {
  //                   "label": "สายธรรมดา",
  //                   "levelName": "รูปแบบสาย",
  //                   "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
  //                   "price": 200,
  //                   "subProductId": "P001-2311",
  //                   "quantity": 120,
  //                   "level5": [
  //                     {
  //                       "label": "สายธรรมดา",
  //                       "levelName": "รูปแบบสาย",
  //                       "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
  //                       "price": 300,
  //                       "subProductId": "P001-23111",
  //                       "quantity": 120
  //                     }
  //                   ]
  //                 }
  //               ]
  //             }
  //           ]
  //         }
  //       ]
  //     }
  //   ]
  // };

  final mockOrderResponse = {"orderNo": "o1234", "paymentURL": "https://test.test.com"};

  group("orderSummary bloc", () {
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
    });

    test(
      'initial state [OrderStatus.initial]',
      () {
        expect(
          OrderSummaryBloc(utilityRepository: utilityRepository).state.orderStatus.isInitial,
          isTrue,
        );
      },
    );

    test(
      'OrderSummaryState copyWith method initial state',
      () {
        expect(
          OrderSummaryBloc(utilityRepository: utilityRepository).state,
          OrderSummaryBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    group("ProductDetailBloc OrderSummaryEvent", () {
      blocTest<OrderSummaryBloc, OrderSummaryState>("set initial OrderSummaryEvent",
          build: () => OrderSummaryBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.add(const InitialOrderState()),
          expect: () => <OrderSummaryState>[OrderSummaryState()]);
    });

    group("OrderSummaryBloc CreateOrder", () {
      blocTest<OrderSummaryBloc, OrderSummaryState>("create order case success",
          setUp: () {
            SharedPreferences.setMockInitialValues({});
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final transactionApiPath = Environment().getValue("BFF_TRANSACTION_CREATE_BASE_URL");
            String path = "/v1/create";
            when(() {
              return utilityRepository.postByURL("$baseUrl$transactionApiPath$path", CreateOrderRequestModel.empty.toJson());
            }).thenAnswer(
              (_) async {
                RequestOptions option =
                    RequestOptions(baseUrl: "$baseUrl$transactionApiPath$path", method: "POST", data: CreateOrderRequestModel.empty.toJson());
                return Response(requestOptions: option, data: mockOrderResponse, statusCode: 200, statusMessage: "OK");
              },
            );
          },
          build: () => OrderSummaryBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.add(const CreateOrder(requestModel: CreateOrderRequestModel.empty)),
          expect: () => <OrderSummaryState>[
                OrderSummaryState(orderStatus: OrderStatus.loading),
                OrderSummaryState(orderStatus: OrderStatus.success, orderResponseModel: OrderResponseModel.fromJson(mockOrderResponse))
              ]);

      blocTest<OrderSummaryBloc, OrderSummaryState>("create order case fail",
          setUp: () {
            SharedPreferences.setMockInitialValues({});
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final transactionApiPath = Environment().getValue("BFF_TRANSACTION_CREATE_BASE_URL");
            String path = "/v1/create";
            when(() {
              return utilityRepository.postByURL("$baseUrl$transactionApiPath$path", CreateOrderRequestModel.empty.toJson());
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(
                    baseUrl: "$baseUrl$transactionApiPath$path",
                    method: "POST",
                    data: CreateOrderRequestModel.empty.toJson(),
                    headers: {"Authorization": "Bearer "});
                return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
              },
            );
          },
          build: () => OrderSummaryBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.add(const CreateOrder(requestModel: CreateOrderRequestModel.empty)),
          expect: () => <OrderSummaryState>[OrderSummaryState(orderStatus: OrderStatus.loading), OrderSummaryState(orderStatus: OrderStatus.error)]);
    });

    blocTest<OrderSummaryBloc, OrderSummaryState>("create order case fail with 404 OutOfStock",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final transactionApiPath = Environment().getValue("BFF_TRANSACTION_CREATE_BASE_URL");
          String path = "/v1/create";
          when(() => utilityRepository.postByURL("$baseUrl$transactionApiPath$path", CreateOrderRequestModel.empty.toJson())).thenThrow(
            DioError(
              requestOptions: RequestOptions(
                path: "$baseUrl$transactionApiPath$path",
                method: "POST",
                data: CreateOrderRequestModel.empty.toJson(),
              ),
              response: Response(
                requestOptions: RequestOptions(
                  path: "$baseUrl$transactionApiPath$path",
                ),
                data: {"code": 404, "error": "1001", "message": "Product ID : PV_UVR95EKJA6PJ quantity not enough."},
                statusCode: 404,
                statusMessage: "Bad Request",
              ),
              type: DioErrorType.badResponse,
            ),
          );
        },
        build: () => OrderSummaryBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(const CreateOrder(requestModel: CreateOrderRequestModel.empty)),
        expect: () => <OrderSummaryState>[OrderSummaryState(orderStatus: OrderStatus.loading), OrderSummaryState(orderStatus: OrderStatus.noStock)]);

    group("ProductDetailBloc SelectPaymentType", () {
      blocTest<OrderSummaryBloc, OrderSummaryState>("set SelectPaymentType success case",
          build: () => OrderSummaryBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.add(const SelectPaymentType(paymentType: PaymentType.fullPayment)),
          expect: () => <OrderSummaryState>[OrderSummaryState(paymentType: PaymentType.fullPayment)]);
    });
  });
}

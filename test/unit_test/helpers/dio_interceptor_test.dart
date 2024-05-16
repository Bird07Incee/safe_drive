import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:autoStation_promptBuy/src/helpers/interceptor_handler.dart';
import 'package:autoStation_promptBuy/src/helpers/line_data_helper.dart';
import 'package:autoStation_promptBuy/src/repositories/dio_utility_repository.dart';
import 'package:autoStation_promptBuy/src/services/dio_utility_services.dart';
import 'package:autoStation_promptBuy/src/services/dio_utils/header_utils.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockService extends Mock implements DioUtilityService {}

void main() async {
  late DioUtilityService utilityService;
  late DioUtilityRepository utilityRepository;
  late InterceptorHandler interceptorHandler;
  Map<String, dynamic> headers = HeaderUtil.baseHeader();
  headers.addAll({"authorization": "Bearer test"});
  final dioClient = DioClient().dioClient;
  final dioAdapter = DioAdapter(
    dio: dioClient,
    matcher: const FullHttpRequestMatcher(),
  );
  dioClient.httpClientAdapter = dioAdapter;
  dioClient.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers = headers;
      return handler.next(options);
    },
  ));
  RequestOptions optionPOST =
      RequestOptions(path: '/mercury-social-dev/line/token', baseUrl: "https://api.marketplace.ksauto.net", method: "POST", data: {"renew": "test"});
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    LineDataHelper().saveSocialDataToLocalStorage(json.encode({"access_token": "test", "refresh_token": "test"}));
    utilityService = MockService();
    utilityRepository = DioUtilityRepository(
      service: utilityService,
    );
    interceptorHandler = InterceptorHandler(dioUtilityRepository: utilityRepository);
  });

  group('utility service', () {
    // Map<String, dynamic> header = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Accept': "application/json",
    //   "Authorization": "Bearer test"
    // };

    // test('throws 401 response then fire refresh token onErrorInterceptor', () async {
    //   final dioError = DioError(
    //     error: {'message': 'Error'},
    //     requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
    //     response: Response(
    //       statusCode: 401,
    //       requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
    //     ),
    //     type: DioErrorType.badResponse,
    //   );
    //
    //   dioAdapter.onPost(
    //     "http://www.mockurl.com/",
    //         (server) => server.throws(
    //       401,
    //       dioError,
    //       delay: const Duration(milliseconds: 1),
    //     ),
    //     data: {},
    //     headers: header,
    //   );
    //
    //   when((){
    //     return interceptorHandler.refreshToken();
    //   }).thenAnswer(
    //         (_) async {
    //       return;
    //     },
    //   );
    //
    //   final service = DioUtilityService(dio: dioClient);
    //   expect(
    //         () async => await service.postByURL("http://www.mockurl.com/", {}),
    //     throwsA(isA<DioError>()),
    //   );
    // });

    test('call refreshToken method success 200', () async {
      when(
        () => utilityService.postByURL("https://api.marketplace.ksauto.net/mercury-social-dev/line/token", {"renew": "test"}),
      ).thenAnswer(
        (_) => Future.value(
          Response(requestOptions: optionPOST, data: {"access_token": "success", "refresh_token": "success"}, statusCode: 200, statusMessage: "OK"),
        ),
      );

      await interceptorHandler.refreshToken();
      verify(
        () => utilityService.postByURL("https://api.marketplace.ksauto.net/mercury-social-dev/line/token", {"renew": "test"}),
      ).called(1);
    });

    test('call refreshToken method fail non-200', () async {
      when(
        () => utilityService.postByURL("https://api.marketplace.ksauto.net/mercury-social-dev/line/token", {"renew": "test"}),
      ).thenAnswer(
        (_) => Future.value(
          Response(
              requestOptions: optionPOST, data: {"access_token": "success", "refresh_token": "success"}, statusCode: 400, statusMessage: "Error"),
        ),
      );

      await interceptorHandler.refreshToken();
      verify(
        () => utilityService.postByURL("https://api.marketplace.ksauto.net/mercury-social-dev/line/token", {"renew": "test"}),
      ).called(1);
    });
  });
}

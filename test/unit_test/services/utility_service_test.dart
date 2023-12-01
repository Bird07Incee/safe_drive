import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';
import 'package:marketplace_line_oa/src/services/dio_utils/header_utils.dart';

void main() async {
  Map<String, dynamic> headers = HeaderUtil.baseHeader;
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
  dynamic resJson = {
    "message": "ok"
  };
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('utility service', () {
    Map<String, dynamic> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json",
      "Authorization": "Bearer test"
    };
    test(
        'test get success case', () async {
      dioAdapter.onGet(
        "http://www.mockurl.com/",
        (server) => server.reply(
          200,
          resJson,
          delay: const Duration(milliseconds: 1),
        ),
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      Response response = await service.getByURL("http://www.mockurl.com/", {}, headers: {});
      expect(
        response.data,
        resJson,
      );
    });

    test(
        'test get success case but response data is empty', () async {
      dioAdapter.onGet(
        "http://www.mockurl.com/",
            (server) => server.reply(
          200,
          {},
          delay: const Duration(milliseconds: 1),
        ),
        headers: header,
      );

      try {
        final service = DioUtilityService(dio: dioClient);
        await service.getByURL("http://www.mockurl.com/", {});
        fail('Getting path error');
      } catch (error) {
        expect(
          error,
          isA<Exception>(),
        );
      }
    });
    
    test(
        'test get not success case', () async {
      dioAdapter.onGet(
        "http://www.mockurl.com/",
        (server) => server.reply(
          201,
          resJson,
          delay: const Duration(milliseconds: 1),
        ),
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      try {
        await service.getByURL("http://www.mockurl.com/", {});
        fail('should throw error empty body on get utility service');
      } catch (error) {
        expect(
          error,
          isA<Exception>(),
        );
      }
    });

    test('throws [ErrorGettingHomeConfig] on non-200 response for utility service', () async {
      final dioError = DioException(
        error: {'message': 'Error'},
        requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
        ),
        type: DioExceptionType.badResponse,
      );

      dioAdapter.onGet(
        "http://www.mockurl.com/",
        (server) => server.throws(
          404,
          dioError,
          delay: const Duration(milliseconds: 1),
        ),
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      expect(
        () async => await service.getByURL("http://www.mockurl.com/", {}),
        throwsA(isA<DioException>()),
      );
    });

    test(
        'test post success case', () async {
      dioAdapter.onPost(
        "http://www.mockurl.com/",
        (server) => server.reply(
          200,
          resJson,
          delay: const Duration(milliseconds: 1),
        ),
        data: {},
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      Response response = await service.postByURL("http://www.mockurl.com/", {}, headers: {});
      expect(
        response.data,
        resJson,
      );
    });

    test(
        'test post success case but response data is empty', () async {
      dioAdapter.onPost(
        "http://www.mockurl.com/",
            (server) => server.reply(
          200,
          {},
          delay: const Duration(milliseconds: 1),
        ),
        data: {},
        headers: header,
      );

      try {
        final service = DioUtilityService(dio: dioClient);
        await service.postByURL("http://www.mockurl.com/", {});
        fail('Posting path error');
      } catch (error) {
        expect(
          error,
          isA<Exception>(),
        );
      }
    });

    test(
        'test get not success case', () async {
      dioAdapter.onPost(
        "http://www.mockurl.com/",
        (server) => server.reply(
          201,
          resJson,
          delay: const Duration(milliseconds: 1),
        ),
        data: {},
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      try {
        await service.postByURL("http://www.mockurl.com/", {});
        fail('should throw error empty body on get utility service');
      } catch (error) {
        expect(
          error,
          isA<Exception>(),
        );
      }
    });

    test('throws [ErrorGettingHomeConfig] on non-200 response for utility service', () async {
      final dioError = DioException(
        error: {'message': 'Error'},
        requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: "http://www.mockurl.com/"),
        ),
        type: DioExceptionType.badResponse,
      );

      dioAdapter.onPost(
        "http://www.mockurl.com/",
        (server) => server.throws(
          404,
          dioError,
          delay: const Duration(milliseconds: 1),
        ),
        data: {},
        headers: header,
      );

      final service = DioUtilityService(dio: dioClient);
      expect(
        () async => await service.postByURL("http://www.mockurl.com/", {}),
        throwsA(isA<DioException>()),
      );
    });

  });

}
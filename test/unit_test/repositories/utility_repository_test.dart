import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements DioUtilityService {}

void main() {
  group('utility Repository', () {
    late DioUtilityService utilityService;
    late DioUtilityRepository utilityRepository;
    const body = <String, dynamic>{};
    const response = <String, dynamic>{
      "code": 200,
      "message": "Success"
    };
    RequestOptions optionGet = RequestOptions(path: '/', baseUrl: "https://mock.test", method: "GET", data: body);
    RequestOptions optionPOST = RequestOptions(path: '/', baseUrl: "https://mock.test", method: "POST", data: body);
    setUp(() {
      utilityService = MockService();
      utilityRepository = DioUtilityRepository(
        service: utilityService,
      );
    });

    group('constructor', () {
      test('instantiate utilityService with a required UtilityService', () {
        expect(
          utilityService,
          isNotNull,
        );
      });
    });

    group('call methods', () {
      Map<String, String> params = {};
      test('call get by url method', () async {
        when(
              () => utilityService.getByURL("https://mock.test/",params),
        ).thenAnswer(
              (_) => Future.value(
               Response(requestOptions: optionGet, data: response, statusCode: 200, statusMessage: "OK"),
          ),
        );
        await utilityRepository.getByURL("https://mock.test/",params);
        verify(
              () => utilityService.getByURL("https://mock.test/",params),
        ).called(1);
      });
      test('call post by url method', () async {
        when(
              () => utilityService.postByURL("https://mock.test/",params),
        ).thenAnswer(
              (_) => Future.value(
               Response(requestOptions: optionPOST, data: response, statusCode: 200, statusMessage: "OK"),
          ),
        );
        await utilityRepository.postByURL("https://mock.test/",params);
        verify(
              () => utilityService.postByURL("https://mock.test/",params),
        ).called(1);
      });
    });
    
  });
}

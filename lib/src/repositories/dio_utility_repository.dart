import 'package:dio/dio.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

class DioUtilityRepository {
  const DioUtilityRepository({required this.service});
  final DioUtilityService service;

  Future<Response> getByURL(path, params) async => service.getByURL(path, params);
  Future<Response> postByURL(path, body, {headers}) async =>
      service.postByURL(path, body, headers: headers ?? {"": ""});
}

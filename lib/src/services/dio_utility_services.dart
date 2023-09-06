import 'package:dio/dio.dart';
import 'package:marketplace_line_oa/src/services/dio_utils/header_utils.dart';

class DioUtilityService with HeaderUtil {
  DioUtilityService({Dio? dio}) : _dioClient = dio ?? Dio();
  final Dio _dioClient;

  Future<Response> getByURL(String path, Map<String, Object> params, {bool isRecursion = false}) async {
    try {
      final response = await _dioClient.get(
        path,
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return response;
        } else {
          throw Exception("Getting path \"$path\" error");
        }
      } else {
        throw Exception("Getting service error with response ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.error != null) {
        if (!isRecursion && e.response?.statusCode == 401) {
          //handle token
        }
      }
      rethrow;
    }
  }

  Future<Response> postByURL(String path, Map<String, Object?> body, {bool isRecursion = false}) async {
    try {
      final response = await _dioClient.post(
        path,
        data: body,
      );
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return response;
        } else {
          throw Exception("Posting path \"$path\" error");
        }
      } else {
        throw Exception("Posting service error with response ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.error != null) {
        if (!isRecursion && e.response?.statusCode == 401) {
          //handle token
        }
      }
      rethrow;
    }
  }
}

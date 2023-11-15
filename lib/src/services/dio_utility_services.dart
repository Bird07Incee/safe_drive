import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:marketplace_line_oa/src/helpers/dio_intercetptor.dart';
import 'package:marketplace_line_oa/src/services/dio_utils/header_utils.dart';

class DioUtilityService with HeaderUtil {
  DioUtilityService({Dio? dio}) : _dioClient = dio ?? DioClient().dioClient;
  final Dio _dioClient;

  Future<Response> getByURL(String path, Map<String, Object> params, {bool isRecursion = false, Map<String, dynamic>? headers}) async {
    _dioClient.options.headers = HeaderUtil.baseHeader;
    if (headers != null) {
      _dioClient.options.headers.addAll(headers);
    }

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
    } on DioException catch (e) {
      if (e.error != null) {
        if (!isRecursion && e.response?.statusCode == 401) {
          //handle token
        }
      }
      rethrow;
    }
  }

  Future<Response> postByURL(String path, Map<dynamic, dynamic> body, {bool isRecursion = false, Map<String, dynamic>? headers}) async {
    _dioClient.options.headers = HeaderUtil.baseHeader;
    if (headers != null) {
      _dioClient.options.headers.addAll(headers);
    }

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
    } on DioException catch (e) {
      if (e.error != null) {
        if (!isRecursion && e.response?.statusCode == 401) {
          //handle token
        }
      }
      rethrow;
    }
  }
}

class DioClient {
  static final Dio client = Dio();
  Dio get dioClient {
    client.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        initAdapter();
        return handler.next(options);
      },
    ));

    client.interceptors.add(DioInterceptor());
    return client;
  }

  void initAdapter() {
    String selfHash = "37e2a47da812dd09f8f44ad4002087866378fdf834eb28c441f4e3edc605b639";
    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          log("cert.pem : ${cert.pem}");
          var b = utf8.encode(cert.pem);
          var hostHash = sha256.convert(b).toString();
          return hostHash == selfHash; // Verify the certificate.
        };
        return client;
      },
    );
  }
}

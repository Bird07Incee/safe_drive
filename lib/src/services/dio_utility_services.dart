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
  String calculateSHA256(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Dio get dioClient {
    client.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        // initAdapter();
        await setupCertificate();
        return handler.next(options);
      },
    ));

    client.interceptors.add(DioInterceptor());
    return client;
  }

  void initAdapter() {
    log("initAdapter ");
    String selfHash = "076c0c9749e7b0fed7294a2ba9f22803d5148ea3132ea9d1327dfb652cdb5fde";
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

  Future<void> setupCertificate() async {
    SecurityContext clientContext = SecurityContext(withTrustedRoots: false);
//     const String awsRootCACertificate = '''
// -----BEGIN CERTIFICATE-----
// MIIB8jCCAXigAwIBAgITBmyf18G7EEwpQ+Vxe3ssyBrBDjAKBggqhkjOPQQDAzA5
// MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6b24g
// Um9vdCBDQSA0MB4XDTE1MDUyNjAwMDAwMFoXDTQwMDUyNjAwMDAwMFowOTELMAkG
// A1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJvb3Qg
// Q0EgNDB2MBAGByqGSM49AgEGBSuBBAAiA2IABNKrijdPo1MN/sGKe0uoe0ZLY7Bi
// 9i0b2whxIdIA6GO9mif78DluXeo9pcmBqqNbIJhFXRbb/egQbeOc4OO9X4Ri83Bk
// M6DLJC9wuoihKqB1+IGuYgbEgds5bimwHvouXKNCMEAwDwYDVR0TAQH/BAUwAwEB
// /zAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFNPsxzplbszh2naaVvuc84ZtV+WB
// MAoGCCqGSM49BAMDA2gAMGUCMDqLIfG9fhGt0O9Yli/W651+kI0rz2ZVwyzjKKlw
// CkcO8DdZEv8tmZQoTipPNU0zWgIxAOp1AE47xDqUEpHJWEadIRNyp4iciuRMStuW
// 1KyLa2tJElMzrdfkviT8tQp21KW8EA==
// -----END CERTIFICATE-----
// ''';
//     String certificateSHA256 = calculateSHA256(awsRootCACertificate);
    String expectedSHA256 = 'd7c774cc0f66ce20d12628cd251a1b0982a31a2bf26735b017bd552d8ad2552d';
    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient httpClient = HttpClient(context: clientContext);
        httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
          if (calculateSHA256(cert.pem) == expectedSHA256) {
            return true; // Accept the certificate
          }
          return false; // Reject the certificate
        };
        return httpClient;
      },
    );

// static Future<void> _setupCertificate() async {
    //   String path = 'assets/raw/AWSRootCA4.pem';
    //   ByteData data = await rootBundle.load(path);
    //   SecurityContext clientContext = SecurityContext(withTrustedRoots: false);
    //   clientContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
    //   client.httpClientAdapter = IOHttpClientAdapter(
    //     createHttpClient: () {
    //       HttpClient httpClient = HttpClient(context: clientContext);
    //       httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => false);
    //       return httpClient;
    //     },
    //   );
    //
    //   // old version code is notwork
    //
    //   // (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //   //   HttpClient httpClient = HttpClient(context: clientContext);
    //   //   httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
    //   //     return false;
    //   //   };
    //   //   return httpClient;
    //   // };
  }
}

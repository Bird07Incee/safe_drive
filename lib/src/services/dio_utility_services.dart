// import 'package:dio/browser.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:marketplace_line_oa/src/helpers/dio_intercetptor.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/services/dio_utils/header_utils.dart';

class DioUtilityService {
  DioUtilityService({Dio? dio}) : _dioClient = dio ?? DioClient().dioClient;
  final Dio _dioClient;

  Future<Response> getByURL(String path, Map<String, dynamic> params, {bool isRecursion = false, Map<String, dynamic>? headers}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String accessToken = await lineDataHelper.getLineAccessToken();
    _dioClient.options.headers = HeaderUtil.baseHeader(token: accessToken);

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
      var uid = LineDataHelper().getLineUid();
      DatadogSdk.instance.rum?.addError("GET $path error with response: ${e.response?.statusCode} ,message: ${e.message}", RumErrorSource.network,
          attributes: {"uuid": uid});
      rethrow;
    }
  }

  Future<Response> postByURL(String path, Map<dynamic, dynamic> body, {bool isRecursion = false}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    if (!path.contains("/line/token")) {
      String accessToken = await lineDataHelper.getLineAccessToken();
      _dioClient.options.headers = HeaderUtil.baseHeader(token: accessToken);
    } else {
      _dioClient.options.headers = HeaderUtil.baseHeader();
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
      var uid = LineDataHelper().getLineUid();
      DatadogSdk.instance.rum?.addError("POST $path error with response: ${e.response?.statusCode} ,message: ${e.message}", RumErrorSource.network,
          attributes: {"uuid": uid});
      rethrow;
    }
  }
}

class DioClient {
  static final Dio client = Dio();
  // String calculateSHA256(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  Dio get dioClient {
    client.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        // initAdapter();
        // await setupCertificate();
        return handler.next(options);
      },
    ));

    client.interceptors.add(DioInterceptor());
    return client;
  }

  // void initAdapter() {
  //   String selfHash = "076c0c9749e7b0fed7294a2ba9f22803d5148ea3132ea9d1327dfb652cdb5fde";
  //   client.httpClientAdapter = IOHttpClientAdapter(
  //     createHttpClient: () {
  //       final client = HttpClient();
  //       client.badCertificateCallback = (X509Certificate cert, String host, int port) {
  //         var b = utf8.encode(cert.pem);
  //         var hostHash = sha256.convert(b).toString();
  //         return hostHash == selfHash; // Verify the certificate.
  //       };
  //       return client;
  //     },
  //   );
  // }

  Future<Uint8List> loadAWSRootCA4Certificate(String pem) async {
    final derCertificate = pem.codeUnits;
    return Uint8List.fromList(derCertificate);
  }

  // Future<void> setupCertificate() async {
  //   client.httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  // }
}

const stringCertificateBytes = '''
-----BEGIN CERTIFICATE-----
MIIB8jCCAXigAwIBAgITBmyf18G7EEwpQ+Vxe3ssyBrBDjAKBggqhkjOPQQDAzA5
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6b24g
Um9vdCBDQSA0MB4XDTE1MDUyNjAwMDAwMFoXDTQwMDUyNjAwMDAwMFowOTELMAkG
A1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJvb3Qg
Q0EgNDB2MBAGByqGSM49AgEGBSuBBAAiA2IABNKrijdPo1MN/sGKe0uoe0ZLY7Bi
9i0b2whxIdIA6GO9mif78DluXeo9pcmBqqNbIJhFXRbb/egQbeOc4OO9X4Ri83Bk
M6DLJC9wuoihKqB1+IGuYgbEgds5bimwHvouXKNCMEAwDwYDVR0TAQH/BAUwAwEB
/zAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFNPsxzplbszh2naaVvuc84ZtV+WB
MAoGCCqGSM49BAMDA2gAMGUCMDqLIfG9fhGt0O9Yli/W651+kI0rz2ZVwyzjKKlw
CkcO8DdZEv8tmZQoTipPNU0zWgIxAOp1AE47xDqUEpHJWEadIRNyp4iciuRMStuW
==
-----END CERTIFICATE-----
''';

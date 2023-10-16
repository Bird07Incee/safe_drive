import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

class DioInterceptor extends Interceptor {
  final LineDataHelper lineDataHelper = LineDataHelper();
  final DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService(dio: DioClient.client));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //_responseHandler(response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _onErrorHandler(err, handler);
    handler.next(err);
  }

  void _onErrorHandler(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      _refreshToken();
    }
  }

  //ignore on error condition
  // bool _shouldInvokeCallbackFromOnError(DioError err) =>
  //     NetworkErrorHandler.shouldInvokeErrorHandlerCallback &&
  //         !err.requestOptions.uri.toString().contains('checkcampaign') &&
  //         !(err.message ?? '').contains('cancel');

  bool _isBaseService({RequestOptions? options, Response? response}) {
    final String reqUrl = options != null ? options.uri.toString() : response!.requestOptions.uri.toString();
    final String inventoryBaseUrl = Environment().getValue("BFF_BASE_URL");
    return reqUrl.contains(inventoryBaseUrl); // && (reqUrl.contains('category=mkp_items'))
  }

  // void _responseHandler(Response response) {
  //   if (_isInventoryService(response: response)) {
  //     if (response.statusCode == HttpStatus.ok) {
  //       if (response.data.runtimeType.toString() == "_Map<String, dynamic>" &&
  //           (response.data as Map<String, dynamic>).containsKey(_responseKey)) {
  //         _lastEvaluateKey = response.data[_responseKey];
  //       }
  //     }
  //   }
  // }

  _refreshToken() async {
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final socialApiPath = Environment().getValue("BFF_SOCIAL_BASE_URL");
    String refreshToken = await lineDataHelper.getLineRefreshToken();
    print('refreshToken : $refreshToken');
    Response response =
        await dioUtilityRepository.postByURL("$baseUrl$socialApiPath/line/token", {"renew": refreshToken});
    if (response.statusCode == 200) {
      lineDataHelper.saveSocialDataToLocalStorage(json.encode(response.data));
    } else if (response.statusCode == 400) {
      PreferencesHelper.clear();
      String url = Environment().getValue("LINE_REDIRECT_URL");
      window.open(url, '_self');
    }
  }
}

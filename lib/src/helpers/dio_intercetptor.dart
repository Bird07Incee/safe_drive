import 'package:marketplace_line_oa/src/helpers/interceptor_handler.dart';
import 'package:universal_html/html.dart' as html;
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    await _onErrorHandler(err, handler);
    handler.next(err);
  }

  Future<void> _onErrorHandler(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == html.HttpStatus.unauthorized && !err.requestOptions.uri.toString().contains('/line/token')) {
      await InterceptorHandler().refreshToken();
    }

    ///Handle case renew error
    else if (err.response?.statusCode != 200 && err.requestOptions.uri.toString().contains('/line/token')) {
      await InterceptorHandler().reloadApp();
    }
  }

  //ignore on error condition
  // bool _shouldInvokeCallbackFromOnError(DioException err) =>
  //     NetworkErrorHandler.shouldInvokeErrorHandlerCallback &&
  //         !err.requestOptions.uri.toString().contains('checkcampaign') &&
  //         !(err.message ?? '').contains('cancel');

  // bool _isBaseService({RequestOptions? options, Response? response}) {
  //   final String reqUrl = options != null ? options.uri.toString() : response!.requestOptions.uri.toString();
  //   final String inventoryBaseUrl = Environment().getValue("BFF_BASE_URL");
  //   return reqUrl.contains(inventoryBaseUrl); // && (reqUrl.contains('category=mkp_items'))
  // }

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
}

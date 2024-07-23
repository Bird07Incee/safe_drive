import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';
import 'package:universal_html/html.dart' as html;

class InterceptorHandler {
  InterceptorHandler({this.dioUtilityRepository});
  final LineDataHelper lineDataHelper = LineDataHelper();
  final DioUtilityRepository? dioUtilityRepository;

  Future<void> refreshToken() async {
    final repository = dioUtilityRepository ?? DioUtilityRepository(service: DioUtilityService(dio: DioClient.client));
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final socialApiPath = Environment().getValue("BFF_SOCIAL_BASE_URL");
    String refreshToken = await lineDataHelper.getLineRefreshToken();
    Response response = await repository.postByURL("$baseUrl$socialApiPath/line/token", {"renew": refreshToken});
    if (response.statusCode == 200) {
      lineDataHelper.saveSocialDataToLocalStorage(json.encode(response.data));
    } else if (response.statusCode == 400) {
      PreferencesHelper.clear();
      String url = Environment().getValue("LINE_REDIRECT_URL");
      html.window.open(url, '_self');
    }
  }

  Future<void> reloadApp() async {
    PreferencesHelper.clear();
    String url = Environment().getValue("LINE_REDIRECT_URL");
    if (!kDebugMode) {
      html.window.open(url, '_self');
    }
  }
}

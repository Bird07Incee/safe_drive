import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';

class AmplitudeWebHelper {
  Amplitude? _amplitude;

  AmplitudeWebHelper._() {
    _onInit();
  }

  static AmplitudeWebHelper getInstance() {
    return AmplitudeWebHelper._();
  }

  void _onInit() async {
    if (_amplitude == null) {
      _amplitude = Amplitude(promptBuyWebTitle);
      final apiKey = Environment().getValue("SUPER_APP_AMPLITUDE_API_KEY");

      _amplitude!.init(apiKey);
    }
  }

  Future<String> getUserId() async {
    String userId = await _amplitude!.getUserId() ?? "";
    return userId;
  }

  void logEvent({required String eventType, required String screenName, required String eventName, Map<String, dynamic>? eventProperties}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    Map<String, dynamic> defaultEventProperties = {
      'channel': "LINE",
      'line_uuid': lineUID,
      'screen_name': screenName,
      'event_name': eventName,
    };
    try {
      if (eventProperties != null) {
        defaultEventProperties.addAll(eventProperties);
      }
      _amplitude!.logEvent(eventType, eventProperties: defaultEventProperties);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

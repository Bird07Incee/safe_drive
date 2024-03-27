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

  void logEnterTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String tcVersion = await lineDataHelper.getTAndC();
    logEvent(
        eventType: "Enter term&condition page",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion});
  }

  void logTapOnOkButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var tcVersion = await lineDataHelper.getTAndC();
    logEvent(
        eventType: "Tap on ok button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion});
  }

  void logTapOnCancelButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var tcVersion = await lineDataHelper.getTAndC();
    logEvent(
        eventType: "Tap on cancel button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion});
  }

  void logTapOnPrivacyButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var tcVersion = await lineDataHelper.getTAndC();
    logEvent(
        eventType: "Tap on privacy policy button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion});
  }

  void logeMarketplaceHomePageHomeScreen() {
    logEvent(
        eventType: "Enter eMarketplace homepage", screenName: "AutoStation_eMarketplace_homepage", eventName: "AutoStation_eMarketplace_homepage");
  }

  void logeTapCarouselOnHomeScreen({required String bannerName, required String bannerSequence}) {
    logEvent(
        eventType: "Tap carousel",
        screenName: "AutoStation_eMarketplace_homepage",
        eventName: bannerName,
        eventProperties: {"position": bannerSequence});
  }

  void logTapOnProduct(
      {required String productName, required String productId, required String categoryId, required String price, required String discountPrice}) {
    logEvent(eventType: "Tap on product list", screenName: "AutoStation_eMarketplace_homepage", eventName: productName, eventProperties: {
      "content_id": productId,
      "content_type": categoryId,
      "product_price": price,
      "product_discount_price": discountPrice,
    });
  }

  void logTapOnImageGallery({required String productName, required String productId, required String categoryId}) {
    logEvent(eventType: "Tap on image gallery", screenName: "AutoStation_eMarketplace_homepage", eventName: productName, eventProperties: {
      "content_id": productId,
      "content_type": categoryId,
    });
  }

  void logTapOnTermAndConditionButton() {
    logEvent(
      eventType: "Tap on term&condition button",
      screenName: "AutoStation_eMarketplace_homepage",
      eventName: "AutoStation_eMarketplace_term&condition",
    );
  }

  void logTapOnPrivacyPolicyButton() {
    logEvent(
      eventType: "Tap on privacy policy button",
      screenName: "AutoStation_eMarketplace_homepage",
      eventName: "AutoStation_eMarketplace_privacypolicy",
    );
  }

  void logTapOnCallCenterButton() {
    logEvent(
      eventType: "Tap on call center button",
      screenName: "AutoStation_eMarketplace_homepage",
      eventName: "AutoStation_eMarketplace_callcenter",
    );
  }

  void logTapOnCategory({required String categoryId}) {
    logEvent(
        eventType: "Tap on category",
        screenName: "AutoStation_eMarketplace_homepage",
        eventName: "AutoStation_eMarketplace_catagory",
        eventProperties: {
          "content_type": categoryId,
        });
  }

  void logTapOnOrderTrackingButton() {
    logEvent(
      eventType: "Tap on order tracking button",
      screenName: "AutoStation_eMarketplace_homepage",
      eventName: "AutoStation_eMarketplace_order_tracking",
    );
  }
}

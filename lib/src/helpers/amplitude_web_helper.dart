import 'package:amplitude_flutter/amplitude.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
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
      _amplitude!.setUserProperties({'Version': '1.0.0'});
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
      DatadogSdk.instance.rum?.addError("Amplitude logEvent Error : $e", RumErrorSource.custom, attributes: {"line_uuid": lineUID});
    }
  }

  void logEnterTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String tcVersion = await lineDataHelper.getTAndC();
    String lineUUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter term&condition page",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion, "line_uuid": lineUUID});
  }

  void logTapOnOkButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String tcVersion = await lineDataHelper.getTAndC();
    String lineUUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on ok button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion, "line_uuid": lineUUID});
  }

  void logTapOnCancelButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String tcVersion = await lineDataHelper.getTAndC();
    String lineUUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on cancel button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion, "line_uuid": lineUUID});
  }

  void logTapOnPrivacyButtonTermAndConPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    String tcVersion = await lineDataHelper.getTAndC();
    String lineUUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on privacy policy button",
        screenName: "AutoStation_eMarketplace_term&condition_page",
        eventName: tcVersion,
        eventProperties: {"event_name": tcVersion, "line_uuid": lineUUID});
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

// ProductDetail
  Future<void> logEnterProductDetails(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Enter product details", screenName: "AutoStation_eMarketplace_product_details", eventName: productName, eventProperties: {
      "content_id": contentId,
      "category_name": merchantName,
      "content_type": productCategoryId,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  Future<void> logTapOniImageGallery(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on image gallery", screenName: "AutoStation_eMarketplace_product_details", eventName: productName, eventProperties: {
      "content_id": contentId,
      "category_name": merchantName,
      "content_type": productCategoryId,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  Future<void> logTapOnGeneralInfoButton(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on general info button",
        screenName: "AutoStation_eMarketplace_product_details",
        eventName: productName,
        eventProperties: {
          "content_id": contentId,
          "category_name": merchantName,
          "content_type": productCategoryId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnConditionsButton(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on conditions button", screenName: "AutoStation_eMarketplace_product_details", eventName: productName, eventProperties: {
      "content_id": contentId,
      "category_name": merchantName,
      "content_type": productCategoryId,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  Future<void> logTapOnCallMerchantButton(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call merchant button",
        screenName: "AutoStation_eMarketplace_product_details",
        eventName: productName,
        eventProperties: {
          "content_id": contentId,
          "category_name": merchantName,
          "content_type": productCategoryId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnPurchaseButton(
      {required String productName,
      required String contentId,
      required String merchantName,
      required String productCategoryId,
      required String price,
      required String discountPrice}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on purchase button", screenName: "AutoStation_eMarketplace_product_details", eventName: productName, eventProperties: {
      "content_id": contentId,
      "category_name": merchantName,
      "content_type": productCategoryId,
      "product_price": price,
      "product_discount_price": discountPrice,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  // select option

  Future<void> logEnterProductOptionPage(
      {required String productName, required String contentId, required String merchantName, required String productCategoryId}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter product option page",
        screenName: "AutoStation_eMarketplace_productoption_page",
        eventName: productName,
        eventProperties: {
          "content_id": contentId,
          "category_name": merchantName,
          "content_type": productCategoryId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnNextButton(
      {required String productName,
      required String contentId,
      required String merchantName,
      required String productCategoryId,
      required String optionId,
      required String productOptionPrice}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on next button", screenName: "AutoStation_eMarketplace_productoption_page", eventName: productName, eventProperties: {
      "content_id": contentId,
      "sub_category_name": optionId,
      "category_name": merchantName,
      "content_type": productCategoryId,
      "product_option_price": productOptionPrice,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  // ordersummary

  Future<void> logEnterOrderSummaryPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter order summary page",
        screenName: "AutoStation_eMarketplace_ordersummary_page",
        eventName: "AutoStation_eMarketplace_ordersummary",
        eventProperties: {
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnManageShippingAddressButton() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on manage shipping address button",
        screenName: "AutoStation_eMarketplace_ordersummary_page",
        eventName: "AutoStation_eMarketplace_ordersummary",
        eventProperties: {
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // add address

  Future<void> logEnterShippingAddressPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter shipping address page",
        screenName: "AutoStation_eMarketplace_shippingaddress_page",
        eventName: "AutoStation_eMarketplace_shippingaddress",
        eventProperties: {
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnOkButton({required String address}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on ok button",
        screenName: "AutoStation_eMarketplace_shippingaddress_page",
        eventName: "AutoStation_eMarketplace_shippingaddress",
        eventProperties: {
          'user_location': address,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac popup confirm payment

  Future<void> logTapOnConfirmOrderButton(
      {required String productName,
      required String contentId,
      required String optionID,
      required String merchantName,
      required String productCategoryId,
      required String price,
      required String paymentType}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on confirm order button",
        screenName: "AutoStation_eMarketplace_ordersummary_page",
        eventName: productName,
        eventProperties: {
          'content_id': contentId,
          'sub_category_name': optionID,
          'category_name': merchantName,
          'content_type': productCategoryId,
          'product_price': price,
          'payment_type': paymentType,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac popup cancel order

  Future<void> logTapOnBackButton(
      {required String productName,
      required String contentId,
      required String optionID,
      required String merchantName,
      required String productCategoryId,
      required String price,
      required String paymentType}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on back button", screenName: "AutoStation_eMarketplace_ordersummary_page", eventName: productName, eventProperties: {
      'content_id': contentId,
      'sub_category_name': optionID,
      'category_name': merchantName,
      'content_type': productCategoryId,
      'product_price': price,
      'payment_type': paymentType,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  // Marketplace ac success order
  Future<void> logEnterOrderSuccessPage(
      {required String selectedType,
      required String invoiceNumber,
      required String productName,
      required String contentId,
      required String optionID,
      required String merchantName,
      required String productCategoryId,
      required String price,
      required String paymentType,
      required String userLocation}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter order success page",
        screenName: "AutoStation_eMarketplace_ordersuccess_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'content_id': contentId,
          'sub_category_name': optionID,
          'category_name': merchantName,
          'content_type': productCategoryId,
          'product_price': price,
          'payment_type': paymentType,
          'selected_type': selectedType,
          'user_location': userLocation,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnOrderTrackingButtonSuccessScreen(
      {required String productName, required String invoiceNumber, required String merchantName}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on order tracking button",
        screenName: "AutoStation_eMarketplace_ordersuccess_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapTapOnCallMerchantButton({required String productName, required String invoiceNumber, required String merchantName}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call merchant button",
        screenName: "AutoStation_eMarketplace_ordersuccess_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnCallCenterButtonSuccessScreen(
      {required String productName, required String invoiceNumber, required String merchantName}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call center button",
        screenName: "AutoStation_eMarketplace_ordersuccess_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac payment fail

  Future<void> logEnterPaymentFailPage(
      {required String invoiceNumber,
      required String productName,
      required String contentId,
      required String merchantName,
      required String price,
      required String paymentType,
      required String userLocation}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Enter payment fail page", screenName: "AutoStation_eMarketplace_payment_fail", eventName: productName, eventProperties: {
      'invoice_number': invoiceNumber,
      'content_id': contentId,
      'category_name': merchantName,
      'product_price': price,
      'payment_type': paymentType,
      'user_location': userLocation,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  Future<void> logTapOneMarketplaceHomepageButton() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on eMarketplace homepage button",
        screenName: "AutoStation_eMarketplace_payment_fail",
        eventName: "AutoStation_eMarketplace_homapage",
        eventProperties: {
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac bs not support

  Future<void> logEnterBrowserNotSupport() async {
    logEvent(
      eventType: "Enter browser notsupport",
      screenName: "AutoStation_eMarketplace_browser_notsupport",
      eventName: "AutoStation_eMarketplace_browser_notsupport",
    );
  }

  Future<void> logTapOnOkButtonInBrowserNotSupport() async {
    logEvent(
      eventType: "Tap on ok button",
      screenName: "AutoStation_eMarketplace_browser_notsupport",
      eventName: "AutoStation_eMarketplace_KALineOAfriend",
    );
  }

  // Marketplace ac tracking
  Future<void> logEnterOrderTrackingPage() async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter order tracking page",
        screenName: "AutoStation_eMarketplace_ordertracking",
        eventName: "AutoStation_eMarketplace_ordertracking",
        eventProperties: {
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnOrderTrackingList(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(eventType: "Tap on order tracking list", screenName: "AutoStation_eMarketplace_ordertracking", eventName: productName, eventProperties: {
      'invoice_number': invoiceNumber,
      'order_status': statusId,
      'channel': "LINE",
      'line_uuid': lineUID,
    });
  }

  // Marketplace ac status tracking

  Future<void> logEnterOrderTrackingDetail(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter order tracking detail",
        screenName: "AutoStation_eMarketplace_ordertracking_details",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnCallMerchantButtonInTrackingDetail(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call merchant button",
        screenName: "AutoStation_eMarketplace_ordertracking_details",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnProductRefundButton(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on product refund button",
        screenName: "AutoStation_eMarketplace_ordertracking_details",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnCallCenterButtonInTrackingDetail(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call center button",
        screenName: "AutoStation_eMarketplace_ordertracking_details",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac return
  Future<void> logEnterProductRefundPage(String productName, String invoiceNumber, String statusId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter product refund page",
        screenName: "AutoStation_eMarketplace_productrefund_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac return confirm
  Future<void> logTapOnConfirmRefundButton(String productName, String invoiceNumber, String statusId, String cancelReason, String contentId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on confirm refund button",
        screenName: "AutoStation_eMarketplace_productrefund_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'order_status': statusId,
          'cancel_reason': cancelReason,
          'content_id': contentId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  // Marketplace ac success cancel

  Future<void> logTapOnConfirmRefundButtonInSuccessCancel(
      String productName, String invoiceNumber, String merchantName, String cancelReason, String contentId) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Enter refund summary page",
        screenName: "AutoStation_eMarketplace_refundsummary_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'cancel_reason': cancelReason,
          'content_id': contentId,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnOrderTrackingButtonInSuccessCancel(String productName, String invoiceNumber, String merchantName) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on order tracking button",
        screenName: "AutoStation_eMarketplace_refundsummary_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnCallMerchantButtonInSuccessCancel(String productName, String invoiceNumber, String merchantName) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call merchant button",
        screenName: "AutoStation_eMarketplace_refundsummary_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': merchantName,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }

  Future<void> logTapOnCallCenterButtonInSuccessCancel(String productName, String invoiceNumber, String merchantName) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    var lineUID = await lineDataHelper.getLineUid();
    logEvent(
        eventType: "Tap on call center button",
        screenName: "AutoStation_eMarketplace_refundsummary_page",
        eventName: productName,
        eventProperties: {
          'invoice_number': invoiceNumber,
          'category_name': invoiceNumber,
          'channel': "LINE",
          'line_uuid': lineUID,
        });
  }
}

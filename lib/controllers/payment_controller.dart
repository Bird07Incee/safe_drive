import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/landing_controller.dart';
import 'package:marketplace_line_oa/models/product_list.dart';
import 'dart:html' as html;

class PaymentBinding implements Bindings {
  final String tag;
  PaymentBinding({required this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}

class PaymentController extends GetxController {
  static PaymentController to = Get.find();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}

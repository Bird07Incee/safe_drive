
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/image_controller.dart';
import 'package:marketplace_line_oa/controllers/landing_controller.dart';
import 'package:marketplace_line_oa/helpers/mime_types.dart';
import 'package:marketplace_line_oa/models/file_model.dart';
import 'package:marketplace_line_oa/models/product_list.dart';
import 'dart:html' as html;

import 'package:screenshot/screenshot.dart';

class ProductBinding implements Bindings {
  final String tag;
  ProductBinding({required this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(), tag: tag);
    Get.lazyPut(() => ScreenshotController(), tag: tag);
    Get.lazyPut(() => ImageController(), tag: tag);
  }
}

class ProductController extends GetxController with GetSingleTickerProviderStateMixin{
  static ProductController to = Get.find();
  final Rxn<ProductData> selectedProduct = Rxn<ProductData>();
  final RxBool isFav = false.obs;
  final RxBool expandDetail = false.obs;
  final RxInt selectedTab = 0.obs;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  //mock
  final Rxn<ProductListModel> products = Rxn<ProductListModel>();
  setList() {
    products.value = const ProductListModel().mockData;
    selectedProduct.value = products.value!.items!.first;
    update();
  }

  LandingController? landingController;
  TabController? tabController;
  ImageController? imageController;

  @override
  void onInit() async {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    setList();
    super.onInit();
  }

  @override
  void onReady() async {
    //
    imageController = Get.find<ImageController>();
    super.onReady();
  }

  @override
  void onClose() {
    //
    imageController = null;
    super.onClose();
  }

  setSelectedProduct() {
    landingController = Get.find<LandingController>(tag: 'landing');
    if(landingController != null) {
      selectedProduct.value = landingController!.selectedProduct;
      update();
      String url = "/product?id=${selectedProduct.value!.carRefId}";
      print('url : $url');
      html.window.history.pushState(null, 'Product', url);
    } else {
      print('controller is null');
      print(html.window.location);

    }
  }

  setFav() {
    isFav.value = !isFav.value;
    print("set isFav : ${isFav.value}");
    update();
  }

  showMoreDetail(bool s) {
    expandDetail.value = s;
    update();
  }

  setSelectedTab(int s) {
    selectedTab(s);
  }

  captureImage(Widget w, {required Function(bool) callback}) {
    //Widget w = Text("Test");
    screenshotController.captureFromWidget(w).then((value) async {
      try {
        String fileName = "mkpp_${DateTime.now().millisecondsSinceEpoch}";
        FileModel fileModel = FileModel(name: fileName, bytes: value, ext: 'png', mimeType: MimeType.png.type);
        imageController!.downloadFile(fileModel);
        callback(true);
      } catch (e) {
        callback(false);
      }
    });
  }
}

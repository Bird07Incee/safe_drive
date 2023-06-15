import 'dart:js_interop';

import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';
import 'package:marketplace_line_oa/models/product_list.dart';

class GalleryBinding implements Bindings {
  final String tag;
  GalleryBinding({required this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController(), tag: tag);
    Get.lazyPut(() => ProductController(), tag: tag);
  }
}

class GalleryController extends GetxController{
  static GalleryController to = Get.find();
  final Rxn<ProductData> selectedProduct = Rxn<ProductData>();
  final RxInt focusIndex = 0.obs;

  //Dependencies Inject
  late ProductController? productController;


  @override
  void onInit() async {
    super.onInit();
    productController = Get.find<ProductController>();
    if(productController.isDefinedAndNotNull) {
      selectedProduct(productController!.selectedProduct.value);
    }
  }

  @override
  void onReady() async {
    //run every time auth state changes
    // ever(firebaseUser, handleAuthChanged);
    //
    // firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  setCurrentFocusIndex(int i) {
    focusIndex(i);
  }

}

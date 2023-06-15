import 'package:get/get.dart';
import 'package:marketplace_line_oa/models/product_list.dart';
import 'dart:html' as html;

class LandingBinding implements Bindings {
  final String tag;
  LandingBinding({required this.tag});

  @override
  void dependencies() {
    Get.put(() => LandingController(), permanent: true);
  }
}

class LandingController extends GetxController{
  static LandingController to = Get.find();
  final Rxn<ProductListModel> products = Rxn<ProductListModel>();
  late ProductData? selectedProduct;

  @override
  void onInit() async {
    preventBackNavigation();
    setList();
    super.onInit();
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
    super.onClose();
  }

  setList() {
    products.value = const ProductListModel().mockData;
    update();
  }

  setSelectedProduct(ProductData p) {
    selectedProduct = p;
  }

  preventBackNavigation() {
    // html.window.history.pushState(null, 'Prevent Back', html.window.location.href);
    html.window.onPopState.listen((event) {
      html.window.history.pushState(null, 'Prevent Back', html.window.location.href);
    });
  }
}

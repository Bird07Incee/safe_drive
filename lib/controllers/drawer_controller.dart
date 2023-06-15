import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/auth_controller.dart';

class DrawerBinding implements Bindings {
  final String tag;
  DrawerBinding({required this.tag});

  @override
  void dependencies() {
    Get.put(() => DrawerWidgetController(), permanent: true);
    Get.lazyPut(() => UserAuthController(), fenix: true);
  }
}

class DrawerWidgetController extends GetxController{
  static DrawerWidgetController to = Get.find();
  final Rxn<Profile> useLineProfile = Rxn<Profile>();
  UserAuthController? userAuthController;

  @override
  void onInit() async {
    userAuthController = Get.find<UserAuthController>();
    setUserProfile();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setUserProfile() {
    useLineProfile.value = userAuthController!.useLineProfile.value;
    update();
  }

}

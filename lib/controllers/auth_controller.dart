import 'dart:html';

import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/constants/router/route_config.dart';
import 'package:marketplace_line_oa/models/user.dart';

class UserAuthController extends GetxController {
  static UserAuthController to = Get.find();
  final liff = FlutterLineLiff();
  final RxBool isAuth = false.obs;
  final Rxn<User> user = Rxn<User>();
  final Rxn<Profile> useLineProfile = Rxn<Profile>();


  @override
  void onInit() async {
    lineAuth();
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

  lineAuth() async {
    await liff.ready.then((_) async{
      print('Line Ready');
      if (!liff.isLoggedIn) {
        print('login');
        liff.login();
      } else {
        bool profileSuccess = await setLineAuth();
        print("arguments :${Get.arguments}");
        var href = window.location.href;
        print("href :$href");
        var location = window.location.toString();
        print("location :$location");
        if(profileSuccess) {
          print('is Logged in and profile success >>>> Redirect to Landing');
          useLineProfile.value = await FlutterLineLiff().profile;
          update();
          //Get.toNamed(RouteName.landing);
        } else {
          print('profile err');
        }

      }
    });
  }

  Future<bool> setLineAuth() async {
    try {
      isAuth.value = true;
      user.update((u) {
        u?.lineAuth!.code = Get.arguments["code"] ?? "";
        u?.lineAuth!.state = Get.arguments["state"] ?? "";
        u?.lineAuth!.liffClientId = liff.id ?? "";
        u?.lineAuth!.liffRedirectUri = Get.arguments["liffRedirectUri"] != null ? Uri.parse(Get.arguments["liffRedirectUri"].toString()): Uri();
        u?.lineAuth!.accessToken = liff.id ?? "";
      });
      useLineProfile.value = await liff.profile;
      update();
      return true;
    } catch (e) {
      print("set line auth err : =====> $e");
      return false;
    }
  }

  Future<void> logoutLine() async {
    try {
      liff.logout();
    } catch (e) {
      print("logout err : =====> $e");
    }
  }
}

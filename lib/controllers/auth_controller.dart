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

  // handleAuthChanged(user) async {
  //   get user data from firestore
  //   if (_firebaseUser?.uid != null) {
  //     firestoreUser.bindStream(streamFirestoreUser());
  //     await isAdmin();
  //   }
  //
  //   if (_firebaseUser == null) {
  //     print('Send to signin');
  //     Get.offAll(SignInUI());
  //   } else {
  //     Get.offAll(HomeUI());
  //   }
  // }

  // Firebase user one-time fetch
  // Future<User> get getUser async => _auth.currentUser!;
  //
  // // Firebase user a realtime stream
  // Stream<User?> get user => _auth.authStateChanges();
  //
  // //Streams the firestore user from the firestore collection
  // Stream<UserModel> streamFirestoreUser() {
  //   print('streamFirestoreUser()');
  //
  //   return _db
  //       .doc('/users/${firebaseUser.value!.uid}')
  //       .snapshots()
  //       .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  // }
  //
  // //get the firestore user from the firestore collection
  // Future<UserModel> getFirestoreUser() {
  //   return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
  //       (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  // }
  //
  // //Method to handle user sign in using email and password
  // signInWithEmailAndPassword(BuildContext context) async {
  //   showLoadingIndicator();
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //     emailController.clear();
  //     passwordController.clear();
  //     hideLoadingIndicator();
  //   } catch (error) {
  //     hideLoadingIndicator();
  //     Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 7),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }
  //
  // // User registration using email and password
  // registerWithEmailAndPassword(BuildContext context) async {
  //   showLoadingIndicator();
  //   try {
  //     await _auth
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text)
  //         .then((result) async {
  //       print('uID: ' + result.user!.uid.toString());
  //       print('email: ' + result.user!.email.toString());
  //       //get photo url from gravatar if user has one
  //       Gravatar gravatar = Gravatar(emailController.text);
  //       String gravatarUrl = gravatar.imageUrl(
  //         size: 200,
  //         defaultImage: GravatarImage.retro,
  //         rating: GravatarRating.pg,
  //         fileExtension: true,
  //       );
  //       //create the new user object
  //       UserModel _newUser = UserModel(
  //           uid: result.user!.uid,
  //           email: result.user!.email!,
  //           name: nameController.text,
  //           photoUrl: gravatarUrl);
  //       //create the user in firestore
  //       _createUserFirestore(_newUser, result.user!);
  //       emailController.clear();
  //       passwordController.clear();
  //       hideLoadingIndicator();
  //     });
  //   } on FirebaseAuthException catch (error) {
  //     hideLoadingIndicator();
  //     Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }
  //
  // //handles updating the user when updating profile
  // Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
  //     String password) async {
  //   String _authUpdateUserNoticeTitle = 'auth.updateUserSuccessNoticeTitle'.tr;
  //   String _authUpdateUserNotice = 'auth.updateUserSuccessNotice'.tr;
  //   try {
  //     showLoadingIndicator();
  //     try {
  //       await _auth
  //           .signInWithEmailAndPassword(email: oldEmail, password: password)
  //           .then((_firebaseUser) async {
  //         await _firebaseUser.user!
  //             .updateEmail(user.email)
  //             .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
  //       });
  //     } catch (err) {
  //       print('Caught error: $err');
  //       //not yet working, see this issue https://github.com/delay/flutter_starter/issues/21
  //       if (err.toString() ==
  //           "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
  //         _authUpdateUserNoticeTitle = 'auth.updateUserEmailInUse'.tr;
  //         _authUpdateUserNotice = 'auth.updateUserEmailInUse'.tr;
  //       } else {
  //         _authUpdateUserNoticeTitle = 'auth.wrongPasswordNotice'.tr;
  //         _authUpdateUserNotice = 'auth.wrongPasswordNotice'.tr;
  //       }
  //     }
  //     hideLoadingIndicator();
  //     Get.snackbar(_authUpdateUserNoticeTitle, _authUpdateUserNotice,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 5),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   } on PlatformException catch (error) {
  //     //List<String> errors = error.toString().split(',');
  //     // print("Error: " + errors[1]);
  //     hideLoadingIndicator();
  //     print(error.code);
  //     String authError;
  //     switch (error.code) {
  //       case 'ERROR_WRONG_PASSWORD':
  //         authError = 'auth.wrongPasswordNotice'.tr;
  //         break;
  //       default:
  //         authError = 'auth.unknownError'.tr;
  //         break;
  //     }
  //     Get.snackbar('auth.wrongPasswordNoticeTitle'.tr, authError,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }
  //
  // //updates the firestore user in users collection
  // void _updateUserFirestore(UserModel user, User _firebaseUser) {
  //   _db.doc('/users/${_firebaseUser.uid}').update(user.toJson());
  //   update();
  // }
  //
  // //create the firestore user in users collection
  // void _createUserFirestore(UserModel user, User _firebaseUser) {
  //   _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
  //   update();
  // }
  //
  // //password reset email
  // Future<void> sendPasswordResetEmail(BuildContext context) async {
  //   showLoadingIndicator();
  //   try {
  //     await _auth.sendPasswordResetEmail(email: emailController.text);
  //     hideLoadingIndicator();
  //     Get.snackbar(
  //         'auth.resetPasswordNoticeTitle'.tr, 'auth.resetPasswordNotice'.tr,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 5),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   } on FirebaseAuthException catch (error) {
  //     hideLoadingIndicator();
  //     Get.snackbar('auth.resetPasswordFailed'.tr, error.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
  //         colorText: Get.theme.snackBarTheme.actionTextColor);
  //   }
  // }
  //
  // //check if user is an admin user
  // isAdmin() async {
  //   await getUser.then((user) async {
  //     DocumentSnapshot adminRef =
  //         await _db.collection('admin').doc(user.uid).get();
  //     if (adminRef.exists) {
  //       admin.value = true;
  //     } else {
  //       admin.value = false;
  //     }
  //     update();
  //   });
  // }
  //
  // // Sign out
  // Future<void> signOut() {
  //   nameController.clear();
  //   emailController.clear();
  //   passwordController.clear();
  //   return _auth.signOut();
  // }
}

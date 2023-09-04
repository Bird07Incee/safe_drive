import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, UserAuthState> {
  final liff = FlutterLineLiff();

  AuthBloc() : super(UserAuthInitial()) {
    on<UserAuthEventLogin>((event, emit) async {
      List<User> user;
      await liff.ready.then((_) async {
        print('Line Ready');
        if (!liff.isLoggedIn) {
          print('login');
          liff.login();
        } else {
          // bool profileSuccess = await setLineAuth();
          // if(profileSuccess) {
          //   print('is Logged in and profile success >>>> Redirect to Landing');
          //   useLineProfile.value = await FlutterLineLiff().profile;
          //   update();
          //   Get.toNamed(RouteName.landing);
          // } else {
          //   print('profile err');
          // }
          Navigator.pushNamed(event.context, "termAndCon");
        }
      });
      // liff.login();
      emit(UserAuthLoading());
      await liff.profile;

      String url = Uri.base.path;
      Uri uri = Uri.parse(url);
      String code = uri.queryParameters["code"]!;
      String state = uri.queryParameters["state"]!;
      String liffClientId = uri.queryParameters["liffClientId"]!;
      String liffRedirectUri = uri.queryParameters["liffRedirectUri"]!;

      print(code);

      emit(UserAuthAuthenticated(
          code: code,
          state: state,
          liffClientId: liffClientId,
          liffRedirectUri: Uri.parse(liffRedirectUri),
          accessToken: liff.id!));
    });

    on<UserAuthEventLogout>((event, emit) async {
      liff.logout();
      emit(UserAuthLogout());
    });
  }
}

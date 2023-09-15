import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/helpers/term_and_con_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, UserAuthState> {
  final liff = FlutterLineLiff();
  bool isLogin = false;
  TermAndConHelper termAndConHelper = TermAndConHelper();

  AuthBloc() : super(UserAuthInitial()) {
    on<UserAuthEventLogin>((event, emit) async {
      await liff.ready.then((_) async {
        // waiting for change

        Storage localStorage = window.localStorage;
        localStorage.forEach((key, value) {
          if (key == "LineLogin") {
            isLogin = true;
          }
        });

        if (!isLogin) {
          // liff.login();
          const url =
              'https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Kn9nO7oB&state=12345abcde&scope=profile%20openid%20email&nonce=09876xyz';
          if (await canLaunch(url)) {
            window.open(url, '_self');
          } else {
            throw "Couldn't launch URL";
          }
        } else {
          // print("termandcon value ${termAndConHelper.isTermAndConAccepted().toString()}");
          if (termAndConHelper.isTermAndConAccepted()) {
            print("term and con already accept");
            loadOneTrustCookieScript();
          } else {
            print("term and con not accept");
            await Navigator.pushNamed(
                event.context, Routes.termAndCon.toStringPath());
            loadOneTrustCookieScript();
          }
        }
      });

      // emit(UserAuthLoading());
      // await liff.profile;

      // String url = Uri.base.path;
      // Uri uri = Uri.parse(url);
      // String code = uri.queryParameters["code"]!;
      // String state = uri.queryParameters["state"]!;
      // String liffClientId = uri.queryParameters["liffClientId"]!;
      // String liffRedirectUri = uri.queryParameters["liffRedirectUri"]!;

      // emit(UserAuthAuthenticated(
      //     code: code,
      //     state: state,
      //     liffClientId: liffClientId,
      //     liffRedirectUri: Uri.parse(liffRedirectUri),
      //     accessToken: liff.id!));
    });

    on<UserAuthEventLogout>((event, emit) async {
      liff.logout();
      emit(UserAuthLogout());
    });
  }
}

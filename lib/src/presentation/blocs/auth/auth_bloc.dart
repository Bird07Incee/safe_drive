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

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final liff = FlutterLineLiff();
  bool isLogin = false;
  TermAndConHelper termAndConHelper = TermAndConHelper();

  AuthBloc() : super(const AuthState()) {
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
          bool isAccepted = await termAndConHelper.isTermAndConAccepted();
          if (isAccepted) {
            print("term and con already accept");
            loadOneTrustCookieScript();
            emit(state.copyWith(authStatus: AuthStatus.success));
          } else {
            print("term and con not accept");
            await Navigator.pushNamed(event.context, Routes.termAndCon.toStringPath());
            loadOneTrustCookieScript();
            emit(state.copyWith(authStatus: AuthStatus.success));
          }
        }
      });
    });

    on<UserAuthEventLogout>((event, emit) async {
      liff.logout();
    });
  }
}

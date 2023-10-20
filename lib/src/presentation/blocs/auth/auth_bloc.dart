import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/helpers/term_and_con_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final liff = FlutterLineLiff();
  bool isLogin = false;
  TermAndConHelper termAndConHelper = TermAndConHelper();

  AuthBloc() : super(const AuthState()) {
    on<UserAuthEventLogin>((event, emit) async {
      await Future.delayed(Duration(seconds: 1)).then((value) async {
        emit(state.copyWith(authStatus: AuthStatus.success));
      });
      // await liff.ready.then((_) async {
      //   // waiting for change
      //   bool isLogin = await PreferencesHelper.isContains('LineLogin');
      //   int exp = await LineDataHelper().getTokenExp();
      //   bool isExpired = exp < DateTime.now().millisecond * 1000;
      //   if (!isLogin) {
      //     String url = Environment().getValue("LINE_REDIRECT_URL");
      //     window.open(url, '_self');
      //   } else {
      //     bool isAccepted = await termAndConHelper.isTermAndConAccepted();
      //     if (isAccepted) {
      //       print("term and con already accept");
      //       loadOneTrustCookieScript();
      //       emit(state.copyWith(authStatus: AuthStatus.success));
      //     } else {
      //       print("term and con not accept");
      //       await Navigator.pushNamed(
      //           event.context, Routes.termAndCon.toStringPath());
      //       loadOneTrustCookieScript();
      //       emit(state.copyWith(authStatus: AuthStatus.success));
      //     }
      //   }
      // });
    });

    on<UserAuthEventLogout>((event, emit) async {
      liff.logout();
    });
  }
}

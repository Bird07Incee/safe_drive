import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:autoStation_promptBuy/configs/enivironment_config.dart';
import 'package:autoStation_promptBuy/src/helpers/shared_preference_helper.dart';
import 'package:autoStation_promptBuy/src/helpers/term_and_con_helper.dart';
import 'package:autoStation_promptBuy/src/js/js_manager.dart';
import 'package:autoStation_promptBuy/src/routes/routes.dart';
import 'package:universal_html/html.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final liff = FlutterLineLiff();
  bool isLogin = false;
  TermAndConHelper termAndConHelper = TermAndConHelper();

  AuthBloc() : super(const AuthState()) {
    on<UserAuthEventLogin>((event, emit) async {
      final navCtx = Navigator.of(event.context);
      await liff.ready.then((_) async {
        bool isLogin = await PreferencesHelper.isContains('LineLogin');
        if (!isLogin) {
          String url = Environment().getValue("LINE_REDIRECT_URL");
          window.open(url, '_self');
        } else {
          bool isAccepted = await termAndConHelper.isTermAndConAccepted();
          if (isAccepted) {
            // debugPrint("term and con already accept");
            String env = Environment().getValue("ENVIRONMENT_NAME");
            loadOneTrustCookieScript(env);
            emit(state.copyWith(authStatus: AuthStatus.success));
          } else {
            // debugPrint("term and con not accept");
            await navCtx.pushNamed(Routes.termAndCon.toStringPath());
            String env = Environment().getValue("ENVIRONMENT_NAME");
            loadOneTrustCookieScript(env);
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

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, UserAuthState> {
  final liff = FlutterLineLiff();
  Storage localStorage = window.localStorage;

  AuthBloc() : super(UserAuthInitial()) {
    on<UserAuthEventLogin>((event, emit) async {
      await liff.ready.then((_) async {
        print('Line Ready');
        if (!liff.isLoggedIn) {
          print('login liff');
          liff.login();
        } else {
          Navigator.pushNamed(event.context, "termAndCon");
        }
      });

      emit(UserAuthLoading());
      await liff.profile;

      String url = Uri.base.path;
      Uri uri = Uri.parse(url);
      String code = uri.queryParameters["code"]!;
      String state = uri.queryParameters["state"]!;
      String liffClientId = uri.queryParameters["liffClientId"]!;
      String liffRedirectUri = uri.queryParameters["liffRedirectUri"]!;

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

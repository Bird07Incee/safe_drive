// import 'dart:js' as js;
// import 'package:js/js.dart' as js;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universal_html/html.dart';

part 'check_browser_event.dart';

part 'check_browser_state.dart';

class CheckBrowserBloc extends Bloc<CheckBrowserEvent, CheckBrowserState> {
  CheckBrowserBloc() : super(CheckBrowserInitial()) {
    on<GetBrowserClient>((event, emit) async {
      emit(CheckBrowserLoading());
      var userAgent = window.navigator.userAgent;
      bool isLineBrowser = userAgent.contains('Line');
      if (!isLineBrowser) {
        emit(BrowserIsNotLineLiff());
      } else {
        emit(BrowserIsLineLiff());
      }
    });
  }
}

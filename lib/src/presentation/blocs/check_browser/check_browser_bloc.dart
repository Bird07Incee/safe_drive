import 'dart:js' as js;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';

part 'check_browser_event.dart';
part 'check_browser_state.dart';

class CheckBrowserBloc extends Bloc<CheckBrowserEvent, CheckBrowserState> {
  final liff = FlutterLineLiff();
  CheckBrowserBloc() : super(CheckBrowserInitial()) {
    on<GetBrowserClient>((event, emit) async {
      emit(CheckBrowserLoading());
      await liff.ready.then((_) async {
        var userAgent = js.context['navigator']['userAgent'];
        bool isLineBrowser = userAgent.contains('Line');
        if (!liff.isInClient && !isLineBrowser) {
          emit(BrowserIsNotLineLiff());
        } else {
          emit(BrowserIsLineLiff());
        }
      });
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'webview_event.dart';
part 'webview_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(WebViewState()) {
    on<WebViewInit>((event, emit) {
      emit(state.copyWith(url: event.url, status: WebViewStatus.loading));
    });
    on<WebViewSuccess>(webviewSuccess);
    on<WebViewError>(webviewError);
  }

  webviewSuccess(WebViewSuccess event, Emitter<WebViewState> emit) {
    emit(state.copyWith(status: WebViewStatus.success));
  }

  webviewError(WebViewError event, Emitter<WebViewState> emit) {
    emit(state.copyWith(status: WebViewStatus.error));
  }
}

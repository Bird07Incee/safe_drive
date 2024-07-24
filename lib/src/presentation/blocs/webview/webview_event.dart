part of 'webview_bloc.dart';

class WebViewEvent extends Equatable {
  const WebViewEvent();

  @override
  List<Object> get props => [];
}

class WebViewInit extends WebViewEvent {
  const WebViewInit({this.url = ""});
  final String url;
}

class WebViewSuccess extends WebViewEvent {}

class WebViewError extends WebViewEvent {}

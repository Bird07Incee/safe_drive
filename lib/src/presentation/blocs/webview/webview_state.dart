part of 'webview_bloc.dart';

enum WebViewStatus { initial, success, loading, error }

class WebViewState {
  const WebViewState({this.url = "", this.status = WebViewStatus.initial});
  final String url;
  final WebViewStatus status;

  WebViewState copyWith({String? url, WebViewStatus? status}) {
    return WebViewState(url: url ?? this.url, status: status ?? this.status);
  }
}

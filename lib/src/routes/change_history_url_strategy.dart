import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class ChangeHistoryUrlStrategy extends PathUrlStrategy {
  String? title;
  String? urlPromptBuy;
  ChangeHistoryUrlStrategy({this.title, this.urlPromptBuy}) {
    addPopStateListener((state) {
      replaceState(state, title ?? "", urlPromptBuy ?? "");
    });
  }
}

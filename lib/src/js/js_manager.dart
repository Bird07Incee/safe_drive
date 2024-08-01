// ignore_for_file: file_names, library_names

@JS()
library jsManager;

import 'package:js/js.dart';

@JS()
external void loadOneTrustCookieScript(env);
external void jsAlert(val);
external void callPhone(val);
external void replacePageHistory();
external void hideOneTrustCookieScript();
external void showOneTrustCookieScript();
external void setHistoryToInitialPage();
external void setStrictlyNecessaryCookie(cookieName, cookieValue, expirationDays);
external List<String> getOnetrustActiveGroups();

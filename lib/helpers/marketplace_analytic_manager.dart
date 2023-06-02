// import 'package:marketplace_line_oa/core/marketplace_core.dart';
// import 'package:superapp_flutter_core/core.dart';
//
// import 'marketplace_datastore.dart';
//
// class MarketplaceAnalyticManager extends MarketplaceCoreFeature {
//   static MarketplaceAnalyticManager? _instance;
//
//   static MarketplaceAnalyticManager get instance {
//     _instance ??= MarketplaceAnalyticManager();
//     return _instance!;
//   }
//
//   final SuperappCore _core = SuperappCore.instance;
//   late SuperAnalyticManager analyticManager;
//   late SuperUserManagement superUserManagement;
//   String? _key;
//
//   MarketplaceAnalyticManager() {
//     analyticManager = _core.superAnalyticManager;
//     superUserManagement = _core.superUserManagement;
//   }
//
//   Future<void> logEvent(
//       {required String eventType,
//       required String eventName,
//       required String screenName,
//       Map<String, String>? params}) async {
//     try {
//       if (_key == null || _key!.isEmpty) _key = getEnv<String>('AMPLITUDE_KEY');
//
//       Map<String, String>? _params = {};
//       if (params != null) _params = {...params};
//
//       await analyticManager.logActivityAndEvent(
//         key: _key!,
//         eventType: eventType,
//         eventName: eventName,
//         screenName: screenName,
//         params: _params,
//       );
//     } catch (_) {}
//   }
//
//   Future<void> logActivityAndEvent(
//       {required String eventType,
//       required String eventName,
//       required String screenName,
//       Map<String, String>? params}) async {
//     try {
//       bool isStandalone = MarketplaceDataStore().getArgs<bool>('isStandalone');
//       if (!isStandalone) {
//         if (_key == null || _key!.isEmpty) _key = getEnv<String>('AMPLITUDE_KEY');
//
//         Map<String, String>? _params = {};
//         if (params != null) _params = {...params};
//
//         await analyticManager.logActivityAndEvent(
//           key: _key!,
//           eventType: eventType,
//           eventName: eventName,
//           screenName: screenName,
//           params: _params,
//         );
//       }
//     } catch (_) {}
//   }
// }

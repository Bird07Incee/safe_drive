import 'package:commons/commons.dart';
import 'package:safe_drive/src/routers/screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: Get.key,
    initialLocation: Routes.loginScreen,
    routes: AppRouterPlatform.routers,
  );
}

class AppRouterPlatform {
  static final routers = <RouteBase>[
    GoRoute(
      path: Routes.loginScreen,
      redirect: HomePlatform.middleware,
      pageBuilder: HomePlatform.loginPage,
    ),
  ];
}

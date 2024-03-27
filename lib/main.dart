import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/blocs.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/routes/change_history_url_strategy.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

// import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
late DatadogConfiguration configuration;
UrlStrategy urlStrategyPromptBuy = ChangeHistoryUrlStrategy();
void main() async {
  setUrlStrategy(urlStrategyPromptBuy);
  WidgetsFlutterBinding.ensureInitialized();
  // _configureApp();
  _setUpAmplitude();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(MyApp());
    // DatadogSdk.runApp(configuration, TrackingConsent.granted, () async {
    //   return runApp(const MyApp());
    // });
  });
}

_configureApp() {
  _setUpDatadog();
  _setUpLineLIFF();
}

_setUpDatadog() {
  DatadogSdk.instance.sdkVerbosity = CoreLoggerLevel.debug;
  configuration = DatadogConfiguration(
    clientToken: 'pub002fb557c4b3f796b2eb3e9a2cc3bcdd',
    env: const String.fromEnvironment('SET_ENV', defaultValue: 'dev'),
    site: DatadogSite.us1,
    nativeCrashReportEnabled: true,
    loggingConfiguration: DatadogLoggingConfiguration(),
    rumConfiguration: DatadogRumConfiguration(applicationId: '93edfddb-2127-4074-b50c-ae8d9b9fadee', traceSampleRate: 100),
  );
}

_setUpLineLIFF() {
  LineDataHelper lineDataHelper = LineDataHelper();
  if (Uri.base.queryParameters.isNotEmpty) {
    Uri.base.queryParameters.forEach((key, value) {
      lineDataHelper.lineDataGrabber(key, value);
    });
    // waiting for change
    PreferencesHelper.setString("LineLogin", 'true');
    // Storage localStorage = window.localStorage;
    // localStorage.addAll({"LineLogin": 'true'});
  }
  String lineId = Environment().getValue("LIFF_ID");
  FlutterLineLiff().init(
      //TODO: config LIFF for prod
      config: Config(liffId: lineId),
      successCallback: () {},
      errorCallback: (error) {
        // debugPrint('init error: ${error.name}, ${error.message}, ${error.stack}');
      });
}

_setUpAmplitude() {
  final env = Environment().getValue("ENVIRONMENT_NAME");
  if (env == "dev") {
    try {
      AmplitudeWebHelper.getInstance();
    } catch (e) {
      debugPrint("Error initializing Amplitude: $e");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    LineDataHelper lineDataHelper = LineDataHelper();
    //qa
    lineDataHelper.saveSocialDataToLocalStorage(json.encode({
      "uid": "e959b083b3166422fb8717c6fe7e19e0cc6042dcb53976b26cb0c67085f636bf9fa8bef968f675d85619e150b1b2c91e6edf9859880ea63b38a5d18bca1b2be6",
      "access_token":
          "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQHH1TTAYaeDYZrot7f/MF+xAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAz8WjYdLV/0BxVdAoMCARCAggEHkWU0LbJns3MjepHoh2qrRJQNLin+cf0It4j20BcQyMt8BkaokyHX+JF/IdmuSs7IoE91fvFcHQ+AMmu8Z7KM5mBc17j2te8QPga7rvGD/BfTO9R/8+ptHJXnWxb8Vx6zp7Un1bprsXvB1nCknbpJ4KrHkCd5UOc+hqKZiNskmCd8thYlMPMiw+WWFvtol+hpVMB+l/QEyYx2OqtvR/iVetp7pfxhnePO2HTkP74hMLwQyZFUtMzgsE4apkMB8Nq56upCvbRM0o90SijtWvaXnskOeEyingk8hhnjgnk9M8a2iGD1iKVorI449QP2K8KzpOvFsfSOKitTer9IwYzp053uggfiTnU=",
      "refresh_token":
          "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQHV0mwEfX+n9TyfcVHt5Lc/AAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMiDBMB/w3cnGX86zwAgEQgC8EWRNCiio8BA1/l/QOSOiHN9FRqM5/63A6SzStxP9T/yOxu792a0U+57n4olAo5A==",
      "expires_in": 2592000,
      "tcVersion": "1",
      "tc_accept": "true"
    }));
    PreferencesHelper.setString("code", "unq9oC8ktfM5dKYf3tTg");
    PreferencesHelper.setString("LineLogin", 'true');
    PreferencesHelper.setString("tcVersion", '1');
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioUtilityRepository>(create: (context) => DioUtilityRepository(service: DioUtilityService())),
      ],
      child: MultiBlocProvider(
        providers: blocs,
        child: const RootPage(),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
  });
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    context.read<CheckBrowserBloc>().add(GetBrowserClient());
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      context.read<ConnectivityStatusBloc>().add(ConnectivityStatusEvent(connectivityResult: result));
    });
  }

  Future<void> initConnectivity() async {
    await Connectivity()
        .checkConnectivity()
        .then((value) => context.read<ConnectivityStatusBloc>().add(ConnectivityStatusEvent(connectivityResult: value)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace LINE OA mini',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      // routes: routes,
      onGenerateInitialRoutes: (initialRoute) => [generateRoute(RouteSettings(name: initialRoute))],
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 172, 204, 229),
          scaffoldBackgroundColor: const Color.fromARGB(255, 172, 204, 229),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Color(0xff2c2626)),
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)),
      navigatorObservers: [DatadogNavigationObserver(datadogSdk: DatadogSdk.instance), CurrentRouteObserver.instance],
    );
  }
}

class CurrentRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  CurrentRouteObserver._();

  static final instance = CurrentRouteObserver._();
  static final _stack = <String>[];

  String _name = "";
  String _last = "";

  String get name => _name;
  String get last => _last;
  List<String> get stack => _stack;

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    _name = screenName ?? "";
    // do something with it, ie. send it to analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
    var name = route.settings.name ?? "";
    _stack.add(name);
    _last = name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
    var name = newRoute?.settings.name ?? "";
    _stack.removeLast();
    _stack.add(name);
    _last = name;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
    _stack.removeLast();
  }
}

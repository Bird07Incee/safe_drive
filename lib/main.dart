import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/blocs.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

// import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
late DdSdkConfiguration configuration;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _configureApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    usePathUrlStrategy();
    // runApp(const MyApp());
    await DatadogSdk.runApp(configuration, () async {
      runApp(const MyApp());
    });
  });
}

_configureApp() {
  _setUpDatadog();
  _setUpLineLIFF();
}

_setUpLineLIFF() {
  LineDataHelper lineDataHelper = LineDataHelper();
  if (Uri.base.queryParameters.isNotEmpty) {
    print("params:");
    Uri.base.queryParameters.forEach((key, value) {
      print("$key=$value");
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
      successCallback: () {
        print('successCallback');
      },
      errorCallback: (error) {
        print('init error: ${error.name}, ${error.message}, ${error.stack}');
      });
}

_setUpDatadog() {
  configuration = DdSdkConfiguration(
    clientToken: 'pub002fb557c4b3f796b2eb3e9a2cc3bcdd',
    env: const String.fromEnvironment('SET_ENV', defaultValue: 'dev'),
    site: DatadogSite.us1,
    trackingConsent: TrackingConsent.granted,
    nativeCrashReportEnabled: true,
    loggingConfiguration: LoggingConfiguration(),
    rumConfiguration: RumConfiguration(applicationId: '93edfddb-2127-4074-b50c-ae8d9b9fadee'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioUtilityRepository>(
            create: (context) => DioUtilityRepository(service: DioUtilityService())),
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
    context.read<CheckBrowserBloc>().add(GetBrowserClient(context: context));
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      context.read<ConnectivityStatusBloc>().add(ConnectivityStatusEvent(connectivityResult: result));
    });
  }

  Future<void> initConnectivity() async {
    await Connectivity().checkConnectivity().then(
        (value) => context.read<ConnectivityStatusBloc>().add(ConnectivityStatusEvent(connectivityResult: value)));
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
      ),
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

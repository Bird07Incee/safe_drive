import 'dart:html';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/blocs.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
// import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

late DdSdkConfiguration configuration;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _configureApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    usePathUrlStrategy();
    runApp(const MyApp());
    // await DatadogSdk.runApp(configuration, () async {
    //   runApp(const MyApp());
    // });
  });
}

_configureApp() {
  //_setUpDatadog(); //get ENV also implemented here.
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
    Storage localStorage = window.localStorage;
    localStorage.addAll({"LineLogin": 'true'});
  }
  const env = String.fromEnvironment('SET_ENV', defaultValue: 'dev');
  FlutterLineLiff().init(
      //TODO: config LIFF for prod
      config: env == "prod" ? Config(liffId: '1661164508-Kn9nO7oB') : Config(liffId: '1661164508-Kn9nO7oB'),
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
    rumConfiguration: RumConfiguration(
      applicationId: '93edfddb-2127-4074-b50c-ae8d9b9fadee'
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocs,
      child: const RootPage(),
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
    // TODO: implement initState
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
      routes: routes,
      // onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 172, 204, 229),
        scaffoldBackgroundColor: const Color.fromARGB(255, 172, 204, 229),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Color(0xff2c2626)),
      ),
      // navigatorObservers: [
      //   DatadogNavigationObserver(datadogSdk: DatadogSdk.instance),
      // ],
    );
  }
}

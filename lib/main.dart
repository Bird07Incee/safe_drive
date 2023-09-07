import 'dart:html';

import 'package:connectivity_plus/connectivity_plus.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _loadENV();
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

  FlutterLineLiff().init(
      config: Config(liffId: '1661164508-Kn9nO7oB'),
      successCallback: () {
        print('successCallback');
      },
      errorCallback: (error) {
        print('init error: ${error.name}, ${error.message}, ${error.stack}');
      });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    // configureApp();
    usePathUrlStrategy();
    runApp(const MyApp());
  });
}

_loadENV() {
  const setEnv = String.fromEnvironment('SET_ENV', defaultValue: 'dev');
  String? env = setEnv;
  print('env : $env');
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
    );
  }
}

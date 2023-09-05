import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/blocs.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
// import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _loadENV();
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
      child: MaterialApp(
        title: 'Marketplace LINE OA mini',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        initialRoute: "/",
        routes: routes,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 172, 204, 229),
          scaffoldBackgroundColor: const Color.fromARGB(255, 172, 204, 229),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Color(0xff2c2626)),
        ),
      ),
    );
  }
}

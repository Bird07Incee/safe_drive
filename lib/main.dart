import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace_line_oa/constants/router/app_router.dart';
import 'package:marketplace_line_oa/controllers/auth_controller.dart';
import 'package:marketplace_line_oa/controllers/image_controller.dart';
import 'package:marketplace_line_oa/controllers/language_controller.dart';
import 'package:marketplace_line_oa/views/404_not_found.dart';
// import 'package:marketplace_line_oa/providers/line_provider.dart';
import 'package:marketplace_line_oa/views/widgets/shared/loading.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLineLiff().init(
      config: Config(liffId: '1661164508-Kn9nO7oB'),
      successCallback: (){
        print('successCallback');
      },
      errorCallback: (error){
        print('init error: ${error.name}, ${error.message}, ${error.stack}');
      }
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    configureApp();
    initialDependencies();
    runApp(MyApp());
  });
}

initialDependencies() async{
  await GetStorage.init();
  Get.put<LanguageController>(LanguageController());
}


class MyApp extends StatelessWidget {
  final AppRouter router = AppRouter();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          title: 'Marketplace LINE OA mini',
          // supportedLocales: const [
          //   Locale('en'), // English
          //   Locale('th') // Thailand
          // ],
          // localizationsDelegates: const [
          //   DefaultMaterialLocalizations.delegate,
          //   DefaultCupertinoLocalizations.delegate,
          //   DefaultWidgetsLocalizations.delegate,
          // ],
          // locale: languageController.getLocale, // <- Current locale
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 172, 204, 229),
            scaffoldBackgroundColor: const Color.fromARGB(255, 172, 204, 229),
            fontFamily: 'PromptMedium',
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Prompt-SemiBold',
                fontSize: 20,
                color: Colors.white,
              ), // AppBar
              titleMedium: TextStyle(
                fontFamily: 'Prompt-SemiBold',
                fontSize: 20,
                color: Color.fromARGB(255, 14, 90, 171),
              ), // Head Detail
              titleSmall: TextStyle(
                fontFamily: 'Prompt-SemiBold',
                fontSize: 18,
                color: Color.fromARGB(255, 14, 90, 171),
              ), // Head Promotion
              headlineMedium: TextStyle(
                fontFamily: 'Prompt-Medium',
                fontSize: 20,
                color: Color.fromARGB(255, 14, 90, 171),
              ), // Head PopUp
              headlineSmall: TextStyle(
                fontFamily: 'Prompt-Medium',
                fontSize: 16,
                color: Color.fromARGB(255, 14, 90, 171),
              ), // title Detail
              labelSmall: TextStyle(
                fontFamily: 'Prompt-Regular',
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
              ), // Text fields label
              displaySmall: TextStyle(
                fontFamily: 'Prompt-Regular',
                fontSize: 14,
                color: Color.fromRGBO(110, 196, 226, 100),
              ), // Text fields label Contact
              labelMedium: TextStyle(
                fontFamily: 'Prompt-Regular',
                fontSize: 18,
                color: Color.fromARGB(255, 14, 90, 171),
              ), //  menu profile
              bodyLarge: TextStyle(
                fontFamily: 'Prompt-Light',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(112, 112, 112, 1),
              ), // Text fields
              bodyMedium: TextStyle(
                fontFamily: 'Prompt-Light',
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, .7),
              ),
              bodySmall: TextStyle(
                fontFamily: 'Prompt-Light',
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),

              // Detail Body
            ),
          ),
          // initialRoute: "/landing",
          // getPages: AppRoutes.routes,
          onGenerateRoute: router.generateRoute,
          // onUnknownRoute: (settings) {
          //   return MaterialPageRoute(builder: (_) => const PageNotFound());
          // },
          initialBinding: RootBinding(),
          debugShowMaterialGrid: false,
        ),
      ),
    );
  }
}

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserAuthController(), permanent: true);
    Get.put(ImageController(), permanent: true);
  }
}


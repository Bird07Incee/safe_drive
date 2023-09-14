import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
// import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
// import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_banner.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/product_card_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart' as fll;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void webCookiePolicyBTS() {
  //   var maxWidth = MediaQuery.of(context).size.width;
  //   // เรียกใช้ showModalBottomSheet
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CookieAcceptUI(maxWidth: maxWidth);
  //     },
  //   );
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
    // Timer(const Duration(seconds: 1), () {
    //   final checkBrowserState = context.read<CheckBrowserBloc>().state;
    //   final env = Environment().getValue("ENVIRONMENT_NAME");
    //   if (checkBrowserState is BrowserIsLineLiff || (env != 'uat' && env != 'prod')) {
    //     context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
    //   }
    // });
  }

  Future<void> openLine() async {
    final Uri deepLink = Uri.parse(HomeConst().lineOAURL);
    if (!await launchUrl(deepLink)) {
      throw Exception('Could not launch $deepLink');
    }
  }

  showLoading(BuildContext context) {
    GeneralDialog().showLoadingDialog(context: context);
    Future.delayed(const Duration(seconds: 10)).then((value) => Navigator.pop(context));
  }

  PageController pageController = PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final liff = fll.FlutterLineLiff();
    return RootPageCondition(
        child: AlvaRootWidget(
            titlePage: titleWebPage,
            child: Container(
              color: cloudyWhite,
              child: ListView(
                children: [
                  HomepageTopSection(maxWidth: maxWidth),
                  HomePageBanner(
                    maxWidth: maxWidth,
                    pageControllerState: pageController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: maxWidth - 32,
                        child: ProductCardWidget(maxWidth: maxWidth),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: cloudDeepWhite,
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Storage localStorage = window.localStorage;
                                localStorage.clear();

                                liff.logout();
                              },
                              child: AlvaText(
                                title: HomeConst().termsAndConditions,
                                textStyle: AlvaStyles().headingSize10(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 1,
                              height: 16,
                              color: cloudSoftDeepWhite,
                            ),
                            AlvaText(
                              title: HomeConst().privacyPolicy,
                              textStyle: AlvaStyles().headingSize10(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: cloudDeepWhite,
                        height: 72,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AlvaText(
                                  title: HomeConst().askInformation,
                                  textStyle: AlvaStyles().headingSize10(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AlvaText(
                                  title: HomeConst().pleaseContact,
                                  textStyle: AlvaStyles().headingSize12w700(sugarRed),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: spaceGrey,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AlvaText(
                              title: HomeConst().warningWord,
                              textStyle: AlvaStyles().headingSize10w400(whiteFalse),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

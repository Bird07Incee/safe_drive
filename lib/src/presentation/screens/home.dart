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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    Future.delayed(const Duration(seconds: 10))
        .then((value) => Navigator.pop(context));
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width;
    final tabController = TabController(length: 4, vsync: this);
    return RootPageCondition(
        child: AlvaRootWidget(
            titlePage: titleWebPage,
            child: Container(
              color: cloudyWhite,
              child: CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    HomepageTopSection(maxWidth: maxWidth),
                    HomePageBanner(
                      maxWidth: maxWidth,
                      pageControllerState: pageController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ])),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    TabBar(
                      controller: tabController,
                      tabs: const <Widget>[
                        Tab(
                          icon: Icon(Icons.cloud_outlined),
                          // icon: Image.asset("assets/images/category/icon_cate_all.png"),
                          text: "ทั้งหมด",
                        ),
                        Tab(
                          icon: Icon(Icons.beach_access_sharp),
                          text: "วอลชาร์จ",
                        ),
                        Tab(
                          icon: Icon(Icons.brightness_5_sharp),
                          text: "โซลาร์เซลล์",
                        ),
                        Tab(
                          icon: Icon(Icons.access_alarm_sharp),
                          text: "สินค้าอื่นๆ",
                        ),
                      ],
                    )
                  ])),
                  SliverFillRemaining(
                    child: TabBarView(
                      clipBehavior: Clip.none,
                      controller: tabController,
                      children: <Widget>[
                        // ProductCardWidget(maxWidth: maxWidth),
                        Text("It's qwer here"),
                        Text("It's rainy here"),
                        Text("It's sunny here"),
                        Text("It's asdf here"),
                      ],
                    ),

                    // child: Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   crossAxisAlignment: CrossAxisAlignment.stretch,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: TabBarView(
                    //           clipBehavior: Clip.none,
                    //           controller: tabController,
                    //           children: [
                    //             ProductCardWidget(maxWidth: maxWidth),
                    //             // Text("It's qwer here"),
                    //             Text("It's rainy here"),
                    //             Text("It's sunny here"),
                    //             Text("It's asdf here"),
                    //           ]),
                    //     )
                    //   ],
                    // ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    Column(
                      children: [
                        Container(
                          color: cloudDeepWhite,
                          height: 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AlvaText(
                                title: HomeConst().termsAndConditions,
                                textStyle: AlvaStyles().headingSize10(),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                    textStyle: AlvaStyles()
                                        .headingSize12w700(sugarRed),
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
                                textStyle:
                                    AlvaStyles().headingSize10w400(whiteFalse),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]))
                ],
              ),
            )));
  }
}

// Poc appbar
class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        // body: Expanded(
        //   child: ,
        // ),
      ),
    );
  }
}

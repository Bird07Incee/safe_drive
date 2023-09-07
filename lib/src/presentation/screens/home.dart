import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_banner.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/product_card_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    // final checkBrowserState = context.read<CheckBrowserBloc>().state;
// -------------------------bypass-------------------------------------------------------
    // if (checkBrowserState is BrowserIsLineLiff) {
    //   context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
    // }
// -------------------------bypass-------------------------------------------------------
    context.read<AuthBloc>().add(UserAuthEventLogin(context: context));

    // Future.delayed(const Duration(seconds: 0)).then((_) {
    //   webCookiePolicyBTS();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ConnectivityStatusBloc, ConnectivityStatusState>(
      builder: (context, connectState) {
        if (connectState is NoInternet) {
          return ErrorScreen(
            title: ErrorConst().titleNS,
            subTitle: ErrorConst().subTitleNS,
            titleBtn: ErrorConst().titleBtnNS,
            onTap: () {},
          );
        } else {
          return AlvaRootWidget(
              titlePage: titleWebPage,
              child: Container(
                color: cloudyWhite,
                child: ListView(
                  children: [
                    HomepageTopSection(maxWidth: maxWidth),
                    GestureDetector(onTap: () => showLoading(context), child: HomePageBanner(maxWidth: maxWidth)),
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
                              AlvaText(
                                title: HomeConst().termsAndConditions,
                                textStyle: AlvaStyles().headingSize10(),
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
              ));
          // -------------------------bypass-------------------------------------------------------
          // return BlocBuilder<CheckBrowserBloc, CheckBrowserState>(
          //   builder: (context, checkBrowserState) {
          //     if (checkBrowserState is CheckBrowserLoading) {
          //       return const LoadingScreen();
          //     } else if (checkBrowserState is BrowserIsLineLiff) {
          //       return AlvaRootWidget(
          //           titlePage: titleWebPage,
          //           child: Container(
          //             color: cloudyWhite,
          //             child: ListView(
          //               children: [
          //                 HomepageTopSection(maxWidth: maxWidth),
          //                 HomePageBanner(maxWidth: maxWidth),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     SizedBox(
          //                       width: maxWidth - 32,
          //                       child: ProductCardWidget(maxWidth: maxWidth),
          //                     ),
          //                   ],
          //                 ),
          //                 Column(
          //                   children: [
          //                     Container(
          //                       color: cloudDeepWhite,
          //                       height: 32,
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.end,
          //                         children: [
          //                           AlvaText(
          //                             title: HomeConst().termsAndConditions,
          //                             textStyle: AlvaStyles().headingSize10(),
          //                           ),
          //                           Container(
          //                             margin: const EdgeInsets.symmetric(horizontal: 8),
          //                             width: 1,
          //                             height: 16,
          //                             color: cloudSoftDeepWhite,
          //                           ),
          //                           AlvaText(
          //                             title: HomeConst().privacyPolicy,
          //                             textStyle: AlvaStyles().headingSize10(),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     Container(
          //                       color: cloudDeepWhite,
          //                       height: 72,
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             children: [
          //                               AlvaText(
          //                                 title: HomeConst().askInformation,
          //                                 textStyle: AlvaStyles().headingSize10(),
          //                               ),
          //                             ],
          //                           ),
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             children: [
          //                               AlvaText(
          //                                 title: HomeConst().pleaseContact,
          //                                 textStyle: AlvaStyles().headingSize12w700(sugarRed),
          //                               ),
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     Container(
          //                       color: spaceGrey,
          //                       height: 40,
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           AlvaText(
          //                             title: HomeConst().warningWord,
          //                             textStyle: AlvaStyles().headingSize10w400(whiteFalse),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ));
          //     } else {
          //       return ErrorScreen(
          //         title: ErrorConst().titleBrowser,
          //         subTitle: ErrorConst().subTitleBrowser,
          //         titleBtn: ErrorConst().titleBtnBrowser,
          //         onTap: () {
          //           openLine();
          //         },
          //       );
          //     }
          //   },
          // );
          // -------------------------bypass-------------------------------------------------------
        }
      },
    );
  }
}

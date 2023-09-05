import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_banner.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/product_card_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

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
    super.initState();
    // TODO: implement initState

    // final checkBrowserState = context.read<CheckBrowserBloc>().state;
    // if (checkBrowserState is BrowserIsLineLiff) {
    //   context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
    // }

    context.read<AuthBloc>().add(UserAuthEventLogin(context: context));

    // Future.delayed(const Duration(seconds: 0)).then((_) {
    //   webCookiePolicyBTS();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return AlvaRootWidget(
        titlePage: "HomeScreen",
        child: Container(
          color: const Color(0xffF3F3F3),
          child: ListView(
            children: [
              HomepageTopSection(maxWidth: maxWidth),
              HomePageBanner(maxWidth: maxWidth),
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
                    color: Color(0xffE2DFDF),
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            window.location.assign("https://sandbox-pgw-ui.2c2p.com/payment/4.1/#/token/kSAops9Zwhos8hSTSeLTUcp7apFvO3Sxaj6ugSoUgMu[…]im9OmovvbjsmrRKV0l8GTeDONlZ5SeGAX7j59D3243yVCsg%2f");
                          },
                          child: AlvaText(
                            title: 'ข้อกำหนดและเงื่อนไข',
                            textStyle: AlvaStyles().headingSize10(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 1,
                          height: 16,
                          color: Color(0xffDEDEDE),
                        ),
                        AlvaText(
                          title: 'นโยบายความเป็นส่วนตัว',
                          textStyle: AlvaStyles().headingSize10(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffE2DFDF),
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AlvaText(
                              title: 'สอบถามข้อมูลอื่นๆ เกี่ยวกับสินค้า หรือ ติดตามสถานะการจัดส่งสินค้า',
                              textStyle: AlvaStyles().headingSize10(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AlvaText(
                              title: 'กรุณาติดต่อ  081-123-4567',
                              textStyle: AlvaStyles().headingSize12w700(Color(0xff6F5F5E)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xff5A5A5A),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AlvaText(
                          title: 'ข้อมูลนี้เป็นข้อมูลจากผู้ให้บริการ อาจมีการเปลี่ยนแปลงได้ตลอดเวลา',
                          textStyle: AlvaStyles().headingSize10w400(Color(0xffFAFCFF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));

    // return BlocBuilder<CheckBrowserBloc, CheckBrowserState>(
    //   builder: (context, checkBrowserState) {
    //     if (checkBrowserState is CheckBrowserLoading) {
    //       return const LoadingScreen();
    //     } else if (checkBrowserState is BrowserIsLineLiff) {
    //       return AlvaRootWidget(
    //           titlePage: "HomeScreen",
    //           child: Container(
    //             color: const Color(0xffF3F3F3),
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
    //                       color: Color(0xffE2DFDF),
    //                       height: 32,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           AlvaText(
    //                             title: 'ข้อกำหนดและเงื่อนไข',
    //                             textStyle: AlvaStyles().headingSize10(),
    //                           ),
    //                           Container(
    //                             margin: EdgeInsets.symmetric(horizontal: 8),
    //                             width: 1,
    //                             height: 16,
    //                             color: Color(0xffDEDEDE),
    //                           ),
    //                           AlvaText(
    //                             title: 'นโยบายความเป็นส่วนตัว',
    //                             textStyle: AlvaStyles().headingSize10(),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       color: Color(0xffE2DFDF),
    //                       height: 72,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               AlvaText(
    //                                 title: 'สอบถามข้อมูลอื่นๆ เกี่ยวกับสินค้า หรือ ติดตามสถานะการจัดส่งสินค้า',
    //                                 textStyle: AlvaStyles().headingSize10(),
    //                               ),
    //                             ],
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               AlvaText(
    //                                 title: 'กรุณาติดต่อ  081-123-4567',
    //                                 textStyle: AlvaStyles().headingSize12w700(Color(0xff6F5F5E)),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       color: Color(0xff5A5A5A),
    //                       height: 40,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           AlvaText(
    //                             title: 'ข้อมูลนี้เป็นข้อมูลจากผู้ให้บริการ อาจมีการเปลี่ยนแปลงได้ตลอดเวลา',
    //                             textStyle: AlvaStyles().headingSize10w400(Color(0xffFAFCFF)),
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
    //       return const ErrorScreen();
    //     }
    //   },
    // );
  }
}

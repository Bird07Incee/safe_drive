import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
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
    context.read<ProductListBloc>().add(const GetProductList());
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

  ProductList getProductListByCategory(ProductList unSortProductList, int id) {
    // ignore: prefer_const_constructors
    ProductList result =
        ProductList(productAllItems: 0, productPage: 0, productCountItems: 0, banner: [], category: [], products: []);

    for (final product in unSortProductList.products!) {
      if (product.categoryId == (id + 1).toString()) {
        result.products?.add(product);
      }
    }

    return result;
  }

  PageController pageController = PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width;
    final tabController = TabController(length: 4, vsync: this);
    return RootPageCondition(
        child: AlvaRootWidget(
            titlePage: titleWebPage,
            child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state.productListStatus == GetProductListStatus.success) {
                  return Container(
                    color: cloudyWhite,
                    child: ListView(
                      children: [
                        HomepageTopSection(maxWidth: maxWidth),
                        HomePageBanner(
                          maxWidth: maxWidth,
                          pageControllerState: pageController,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.white,
                          child: TabBar(
                              controller: tabController,
                              labelColor: Colors.black,
                              indicatorColor: BlueFantasy,
                              labelStyle: AlvaStyles().headingSize10w600(BTN_SELECTED_TEXT_COLOR_NEW),
                              unselectedLabelColor: const Color(0xffA4A8AD),
                              onTap: (int index) {
                                context.read<ProductListBloc>().add(SetSelectTabIndex(index));
                              },
                              tabs: [
                                Tab(
                                  text: "ทั้งหมด",
                                  icon: state.selectedTabIndex == 0
                                      ? Image.asset('assets/images/category/icon_active_cate_all.png',
                                          width: 24, height: 24)
                                      : Image.asset('assets/images/category/icon_cate_all.png', width: 24, height: 24),
                                ),
                                Tab(
                                  text: "วอลชาร์จ",
                                  icon: state.selectedTabIndex == 1
                                      ? Image.asset('assets/images/category/icon_active_cate_wallcharge.png',
                                          width: 24, height: 24)
                                      : Image.asset('assets/images/category/icon_cate_wallcharge.png',
                                          width: 24, height: 24),
                                ),
                                Tab(
                                  text: "โซลาร์เซลล์",
                                  icon: state.selectedTabIndex == 2
                                      ? Image.asset('assets/images/category/icon_active_cate_solar.png',
                                          width: 24, height: 24)
                                      : Image.asset('assets/images/category/icon_cate_solar.png',
                                          width: 24, height: 24),
                                ),
                                Tab(
                                  text: "สินค้าอื่นๆ",
                                  icon: state.selectedTabIndex == 3
                                      ? Image.asset('assets/images/category/icon_active_cate_other.png',
                                          width: 24, height: 24)
                                      : Image.asset('assets/images/category/icon_cate_other.png',
                                          width: 24, height: 24),
                                ),
                              ]),
                        ),
                        IndexedStack(
                          index: state.selectedTabIndex,
                          children: [
                            Visibility(
                              maintainState: true,
                              visible: state.selectedTabIndex == 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: maxWidth - 32,
                                    child: ProductCardWidget(
                                      maxWidth: maxWidth,
                                      productList: state.productList,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              maintainState: true,
                              visible: state.selectedTabIndex == 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: maxWidth - 32,
                                    child: ProductCardWidget(
                                        maxWidth: maxWidth,
                                        productList: getProductListByCategory(state.productList, 1)),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              maintainState: true,
                              visible: state.selectedTabIndex == 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: maxWidth - 32,
                                    child: ProductCardWidget(
                                        maxWidth: maxWidth,
                                        productList: getProductListByCategory(state.productList, 2)),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              maintainState: true,
                              visible: state.selectedTabIndex == 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: maxWidth - 32,
                                    child: ProductCardWidget(
                                        maxWidth: maxWidth,
                                        productList: getProductListByCategory(state.productList, 3)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AlvaText(
                                    title: HomeConst().warningWord,
                                    textStyle: AlvaStyles().headingSize10w400(BTN_SELECTED_TEXT_COLOR_NEW),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              color: cloudDeepWhite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AlvaText(
                                    title: HomeConst().termsAndConditions,
                                    textStyle: AlvaStyles().headingSize10w600(sugarRed),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    width: 1,
                                    height: 16,
                                    color: sugarRed,
                                  ),
                                  AlvaText(
                                    title: HomeConst().privacyPolicy,
                                    textStyle: AlvaStyles().headingSize10w600(sugarRed),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: spaceGrey,
                              height: 72,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AlvaText(
                                        title: HomeConst().askInformation,
                                        textStyle: AlvaStyles().headingSize10w600(whiteFalse),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AlvaText(
                                        title: HomeConst().pleaseContact,
                                        textStyle: AlvaStyles().headingSize12w700(whiteFalse),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state.productListStatus == GetProductListStatus.error) {
                  return ErrorScreen(
                    title: ErrorConst().titleNS,
                    subTitle: ErrorConst().subTitleNS,
                    titleBtn: ErrorConst().titleBtnNS,
                    onTap: () {},
                  );
                } else {
                  return const LoadingScreen();
                }
              },
            )));
  }
}

import 'dart:async';
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
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0, keepPage: false);
  ScrollController scrollController = ScrollController();
  // late TabController tabController;

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

  bool isMorePageToLoad(ProductList productList) {
    bool isMore = false;

    if ((10 - productList.productCountItems!) == 0 && productList.productAllItems! > (productList.productPage! * 10)) {
      isMore = true;
    }

    return isMore;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width;
    final tabController = TabController(length: 5, vsync: this);
    return RootPageCondition(
        child: AlvaRootWidget(
            titlePage: titleWebPage,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.authStatus == AuthStatus.success) {
                  context.read<ProductListBloc>().add(const GetProductList());
                }
              },
              builder: (context, state) {
                return BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, state) {
                    // tabController = TabController(length: state.productList.category!.length + 1, vsync: this);
                    if (state.productListStatus == GetProductListStatus.success) {
                      return Container(
                        color: cloudyWhite,
                        child: ListView(
                          controller: scrollController,
                          children: [
                            HomepageTopSection(maxWidth: maxWidth),
                            HomePageBanner(
                              maxWidth: maxWidth,
                              pageControllerState: pageController,
                            ),
                            StickyHeader(
                              header: Visibility(
                                visible: state.hideCategory ? false : true,
                                child: Container(
                                  width: maxWidth,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  color: Colors.white,
                                  child: TabBar(
                                      controller: tabController,
                                      labelColor: Colors.black,
                                      indicatorColor: BlueFantasy,
                                      padding: EdgeInsets.only(right: 8),
                                      labelPadding: EdgeInsets.symmetric(horizontal: 24),
                                      isScrollable: true,
                                      labelStyle: AlvaStyles().headingSize10w600(BTN_SELECTED_TEXT_COLOR_NEW),
                                      unselectedLabelColor: const Color(0xffDEDEDE),
                                      onTap: (int index) {
                                        context.read<ProductListBloc>().add(SetSelectTabIndex(index));
                                        if (index == 0) {
                                          context.read<ProductListBloc>().add(GetProductListByCategory("", context));
                                        } else {
                                          context.read<ProductListBloc>().add(GetProductListByCategory(
                                              state.productList.category![index - 1]["categoryId"], context));
                                        }
                                        scrollController.animateTo(
                                            //go to top of scroll
                                            0, //scroll offset to go
                                            duration: Duration(milliseconds: 500), //duration of scroll
                                            curve: Curves.fastOutSlowIn //scroll type
                                            );
                                      },
                                      tabs: [
                                        Tab(
                                          text: "ทั้งหมด",
                                          icon: state.selectedTabIndex == 0
                                              ? Image.asset('assets/images/category/icon_active_cate_all.png',
                                                  width: 24, height: 24)
                                              : Image.asset('assets/images/category/icon_cate_all.png',
                                                  width: 24, height: 24),
                                        ),
                                        for (int i = 0; i < state.productList.category!.length; i++)
                                          Tab(
                                              text: state.productList.category![i]["categoryTh"],
                                              icon: state.selectedTabIndex == (i + 1)
                                                  ? SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: FadeInImage(
                                                        placeholder: const AssetImage(
                                                            'assets/images/category/icon_active_cate_other.png'),
                                                        // Replace with your placeholder image path
                                                        image:
                                                            NetworkImage(state.productList.category![i]["img_active"]),
                                                        fit: BoxFit.fitWidth,
                                                        imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                                            'assets/images/category/icon_active_cate_other.png',
                                                            fit: BoxFit.fitWidth),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: FadeInImage(
                                                        placeholder: const AssetImage(
                                                            'assets/images/category/icon_cate_other.png'),
                                                        // Replace with your placeholder image path
                                                        image: NetworkImage(
                                                            state.productList.category![i]["img_inactive"]),
                                                        fit: BoxFit.fitWidth,
                                                        imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                                            'assets/images/category/icon_cate_other.png',
                                                            fit: BoxFit.fitWidth),
                                                      ),
                                                    )),
                                        // Tab(
                                        //   text: "วอลชาร์จ",
                                        //   icon: state.selectedTabIndex == 1
                                        //       ? Image.asset('assets/images/category/icon_active_cate_wallcharge.png',
                                        //           width: 24, height: 24)
                                        //       : Image.asset('assets/images/category/icon_cate_wallcharge.png',
                                        //           width: 24, height: 24),
                                        // ),
                                        // Tab(
                                        //   text: "โซลาร์เซลล์",
                                        //   icon: state.selectedTabIndex == 2
                                        //       ? Image.asset('assets/images/category/icon_active_cate_solar.png',
                                        //           width: 24, height: 24)
                                        //       : Image.asset('assets/images/category/icon_cate_solar.png',
                                        //           width: 24, height: 24),
                                        // ),
                                        // Tab(
                                        //   text: "สินค้าอื่นๆ",
                                        //   icon: state.selectedTabIndex == 3
                                        //       ? Image.asset('assets/images/category/icon_active_cate_other.png',
                                        //           width: 24, height: 24)
                                        //       : Image.asset('assets/images/category/icon_cate_other.png',
                                        //           width: 24, height: 24),
                                        // ),
                                      ]),
                                ),
                              ),
                              content: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: maxWidth - 32,
                                        child: ProductCardWidget(
                                          maxWidth: maxWidth,
                                          // productList: state.productList,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: isMorePageToLoad(state.productList),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (state.selectedTabIndex == 0) {
                                          context.read<ProductListBloc>().add(GetProductListByPage(
                                              state.productList, state.productList.productPage! + 1, "", context));
                                        } else {
                                          context.read<ProductListBloc>().add(GetProductListByPage(
                                              state.productList,
                                              state.productList.productPage! + 1,
                                              state.productList.category![state.selectedTabIndex - 1]["categoryId"],
                                              context));
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 32,
                                            margin: EdgeInsets.symmetric(vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: whitePure.withOpacity(0.4),
                                                    spreadRadius: 0,
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ]),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                  'โหลดเพิ่มเติม',
                                                  style: AlvaStyles().bodySize12W600(spaceGrey),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                          onTapfunction: () {
                                            Navigator.pushNamed(context, '/readTermAndCon');
                                          }),
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
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
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
                                      const SizedBox(
                                        height: 32,
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
                        onTap: () {
                          if (state.selectedTabIndex == 0) {
                            context.read<ProductListBloc>().add(const GetProductList());
                          } else {
                            context.read<ProductListBloc>().add(GetProductListByCategory(
                                state.productList.category![state.selectedTabIndex - 1]["categoryId"], context));
                          }
                        },
                      );
                    } else if (state.productListStatus == GetProductListStatus.loadingTranparent) {
                      return const LoadingScreen();
                    } else {
                      return const LoadingScreen();
                    }
                  },
                );
              },
            )));
  }
}

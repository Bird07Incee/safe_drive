import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/helpers/term_and_con_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
// import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
// import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_banner.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/home_page_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/homepage/product_card_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AmplitudeWebHelper amplitudeWebHelper = AmplitudeWebHelper.getInstance();
  PageController pageController = PageController(initialPage: 0, keepPage: false);
  ScrollController? scrollController;
  bool isNotLogin = true;
  TextEditingController tc = TextEditingController();
  TabController? tabController;

  bool loglaew = false;

  @override
  void initState() {
    super.initState();
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

  bool isMorePageToLoad(ProductList productList) {
    bool isMore = false;

    if ((10 - productList.productCountItems!) == 0 && productList.productAllItems! > (productList.productPage! * 10)) {
      isMore = true;
    }

    return isMore;
  }

  Future<void> _checkTermAndConAcceptedVersion(BuildContext context) async {
    final nav = Navigator.of(context);
    final route = ModalRoute.of(context);
    bool tc = await TermAndConHelper().isTermAndConAccepted();

    if (!tc && CurrentRouteObserver.instance.last != Routes.termAndCon.toStringPath()) {
      nav.pushNamed(Routes.termAndCon.toStringPath()).then((value) {
        loglaew = false;
      });
    } else {
      if (!loglaew && route!.settings.name! == Routes.initial.name) {
        amplitudeWebHelper.logeMarketplaceHomePageHomeScreen();
        loglaew = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width;
    return RootPageCondition(
        child: WillPopScope(
            onWillPop: () async {
              setHistoryToInitialPage();
              return false;
            },
            child: AlvaRootWidget(
                titlePage: titleWebPage,
                child: BlocConsumer<ProductListBloc, ProductListState>(
                  listener: (context, state) {
                    if (state.productListStatus == GetProductListStatus.success) {
                      _checkTermAndConAcceptedVersion(context);
                    }
                  },
                  builder: (context, state) {
                    scrollController ??= ScrollController(initialScrollOffset: state.scrollPosition);
                    return BlocConsumer<AuthBloc, AuthState>(listener: (context, stateAuth) {
                      if (stateAuth.authStatus == AuthStatus.success && state.productListStatus == GetProductListStatus.initial) {
                        context.read<ProductListBloc>().add(const GetProductList());
                      }
                    }, builder: (ctx, stateAuth) {
                      if (stateAuth.authStatus == AuthStatus.initial && isNotLogin) {
                        isNotLogin = false;
                        context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
                      }
                      if (state.productListStatus == GetProductListStatus.maintenance) {
                        return ErrorScreen(
                          title: ErrorConst().titleMaintenance,
                          subTitle: ErrorConst().subtitleMaintenance,
                          titleBtn: ErrorConst().titleBtnMaintenance,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      } else if (state.productListStatus == GetProductListStatus.success) {
                        tabController ??=
                            TabController(initialIndex: state.selectedTabIndex, length: state.productList.category!.length + 1, vsync: this);
                        return Container(
                          color: cloudyWhite,
                          child: ListView(
                            controller: scrollController,
                            children: [
                              HomepageTopSection(
                                maxWidth: maxWidth,
                                scrollController: scrollController!,
                              ),
                              HomePageBanner(
                                pageControllerState: pageController,
                                banners: state.productList.banner!,
                              ),
                              StickyHeader(
                                header: Visibility(
                                  visible: state.hideCategory ? false : true,
                                  child: Container(
                                    width: maxWidth,
                                    //  padding: const EdgeInsets.symmetric(horizontal: 16),
                                    color: Colors.white,
                                    child: TabBar(
                                        controller: tabController,
                                        labelColor: Colors.black,
                                        indicatorColor: mintGreen,
                                        //    padding: EdgeInsets.only(right: 8),
                                        labelPadding: EdgeInsets.symmetric(horizontal: 30),
                                        isScrollable: true,
                                        labelStyle: AlvaStyles().headingSize10w600(BTN_SELECTED_TEXT_COLOR_NEW),
                                        unselectedLabelColor: const Color(0xffC2C1C1),
                                        onTap: (int index) {
                                          context.read<ProductListBloc>().add(SetSelectTabIndex(index));
                                          if (index == 0) {
                                            amplitudeWebHelper.logTapOnCategory(categoryId: "ALL");
                                            context.read<ProductListBloc>().add(GetProductListByCategory("", context));
                                          } else {
                                            amplitudeWebHelper.logTapOnCategory(
                                                categoryId: state.productList.category![index - 1]["categoryId"].toString());
                                            context.read<ProductListBloc>().add(
                                                GetProductListByCategory(state.productList.category![index - 1]["categoryId"].toString(), context));
                                          }

                                          scrollController!.animateTo(
                                              //go to top of scroll
                                              0, //scroll offset to go
                                              duration: Duration(milliseconds: 500), //duration of scroll
                                              curve: Curves.fastOutSlowIn //scroll type
                                              );
                                        },
                                        tabs: [
                                          Container(
                                            height: 58,
                                            padding: EdgeInsets.only(top: 8, bottom: 4),
                                            child: Tab(
                                              iconMargin: EdgeInsets.only(bottom: 4),
                                              text: "ทั้งหมด",
                                              icon: state.selectedTabIndex == 0
                                                  ? Image.asset('assets/images/category/icon_active_cate_all2.png', width: 24, height: 24)
                                                  : Image.asset('assets/images/category/icon_cate_all2.png', width: 24, height: 24),
                                            ),
                                          ),
                                          for (int i = 0; i < state.productList.category!.length; i++)
                                            Container(
                                              height: 58,
                                              padding: EdgeInsets.only(top: 8, bottom: 4),
                                              child: Tab(
                                                  iconMargin: EdgeInsets.only(bottom: 4),
                                                  text: state.productList.category![i]["categoryTh"],
                                                  icon: state.selectedTabIndex == (i + 1)
                                                      ? SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: FadeInImage(
                                                            placeholder: const AssetImage('assets/images/category/icon_active_cate_other2.png'),
                                                            // Replace with your placeholder image path
                                                            image: NetworkImage(state.productList.category![i]["img_active"]),
                                                            fit: BoxFit.fitWidth,
                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                              return Image.asset('assets/images/category/icon_cate_other2.png', fit: BoxFit.fitWidth);
                                                            },
                                                          ))
                                                      : SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: FadeInImage(
                                                              placeholder: const AssetImage('assets/images/category/icon_cate_other2.png'),
                                                              // Replace with your placeholder image path
                                                              image: NetworkImage(state.productList.category![i]["img_inactive"]),
                                                              fit: BoxFit.fitWidth,
                                                              imageErrorBuilder: (context, error, stackTrace) {
                                                                return Image.asset('assets/images/category/icon_cate_other2.png',
                                                                    fit: BoxFit.fitWidth);
                                                              }),
                                                        )),
                                            ),
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
                                            scrollController: scrollController!,
                                            // productList: state.productList,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: isMorePageToLoad(state.productList),
                                      child: GestureDetector(
                                        key: const Key("load_more_button"),
                                        onTap: () {
                                          if (state.selectedTabIndex == 0) {
                                            context
                                                .read<ProductListBloc>()
                                                .add(GetProductListByPage(state.productList, state.productList.productPage! + 1, "", context));
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
                                              decoration:
                                                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)), boxShadow: [
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
                                              amplitudeWebHelper.logTapOnTermAndConditionButton();
                                              context.read<ProductListBloc>().add(SetScrollPosition(scrollController!.offset));
                                              Navigator.pushNamed(context, '/readTermAndCon').then((value) {
                                                loglaew = false;
                                              });
                                            }),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          width: 1,
                                          height: 16,
                                          color: sugarRed,
                                        ),
                                        GestureDetector(
                                          key: const Key("about_us_button"),
                                          onTap: () {
                                            amplitudeWebHelper.logTapOnPrivacyPolicyButton();
                                            launchUrl(Uri.parse("https://www.krungsriauto.com/auto/About-Us/Privacy_Notice.html"));
                                          },
                                          child: Text(
                                            HomeConst().privacyPolicy,
                                            style: AlvaStyles().headingSize10w600(sugarRed),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DisclaimerSection(),
                                  Container(
                                    color: mintGreen,
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
                                        GestureDetector(
                                          key: const Key("call_button"),
                                          onTap: () {
                                            amplitudeWebHelper.logTapOnCallCenterButton();
                                            callPhone(HomeConst().pleaseContactNumber);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                HomeConst().pleaseContact,
                                                style: AlvaStyles().headingSize12w700(whiteFalse),
                                              ),
                                            ],
                                          ),
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
                      } else if (state.productListStatus == GetProductListStatus.initial || state.productListStatus == GetProductListStatus.loading) {
                        return const LoadingScreen();
                      } else {
                        return ErrorScreen(
                          title: ErrorConst().titleNS,
                          subTitle: ErrorConst().subTitleNS,
                          titleBtn: ErrorConst().titleBtnNS,
                          onTap: () {
                            if (state.selectedTabIndex == 0) {
                              context.read<ProductListBloc>().add(const GetProductList());
                            } else {
                              context
                                  .read<ProductListBloc>()
                                  .add(GetProductListByCategory(state.productList.category![state.selectedTabIndex - 1]["categoryId"], context));
                            }
                          },
                        );
                      }
                    });
                  },
                ))));
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:marketplace_line_oa/controllers/auth_controller.dart';
//
// class Default extends StatelessWidget {
//   const Default({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: UserAuthController(),
//       builder: (controller) => const Scaffold(
//         body: Center(
//           child: Text('Default Page',
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/constants/router/route_config.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';
import 'package:marketplace_line_oa/views/widgets/product_detail_widgets/product_detail_center_section.dart';
import 'package:marketplace_line_oa/views/widgets/product_detail_widgets/product_detail_top_section.dart';
import 'package:marketplace_line_oa/views/widgets/product_detail_widgets/product_details_bottom_section.dart';
import 'package:marketplace_line_oa/views/widgets/shared/bottom_sheet.dart';


class Default extends GetView<ProductController> {
  Default({Key? key}) : super(key: key);
  final oCcy = NumberFormat("#,##0", "en_US");
  final scrollController = ScrollController();
  late double maxWidth, maxHeight;

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height - 40;
    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (pController) {
          return WillPopScope(
              onWillPop: _backPressed,
              child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      key: const Key("pop_navigator_to_home_page"),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    actions: [
                      GestureDetector(
                        key: const Key("favorite_appbar_section_button"),
                        onTap: () {
                          pController.setFav();
                        },
                        child: Container(
                          width: 32.0,
                          height: 32.0,
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          margin: const EdgeInsets.only(right: 18.0),
                          child: pController.isFav.value ? Image.asset(
                            "assets/icons/icon_favorite_white.png",
                            fit: BoxFit.fitWidth,
                          ) : Image.asset(
                            "assets/icons/icon_favorite_outline.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                    leadingWidth: 60,
                    titleSpacing: 0,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WallBox DC Fast Charger",
                          key: const Key("appbar_title"),
                          style: const TextTheme().titleLarge?.copyWith(
                            color: const Color(0xffffffff),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                        ),
                        // Text(
                        //   "300000 บาท",
                        //   key: const Key("appbar_show_price"),
                        //   style: const TextTheme().titleLarge?.copyWith(
                        //     color: const Color(0xffffffff),
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                    centerTitle: false,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bg/bg_header_car_detail.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  body: ListView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    children: [
                      // Car Details top section
                      CarDetailTopSection(
                        onTap: () {
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: maxWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffdedede).withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const ProductDetailCenterSection(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: maxWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffdedede).withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const BottomSection(),
                      ),
                    ],
                  ),
                  bottomSheet: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BottomSheetCustom(
                      key: const Key("dld_button"),
                      textColor: BN_COLOR_BLACK,
                      buttonColor: BN_COLOR_PRIMARY_YELLOW,
                      callback: () async {
                        Get.toNamed(RouteName.payment);
                      },
                      btnText: "สนใจสั่งซื้อ",
                    ),
                  )
              )
          );
        }
    );
  }

  Future<bool> _backPressed() async {
    return true;
  }

}


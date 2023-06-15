import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/constants/router/route_config.dart';
import 'package:marketplace_line_oa/controllers/landing_controller.dart';
import 'package:marketplace_line_oa/views/widgets/drawer_widget.dart';
import 'package:marketplace_line_oa/views/widgets/product_list_widget.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';


class Landing extends GetView<LandingController> {
  const Landing({Key? key}) : super(key: key);
  final int i = 0;
  // CategoryControllerGetx categoryControllerGetx =
  // Get.put(CategoryControllerGetx());
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height - 40;
    final appBar = AppBar(
      // leading: IconButton(
      //   key: const Key("pop_navigator_to_home_page"),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   icon: const Icon(Icons.arrow_back),
      // ),
      actions: [
        GestureDetector(
          key: const Key("favorite_appbar_section_button"),
          onTap: () {
          },
          child: Container(
            width: 32.0,
            height: 32.0,
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            margin: const EdgeInsets.only(right: 18.0),
            child: Image.asset(
              "assets/icons/icon_favorite_white.png",
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
            "Auto StationX",
            key: const Key("appbar_title"),
            style: const TextTheme().titleLarge?.copyWith(
              color: const Color(0xffffffff),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
          ),
        ],
      ),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_header_car_detail.png'),
                fit: BoxFit.fill)),
      ),
    );
    final double appBarHeight = appBar.preferredSize.height;
    final double bodyHeight = maxHeight - appBarHeight;
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: appBar,
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: bodyHeight * .2,
                  width: maxWidth,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      pauseAutoPlayOnManualNavigate: true,
                      autoPlay: true,
                      viewportFraction: 1,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.linear,
                      enlargeFactor: 0
                    ),
                    items: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/fuel-retailers.png"),
                            fit: BoxFit.fill,
                          )
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32, bottom: 16),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(BN_COLOR_PRIMARY_YELLOW),
                              ),
                              child: const Text(
                                'ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/commercial-charging-parking-solutions.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32, bottom: 16),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(BN_COLOR_PRIMARY_YELLOW),
                              ),
                              child: const Text(
                                'ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/fleet-charging.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32, bottom: 16),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(BN_COLOR_PRIMARY_YELLOW),
                              ),
                              child: const Text(
                                'ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: 90,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'ทั้งหมด',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: BN_COLOR_PRIMARY_YELLOW,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'EV Charger',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Solar Cell',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: maxWidth - 32,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8 ,left: 16.0, right: 16),
                        child: Row(
                          children: [
                            Text(
                              'Popular Now',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: (Get.isDarkMode)
                                    ? Colors.white
                                    : Colors.grey.shade900,
                              ),
                            ),
                            // const Spacer(),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed('viewScreen');
                            //   },
                            //   child: Text(
                            //     'View All ▶️',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.amber.shade500,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: bodyHeight * .8 - 98,
                  width: maxWidth - 32,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GetBuilder<LandingController>(
                        tag: 'landing',
                        init: LandingController(),
                        builder: (l) {
                          return ProductListWidget(
                              key: const Key("car_list_widget"),
                              cars: l.products.value!.items!,
                              onTap: (i, val) {
                                l.setSelectedProduct(val);
                                Get.toNamed(RouteName.detail, arguments: {"id": "1234"});
                              });
                        }
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

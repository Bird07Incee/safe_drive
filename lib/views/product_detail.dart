import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';
import 'package:marketplace_line_oa/models/product_list.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/views/widgets/product_detail_widgets/product_detail_top_section.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0", "en_US");
  final scrollController = ScrollController();
  late PageController pageViewController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );
  late TabController _tabController;
  late double maxWidth, maxHeight;
  

  @override
  void dispose() {
    _tabController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              key: const Key("pop_navigator_to_home_page"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              InkWell(
                key: const Key("loan_cal_button_app_bar_section"),
                onTap: () {

                },
                child: Container(
                    width: 40.0,
                    height: 38.0,
                    margin: const EdgeInsets.only(right: 16.0, left: 8),
                    child: Image.asset(
                      "assets/icons/icon_Cal-2.png",
                      fit: BoxFit.fitWidth,
                    )),
              ),
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
                  "Appbar Title",
                  key: const Key("appbar_title"),
                  style: const TextTheme().titleLarge?.copyWith(
                    color: const Color(0xffffffff),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                ),
                Text(
                  "300000 บาท",
                  key: const Key("appbar_show_price"),
                  style: const TextTheme().titleLarge?.copyWith(
                    color: const Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          ),
          body: ListView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            children: [
              // Car Details top section
              CarDetailTopSection(
                pageViewController: pageViewController,
                onTap: () {
                },
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
                  ),),
            ],
          ),)
    );
  }

  Future<bool> _backPressed() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pop(context);
    return true;
  }

}

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/views/widgets/shared/mkp_styles.dart';

typedef OnTap = Function();

class CarDetailTopSection extends StatelessWidget {
  const CarDetailTopSection({Key? key, required this.pageViewController, required this.onTap}) : super(key: key);
  final PageController pageViewController;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Car Image
        GestureDetector(
          onTap: () {
          },
          child: Stack(
            children: [
              Container(
                color: Colors.black12,
                child: const Center(
                  child: Text("Product Pics"),
                ),
              ),
              // CarGalleryListsWidget(
              //   pageViewController: pageViewController,
              //   state: state,
              // ),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                      width: 62,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff000000).withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageIcon(
                            AssetImage('assets/icons/image_view_btn.png'),
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "ดูรูป",
                            style: const TextTheme().titleLarge
                                ?.copyWith(color: const Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
        // Car Detail
        Container(
          width: maxWidth,
          padding: const EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xffdedede).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Car Post Title
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                width: maxWidth - 32.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (maxWidth - 32.0) - 32.0,
                      child: RichText(
                        maxLines: 3,
                        key: const Key("title_car_product"),
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                child: Image.asset(
                                  "assets/homepage/shield_flat.png",
                                  height: 16,
                                ),
                              )),
                          TextSpan(
                            text: "WALL CHARGE",
                            style: const TextTheme().titleLarge?.copyWith(
                              color: BN_COLOR_BLACK,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ], style: const TextStyle(height: 1.5)),
                      ),
                    ),
                    GestureDetector(
                      key: const Key("favorite_detail_section_button"),
                      onTap: () {
                        onTap();
                      },
                      child: Container(
                        width: 32.0,
                        height: 32.0,
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Image.asset(
                          "assets/icons/icon_favorite_inactive.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Car Pre Detail
              Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                margin: const EdgeInsets.only(bottom: 12.0),
                width: maxWidth - 32.0,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          border: Border(right: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                      child: Text(
                        "200000 กม.",
                        style: const TextTheme().titleLarge?.copyWith(
                          color: BN_COLOR_BLACK,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          border: Border(right: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                      child: Text(
                        "รถบ้าน",
                        style: const TextTheme().titleLarge?.copyWith(
                          color: BN_COLOR_BLACK,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          border: Border(right: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                      child: Text(
                        "เกียร์ออโต้",
                        style: const TextTheme().titleLarge?.copyWith(
                          color: BN_COLOR_BLACK,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "เบนซิน",
                        style: const TextTheme().titleLarge?.copyWith(
                          color: BN_COLOR_BLACK,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Car Price
              SizedBox(
                width: maxWidth - 32.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: (maxWidth - 32.0) - 116,
                          child: Text(
                            "300000 บาท",
                            style: const TextTheme().titleLarge?.copyWith(
                              color: BTN_SELECTED_TEXT_COLOR,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            width: (maxWidth - 32.0) - 116,
                            child: RichText(
                              key: const Key("price_car_top_section"),
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "300000",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: BN_COLOR_GREYSCALE_300,
                                          decoration: TextDecoration.lineThrough)),
                                  TextSpan(
                                      text: " บาท",
                                      style: const TextTheme().titleLarge?.copyWith(
                                        color: BN_COLOR_GREYSCALE_300,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      width: 116,
                      height: 40,
                      child: GestureDetector(
                        key: const Key("loan_cal_button_top_section"),
                        onTap: () {

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0), color: BN_COLOR_PRIMARY_YELLOW),
                          child: Center(
                            child: Text('คำนวณสินเชื่อ',
                                style:
                                const TextTheme().labelLarge!.copyWith(color: BN_COLOR_BLACK, fontSize: 14)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

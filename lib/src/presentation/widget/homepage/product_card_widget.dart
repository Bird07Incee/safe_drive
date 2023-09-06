import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  var indicator = [
    1,
    1,
    1,
    1,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          late final PageController pageViewController = PageController(initialPage: 0);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: whitePure,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: whitePure.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        child: PageView.builder(
                            itemCount: 5,
                            // pageSnapping: true,
                            controller: pageViewController,
                            // allowImplicitScrolling: true,
                            onPageChanged: (val) {
                              setState(() {
                                indicator[index] = val + 1;
                              });
                              // if (!state.onFullscreenGallery) {
                              //   if (val == state.selectedCarDetail.carImage!.length) {
                              //     context.read<CarListBloc>().add(const SetFixibleCurrentNumberActiveImage(1));
                              //     pageViewController.jumpToPage(0);
                              //   } else {
                              //     context.read<CarListBloc>().add(SetCurrentNumberActiveImage(val));
                              //   }
                              // }
                            },
                            itemBuilder: (ctx, i) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: SizedBox(
                                          width: widget.maxWidth,
                                          height: 576,
                                          child: Image.asset('assets/mockimg/product.png', fit: BoxFit.fitWidth)),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                        width: 62,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: cloudyWhite.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            "${indicator[index]}/ 5",
                            style: const TextStyle(color: whitePure),
                          ),
                        ),
                      ),
                    )),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "assets/homepage/brand.png",
                        height: 32,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(),
                      ),
                    ))
                  ],
                ),
                Container(
                  color: whitePure,
                  width: widget.maxWidth,
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: true,
                        child: SmoothPageIndicator(
                            controller: pageViewController,
                            count: 5,
                            effect: const ExpandingDotsEffect(
                              expansionFactor: 2,
                              dotHeight: 6,
                              dotWidth: 6,
                              activeDotColor: spaceGrey123,
                              dotColor: cloudSoftDeepWhite,
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: widget.maxWidth - 64,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AlvaText(
                            title: 'Pulsar Plus',
                            textStyle: AlvaStyles().headingSize32(),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                decoration:
                                    BoxDecoration(color: whiteSoftGreen, borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: AlvaText(
                                    title: 'ติดตั้งฟรี',
                                    textStyle: AlvaStyles().headingSize10(),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 16,
                                color: cloudSoftDeepWhite,
                              ),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: AlvaText(
                                    title: 'รับประกัน 3 ปี',
                                    textStyle: AlvaStyles().headingSize10(),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 16,
                                color: cloudSoftDeepWhite,
                              ),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: AlvaText(
                                    title: 'สิทธิพิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้ ',
                                    textStyle: AlvaStyles().headingSize10(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: widget.maxWidth - 64,
                            height: 1,
                            color: cloudSoftDeepWhite,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AlvaText(
                            title: 'เล็ก ทรงพลัง',
                            textStyle: AlvaStyles().headingSize16w600(BTN_SELECTED_TEXT_COLOR_NEW),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AlvaText(
                            title:
                                'เครื่องชาร์จรถยนต์ไฟฟ้าสไตล์มินิมอล ที่ทรงพลังในขนาดกะทัดรัด สามารถติดตั้งได้กับโรงจอดรถหลายสไตล์เหมาะกับการชาร์จรถยนต์ไฟฟ้าที่บ้านทุกวันอีกทั้งยังสามารถเพิ่มประสิทธิภาพการทำงานของเครื่องชาร์จได้อย่างเต็มที่ผ่านการใช้งานร่วมกับ myWallbox Application',
                            textStyle: AlvaStyles().headingSize10w400(blackInBlack),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          AlvaText(
                            title: '฿ 44,500',
                            textStyle: AlvaStyles().headingSize32(),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

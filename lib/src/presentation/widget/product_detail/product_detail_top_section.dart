import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/selected_product/selected_product_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PDTopSection extends StatelessWidget {
  const PDTopSection({super.key, required this.imageDataLength});
  final int imageDataLength;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Container(
      width: maxWidth - 32,
      // height: 520,
      decoration: BoxDecoration(
        color: whitePure,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffdedede).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: BlocBuilder<ProductDetailCarouselScrollControllerBloc, PageController>(
              builder: (context, carouselState) {
          return BlocBuilder<SelectedProductBloc, SelectedProductState>(
  builder: (context, state) {
    return Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: PageView.builder(
                        itemCount: imageDataLength == 1 ? imageDataLength : imageDataLength + 1,
                        controller: carouselState,
                        onPageChanged: (val) {
                          context
                              .read<ProductDetailCarouselScrollControllerBloc>()
                              .add(CarouselScrollAction(index: val));
                          if (val == imageDataLength && val != 1) {
                            carouselState.jumpToPage(0);
                          }
                        },
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ViewImgDetailPageSwitchBloc>()
                                  .add(SwitchPageAction(statePage: true));
                              context
                                  .read<ProductDetailCarouselScrollControllerBloc>()
                                  .add(CarouselScrollAction(index: carouselState.initialPage));
                            },
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: SizedBox(
                                width: maxWidth,
                                height: 576,
                                child: FadeInImage(
                                  placeholder: const AssetImage('assets/homepage/img_default.png'),
                                  image: NetworkImage(
                                    i == imageDataLength ? state.selectedProduct.productionAssets[0] : state.selectedProduct.productionAssets[i],
                                  ),
                                  fit: BoxFit.fitWidth,
                                  imageErrorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                          width: 41,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: cloudyWhite.withOpacity(0.8),
                          ),
                          child: Center(
                            child: AlvaText(
                                title: "${carouselState.initialPage + 1}/$imageDataLength",
                                textStyle: AlvaStyles().headingSize10w500(ModernDarkGray)),
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
                width: maxWidth,
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: imageDataLength == 1 ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: SmoothPageIndicator(
                            controller: carouselState,
                            count: imageDataLength <= carouselShowLimit ? imageDataLength : carouselShowLimit,
                            effect: const ExpandingDotsEffect(
                              expansionFactor: 2,
                              dotHeight: 6,
                              dotWidth: 6,
                              activeDotColor: BlueFantasy,
                              dotColor: cloudSoftDeepWhite,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: maxWidth - 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AlvaText(
                          title: 'Pulsar Plus',
                          textStyle: AlvaStyles().headingSize22w700(ModernDarkGray),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: AlvaText(
                                title: 'ติดตั้งฟรี',
                                textStyle: AlvaStyles().headingSize10w500(spaceGrey),
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
                                  textStyle: AlvaStyles().headingSize10w500(spaceGrey),
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
                                  textStyle: AlvaStyles().headingSize10w500(spaceGrey),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: maxWidth - 32,
                          height: 1,
                          color: cloudWhite,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AlvaText(
                          title: 'แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น',
                          textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AlvaText(
                          title:
                          'เครื่องชาร์จรถยนต์ไฟฟ้าสไตล์มินิมอล ที่ทรงพลังในขนาดกะทัดรัด สามารถติดตั้งได้กับโรงจอดรถหลายสไตล์เหมาะกับการชาร์จรถยนต์ไฟฟ้าที่บ้านทุกวันอีกทั้งยังสามารถเพิ่มประสิทธิภาพการทำงานของเครื่องชาร์จได้อย่างเต็มที่ผ่านการใช้งานร่วมกับ myWallbox Application',
                          textStyle: AlvaStyles().headingSize10w400(spaceGrey),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            AlvaText(
                              title: '${56640.toDecimalFormat()} บาท',
                              textStyle: AlvaStyles().headingSize22w700(RedWordShow),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              // margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              decoration: BoxDecoration(color: RedSoft, borderRadius: BorderRadius.circular(4)),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: AlvaText(
                                  title: 'ถูกลง 4 %',
                                  textStyle: AlvaStyles().headingSize10w700(RedWordShow),
                                ),
                              ),
                            ),
                          ],
                        ),
                        AlvaText(
                          title: '${56640.toDecimalFormat()} บาท',
                          textStyle: AlvaStyles().discountPriceTxt14w400(smockGrey),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
  },
);
        }
      ),
    );
  }
}

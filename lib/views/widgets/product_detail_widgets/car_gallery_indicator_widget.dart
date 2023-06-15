import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class CarGalleryIndicatorWidget extends StatelessWidget {
  final PageController pageViewController;

  const CarGalleryIndicatorWidget({
    Key? key,
    required this.pageViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (pController) {
        return Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Visibility(
            visible: pController.selectedProduct.value!.carImage!.length == 1 ? false : true,
            child: SmoothPageIndicator(
                controller: pageViewController,
                count: pController.selectedProduct.value!.carImage!.length,
                effect: const ScrollingDotsEffect(
                    activeStrokeWidth: 2.6,
                    activeDotScale: 1.5,
                    maxVisibleDots: 5,
                    radius: 8,
                    spacing: 8,
                    dotHeight: 4,
                    dotWidth: 4,
                    activeDotColor: BTN_SELECTED_TEXT_COLOR,
                    dotColor: BN_COLOR_GREYSCALE_200)),
          ),
        );
      }
    );
  }
}

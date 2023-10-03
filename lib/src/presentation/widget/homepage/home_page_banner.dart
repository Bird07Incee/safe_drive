import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart' as fll;

class HomePageBanner extends StatefulWidget {
  final PageController pageControllerState;

  const HomePageBanner({
    super.key,
    required this.maxWidth,
    required this.pageControllerState,
  });

  final double maxWidth;

  @override
  State<HomePageBanner> createState() => _HomePageBannerState();
}

class _HomePageBannerState extends State<HomePageBanner> {
  bool errorCase = true;
  final liff = fll.FlutterLineLiff();
  @override
  Widget build(BuildContext context) {
    int itemBannerLength = errorCase ? assetsCarouselItem.length : carouselOver20Item.length;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: PageView.builder(
              itemCount: itemBannerLength == 1 ? itemBannerLength : itemBannerLength + 1,
              controller: widget.pageControllerState,
              onPageChanged: (val) {
                if (val == itemBannerLength && val != 1) {
                  widget.pageControllerState.jumpToPage(0);
                }
              },
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () {
                    GeneralDialog().showLoadingDialog(context: context);
                    Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.pop(context));
                  },
                  onLongPress: () {
                    setState(() {
                      if (errorCase) {
                        errorCase = false;
                      } else {
                        errorCase = true;
                      }
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SizedBox(
                      child: errorCase
                          ? Image.asset(ProductDetailConst().imgHeroBannerPath, fit: BoxFit.fitWidth)
                          : FadeInImage(
                              placeholder: AssetImage(ProductDetailConst().imgDefaultPath),
                              image: NetworkImage(
                                i == carouselOver20Item.length ? carouselOver20Item[0] : carouselOver20Item[i],
                              ),
                              fit: BoxFit.fitWidth,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(ProductDetailConst().imgDefaultPath, fit: BoxFit.fitWidth),
                            ),
                    ),
                  ),
                );
              }),
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
            visible: itemBannerLength == 1 ? false : true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: SmoothPageIndicator(
                  controller: widget.pageControllerState,
                  count: itemBannerLength <= carouselShowLimit ? itemBannerLength : carouselShowLimit,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 2,
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: cloudSoftDeepWhite,
                    dotColor: spaceGrey,
                  )),
            ),
          ),
        )),
      ],
    );
  }
}

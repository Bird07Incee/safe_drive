import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageBanner extends StatefulWidget {
  final PageController pageControllerState;
  final List banners;

  const HomePageBanner({
    super.key,
    required this.pageControllerState,
    required this.banners,
  });

  @override
  State<HomePageBanner> createState() => _HomePageBannerState();
}

class _HomePageBannerState extends State<HomePageBanner> {
  AmplitudeWebHelper amplitudeWebHelper = AmplitudeWebHelper.getInstance();
  @override
  Widget build(BuildContext context) {
    int itemBannerLength = widget.banners.length;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: PageView.builder(
              itemCount: itemBannerLength == 1 ? itemBannerLength : itemBannerLength + 1,
              controller: widget.pageControllerState,
              onPageChanged: (val) {
                var max = itemBannerLength;

                if (max > 5) {
                  max = 5;
                }

                if (val == max && val != 1) {
                  widget.pageControllerState.jumpToPage(0);
                }
              },
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  key: const Key("home_banner"),
                  onTap: () {
                    amplitudeWebHelper.logeTapCarouselOnHomeScreen(
                        bannerName: widget.banners[i].route.toString(), bannerSequence: widget.banners[i].seqNo.toString());
                    if (itemBannerLength != 0) {
                      launchUrl(Uri.parse(widget.banners[i].url));
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SizedBox(
                      child: itemBannerLength == 0
                          ? Image.asset(ProductDetailConst().imgHeroBannerPath, fit: BoxFit.fitWidth)
                          : FadeInImage(
                              placeholder: AssetImage(ProductDetailConst().imgDefaultPath),
                              image: NetworkImage(
                                i == itemBannerLength ? widget.banners[0].image : widget.banners[i].image,
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
                  count: itemBannerLength <= 5 ? itemBannerLength : 5,
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

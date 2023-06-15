import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';
import 'package:marketplace_line_oa/models/product_list.dart';
import 'package:marketplace_line_oa/views/widgets/shared/mkp_static_image.dart';

typedef OnTap = Function(int index, ProductData carData);

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key, required this.cars, required this.onTap}) : super(key: key);

  final List<ProductData> cars;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    List<Widget> buildCards(List<ProductData> cars) {
      List<Widget> list = [];
      for (int i = 0; i < cars.length; i++) {
        var mile = cars[i].mileage!;
        var sellerType = cars[i].sellerType!;
        var discountPrice = cars[i].discountPrice! != 0 ? cars[i].price! : cars[i].discountPrice!;
        var price = cars[i].discountPrice! == 0 ? cars[i].price! : cars[i].discountPrice!;
        var partnerLogo = cars[i].partnerLogo!;
        var kaPromotionBadge = false;
        var verifyBadge = cars[i].pdfCertificated! != "" ? true : false;
        Widget card = GestureDetector(
          key: Key("car_card_index_$i"),
          onTap: () => onTap(i, cars[i]),
          child: SizedBox(
            width: ((maxWidth - 32.0) / 2).floorToDouble(),
            height: ((((maxWidth - 32.0) / 2).floorToDouble() / 16) * 9) + 124,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.04),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2))
              ]),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0,
                child: Column(
                  children: [
                    //height: (((maxWidth - 32.0) / 2).floorToDouble()/16) * 9
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: ((maxWidth - 32.0) / 2).floorToDouble(),
                            height: (((maxWidth - 32.0) / 2).floorToDouble() / 16) * 9,
                            child: FadeInImage(
                              placeholder: MkpStaticImage.placeholderProvider,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) => MkpStaticImage.placeholder,
                              image: Image.network(
                                cars[i].carImageThumbnail != null && cars[i].carImageThumbnail != ""
                                    ? cars[i].carImageThumbnail!
                                    : cars[i].carImage![0],
                                cacheWidth: 480,
                                errorBuilder: (context, error, stackTrace) => MkpStaticImage.placeholder,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress != null) {
                                    return MkpStaticImage.placeholder;
                                  }
                                  return child;
                                },
                              ).image,
                            ),
                          ),
                          partnerLogo != ""
                              ? Positioned.fill(
                                  child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.network(partnerLogo, height: 14, fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return const SizedBox();
                                  }),
                                ))
                              : const SizedBox(),
                          Visibility(
                            visible: kaPromotionBadge,
                            child: Positioned.fill(
                                child: Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                'assets/homepage/Promotion.png',
                                height: 14,
                                width: 145,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    //height: 42
                    Container(
                      height: 42.0,
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: maxWidth * 0.4,
                      child: RichText(
                        key: Key("car_card_title_index_$i"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            verifyBadge
                                ? WidgetSpan(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 4.0),
                                      height: 12,
                                      child: Image.asset(
                                        "assets/homepage/shield_flat.png",
                                      ),
                                    ),
                                    alignment: PlaceholderAlignment.middle)
                                : const TextSpan(),
                            TextSpan(
                              text: cars[i].marketplaceTitle ?? cars[i].postTitle,
                              style: const TextTheme().displaySmall?.copyWith(color: BN_COLOR_BLACK, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //height: 44
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                            padding: const EdgeInsets.only(bottom: 4.0),
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5, color: BN_COLOR_GREYSCALE_200))),
                            child: SizedBox(
                              height: 19,
                              width: ((maxWidth - 32.0) / 2).floorToDouble(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  mile == 0
                                      ? const SizedBox()
                                      : Text(
                                          "${(mile/1000).floor().toDecimalFormat()} Kw.",
                                          key: Key("car_card_mileage_i_$i"),
                                          style: TextStyle(color: Color(0xFF2C2626), fontSize: 12),
                                        ),
                                  mile != 0 && sellerType != ""
                                      ? Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 12,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                                  sellerType == ""
                                      ? const SizedBox()
                                      : Text(
                                          sellerType,
                                          style: TextStyle(color: Color(0xFF2C2626), fontSize: 12),
                                        ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 4,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                right: BorderSide(width: 1, color: BN_COLOR_GREYSCALE_200))),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "ติดตั้งฟรี",
                                    style: TextStyle(color: Color(0xFF2C2626), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 28,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    "฿ ${price == 0 ? '0' : price.toDecimalFormat()}",
                                    key: Key("car_card_price_i_$i"),
                                    style: const TextTheme().displaySmall?.copyWith(
                                        color: discountPrice != 0 ? BTN_SELECTED_TEXT_COLOR : BN_COLOR_BLACK,
                                        fontSize: 14),
                                  ),
                                ),
                                Visibility(
                                    visible: discountPrice == 0 ? false : true,
                                    child: cars[i].discountPrice! == 0
                                        ? const SizedBox()
                                        : Container(
                                            margin: const EdgeInsets.only(top: 3),
                                            child: Text(discountPrice == 0 ? "0" : discountPrice.toDecimalFormat(),
                                                key: Key("car_card_discount_price_i_$i"),
                                                style: const TextTheme().displaySmall?.copyWith(
                                                    fontSize: 10,
                                                    color: BN_COLOR_GREYSCALE_300,
                                                    decoration: TextDecoration.lineThrough,
                                                    decorationThickness: Platform.isIOS ? 5 : 2.5)),
                                          )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        list.add(card);
      }
      return list;
    }

    return Wrap(
      key: key,
      alignment: WrapAlignment.start,
      spacing: 0.0,
      runSpacing: 0.0,
      children: buildCards(cars),
    );
  }
}

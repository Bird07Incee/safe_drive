import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';

class CarGalleryListsWidget extends StatelessWidget {
  const CarGalleryListsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (pController) {
        return SizedBox(
          width: maxWidth,
          height: 260,
          child: PageView.builder(
              itemCount: pController.selectedProduct.value!.carImage!.length == 1
                  ? pController.selectedProduct.value!.carImage!.length
                  : pController.selectedProduct.value!.carImage!.length + 1,
              pageSnapping: true,
              allowImplicitScrolling: true,
              onPageChanged: (val) {

              },
              itemBuilder: (ctx, i) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: SizedBox(
                    width: maxWidth,
                    height: 576,
                    child: Image.network(
                      i == pController.selectedProduct.value!.carImage!.length
                          ? pController.selectedProduct.value!.carImage![0]
                          : pController.selectedProduct.value!.carImage![i],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/homepage/placeholder_image.png",
                        height: 900,
                        fit: BoxFit.cover,
                      ),
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress != null) {
                          return Image.asset(
                            "assets/homepage/placeholder_image.png",
                            height: 900,
                            fit: BoxFit.cover,
                          );
                        }
                        return child;
                      },
                    ),
                  ),
                );
              }),
        );
      }
    );
  }
}

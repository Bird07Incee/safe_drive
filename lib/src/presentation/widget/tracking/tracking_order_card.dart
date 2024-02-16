import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

class TrackingOrderCard extends StatelessWidget {
  const TrackingOrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: maxWidth,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 1, color: Color(0xffC5BFBF)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "หมายเลขอ้างอิง: ${order.orderNo}",
                    style: AlvaStyles().headingSize12w400(spaceGrey123),
                  ),
                  Text(
                    order.shippingStatusMessage!,
                    style: AlvaStyles().headingSize12w600(btnBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: cloudWhite,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (maxWidth / 2) - 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: FadeInImage(
                            width: 132,
                            height: 74,
                            placeholder: const AssetImage('assets/homepage/img_default.png'),
                            // Replace with your placeholder image path
                            image: NetworkImage(order.products![0].productImageUrl!),
                            fit: BoxFit.fitWidth,
                            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/homepage/img_default.png',
                              fit: BoxFit.fitWidth,
                              width: 132,
                              height: 74,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (maxWidth / 2) - 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.products![0].productNameEn!,
                          style: AlvaStyles().headingSize14w600(blackGoMunTo),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          order.products![0].productDescription!,
                          style: AlvaStyles().headingSize12w400WithLineHeight(blackGoMunTo),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ราคารวม", style: AlvaStyles().headingSize18w400Cordia(spaceGrey123)),
                  Text("${order.totalPrice!.toDecimalFormat()} บาท", style: AlvaStyles().headingSize14w800(blackGoMunTo)),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: cloudWhite,
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '${Routes.tracking.toStringPath()}?orderNo=${order.orderNo!}&pid=${order.products![0].productId!}');
                },
                child: Container(
                  height: 40,
                  width: (maxWidth - 35) / 2,
                  decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Center(child: Text("รายละเอียดการจัดส่ง", style: AlvaStyles().heading3())),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 16,
          color: cloudyWhite,
        ),
      ],
    );
  }
}

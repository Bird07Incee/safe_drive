import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          order.products![0].productNameTh!,
                          style: AlvaStyles().headingSize14Height22(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          order.products![0].productDescription!,
                          style: AlvaStyles().headingSize12RegHeight20(blackGoMunTo),
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
                  Text("ราคา", style: AlvaStyles().headingSize16BoldHeight24(BTN_SELECTED_TEXT_COLOR_NEW)),
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
                  AmplitudeWebHelper.getInstance().logTapOnOrderTrackingList(
                      order.products![0].productNameTh!.toString(), order.orderNo.toString(), order.shippingStatusMessage.toString());

                  Navigator.pushNamed(context,
                      '${Routes.tracking.toStringPath()}?orderNo=${order.orderNo!}&pid=${order.products![0].productId!}&productName=${order.products![0].productNameTh!.toString()}');
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

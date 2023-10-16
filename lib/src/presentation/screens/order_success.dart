import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

    final mockJson = {
      "refId": "REF00005678",
      "payment_card": "987654******1234",
      "payment_date": "1 กันยายน 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "image url",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max",
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร", "ทดสอบ1", "ทดสอบ2"],
      "product_price": "56640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "081-234-5678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address":
          "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "091-862-0511"
    };

    final InquiryData mock = InquiryData.fromJson(mockJson);

    return RootPageCondition(
        child: AlvaRootWidget(
      titlePage: titleWebPage,
      child: Column(
        children: [
          Container(
              width: maxWidth,
              height: maxHeight - 88,
              color: cloudyWhite,
              child: ListView(
                children: [
                  Container(
                    width: maxWidth,
                    height: 76,
                    padding: EdgeInsets.all(16),
                    color: successGreen,
                    child: Row(children: [
                      SizedBox(width: 32, height: 32, child: Image.asset('assets/images/order_success.png')),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชำระเงินสำเร็จ",
                            style: AlvaStyles().headingSize14w600(blackGoMunTo),
                          ),
                          Text(
                            "หมายเลขอ้างอิง: ${mock.refId}",
                            style: AlvaStyles().headingSize12w400(blackGoMunTo),
                          )
                        ],
                      )
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(children: [
                      ProductAttribute(
                        attributeKey: "ชำระเงินโดย",
                        attributevalue: mock.paymentCard!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "วันที่ชำระเงิน",
                        attributevalue: mock.paymentDate!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "เวลาที่ชำระเงิน",
                        attributevalue: mock.paymentTime!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "ช่องทางการชำระเงิน",
                        attributevalue: mock.paymentMedthod!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "รูปแบบการชำระเงิน",
                        attributevalue: mock.paymentPeriod!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "ผู้รับเงิน",
                        attributevalue: mock.paymentMerchant!,
                        maxWidth: maxWidth,
                      ),
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "รหัสสินค้า: ${mock.productId}",
                      style: AlvaStyles().headingSize12w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      children: [
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
                                      child: Image.asset(
                                        'assets/mocking/product.png',
                                        width: 132,
                                        height: 74,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: (maxWidth / 2) - 32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mock.productName!,
                                    style: AlvaStyles().headingSize14w600(blackGoMunTo),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  for (final attr in mock.productAttr!)
                                    Text(
                                      attr,
                                      style: AlvaStyles().headingSize12w400WithLineHeight(blackGoMunTo),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: cloudSoftDeepWhite,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: (maxWidth / 2) - 32,
                                child: Text("ยอดชำระ", style: AlvaStyles().headingSize12w400(blackGoMunTo))),
                            SizedBox(
                              width: (maxWidth / 2) - 32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${mock.productPrice} บาท", style: AlvaStyles().headingSize14w600(blackGoMunTo)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("ยอดชำระนี้รวมภาษีมูลค่าเพิ่มแล้ว",
                                      style: AlvaStyles().headingSize12w400Cordia(spaceGrey))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "ที่อยู่ในการจัดส่งสินค้า",
                      style: AlvaStyles().headingSize12w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(children: [
                      ProductAttribute(
                        attributeKey: "ชื่อผู้รับสินค้า",
                        attributevalue: mock.customerName!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "เบอร์โทรติดต่อ",
                        attributevalue: mock.customerTel!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "อีเมล",
                        attributevalue: mock.customerEmail!,
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "ที่อยู่",
                        attributevalue: mock.customerAddress!,
                        maxWidth: maxWidth,
                      ),
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "ข้อมูลติดต่อผู้ขาย",
                      style: AlvaStyles().headingSize12w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(children: [
                      Center(
                        child: Text(
                          mock.sellerAddress!,
                          style: AlvaStyles().headingSize12w400(spaceGrey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        mock.sellerTel!,
                        style: AlvaStyles().headingSize16w600(blackGoMunTo),
                      ),
                    ]),
                  ),
                  Container(
                    color: spaceGrey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AlvaText(
                              title: HomeConst().askInformation,
                              textStyle: AlvaStyles().headingSize10w600(whiteFalse),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AlvaText(
                              title: HomeConst().pleaseContact,
                              textStyle: AlvaStyles().headingSize12w700(whiteFalse),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
              width: maxWidth,
              height: 88,
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.04),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, -4)),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  print("test");
                },
                child: Container(
                  height: 48,
                  width: (maxWidth - 40) / 2,
                  decoration: BoxDecoration(
                      color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Center(child: Text("กลับสู่หน้าหลัก", style: AlvaStyles().heading3())),
                ),
              ))
        ],
      ),
    ));
  }
}

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key, required this.attributeKey, required this.attributevalue, required this.maxWidth});

  final String attributeKey;
  final String attributevalue;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributeKey,
              style: AlvaStyles().headingSize12w400(spaceGrey),
            ),
          ),
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributevalue,
              style: AlvaStyles().headingSize12w500(blackGoMunTo),
            ),
          )
        ],
      ),
    );
  }
}

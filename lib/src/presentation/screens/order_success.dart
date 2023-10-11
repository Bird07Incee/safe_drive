import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

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
                    padding: EdgeInsets.all(16),
                    color: successGreen,
                    child: Row(children: [
                      Container(width: 32, height: 32, child: Image.asset('assets/images/order_success.png')),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชำระเงินสำเร็จ",
                            style: AlvaStyles().headingSize16w600(blackGoMunTo),
                          ),
                          Text(
                            "หมายเลขอ้างอิง: ABCD1234",
                            style: AlvaStyles().headingSize14w400(blackGoMunTo),
                          )
                        ],
                      )
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    color: Colors.white,
                    child: Column(children: [
                      ProductAttribute(
                        attributeKey: "qwdknqwd",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdefwfw",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdwef",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwd",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdww",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdwefwefwef",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "รหัสสินค้า: ABCD123456",
                      style: AlvaStyles().headingSize14w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
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
                                    "Pulsar Max",
                                    style: AlvaStyles().headingSize14w600(blackGoMunTo),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Black",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "1234123412341234",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
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
                                  Text("1,234 บาท", style: AlvaStyles().headingSize14w600(blackGoMunTo)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("ยอดชำระนี้รวมภาษีมูลค่าเพิ่มแล้ว",
                                      style: AlvaStyles().headingSize10w400(blackGoMunTo))
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
                      style: AlvaStyles().headingSize14w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    color: Colors.white,
                    child: Column(children: [
                      ProductAttribute(
                        attributeKey: "qwdknqwd",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdefwfw",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwdwef",
                        attributevalue: "qwdmqwdqwd",
                        maxWidth: maxWidth,
                      ),
                      ProductAttribute(
                        attributeKey: "qwdknqwd",
                        attributevalue: "qwdmqwdqwdppeqimfpoejfopwjmef",
                        maxWidth: maxWidth,
                      ),
                    ]),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "ข้อมูลติดต่อผู้ขาย",
                      style: AlvaStyles().headingSize14w600(blackGoMunTo),
                    ),
                  ),
                  Container(
                    width: maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    color: Colors.white,
                    child: Column(children: [
                      Center(
                        child: Text(
                          "Qwdqwd\noqwjdpojqwopd\noiqwdoiqnwdoinqwd",
                          style: AlvaStyles().headingSize12w400(spaceGrey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "โทร. 091-862-0511",
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

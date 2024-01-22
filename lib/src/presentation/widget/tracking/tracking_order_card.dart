import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';

class TrackingOrderCard extends StatelessWidget {
  const TrackingOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
                "หมายเลขอ้างอิง: qwdoi213123oi12h",
                style: AlvaStyles().headingSize12w400(spaceGrey123),
              ),
              Text(
                "ชำระเงินแล้ว",
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
                        image:
                            NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/ABC-2021-LOGO.svg/1200px-ABC-2021-LOGO.svg.png"),
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
                      "Pulsar Max",
                      style: AlvaStyles().headingSize14w600(blackGoMunTo),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "ความยาวสายและสี",
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
              Text("${"12,000"} บาท", style: AlvaStyles().headingSize14w800(blackGoMunTo)),
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
          Container(
            height: 40,
            width: (maxWidth - 35) / 2,
            decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Center(child: Text("รายละเอียดการจัดส่ง", style: AlvaStyles().heading3())),
          ),
        ],
      ),
    );
  }
}

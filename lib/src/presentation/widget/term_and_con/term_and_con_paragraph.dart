import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';

class TermAndConParagraph extends StatelessWidget {
  const TermAndConParagraph({super.key, required this.header, required this.text});

  final String header;
  final String text;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                header,
                style: AlvaStyles().heading2(Color(0xff5a5a5a)),
              )),
        ),
        Container(
          width: maxWidth,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              style: AlvaStyles().body1(),
            ),
          ),
        ),
      ],
    );
  }
}

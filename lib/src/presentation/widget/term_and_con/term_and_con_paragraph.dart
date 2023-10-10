import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';

class TermAndConParagraph extends StatelessWidget {
  const TermAndConParagraph({super.key, required this.header, required this.texts});

  final String header;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: maxWidth,
          color: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  header,
                  style: AlvaStyles().heading2(Color(0xff2C2626)),
                )),
          ),
        ),
        Container(
          width: maxWidth,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                for (var text in texts)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: AlvaStyles().body1(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

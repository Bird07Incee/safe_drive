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
            child: SafetyText(text, style: AlvaStyles().body1(), pattern: 'กรุงศรี ออโต้'),
          ),
        ),
      ],
    );
  }
}

class SafetyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String? pattern;

  final String _pattern = '\n';

  const SafetyText(
    this.text, {
    super.key,
    this.style,
    this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    final textList = text.split(_pattern);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textList
          .map(
            (value) => SizedBox(
              child: UnbreakableText(
                value,
                style: style,
                pattern: pattern,
              ),
            ),
          )
          .toList(),
    );
  }
}

class UnbreakableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String? pattern;

  const UnbreakableText(
    this.text, {
    super.key,
    this.style,
    this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    final textList = text.split(pattern!);
    return RichText(
        text: TextSpan(
      style: style,
      children: [
        for (var i = 0; i < textList.length; i++) ...[
          TextSpan(text: textList[i]),
          if (i + 1 != textList.length) WidgetSpan(alignment: PlaceholderAlignment.middle, child: Text(pattern!, style: style)),
        ],
      ],
    ));
  }
}

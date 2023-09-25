import 'package:flutter/material.dart';

class AlvaText extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final bool disableSelectableText;
  const AlvaText({super.key, required this.title, required this.textStyle, this.disableSelectableText = false});

  @override
  Widget build(BuildContext context) {
    return disableSelectableText
        ? Text(
            title,
            style: textStyle,
          )
        : SelectableText(
            title,
            style: textStyle,
          );
  }
}

class AlvaTextMaxLinesOverflow extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final int maxLines;

  const AlvaTextMaxLinesOverflow(
      {super.key, required this.title, required this.textStyle, required this.maxLines, required});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

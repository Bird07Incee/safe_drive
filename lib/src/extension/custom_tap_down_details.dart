import 'package:flutter/gestures.dart';

TapDownDetails customTapDownDetails(Offset globalPosition) {
  return TapDownDetails(
    globalPosition: globalPosition,
    localPosition: globalPosition, // Assuming global and local positions are the same in your use case
    kind: PointerDeviceKind.touch,
  );
}

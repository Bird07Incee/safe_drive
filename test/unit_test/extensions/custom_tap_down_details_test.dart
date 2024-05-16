import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/extension/custom_tap_down_details.dart';

void main() {
  test('Should return TapDownDetails as the TapDownDetails class', (){
    final offset = Offset(0.0, 0.0);
    final tapDownDetail = TapDownDetails(
      globalPosition: offset,
      localPosition: offset, // Assuming global and local positions are the same in your use case
      kind: PointerDeviceKind.touch,
    );
    expect(customTapDownDetails(Offset(0.0, 0.0)).globalPosition, tapDownDetail.globalPosition);
  });
}

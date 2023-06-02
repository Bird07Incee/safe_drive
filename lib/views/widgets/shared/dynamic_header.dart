import 'dart:io';

class DynamicHeaderState {
  List<Map<String, String>> devicesList = [
    {
      "ip14": "390.0 × 844.0",
      "ip14Plus": "428.0 × 926.0",
      "ip14Pro": "393.0 × 852.0",
      "ip14ProMax": "430.0 × 932.0",
      "ipX": "375.0 x 812.0",
      "ipXR": "414.0 x 896.0",
      "ipXSMax": "414.0 x 896.0",
      "ip11": "414.0 x 896.0",
      "ip11Pro": "375.0 x 812.0",
      "ip11ProMax": "414.0 x 896.0",
      "ip12": "390.0 x 844.0",
      "ip12Mini": "360.0 x 780.0",
      "ip12Pro": "390.0 x 844.0",
      "ip12ProMax": "428.0 x 926.0",
      "ip13": "390.0 x 844.0",
      "ip13Mini": "360.0 x 780.0",
      "ip13Pro": "390.0 x 844.0",
      "ip13ProMax": "428.0 x 926.0",
    }
  ];

  String iphone12Pro = "ip12Pro";
  String iphone12ProMax = "ip12ProMax";
  String iphone13Pro = "ip13Pro";
  String iphone13ProMax = "ip13ProMax";
  String iphone14 = "ip14";
  String iphone14Plus = "ip14Plus";
  String iphone14Pro = "ip14Pro";
  String iphone14ProMax = "ip14ProMax";
  String iphoneWithoutNotch = "iphoneWithoutNotch";
  String iphoneWithNotch = "iphoneWithNotch";
  String otherPhone = "otherPhone";
  checkScale(maxWidth, maxHeight) {
    if (Platform.isIOS == true) {
      String targetViewPort = "$maxWidth × $maxHeight";
      if (maxHeight <= 736) {
        return iphoneWithoutNotch;
      } else if (maxHeight == 780 || maxHeight == 812 || maxHeight == 896) {
        return iphoneWithNotch;
      } else {
        for (var deviceMap in devicesList) {
          for (var entry in deviceMap.entries) {
            if (entry.value == targetViewPort) {
              return entry.key;
            }
          }
        }
      }
    }
    return otherPhone;
  }

  static String deviceModel = "";

  void setDeviceModel(String model) {
    deviceModel = model;
  }

  getHeaderHeight(double maxWidth) {
    double h = deviceModel == iphone14 || deviceModel == iphone14Plus
        //if this is iphone 14 or iphone 14 plus
        ? (maxWidth / 360) * 90
        : deviceModel == iphone14Pro || deviceModel == iphone14ProMax
            //if this is iphone 14 pro or iphone 14 pro max
            ? (maxWidth / 360) * 110
            : deviceModel == iphoneWithoutNotch
                //if this is under iphone x
                ? (maxWidth / 360) * 80
                //if this is iphone x - iphone 13
                : (maxWidth / 360) * 100;
    return h;
  }
}

// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

class LineProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int logged;
  String linePicture;
  String uuid;

  LineProvider({this.logged = 0, this.linePicture = "", this.uuid = ""});

  int get loginState => logged;
  set loginState(int val) {
    logged = val;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  String get linePictureState => linePicture;
  set linePictureState(String val) {
    linePicture = val;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  String get uuidState => uuid;
  set uuidState(String val) {
    uuid = val;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Makes `LineProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('loginState', loginState));
    properties.add(StringProperty('linePictureState', linePicture));
    properties.add(StringProperty('uuidState', uuid));
  }
}

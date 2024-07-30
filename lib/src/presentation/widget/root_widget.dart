import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';

class AlvaRootWidget extends StatelessWidget {
  final Widget child;
  final Widget? appBar;
  final Widget? bottomSheet;
  final String titlePage;
  const AlvaRootWidget({
    super.key,
    required this.child,
    required this.titlePage,
    this.appBar,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarCustom;
    if (appBar != null) {
      appBarCustom = PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: appBar!);
    }

    return RumUserActionDetector(
      rum: DatadogSdk.instance.rum,
      child: Title(
          color: Colors.black,
          title: titlePage,
          child: Scaffold(
            body: child,
            appBar: appBarCustom,
            bottomSheet: bottomSheet,
            backgroundColor: Colors.white,
          )),
    );
  }
}

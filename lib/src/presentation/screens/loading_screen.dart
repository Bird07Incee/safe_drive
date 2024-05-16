import 'package:flutter/material.dart';
import 'package:autoStation_promptBuy/src/constants/mkp_styles.dart';
import 'package:autoStation_promptBuy/src/constants/my_constants.dart';
import 'package:autoStation_promptBuy/src/presentation/widget/alva_c_p_i_loader.dart';
import 'package:autoStation_promptBuy/src/presentation/widget/root_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlvaRootWidget(
      titlePage: titleWebPage,
      child: Container(color: whitePure, child: const Center(child: AlvaCPILoader())),
    );
  }
}

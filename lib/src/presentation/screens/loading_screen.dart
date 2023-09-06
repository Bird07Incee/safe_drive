import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_c_p_i_loader.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlvaRootWidget(
      titlePage: titleWebPage,
      child: Container(color: whitePure, child: const Center(child: AlvaCPILoader())),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_c_p_i_loader.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

typedef OnTap = Function();

class GeneralDialog {
  GeneralDialog({this.onCancel, this.onAccept});

  final OnTap? onCancel;
  final OnTap? onAccept;

  showLoadingDialog({Key? key, required BuildContext context}) {
    return _showGeneralLoading(
      context,
      key: key ?? const Key("loading")
    );
  }

  showNoContentAlert({Key? key, required BuildContext context, double? padding}) {
    return _showGeneralAlert(
      context,
      Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
        child: AlvaText(
          title: paymentTextTH,
          textStyle: AlvaStyles().body1(),
        ),
      ),
      key: key ?? const Key("payment_alert"),
      contentPadding: const EdgeInsets.all(24),
    );
  }

  _showGeneralLoading(BuildContext context, {Key? key}) {
    Widget loading = SizedBox(
        width: 64.0,
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlvaCPILoader(),
          ],
        )
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => loading,
    );
  }

  _showGeneralAlert(BuildContext context, Widget body,
      {Key? key,
        EdgeInsetsGeometry? contentPadding,
        EdgeInsetsGeometry? actionPadding}) {
    Widget acceptButton = TextButton(
      child: AlvaText(
        title: acceptButtonTH,
        textStyle: AlvaStyles().heading2(btnBlue),
      ),
      onPressed: () {
        Navigator.pop(context);
        onAccept ?? onAccept!();
      },
    );

    Widget cancelButton = TextButton(
      child: AlvaText(
        title: cancelButtonTH,
        textStyle: AlvaStyles().heading2(btnBlue),
      ),
      onPressed: () {
        Navigator.pop(context);
        onCancel ?? onCancel!();
      },
    );

    Widget alert = AlertDialog(
      contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24, 24, 24, 8),
      actionsPadding: actionPadding ?? const EdgeInsets.symmetric(horizontal: 8),
      key: key,
      content: body,
      actions: [
        onCancel != null ? cancelButton : const SizedBox(),
        acceptButton,
      ],
      shadowColor: const Color.fromARGB(26, 44, 38, 38),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => alert,
    );
  }
}

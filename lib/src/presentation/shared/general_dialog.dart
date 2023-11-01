import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_c_p_i_loader.dart';

typedef OnTap = Function();

class GeneralDialog {
  GeneralDialog({this.onCancel, this.onAccept});

  final OnTap? onCancel;
  final OnTap? onAccept;

  showLoadingDialog({Key? key, required BuildContext context, bool? canBack}) {
    return _showGeneralLoading(context, key: key ?? const Key("loading"), canBack: false);
  }

  showBackFromSummaryDialog({Key? key, required BuildContext context, bool? canBack}) {
    _showGeneralAlert(
        context,
        Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
          child: Text("โปรดทราบ ข้อมูลที่อยู่ของคุณจะถูกลบ และคุณจำเป็นต้องกรอกที่อยู่จัดส่งใหม่ อีกครั้ง เพื่อดำเนินการต่อ",
              style: AlvaStyles().headingSize14w400(Colors.black).copyWith(color: Colors.black, fontSize: 14).copyWith(height: 24 / 14)),
        ),
        title: Text("ระบบจะนำคุณกลับไปยังหน้าข้อมูลสินค้า",
            style: AlvaStyles()
                .headingSize18(Colors.black)
                .copyWith(fontWeight: FontWeight.w600, color: Colors.black, height: 24 / 18)
                .copyWith(height: 24 / 14)),
        key: key ?? const Key("back_from_summary_dialog"),
        contentPadding: const EdgeInsets.all(24),
        actionPadding: const EdgeInsets.only(right: 8, bottom: 16));
  }

  showConfirmOrderDialog({Key? key, required BuildContext context, bool? canBack}) {
    _showGeneralAlert(
        context,
        Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
          child: Text('กรุณากด "ยืนยัน" เพื่อทำการชำระเงิน',
              style: AlvaStyles().headingSize14w400(Colors.black).copyWith(color: Colors.black, fontSize: 14).copyWith(height: 24 / 14)),
        ),
        key: key ?? const Key("back_from_summary_dialog"),
        contentPadding: const EdgeInsets.all(24),
        actionPadding: const EdgeInsets.only(right: 8, bottom: 16));
  }

  _showGeneralLoading(BuildContext context, {Key? key, bool? canBack}) {
    Widget loading = WillPopScope(
      onWillPop: () async => canBack ?? false,
      child: SizedBox(
          width: 64.0,
          height: 64.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AlvaCPILoader(),
            ],
          )),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => loading,
    );
  }

  _showGeneralAlert(BuildContext context, Widget body,
      {Key? key, Widget? title, EdgeInsetsGeometry? contentPadding, EdgeInsetsGeometry? actionPadding, bool platformSpecific = false}) {
    Widget acceptButton = TextButton(
      child: Text(
        "ยืนยัน",
        style: AlvaStyles().heading2(btnBlue).copyWith(height: 24 / 14),
      ),
      onPressed: () {
        Navigator.pop(context);
        if (onAccept != null) {
          onAccept!();
        }
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        "ยกเลิก",
        style: AlvaStyles().heading2(btnBlue).copyWith(height: 24 / 14),
      ),
      onPressed: () {
        Navigator.pop(context);
        if (onCancel != null) {
          onCancel!();
        }
      },
    );

    Widget alert = AlertDialog(
      contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24, 24, 24, 8),
      actionsPadding: actionPadding ?? const EdgeInsets.symmetric(horizontal: 8),
      key: key,
      title: title,
      content: body,
      actions: [
        onCancel != null ? cancelButton : const SizedBox(),
        acceptButton,
      ],
      shadowColor: const Color.fromARGB(26, 44, 38, 38),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    );

    if (platformSpecific) {
      if (Platform.isIOS) {
        List<Widget> actions = onCancel != null ? [CupertinoDialogAction(child: cancelButton)] : [];
        actions.add(CupertinoDialogAction(child: acceptButton));

        alert = CupertinoAlertDialog(
          key: key,
          content: body,
          actions: actions,
        );
      }
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alert,
    );
  }
}

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

  showSummaryDialog({Key? key, required BuildContext context, bool? canBack, bool isConfirmPayment = false}) {
    _showGeneralAlert(
        context,
        Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
          child: Text(isConfirmPayment ? 'กด "ยืนยัน" เพื่อทำการชำระเงิน' : 'หากกด “ออกจากหน้านี้” จะต้องทำรายการสั่งซื้อใหม่',
              style: AlvaStyles().headingSize14w400(Colors.black).copyWith(color: Colors.black, fontSize: 14).copyWith(height: 24 / 14)),
        ),
        title: Text(isConfirmPayment ? "ชำระเงิน" : "คุณต้องการออกจากหน้านี้ใช่หรือไม่",
            style: AlvaStyles()
                .headingSize18(Colors.black)
                .copyWith(fontWeight: FontWeight.w600, color: Colors.black, height: 24 / 18)
                .copyWith(height: 24 / 14)),
        key: key ?? const Key("back_from_summary_dialog"),
        // contentPadding: const EdgeInsets.all(24),
        contentPadding: const EdgeInsets.only(left: 24, top: 8, right: 24, bottom: 16),
        actionPadding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
        isConfirmPayment: isConfirmPayment);
  }

  showRefundDialog({Key? key, required BuildContext context, bool? canBack, bool isConfirmPayment = false}) {
    _showGeneralAlert(
        context,
        Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
          child: Text('กรุณาอ่านเงื่อนไขการคืนสินค้า/คืนเงิน ก่อนทำการยืนยัน',
              style: AlvaStyles().headingSize14w400(Colors.black).copyWith(color: Colors.black, fontSize: 14).copyWith(height: 24 / 14)),
          //   textAlign: Platform.isIOS ? TextAlign.center: TextAlign.start),
        ),
        title: Text("คุณต้องการคืนสินค้า/คืนเงิน?",
            style: AlvaStyles()
                .headingSize18(Colors.black)
                .copyWith(fontWeight: FontWeight.w600, color: Colors.black, height: 24 / 18)
                .copyWith(height: 24 / 14)),
        //  textAlign: Platform.isIOS ? TextAlign.center: TextAlign.start),
        key: key ?? const Key("back_from_summary_dialog"),
        // contentPadding: const EdgeInsets.all(24),
        contentPadding: const EdgeInsets.only(left: 24, top: 8, right: 24, bottom: 16),
        actionPadding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
        isConfirmPayment: isConfirmPayment);
  }

  showOutOfStockDialog({Key? key, required BuildContext context, bool? canBack, String productNameTitle = ""}) {
    _showGeneralAlert(
        context,
        Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .722),
          child: Text('ถูกลบ หรือ ขายหมดแล้ว \nกรุณากด “ยืนยัน” เพื่อทำรายการอีกครั้ง',
              style: AlvaStyles().headingSize14w400(Colors.black).copyWith(color: Colors.black, fontSize: 14).copyWith(height: 24 / 14)),
          //   textAlign: Platform.isIOS ? TextAlign.center: TextAlign.start),
        ),
        title: Text(productNameTitle,
            style: AlvaStyles()
                .headingSize18(Colors.black)
                .copyWith(fontWeight: FontWeight.w600, color: Colors.black, height: 24 / 18)
                .copyWith(height: 24 / 14)),
        //  textAlign: Platform.isIOS ? TextAlign.center: TextAlign.start),
        key: key ?? const Key("back_from_out_of_stock_dialog"),
        // contentPadding: const EdgeInsets.all(24),
        contentPadding: const EdgeInsets.only(left: 24, top: 8, right: 24, bottom: 16),
        actionPadding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
        isConfirmPayment: true);
  }

  _showGeneralLoading(BuildContext context, {Key? key, bool? canBack}) {
    Widget loading = PopScope(
      canPop: canBack ?? false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
      },
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

  _showGeneralAlert(
    BuildContext context,
    Widget body, {
    Key? key,
    Widget? title,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? actionPadding,
    bool platformSpecific = false,
    bool isConfirmPayment = false,
  }) {
    Widget acceptButton = TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.only(left: 14, right: 16, top: 8, bottom: 8)),
      ),
      onPressed: () {
        Navigator.pop(context);
        if (onAccept != null && isConfirmPayment == true) {
          onAccept!();
        } else if (isConfirmPayment == false) {
          onCancel!();
        }
      },
      child: Text(
        isConfirmPayment ? "ยืนยัน" : "อยู่หน้านี้ต่อไป",
        style: AlvaStyles().heading2(btnBlue).copyWith(height: 24 / 14),
      ),
    );

    Widget cancelButton = TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.only(left: 16, right: 14, top: 8, bottom: 8)),
      ),
      onPressed: () {
        Navigator.pop(context);
        if (onCancel != null && isConfirmPayment == true) {
          onCancel!();
        } else if (isConfirmPayment == false) {
          onAccept!();
        }
      },
      child: Text(
        isConfirmPayment ? "ยกเลิก" : "ออกจากหน้านี้",
        style: AlvaStyles().heading2(btnBlue).copyWith(height: 24 / 14),
      ),
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

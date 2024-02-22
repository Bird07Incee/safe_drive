import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';

class DropDownInputWidget extends StatefulWidget {
  final List<dynamic>? options;
  final dynamic value;
  final Function? onChanged;
  final String? label;
  final Icon? icon;
  final bool isExpanded;
  final bool outsideLabel;
  final double marginBottom;
  final bool required;
  final Function? validator;
  final double borderRadius;
  final double fontSize;
  final Color? borderColor;
  final bool disable;
  final AutovalidateMode? autoValidateMode;
  final String? errRequiredMessage;
  final TextEditingController? textEditingController;
  final bool isDisableDropdownSuffixButton;
  final double bottomSheetHeight;
  final Widget? customButton;

  const DropDownInputWidget(
      {super.key,
      this.label,
      this.options = const [],
      this.value,
      this.onChanged,
      this.icon,
      this.isExpanded = true,
      this.outsideLabel = true,
      this.marginBottom = 0,
      this.required = false,
      this.validator,
      this.borderRadius = 5,
      this.fontSize = 14,
      this.borderColor,
      this.disable = false,
      this.autoValidateMode,
      this.errRequiredMessage,
      this.textEditingController,
      this.isDisableDropdownSuffixButton = false,
      this.bottomSheetHeight = 0,
      this.customButton});

  @override
  State<DropDownInputWidget> createState() => _DropDownInputWidgetState();
}

class _DropDownInputWidgetState extends State<DropDownInputWidget> {
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showOutsideLabel = widget.outsideLabel && widget.label != null;
    double height = MediaQuery.of(context).size.height - 32;

    if(widget.bottomSheetHeight != 0){
      height = widget.bottomSheetHeight;
    }

    return GestureDetector(
        key: const Key("select_dropdown"),
        onTap: () async {
          if (!widget.disable) {
            List<DropdownAddressModel> items = widget.options!.map((e) => e as DropdownAddressModel).toList();
            await showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                backgroundColor: whitePure,
                context: context,
                builder: (_) {
                  return SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        height: height, //MediaQuery.of(context).size.height - 32,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              color: cloudSoftDeepWhite,
                              child: SizedBox(
                                height: 4,
                                width: 48,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              widget.label!,
                              style: AlvaStyles().headingSize18(BTN_SELECTED_TEXT_COLOR_NEW),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (widget.textEditingController != null) {
                                        widget.textEditingController!.text = items[index].nameTh!;
                                        if (widget.onChanged != null) {
                                          widget.onChanged!(items[index]);
                                        }
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                      child: Text(items[index].nameTh!),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                      height: 0,
                                    ),
                                  );
                                },
                                itemCount: widget.options!.length,
                              ),
                            )
                          ],
                        ),
                      ));
                });
          }
        },
        child: widget.customButton ?? Container(
            margin: EdgeInsets.only(
              bottom: widget.marginBottom,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: showOutsideLabel,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: widget.label ?? '',
                          style: TextStyle(
                            color: widget.disable
                                ? widget.options!.length == 1
                                    ? blackInBlack
                                    : cloudSoftDeepWhite
                                : blackInBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: fontFamily,
                          ),
                          // children: <TextSpan>[
                          //   if (required)
                          //     const TextSpan(
                          //       text: ' *',
                          //       style: TextStyle(
                          //         color: Colors.red,
                          //       ),
                          //     ),
                          // ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: TextFormField(
                        enabled: false,
                        controller: widget.textEditingController,
                        style: AlvaStyles().heading3Size16Bold(),
                        decoration: InputDecoration(
                          counterText: "",
                          errorText: widget.errRequiredMessage,
                          errorStyle: AlvaStyles().bodySize12W400(RedWordShow),
                          suffixStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          isDense: true,
                          label: !showOutsideLabel && widget.label != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      !showOutsideLabel ? widget.label ?? '' : '',
                                      style: AlvaStyles().bodySize12W600(widget.disable ? cloudSoftDeepWhite : BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ],
                                )
                              : null,
                          suffixIcon: widget.options!.length == 1 && widget.isDisableDropdownSuffixButton
                              ? null
                              : Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: widget.disable ? cloudSoftDeepWhite : blackInBlack),
                          fillColor: cloudSoftDeepWhite,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: grey300),
                            borderRadius: BorderRadius.circular(widget.borderRadius),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: grey300, width: 2),
                            borderRadius: BorderRadius.circular(widget.borderRadius),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.disable
                                    ? widget.options!.length == 1
                                        ? grey300
                                        : cloudSoftDeepWhite
                                    : grey300,
                                width: 1),
                            borderRadius: BorderRadius.circular(widget.borderRadius),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

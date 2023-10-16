import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

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

  const DropDownInputWidget(
      {Key? key,
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
      this.errRequiredMessage})
      : super(key: key);

  @override
  State<DropDownInputWidget> createState() => _DropDownInputWidgetState();
}

class _DropDownInputWidgetState extends State<DropDownInputWidget> {
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showOutsideLabel = widget.outsideLabel && widget.label != null;

    return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
              context: context,
              builder: (_) {
                return Text('jello');
              });
        },
        child: Container(
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
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
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
                        controller:
                            TextEditingController(text: widget.value ?? ''),
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
                                      !showOutsideLabel
                                          ? widget.label ?? ''
                                          : '',
                                      style: AlvaStyles().bodySize12W600(
                                          BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ],
                                )
                              : null,
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                              size: 24, color: blackInBlack),
                          fillColor: spaceGrey,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackInBlack),
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: blackInBlack, width: 2),
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: blackInBlack, width: 1),
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: blackInBlack, width: 1),
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                          ),
                        ),
                      ),
                    )
                    // DropdownButtonFormField(
                    //   autovalidateMode:
                    //   autoValidateMode ?? AutovalidateMode.onUserInteraction,
                    //   icon: icon ?? const Icon(Icons.keyboard_arrow_down),
                    //   isExpanded: isExpanded,
                    //   isDense: true,
                    //   style: TextStyle(
                    //     fontSize: fontSize,
                    //   ),
                    //   value: value,
                    //   onChanged: (dynamic v) {
                    //     if (onChanged != null) {
                    //       onChanged!(v);
                    //     }
                    //   },
                    //   items: options,
                    //   decoration: InputDecoration(
                    //     contentPadding: const EdgeInsets.all(10),
                    //     label: !showOutsideLabel && label != null
                    //         ? Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(!showOutsideLabel ? label ?? '' : ''),
                    //         if (required)
                    //           const Text(
                    //             ' *',
                    //             style: TextStyle(
                    //               color: Colors.red,
                    //             ),
                    //           ),
                    //       ],
                    //     )
                    //         : null,
                    //     hintText: '',
                    //     fillColor: disable ? spaceGrey : Colors.white,
                    //     filled: false,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(borderRadius),
                    //       borderSide: BorderSide(
                    //         color: borderColor ?? blackInBlack,
                    //         width: 1,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(borderRadius),
                    //       borderSide: BorderSide(
                    //         color: Theme.of(context).primaryColor,
                    //         width: 1,
                    //       ),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(borderRadius),
                    //       borderSide: BorderSide(
                    //         color: borderColor ??blackInBlack,
                    //         width: 1,
                    //       ),
                    //     ),
                    //   ),
                    //   validator: (dynamic value) {
                    //     if (required == true && value == null) {
                    //       return 'กรุณาเลือก ${label ?? ''}';
                    //     }
                    //
                    //     if (validator != null) {
                    //       return validator!(value);
                    //     }
                    //
                    //     return null;
                    //   },
                    // ),
                  ],
                ),
              ],
            )));
  }
}

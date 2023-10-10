import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';

class TextInputWidget extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? initialValue;
  final String? helperText;

  final int? maxLines;

  final double borderRadius;
  final double marginBottom;

  final bool outsideLabel;
  final bool filled;
  final bool required;
  final bool isPasswordField;

  final TextInputType? keyboardType;
  final TextEditingController? controller;

  final Widget? prefixIcon;
  final Function? onFocusChange;
  final Function? validator;
  final IconData? suffixIcon;
  final Function? onFocus;
  final Function? onTapSuffix;
  final Color? labelColor;
  final double padding;
  final TextAlign? textAlign;
  final bool? alignLabelWithHint;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  bool readOnly;
  final String? suffixText;

  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final Function? onChanged;

  bool disabled;
  final TextCapitalization textCapitalization;
  final String? errRequiredMessage;

  final AutovalidateMode? autoValidateMode;

  final int? minLines;

  final bool showCounter;

  final bool isAutoDisable;
  final bool isAbsoluteZeroForbidden;
  final bool isPercentageFieldLimit100;
  final bool isAllowAutoAddDecimal;
  final int? digitForCheck;

  TextInputWidget({
    Key? key,
    this.onTapSuffix,
    this.marginBottom = 0,
    this.onFocus,
    this.suffixIcon,
    this.borderRadius = 1,
    this.validator,
    this.required = false,
    this.initialValue,
    this.label,
    this.placeholder,
    this.keyboardType,
    this.isPasswordField = false,
    this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    this.outsideLabel = false,
    this.filled = false,
    this.helperText,
    this.labelColor,
    this.padding = 8,
    this.textAlign,
    this.alignLabelWithHint = false,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.suffixText,
    this.disabled = false,
    this.textCapitalization = TextCapitalization.none,
    this.errRequiredMessage,
    this.minLines,
    this.autoValidateMode,
    this.onFocusChange,
    this.showCounter = false,
    this.isAutoDisable = false,
    this.isAbsoluteZeroForbidden = false,
    this.isPercentageFieldLimit100 = false,
    this.isAllowAutoAddDecimal = false,
    this.digitForCheck,
  }) : super(key: key);

  @override
  TextInputWidgetState createState() => TextInputWidgetState();
}

class TextInputWidgetState extends State<TextInputWidget> {
  bool passwordVisible = false;
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();

    focusNode = FocusNode();
    focusNode!.addListener(() {
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
    });

    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        focusNode!.unfocus();
      }
    });
  }

  @override
  void dispose() {
    focusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;
    if (widget.isPasswordField) {
      suffixIcon = IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      );
    } else {
      if (widget.suffixIcon != null) {
        suffixIcon = IconButton(
          icon: Icon(widget.suffixIcon),
          onPressed: () {
            if (widget.onTapSuffix != null) {
              widget.onTapSuffix!();
            }
          },
        );
      }
    }

    bool showOutsideLabel = widget.outsideLabel && widget.label != null;

    Widget? renderSuffix() {
      if (suffixIcon != null) {
        return suffixIcon;
      }
      return null;
    }

    return Container(
      margin: EdgeInsets.only(
        bottom: widget.marginBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: showOutsideLabel,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: widget.label ?? '',
                style: TextStyle(
                    color: widget.labelColor ?? Colors.black,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Prompt'),
                children: <TextSpan>[
                  if (widget.required)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: showOutsideLabel ? 10 : 0),
          Focus(
            child: TextFormField(
              autovalidateMode: widget.required
                  ? (widget.autoValidateMode ??
                      AutovalidateMode.onUserInteraction)
                  : null,
              buildCounter: (BuildContext context,
                  {int? currentLength, int? maxLength, bool? isFocused}) {
                return widget.showCounter
                    ? Text(
                        '${widget.controller!.text.length}/$maxLength',
                        semanticsLabel: 'character count',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          height: double.minPositive,
                        ),
                      )
                    : Container();
              },
              textCapitalization: widget.textCapitalization,
              readOnly: widget.readOnly,
              inputFormatters: widget.inputFormatters ??
                  [
                    FilteringTextInputFormatter.allow(RegExp(
                        r"[ ก-๛a-zA-Z0-9-!$%^&*#@()_+|~=`{}\[\]:;'<>?,.\/"
                        '"'
                        "]")),
                    FilteringTextInputFormatter.deny(RegExp(
                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                  ],
              focusNode: focusNode,
              initialValue: widget.initialValue,
              minLines: widget.minLines ?? 1,
              maxLines: widget.maxLines,
              controller: widget.controller,
              obscureText: !widget.isPasswordField ? false : !passwordVisible,
              textAlign: widget.textAlign ?? TextAlign.left,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                errorMaxLines: 3,
                suffixStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: textSize(14, context),
                ),
                suffixText: widget.suffixText,
                filled: widget.filled == true ? widget.filled : widget.disabled,
                contentPadding: EdgeInsets.only(
                  left: widget.suffixText != null ? 0 : widget.padding,
                  right: widget.suffixText != null ? 0 : widget.padding,
                  top: widget.padding,
                  bottom: widget.padding,
                ),
                isDense: true,
                label: !showOutsideLabel && widget.label != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            !showOutsideLabel ? widget.label ?? '' : '',
                          ),
                          if (widget.required)
                            const Text(
                              ' *',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                        ],
                      )
                    : null,
                hintText: widget.placeholder,
                // labelText: !showOutsideLabel ? widget.label : null,
                alignLabelWithHint: widget.alignLabelWithHint ?? false,
                suffixIcon: renderSuffix(),
                prefixIcon: widget.prefixIcon,
                fillColor: widget.disabled
                    ? spaceGrey
                    : widget.readOnly
                        ? spaceGrey
                        : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: blackInBlack, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                      color: widget.readOnly ? spaceGrey : blackInBlack,
                      width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              keyboardType: widget.keyboardType,
              onFieldSubmitted: (text) {
                if (widget.onFieldSubmitted != null) {
                  widget.onFieldSubmitted?.call();
                }
              },
              onChanged: (text) async {
                if (widget.onChanged != null && text.isNotEmpty) {
                  widget.onChanged?.call();
                } else {
                  // เช็ค Limit Length text ภาษาไทย
                  if (widget.maxLength != null &&
                      text.isNotEmpty &&
                      text.length > widget.maxLength!) {
                    widget.controller!.text = text.substring(
                        0, text.length - (text.length - widget.maxLength!));
                    widget.controller!.selection = TextSelection.fromPosition(
                        TextPosition(offset: widget.controller!.text.length));
                  }
                }
              },
              validator: (value) {
                var validator = Validator();
                validator.value = value;

                if (widget.validator != null) {
                  return widget.validator!(value);
                }

                if (widget.required == true && validator.isBlank) {
                  return widget.errRequiredMessage ??
                      'กรุณากรอก ${widget.label ?? ''}';
                }

                return null;
              },
            ),
            onFocusChange: (isFocus) {
              if (widget.onFocusChange != null) {
                widget.onFocusChange?.call();
              }
            },
          ),
          Visibility(
            visible: widget.helperText != null,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                widget.helperText ?? '',
                style: TextStyle(
                  color: blackInBlack,
                  fontSize: textSize(10, context),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double textSize(double expectSize, BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double offset = 0;

    if (width < 376) {
      offset = -2;
    } else if (width <= 476) {
      offset = -1;
    }

    var result = expectSize + offset;

    return result;
  }
}

class Validator {
  String? value;

  bool get isBlank => (value == null || value!.trim().isEmpty);
  bool get isNotBlank => ((value != null) && (value!.trim().isNotEmpty));
}

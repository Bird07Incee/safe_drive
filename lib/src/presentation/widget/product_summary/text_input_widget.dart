import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

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
  final FocusNode? focusNode;

  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final Function? onEditingCompleted;
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
  final bool isAllowAutoAddPhoneFormat;
  final bool isAllowAutoAddEmailFormat;

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
    this.focusNode,
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
    this.onEditingCompleted,
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
    this.isAllowAutoAddPhoneFormat = false,
    this.isAllowAutoAddEmailFormat = false,
  }) : super(key: key);

  @override
  TextInputWidgetState createState() => TextInputWidgetState();
}

class TextInputWidgetState extends State<TextInputWidget> {
  bool passwordVisible = false;
  FocusNode? focusNode;
  var phoneNumberFormatter = PhoneNumberFormatter();
  var textFormField = TextFormField();
  String _formattedText = '';

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();
    focusNode = FocusNode();
    if (widget.focusNode != null) focusNode = widget.focusNode;
    focusNode!.addListener(() {
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
      if (widget.isAllowAutoAddEmailFormat && !focusNode!.hasFocus) {
        textFormField.validator!;
      }
    });

    if (widget.isAllowAutoAddPhoneFormat) {
      widget.inputFormatters!.add(phoneNumberFormatter);
      if (widget.controller != null) {
        widget.controller!.addListener(() {
          _formatPhoneNumber();
        });
      }
    }

    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        focusNode!.unfocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final RegExp _phoneNumberRegExp = RegExp(r'^\d{0,3}-\d{0,3}-\d{0,4}$');
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  String? _validateEmail(String value) {
    bool isValid = EmailValidator.validate(value);
    if (!_emailRegExp.hasMatch(value) || !isValid) {
      return 'Invalid email format';
    }
    return null;
  }

  void _formatPhoneNumber() {
    var text = widget.controller!.text;
    _formattedText = phoneNumberFormatter.countOnlyNumber(text);
    if (_phoneNumberRegExp.hasMatch(text)) {
      text = phoneNumberFormatter._formatPhoneNumber(text);
      widget.controller!.value = TextEditingValue(
        text: text,
        selection: widget.controller!.selection,
      );
    }
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

    textFormField = TextFormField(
      autovalidateMode: widget.required ? (widget.autoValidateMode ?? AutovalidateMode.onUserInteraction) : null,
      textCapitalization: widget.textCapitalization,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters ??
          [
            FilteringTextInputFormatter.allow(RegExp(r"[ ก-๛a-zA-Z0-9-!$%^&*#@()_+|~=`{}\[\]:;'<>?,.\/"
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
      maxLength: widget.isAllowAutoAddPhoneFormat ? 12 : widget.maxLength,
      textInputAction: widget.textInputAction,
      style: AlvaStyles().heading3Size16Bold(),
      decoration: InputDecoration(
        counterText: "",
        errorText: widget.errRequiredMessage,
        errorStyle: AlvaStyles().bodySize12W400(RedWordShow),
        suffixStyle: TextStyle(
          color: Colors.grey,
          fontSize: textSize(14, context),
        ),
        suffixText: widget.suffixText,
        filled: widget.filled == true ? widget.filled : widget.disabled,
        contentPadding: EdgeInsets.only(
          left: 0,
          right: 0,
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
                    style: AlvaStyles().bodySize12W600(BTN_SELECTED_TEXT_COLOR_NEW),
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
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: grey300),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.readOnly ? spaceGrey : BlueFantasy, width: 2),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: grey300, width: 1),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      keyboardType: widget.keyboardType,
      onFieldSubmitted: (text) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted?.call();
        }
      },
      onEditingComplete: () {
        if (widget.onEditingCompleted != null) {
          widget.onEditingCompleted?.call();
        }
      },
      onChanged: (text) async {
        if (widget.onChanged != null && text.isNotEmpty) {
          widget.onChanged?.call();
        } else {
          // เช็ค Limit Length text ภาษาไทย
          if (widget.maxLength != null && text.isNotEmpty && text.length > widget.maxLength!) {
            widget.controller!.text = text.substring(0, text.length - (text.length - widget.maxLength!));
            widget.controller!.selection =
                TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.length));
          }
        }
        setState(() {});
      },
      validator: (value) {
        var validator = Validator();
        validator.value = value;

        if (widget.validator != null) {
          return widget.validator!(value);
        }

        if (widget.required == true && validator.isBlank) {
          return widget.errRequiredMessage ?? 'กรุณาระบุ${widget.label ?? ''}ให้ถูกต้อง';
        }

        if (widget.required && widget.isAllowAutoAddEmailFormat) {
          String errorText = _validateEmail(value!) ?? '';
          if (errorText.isEmpty) {
            return null;
          } else {
            return 'กรุณาระบุ${widget.label ?? ''}ให้ถูกต้อง';
          }
        }

        return null;
      },
    );

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
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: fontFamily),
              ),
            ),
          ),
          SizedBox(height: showOutsideLabel ? 4 : 0),
          Focus(
            child: textFormField,
            onFocusChange: (isFocus) {
              if (widget.onFocusChange != null) {
                widget.onFocusChange?.call(isFocus);
              }
            },
          ),
          Visibility(
            visible: widget.showCounter ? true : widget.helperText != null,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                widget.showCounter
                    ? widget.controller!.text.isEmpty
                        ? 'สูงสุด ${widget.maxLength} ตัวอักษร'
                        : '${widget.isAllowAutoAddPhoneFormat ? _formattedText.length.toString() : widget.controller!.text.length.toString()}/${widget.isAllowAutoAddPhoneFormat ? 10 : widget.maxLength}'
                    : widget.helperText ?? '',
                style: AlvaStyles().headingSize12w400(spaceGrey123),
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

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _formatPhoneNumber(newValue.text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String countOnlyNumber(String text) {
    final formatted = text.replaceAll('-', '');
    return formatted;
  }

  String _formatPhoneNumber(String text) {
    final formatted = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (formatted.length <= 3) {
      return formatted;
    } else if (formatted.length <= 6) {
      return '${formatted.substring(0, 3)}-${formatted.substring(3)}';
    } else {
      if (formatted.length == 9) {
        return '${formatted.substring(0, 2)}-${formatted.substring(2, 5)}-${formatted.substring(5, formatted.length)}';
      } else {
        return '${formatted.substring(0, 3)}-${formatted.substring(3, 6)}-${formatted.substring(6, formatted.length)}';
      }
    }
  }
}

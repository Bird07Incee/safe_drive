import 'package:flutter/material.dart';

class DropDownInputWidget extends StatelessWidget {
  final List<DropdownMenuItem>? options;
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

  DropDownInputWidget(
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
      this.autoValidateMode})
      : super(key: key);

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showOutsideLabel = outsideLabel && label != null;

    return Container(
      margin: EdgeInsets.only(
        bottom: marginBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: showOutsideLabel,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: label ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Prompt',
                ),
                children: <TextSpan>[
                  if (required)
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
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[Text("hello")],
                      ),
                    );
                  });
            },
            child: const Text(
              'Choose Option',
              style: TextStyle(fontSize: 24),
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
    );
  }
}

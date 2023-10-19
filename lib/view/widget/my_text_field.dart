import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final String titleText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final int? minLines;
  final bool isPassword;
  final Function onTap;
  final Function onChanged;
  final Function onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final Color? fillColor;
  final bool autoFocus;
  final bool isReadOnly;
  final GlobalKey<FormFieldState<String>>? key;

  MyTextField(
      {this.hintText = '',
      this.titleText = '',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      required this.onSubmit,
      required this.onChanged,
      this.capitalization = TextCapitalization.none,
      required this.onTap,
      this.fillColor,
      this.isPassword = false,
      this.autoFocus = false,
      this.key, this.minLines});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            widget.titleText,
            style: poppinsRegular.copyWith(
              color: Theme.of(context).hintColor,
              fontSize: Dimensions.fontSizeDefault,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        TextField(minLines:widget.minLines ,
          readOnly: widget.isReadOnly,
          key: widget.key,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: poppinsRegular.copyWith(
              fontFamily: 'DMSans',
              fontSize: 14,
              color: Theme.of(context).hintColor),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).backgroundColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: widget.autoFocus,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: true,
            filled: true,
            fillColor: widget.fillColor != null
                ? widget.fillColor
                : Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: Dimensions.border_width),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: Dimensions.border_width),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color: Theme.of(context).backgroundColor,
                  width: Dimensions.border_width),
            ),
            hintStyle:
                poppinsRegular.copyWith(color: Theme.of(context).hintColor),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.check
                          : Icons.check_box_outline_blank,
                      color: Theme.of(context).hintColor.withOpacity(0.5),
                      size: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    onPressed: _toggle,
                  )
                : null,
          ),
          onTap: () => widget.onTap(),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit(text)
                  : null,
          onChanged: (text) => widget.onChanged(text),
        )
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

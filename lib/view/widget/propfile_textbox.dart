import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class ProfileTextField extends StatefulWidget {
  final String hintText;
  final String titleText;
  final String indexmain;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final bool isPassword;
  final Function onTap;
  final Function onChanged;
  final Function onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final Color? fillColor;
  final bool autoFocus;
  final bool? isApplyForm;
  final GlobalKey<FormFieldState<String>>? key;

  ProfileTextField(
      {this.hintText = '',
      this.titleText = '',
      required this.indexmain,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
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
      this.key, this.isApplyForm=false});

  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  widget.indexmain,
                  style: poppinsBold.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                widget.titleText,
                style: poppinsRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeDefault + 2,
                ),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextField(readOnly: widget.isApplyForm== true?true:false,
          key: widget.key,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: poppinsRegular.copyWith(
              fontSize: 15, color: Theme.of(context).hintColor),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).backgroundColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: widget.autoFocus,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
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

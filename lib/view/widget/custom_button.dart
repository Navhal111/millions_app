import 'package:flutter/material.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final IconData? icon;
  final bool? loading;

  CustomButton({
    required this.onPressed,
    required this.buttonText,
    this.transparent = false,
    required this.margin,
    required this.width,
    this.height = 45,
    required this.fontSize,
    this.radius = 5,
    this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      minimumSize: Size(width != null ? width : Dimensions.WEB_MAX_WIDTH,
          height != null ? height : 50),
      padding: EdgeInsets.zero,
      primary: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
      child: SizedBox(
          width: width != null ? width : Dimensions.WEB_MAX_WIDTH,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [Color(0xFFB216D7), Color(0xFFCE2EA1)],
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 6),
            margin: margin == null ? EdgeInsets.all(0) : margin,
            child: !loading!
                ? TextButton(
                    onPressed: () => {onPressed()},
                    style: _flatButtonStyle,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Icon(icon,
                                      color: transparent
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).cardColor),
                                )
                              : SizedBox(),
                          Text(buttonText == null ? '' : buttonText,
                              textAlign: TextAlign.center,
                              style: poppinsRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: fontSize != null
                                    ? fontSize
                                    : Dimensions.fontSizeLarge,
                              )),
                        ]),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 3.0,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
          )),
    );
  }
}

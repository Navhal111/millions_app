import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class FilterItem extends StatelessWidget {
  final Function? onTap;
  final String title;
  final bool? isinner;
  final bool? isLogout;
  final bool? isAnyText;
  final String? anyText;

  FilterItem(
      {required this.title,
      this.onTap,
      this.isinner = false,
      this.isLogout = false,
      this.isAnyText,
      this.anyText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(onTap!=null){
          onTap!();

        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.0,
                color: Theme.of(context).cardColor.withOpacity(0.5)),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: poppinsBold.copyWith(
                color: isLogout == true
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
              textAlign: TextAlign.start,
            ),
            isLogout == true
                ? Icon(Icons.logout, color: Theme.of(context).colorScheme.error)
                : isinner == false
                    ? Row(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            width: Get.width * 0.4,
                            child: Text(
                              isAnyText == true ? anyText.toString() : "Any",
                              overflow: TextOverflow.ellipsis,
                              style: poppinsMedium.copyWith(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontSize: Dimensions.fontSizeExtraLarge,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Theme.of(context).cardColor.withOpacity(0.7),
                          )
                        ],
                      )
                    : Icon(
                        Icons.check,
                        color: Theme.of(context).disabledColor.withOpacity(0.7),
                      )
          ],
        ),
      ),
    );
  }
}

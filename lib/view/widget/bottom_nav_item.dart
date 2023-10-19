import 'package:flutter/material.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class BottomNavItem extends StatelessWidget {
  final String iconData;
  final Function? onTap;
  final bool isSelected;
  final String title;
  BottomNavItem({required this.iconData, required this.title,this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top:10),
      width: (MediaQuery.of(context).size.width/4)-5,
      child:
      InkWell(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            Image.asset(
              iconData,
              width: Dimensions.bottom_Icon,
              height: Dimensions.bottom_Icon,
              color: isSelected ? Theme.of(context).cardColor.withOpacity(0.7) : Theme.of(context).disabledColor.withOpacity(0.7),
            ),
            Text(title,style: poppinsRegular.copyWith(
                    color: isSelected ? Theme.of(context).cardColor.withOpacity(0.7) : Theme.of(context).disabledColor.withOpacity(0.7),
                    fontSize: Dimensions.fontSizeSmall
                )
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

class InviteItemDetails extends StatelessWidget {
  final String title;
  final String dec;
  InviteItemDetails({required this.title,required this.dec});

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.getJobdetailsRought());
          },
          child: Container(
            width: MediaQuery.of(context).size.width-80,
            margin: EdgeInsets.only(right: 15,left:10,top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: poppinsBold.copyWith(
                  color: Theme.of(context).cardColor.withOpacity(0.9),
                  fontSize: Dimensions.fontSizeDefault+5,
                ),textAlign: TextAlign.start,),
                SizedBox(height: 10,),
                Text(dec,
                  style: poppinsRegular.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeSmall+3,
                ),textAlign: TextAlign.start,),
              ],
            ),
          )
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ShadowWidget.dart';

class CommentItem extends StatelessWidget {
  final String title;
  final String dec;
  CommentItem({required this.title, required this.dec});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.avtar,
                  width: MediaQuery.of(context).size.width / 12,
                  height: MediaQuery.of(context).size.width / 12,
                  color: Theme.of(context).disabledColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsBold.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        "Casting 'The Hitcher girl' Appersing from nowehere... A mysterious girl with the name of the hebrew demon,lili,hitchhiking",
                        style: poppinsRegular.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeSmall,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

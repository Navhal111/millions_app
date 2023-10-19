import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ShadowWidget.dart';
import 'package:million/view/widget/image_dialog.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String dec;
  final Map<String, dynamic> user;
  final dynamic createdTime;

  NotificationItem(
      {required this.title, required this.dec, required this.user, this.createdTime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Get.toNamed(RouteHelper.getJobdetailsRought());
        },
        child: ShadowWidget(
          widget: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  user['profilePic'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            child: ImageCard(
                              imagePath: AppConstants.IMAGE_BASE_URL +
                                  user['profilePic'],
                            ),
                          ),
                        )
                      : Image.asset(Images.account,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          color: Theme.of(context).disabledColor),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            width: Get.width * 0.45,
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.7),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),

                          Container(
                              width: Get.width * 0.22,

                              child: Text(createdTime,  overflow: TextOverflow.ellipsis, style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.7),
                                fontSize: Dimensions.fontSizeDefault,
                              ),)),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          dec,
                          style: poppinsRegular.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

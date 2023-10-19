import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';

showPopUpDialog(String message, BuildContext context,
    {bool isApplyForm = false,
    VoidCallback? onClickYes,
    VoidCallback? onClickNo,
    applyTitle,
    applyTalent}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(30),
          backgroundColor: AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 1, color: AppColors.whiteColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: isApplyForm == true
                      ? IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.close,
                            color: AppColors.whiteColor,
                          ))
                      : Container(),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: poppinsMedium.copyWith(
                            color: isApplyForm == true
                                ? AppColors.whiteColor.withOpacity(0.7)
                                : Theme.of(context).hintColor,
                            fontSize: isApplyForm == true
                                ? Dimensions.fontSizeDefault
                                : Dimensions.fontSizeExtraLarge,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isApplyForm
                        ? Container()
                        : Image.asset(
                            width: 40,
                            height: 40,
                            Images.warning,
                            fit: BoxFit.contain,
                          )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: onClickYes,
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.whiteColor, width: 0.2),
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Yes'.toUpperCase(),
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onClickNo,
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.whiteColor, width: 0.2),
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            isApplyForm == true
                                ? 'Apply'.toUpperCase()
                                : 'No'.toUpperCase(),
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
              ],
            ),
          ),
        );
      });
}

showFollowPopUpDialog(
    String follow, String userName, profilePic, BuildContext context,
    {bool isApplyForm = false,
    String? applyTitle,
    applyDesc,
    VoidCallback? onClickYes,
    VoidCallback? onClickNo}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(30),
          backgroundColor: Theme.of(context).canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                width: 1, color: AppColors.whiteColor.withOpacity(0.2)),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                isApplyForm == true
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          applyTitle ?? "",
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
                (profilePic != null && isApplyForm == false)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          AppConstants.IMAGE_BASE_URL + profilePic,
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      )
                    : (isApplyForm == false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              Images.account,
                              width: 60,
                              height: 60,
                              color: Theme.of(context).cardColor,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Column(
                  children: [
                    isApplyForm == true
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'Remove $follow?',
                              textAlign: TextAlign.center,
                              style: poppinsMedium.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                    isApplyForm == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              applyDesc,
                              textAlign: TextAlign.center,
                              style: poppinsMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'we won\'t tell ${userName} thet were removed from \nyour followers.',
                              textAlign: TextAlign.center,
                              style: poppinsMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Divider(
                  color: Theme.of(context).secondaryHeaderColor,
                  thickness: 0.5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: onClickYes,
                      child: Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.05,
                        child: Center(
                          child: Text(
                            isApplyForm == true
                                ? 'Yes'.toUpperCase()
                                : 'Remove'.toUpperCase(),
                            style: poppinsMedium.copyWith(
                                color: isApplyForm == true
                                    ? AppColors.whiteColor
                                    : Theme.of(context).errorColor,
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).secondaryHeaderColor,
                      thickness: 0.5,
                    ),
                    InkWell(
                      onTap: onClickNo,
                      child: Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.05,
                        child: Center(
                          child: Text(
                            isApplyForm == true
                                ? 'Apply'.toUpperCase()
                                : 'Cancel'.toUpperCase(),
                            style: poppinsMedium.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          ),
        );
      });
}

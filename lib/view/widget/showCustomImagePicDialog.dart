import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';

Loading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      );
    },
  );
}

showAddPostDialog(
    BuildContext context, AuthController authController, String imgType) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: AppColors.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(width: 2, color: AppColors.cardColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Text(
                      'Create a Post',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.whiteColor,
                      ))
                ],
              ),
              Divider(
                thickness: 2,
                height: 1.5,
                color: AppColors.primaryColor,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);

                  authController.uploadCameraImage("image", imgType, context);

                  // Get.toNamed(RouteHelper.getCreatePostRought());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_rounded,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        'Choose from Camera',
                        textAlign: TextAlign.start,
                        style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  authController.uploadMultipleCameraImage(
                      "image", imgType, context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        'Choose from Gallery',
                        textAlign: TextAlign.start,
                        style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showBottomSheetImageTypePostDialog(
    BuildContext context, AuthController authController, String imgType) {
  showModalBottomSheet(
    // isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Color(0xFF171717),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    'Select From ...',
                    textAlign: TextAlign.start,
                    style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ))
              ],
            ),
            Divider(
              thickness: 2,
              height: 1.5,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);

                authController.uploadMultipleCameraImage(
                    "image", imgType, context);

                // Get.toNamed(RouteHelper.getCreatePostRought());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Camera',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);

                // Loading(context);

                authController.uploadMultipleCameraImage("image", imgType, context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Gallery',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      );
    },
  );
}

showBottomSheetImageTypePostDialogProfile(
    BuildContext context, AuthController authController, String imgType) {
  showModalBottomSheet(
    // isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Color(0xFF171717),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    'Select From ...',
                    textAlign: TextAlign.start,
                    style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ))
              ],
            ),
            Divider(
              thickness: 2,
              height: 1.5,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);


                authController.uploadCameraImage(
                    "image", imgType, context);

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Camera',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                authController.uploadCameraImageGalery(
                    "image", imgType, context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Gallery',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      );
    },
  );
}

showBottomSheetVideoTypePostDialog(
    BuildContext context, AuthController authController, String imgType) {
  showModalBottomSheet(
    // isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Color(0xFF171717),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    'Create a Post',
                    textAlign: TextAlign.start,
                    style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ))
              ],
            ),
            Divider(
              thickness: 2,
              height: 1.5,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                authController.uploadVideoCameraPost("video", imgType, context);
                // Get.toNamed(RouteHelper.getCreatePostRought());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Camera',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // Loading(context);

                authController.uploadVideoGalleryPost(
                    "video", imgType, context);

                // Get.toNamed(RouteHelper.getCreatePostRought());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Choose from Gallery',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      );
    },
  );
}

showBottomSheetTypePostDialog(
    BuildContext context, AuthController authController, String postType) {
  showModalBottomSheet(
    // isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Color(0xFF171717),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    'Select Types of Post',
                    textAlign: TextAlign.start,
                    style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ))
              ],
            ),
            Divider(
              thickness: 2,
              height: 1.5,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InkWell(
              onTap: () {
                authController.setTypeofPost("image");

                Navigator.pop(context);
                showBottomSheetImageTypePostDialog(
                    context, authController, "image");
                // Get.toNamed(RouteHelper.getCreatePostRought());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Image Post',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {
                // Loading(context);
                authController.setTypeofPost("video");
                Navigator.pop(context);
                showBottomSheetVideoTypePostDialog(
                    context, authController, "video");
                // authController.uploadMultipleCameraImage(
                //     "image", postType, context);

                // Get.toNamed(RouteHelper.getCreatePostRought());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.video_collection_outlined,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Text(
                      'Video Post',
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      );
    },
  );
}

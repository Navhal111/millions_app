import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:agora_rtc_engine/media_recorder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/controllers/coman_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/MasagesScreen.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:million/view/widget/my_text_field.dart';
import 'package:million/view/widget/propfile_textbox.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';
import 'package:video_player/video_player.dart';

class AppLyFormScreen extends StatefulWidget {
  final String? talentType;

  AppLyFormScreen({super.key, this.talentType});

  @override
  State<AppLyFormScreen> createState() => _AppLyFormScreenState();
}

class _AppLyFormScreenState extends State<AppLyFormScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _applyTextController = TextEditingController();
  File? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: GetBuilder<JobDetailController>(
        builder: (jobDetailController) {
          return GetBuilder<AuthController>(
            builder: (authController) {
              print('jobTalentVal ${jobDetailController.jobTalentVal}');
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 9,
                                height: MediaQuery.of(context).size.width / 9,
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 38,
                                ),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width / 9),
                                    border: Border.all(
                                        color: Theme.of(context).disabledColor,
                                        width: 1)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                "Apply For Job",
                                style: poppinsRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(

                          ' ${jobDetailController.jobTalentVal} ',
                          style: poppinsMedium.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 10.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                            controller: _applyTextController,
                            decoration: InputDecoration(
                              labelText: 'Enter Apply Text',
                              fillColor: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.7),
                            ),
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: AppColors.whiteColor),
                            maxLines: 3,
                            // <-- SEE HERE
                            onChanged: (text) => {
                                  jobDetailController.addJobData(text),
                                }),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showBottomSheetImageTypePostDialog(
                                    context, authController, "applyImage");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                    colors: [
                                      Color(0xFFB216D7),
                                      Color(0xFFCE2EA1)
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  '+ Upload Image',
                                  style: poppinsRegular.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: (authController
                                                .sigupdata["applyImage"] !=
                                            null &&
                                        authController.sigupdata["applyImage"]
                                                .length >
                                            0)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: Get.width * 0.9,
                                        height: Get.height * 0.09,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: authController
                                              .sigupdata["applyImage"].length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.18,
                                                  height: Get.height * 0.09,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                  ),
                                                  child: authController
                                                                      .sigupdata[
                                                                  'applyImage']
                                                              [index] !=
                                                          null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: ImageCard(
                                                            imagePath: AppConstants
                                                                    .IMAGE_BASE_URL +
                                                                authController
                                                                        .sigupdata[
                                                                    'applyImage'][index],
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          Images.account,
                                                          fit: BoxFit.fill,
                                                        ),
                                                ),
                                                Positioned(
                                                  right: 15,
                                                  top: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      authController
                                                          .removeImageFromMultiSelect(
                                                              index,
                                                              'applyImage');
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: AppColors
                                                              .whiteColor),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 18,
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showBottomSheetVideoTypePostDialog(
                                    context, authController, "applyVideo");
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      begin: FractionalOffset.centerLeft,
                                      end: FractionalOffset.centerRight,
                                      colors: [
                                        Color(0xFFB216D7),
                                        Color(0xFFCE2EA1)
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    '+ Upload Video',
                                    style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: (authController.sigupdata["applyVideo"] !=
                                          null &&
                                      authController
                                              .sigupdata["applyVideo"].length >
                                          0)
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: Get.width * 0.9,
                                      height: Get.height * 0.09,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: authController
                                            .sigupdata["applyVideo"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                width: Get.width * 0.18,
                                                height: Get.height * 0.09,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                                child: authController.sigupdata[
                                                                'applyVideo']
                                                            [index] !=
                                                        null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: ImageCard(
                                                          imagePath: AppConstants
                                                                  .IMAGE_BASE_URL +
                                                              authController
                                                                      .sigupdata[
                                                                  'applyVideo'][index],
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        Images.account,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                              Positioned(
                                                right: 15,
                                                top: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    authController
                                                        .removeImageFromMultiSelect(
                                                            index,
                                                            'applyVideo');
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: AppColors
                                                            .whiteColor),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 18,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        height: Get.height * 0.15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                authController.pickFile(authController,'documents','documents');
                                // showBottomSheetVideoTypePostDialog(
                                //     context,
                                //     authController,
                                //     "applyVideo");
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      begin: FractionalOffset.centerLeft,
                                      end: FractionalOffset.centerRight,
                                      colors: [
                                        Color(0xFFB216D7),
                                        Color(0xFFCE2EA1)
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    '+ Upload Document',
                                    style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),

                            Expanded(
                              child: (authController.documnetData['documents']!=null)
                                  ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                authController.documnetData['documents'].length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  print('doc............');
                                  print(authController.pichDocsList);

                                  print(AppConstants.DOCS_BASE_URL + authController.documnetData['documents'][index]);

                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: ()async{

                                          final Uri _url = Uri.parse(AppConstants.DOCS_BASE_URL + authController.documnetData['documents'][index]);
                                          if (!await launchUrl(
                                            _url,
                                            mode: LaunchMode.externalApplication,
                                          )) {
                                            throw 'Could not launch $_url';
                                          }

                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.1),
                                                offset:
                                                Offset(-6.0, -6.0),
                                                blurRadius: 10.0,
                                              ),
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                offset: Offset(6.0, 6.0),
                                                blurRadius: 16.0,
                                              ),
                                            ],
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: Get.width * 0.35,
                                          height: Get.height * 0.09,
                                          child: Center(
                                            child: Text(
                                              'Document ${index + 1}',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 15,
                                        child: InkWell(
                                          onTap: (){
                                            authController
                                                .removeImageFromMultiSelectDeument(
                                                index,
                                                'documents');
                                          },
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15),
                                                color:
                                                AppColors.whiteColor),
                                            child: Icon(
                                              Icons.close,
                                              color: AppColors.blackColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                                  : SizedBox(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomButton(
                        loading: jobDetailController.isLoading,
                        onPressed: () {
                          if (_applyTextController.text.isNotEmpty &&
                              authController.sigupdata['postType'] != '') {
                            print(
                                'poettype------------- ${ authController.documnetData['documents']}');
                            print(
                                'text------------- ${_applyTextController.text}');
                            jobDetailController
                                .applyJobPost(
                                    jobDetailController.jobDetails['_id'],
                                    authController.sigupdata['_id'],

                                    jobDetailController.talenttype,
                                jobDetailController.talenttype,
                                    authController.sigupdata['applyImage'],
                                    authController.sigupdata['applyVideo'],
                                authController.documnetData['documents'],

                                    _applyTextController.text ?? "",
                                    authController.sigupdata,
                                    context)
                                .then((value) {
                              authController.sigupdata["applyImage"] == null;
                            });
                          } else {
                            showCustomSnackBar(
                                'Please Enter Apply Info.', context,
                                isError: true);
                          }
                        },
                        buttonText: "Apply",
                        fontSize: Dimensions.fontSizeLarge,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 25, bottom: 10),
                        radius: Dimensions.RADIUS_SMALL,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

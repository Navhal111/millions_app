import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/ApplyFormScreen.dart';
import 'package:million/view/widget/ShadowWidget.dart';
import 'package:million/view/widget/customPopupDialog.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';

class InviteDetails extends StatelessWidget {
  final String title, desc, talentType;
  final int index;
  final String? timeVal;
  final bool? item;
  final String? status;

  InviteDetails(
      {required this.title,
      this.item = false,
      required this.desc,
      required this.timeVal,
      required this.index,
      this.status,
      required this.talentType});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return GetBuilder<JobDetailController>(
          builder: (jobDetailController) {
            return InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.getJobdetailsRought());
              },
              child: ShadowWidget(
                widget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeDefault + 3,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(
                                  Images.boy,
                                  width: MediaQuery.of(context).size.width / 20,
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text(
                                  "10-15 Male",
                                  style: poppinsBold.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(
                                  Images.girl,
                                  width: MediaQuery.of(context).size.width / 20,
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text(
                                  "20-25 Female",
                                  style: poppinsBold.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        desc,
                        style: poppinsRegular.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeSmall + 3,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(jobDetailController.getApplyedJobList);
                                  jobDetailController.setJobTalentValue(title);
                                  if (jobDetailController.getApplyedJobList
                                      .where(
                                          (val) => val["talent"] == talentType)
                                      .isNotEmpty) {
                                    print('---------------1-------------');
                                    var tempOb = jobDetailController
                                        .getApplyedJobList
                                        .where((val) =>
                                            val["talent"] == talentType)
                                        .toList();
                                    jobDetailController
                                        .setApplyJobDetailInfo(tempOb[0]);
                                    Get.toNamed(
                                        RouteHelper
                                            .getApplyJobInfoDetailScreen(),
                                        arguments: tempOb[0]);
                                  } else {
                                    // showPopUpDialog(
                                    //     isApplyForm: true,
                                    //     applyTitle: title,applyTalent: talentType,
                                    //     'Are you want to update your profile?',
                                    //     context, onClickYes: () {
                                    //   Get.back();
                                    //   Get.toNamed(
                                    //       RouteHelper.getCreateProfileRought(),
                                    //       arguments: index);
                                    // }, onClickNo: () {
                                    //   print(jobDetailController.jobTalentVal);
                                    //   jobDetailController
                                    //       .setJobTalentValue(title);
                                    //   Get.back();
                                    //   Get.to(AppLyFormScreen(),
                                    //       arguments:
                                    //           jobDetailController.jobTalentVal);
                                    // });
                                    showFollowPopUpDialog(
                                       '',title,'',context,
                                        isApplyForm: true,
                                        applyTitle: title,
applyDesc: 'Are you want to update your profile?',
                                        onClickYes: () {
                                          Get.back();
                                          Get.toNamed(
                                              RouteHelper.getCreateProfileRought(),
                                              arguments: index);
                                        }, onClickNo: () {
                                      print(jobDetailController.jobTalentVal);
                                      jobDetailController
                                          .setJobTalentValue(title);
                                      Get.back();
                                      Get.to(AppLyFormScreen(),
                                          arguments:
                                          jobDetailController.jobTalentVal);
                                    });
                                    print('---------------2-------------');

                                    jobDetailController
                                        .setTalentType(talentType);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.1),
                                        width: 1),
                                  ),
                                  child: Text(
                                    jobDetailController.getApplyedJobList
                                            .where((val) =>
                                                val["talent"] == talentType)
                                            .isNotEmpty
                                        ? "Show Applyed"
                                        : "Apply",
                                    style: poppinsBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  jobDetailController.addDraftList(index);
                                  showCustomSnackBar('Drafted Saved.', context!,
                                      isError: false);
                                  // Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.1),
                                        width: 1),
                                  ),
                                  child: Text(
                                    "Save Draft",
                                    style: poppinsBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: Get.width * 0.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Text(
                              timeVal.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: poppinsRegular.copyWith(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

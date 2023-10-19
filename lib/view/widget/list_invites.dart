import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ShadowWidget.dart';
import 'package:share_plus/share_plus.dart';

class InviteItem extends StatelessWidget {
  final String title, desc, jobType;
  final String startDate;
  final int roles;
  final bool? item;
  final Color? linkcolor;
  final dynamic jobDetail;

  InviteItem(
      {required this.title,
      this.item = false,
      this.linkcolor,
      required this.desc,
      required this.jobType,
      required this.startDate,
      required this.roles, this.jobDetail});

  var jobDetailController = Get.find<JobDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(
      builder: (jobDetailController) {
        return InkWell(
          onTap: () {


            jobDetailController.getApplyedJobSelected(jobDetail['_id']);
            jobDetailController.setJobDetail(jobDetail);
            Get.toNamed(RouteHelper.getJobdetailsRought());
          },
          child: FocusDetector(
            onForegroundGained: () async {
              print("onForegroundGained");
            },
            child: ShadowWidget(
              widget: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  //   width: 5,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: linkcolor ?? Theme.of(context).backgroundColor,
                  //   ),
                  // ),
                  Container(
                    padding:
                        EdgeInsets.only(right: 18, left: 0, top: 10, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: poppinsBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeDefault + 5,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            desc,
                            style: poppinsRegular.copyWith(
                              color: Theme.of(context).hintColor.withOpacity(0.7),
                              fontSize: Dimensions.fontSizeSmall + 3,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        item!
                            ? Row(
                                children: [
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(top: 12),
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.7),
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(20)),
                                          shadowDarkColor: Color(0xff292929),
                                          shadowLightColor: Color(0xff292929)
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Text(
                                        "NUDITY REQUIRED",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )),
                                ],
                              )
                            : Row(
                                children: [
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(top: 12),
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.7),
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(20)),
                                          shadowDarkColor: Color(0xff292929),
                                          shadowLightColor: Color(0xff292929)
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Text(
                                        "Feature Films",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(top: 12),
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.7),
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(20)),
                                          shadowDarkColor: Color(0xff292929),
                                          shadowLightColor: Color(0xff292929)
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Text(
                                        jobType,
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      ))
                                ],
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.1),
                                          width: 1)),
                                  child: Text(
                                    "${roles} Roles",
                                    style: poppinsBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {

                                    Share.share(
                                        '1Million \n $title');
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
                                            width: 1)),
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity((0.7)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Text(
                                "$startDate",
                                style: poppinsRegular.copyWith(
                                  color:
                                      Theme.of(context).hintColor.withOpacity(0.7),
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

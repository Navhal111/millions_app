import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/applyDocsWidget.dart';
import 'package:million/view/widget/applyImageWidget.dart';
import 'package:million/view/widget/ShadowWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplyItem extends StatelessWidget {
  final String title,
      desc,
      jobType,
      applyText,
      postType,
      locationType,
      unionStatus;
  final String startDate;
  final List? applyImage;
  final List? applyDocs;

  final int roles;
  final bool? item;
  final Color? linkcolor;
  final dynamic jobDetail;

  ApplyItem({
    required this.title,
    this.item = false,
    this.linkcolor,
    required this.desc,
    required this.jobType,
    required this.startDate,
    required this.roles,
    this.jobDetail,
    required this.applyText,
    this.applyImage,
    required this.postType,
    this.applyDocs,
    required this.locationType,
    required this.unionStatus,
  });

  var jobDetailController = Get.find<JobDetailController>();
  final pageController = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(builder: (jobDetailController) {
      return InkWell(
        onTap: () {
          print('mmmmmmmm');
          // jobDetailController.setJobDetail(jobDetail);
          // Get.toNamed(RouteHelper.getJobdetailsRought());
        },
        child: FocusDetector(
          onForegroundGained: () async {
            print("onForegroundGained");
          },
          child: Container(
            width: Get.width * 0.9,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                runSpacing: 0,
                spacing: 0,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: ShadowWidget(
                      widget: SingleChildScrollView(
                        // physics: BouncingScrollPhysics(),
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
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                applyText,
                                maxLines: 3,
                                style: poppinsRegular.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.7),
                                  fontSize: Dimensions.fontSizeSmall + 3,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child:  Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                child: Text(
                                  "Applyed On : $startDate",
                                  style: poppinsRegular.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            applyImage != null
                                ? ApplyImageWidget(
                                    applyImg: applyImage,
                                  )
                                : Container(),
                            const SizedBox(
                              height: 15,
                            ),
                            (applyDocs != null)
                                ? SizedBox(
                                    height: Get.height * 0.15,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: applyDocs!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                final Uri _url = Uri.parse(
                                                    AppConstants.DOCS_BASE_URL +
                                                        applyDocs![index]);
                                                if (!await launchUrl(
                                                  _url,
                                                  mode: LaunchMode
                                                      .externalApplication,
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
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                desc,
                                style: poppinsRegular.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.7),
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
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(
                                                          20)),
                                              shadowDarkColor:
                                                  Color(0xff292929),
                                              shadowLightColor:
                                                  Color(0xff292929)
                                              //border: NeumorphicBorder()
                                              ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Text(
                                            "NUDITY REQUIRED",
                                            style: poppinsBold.copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
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
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(
                                                          20)),
                                              shadowDarkColor:
                                                  Color(0xff292929),
                                              shadowLightColor:
                                                  Color(0xff292929)
                                              //border: NeumorphicBorder()
                                              ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Text(
                                            locationType,
                                            style: poppinsBold.copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      NeumorphicButton(
                                          margin: EdgeInsets.only(top: 12),
                                          onPressed: () {},
                                          style: NeumorphicStyle(
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.7),
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(
                                                          20)),
                                              shadowDarkColor:
                                                  Color(0xff292929),
                                              shadowLightColor:
                                                  Color(0xff292929)
                                              //border: NeumorphicBorder()
                                              ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Text(
                                            jobType,
                                            style: poppinsBold.copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      NeumorphicButton(
                                          margin: EdgeInsets.only(top: 12),
                                          onPressed: () {},
                                          style: NeumorphicStyle(
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.7),
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(
                                                          20)),
                                              shadowDarkColor:
                                                  Color(0xff292929),
                                              shadowLightColor:
                                                  Color(0xff292929)
                                              //border: NeumorphicBorder()
                                              ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Text(
                                            unionStatus,
                                            style: poppinsBold.copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                            ),
                                          ))
                                    ],
                                  ),
                            const SizedBox(
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
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        Share.share('1Million \n $title');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
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

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

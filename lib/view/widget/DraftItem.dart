import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ShadowWidget.dart';

class DraftItem extends StatelessWidget {
  final String title, desc;

  final bool? item;
  final String? timeVal;
  final String? draftTimeVal;
  final VoidCallback? onTap;

  DraftItem(
      {required this.title,
      this.item = false,
      required this.desc,
      this.timeVal,
      this.onTap, this.draftTimeVal});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(
      builder: (jobDetailController) {
        return InkWell(
            onTap: () {
              Get.toNamed(RouteHelper.getJobdetailsRought());
            },
            child: ShadowWidget(
              widget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault + 3,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        desc,
                        style: poppinsRegular.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeSmall + 3,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.calendar_month_sharp,
                              size: 20,
                              color: Theme.of(context).hintColor.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 10),
                            child: Text(
                              "Daft Saved on:",
                              style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.8),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.4,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Text(
                              timeVal.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.5),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.calendar_month_sharp,
                              size: 20,
                              color: Theme.of(context).hintColor.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 10),
                            child: Text(
                              "Created on:",
                              style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.8),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.4,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Text(
                              draftTimeVal.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: poppinsBold.copyWith(
                                color: Theme.of(context).hintColor.withOpacity(0.5),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              jobDetailController.setJobTalentValue(title);
                              Get.toNamed(
                                  RouteHelper.getCreateProfileRought());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.1),
                                    width: 1),
                              ),
                              child: Text(
                                "Apply",
                                style: poppinsBold.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.1),
                                    width: 1),
                              ),
                              child: Text(
                                "Remove Draft",
                                style: poppinsBold.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ));
      }
    );
  }
}

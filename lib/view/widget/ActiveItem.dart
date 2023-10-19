import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ShadowWidget.dart';

class ActiveItem extends StatelessWidget {
  final String title, desc;
  final String? timeVal;
  final dynamic jobDetail;
  final bool? item;

  ActiveItem(
      {required this.title,
      this.item = false,
      required this.desc,
      this.timeVal,
      this.jobDetail});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(builder: (jobDeatilcontroller) {
      return InkWell(
          onTap: () {
            print('ONTAP');
            print('vvvvvvvvvvvvvvvvvvvvvvvvv');


            jobDeatilcontroller.setApplyJobDetailInfo(jobDetail);

            Get.toNamed(RouteHelper.getApplyJobInfoDetailScreen(),
                arguments: jobDetail);
          },
          child: ShadowWidget(
            widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            "Submitted on:",
                            style: poppinsBold.copyWith(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.8),
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
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5),
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),),
          ),);
    },);
  }
}

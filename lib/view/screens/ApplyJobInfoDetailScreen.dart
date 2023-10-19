import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/coman_controller.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/applyWidget.dart';
import 'package:million/view/widget/listDetails.dart';
import 'package:million/view/widget/list_invites.dart';

class ApplyJobInfoDetailScreen extends StatefulWidget {
  const ApplyJobInfoDetailScreen({super.key});

  @override
  State<ApplyJobInfoDetailScreen> createState() =>
      _ApplyJobInfoDetailScreenState();
}

class _ApplyJobInfoDetailScreenState extends State<ApplyJobInfoDetailScreen>
    with TickerProviderStateMixin {
  var jobDdetail;
  TabController? _tabController;

  @override
  void initState() {
    this._tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    jobDdetail = Get.arguments;

    // TODO: implement initState
    super.initState();
  }

  final f2 = new DateFormat('dd-mm-yyyy');

  @override
  Widget build(BuildContext context) {
    print(
        "=======================jobDdetailjobDdetailjobDdetail===============================================${jobDdetail["jobs"][0]}");
    return jobDdetail != null
        ? Scaffold(
            backgroundColor: AppColors.blackColor,
            appBar: AppBar(
              backgroundColor: AppColors.blackColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text(
                '${jobDdetail['jobs'][0]['jobName']}' ?? "",
              ),
              centerTitle: false,
            ),
            body:
                GetBuilder<JobDetailController>(builder: (jobDetailController) {
              return DefaultTabController(
                length: 2,
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: Get.height * 0.85,
                          width: Get.width * 1,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                onTap: (tab) {
                                  jobDetailController.getGlobalSeacrhIndex(tab);
                                },
                                labelColor: AppColors.primaryColor,
                                indicatorColor: AppColors.primaryColor,
                                controller: _tabController,
                                tabs: const <Tab>[
                                  Tab(text: "Job Detail"),
                                  Tab(text: "Production Details"),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                      SizedBox(
                                        width: Get.width * 1,
                                        child: ApplyItem(
                                            postType: jobDdetail['postType'],
                                            jobDetail: jobDdetail['_id'],
                                            applyText:
                                                'ApplyText :  ${jobDdetail['jobText']}',
                                            applyImage: jobDdetail["postItems"],
                                            applyDocs:
                                                jobDdetail["postDocument"],
                                            title:
                                                '${jobDdetail['jobs'][0]["jobName"]} ( ${jobDdetail["talent"]} )',
                                            desc: jobDdetail['jobs'][0]
                                                    ["jobDec"] ??
                                                "",
                                            locationType: jobDdetail['jobs'][0]
                                                ['locationType'],
                                            jobType: jobDdetail['jobs'][0]
                                                    ["jobType"] ??
                                                "Paid",
                                            unionStatus: jobDdetail['jobs'][0]
                                                ['unionStatus'],
                                            roles: jobDdetail['jobs'][0]
                                                ["roles"],
                                            startDate: f2.format(DateTime.parse(
                                                jobDdetail["createdAt"]))),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                  // "Film : Feature films",
                                                  "Job Name : ${jobDdetail['jobs'][0]["jobName"]}",
                                                  style: poppinsBold.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.7),
                                                    fontSize: Dimensions
                                                            .fontSizeDefault +
                                                        2,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                child: Text(
                                                  "Created At :  ${DateFormat('dd/mm/yyyy').format(DateTime.parse(jobDdetail['createdAt']))}",
                                                  style: poppinsBold.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.7),
                                                    fontSize: Dimensions
                                                            .fontSizeDefault +
                                                        2,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 5),
                                                child: Row(
                                                  children: [
                                                    NeumorphicButton(
                                                        margin: EdgeInsets.only(
                                                            top: 12),
                                                        onPressed: () {},
                                                        style: NeumorphicStyle(
                                                            color: Theme.of(context)
                                                                .hintColor
                                                                .withOpacity(
                                                                    0.7),
                                                            shape:
                                                                NeumorphicShape
                                                                    .flat,
                                                            boxShape:
                                                                NeumorphicBoxShape.roundRect(
                                                                    BorderRadius.circular(
                                                                        20)),
                                                            shadowDarkColor:
                                                                Color(
                                                                    0xff292929),
                                                            shadowLightColor:
                                                                Color(
                                                                    0xff292929)
                                                            //border: NeumorphicBorder()
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 15,
                                                                vertical: 8),
                                                        child: Text(
                                                          jobDdetail['jobs'][0]
                                                              ['locationType'],
                                                          style: poppinsBold
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .secondaryHeaderColor,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    NeumorphicButton(
                                                        margin: EdgeInsets.only(
                                                            top: 12),
                                                        onPressed: () {},
                                                        style: NeumorphicStyle(
                                                            color: Theme.of(context)
                                                                .cardColor
                                                                .withOpacity(
                                                                    0.7),
                                                            shape:
                                                                NeumorphicShape
                                                                    .flat,
                                                            boxShape:
                                                                NeumorphicBoxShape.roundRect(
                                                                    BorderRadius.circular(
                                                                        20)),
                                                            shadowDarkColor:
                                                                Color(
                                                                    0xff292929),
                                                            shadowLightColor:
                                                                Color(
                                                                    0xff292929)
                                                            //border: NeumorphicBorder()
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 15,
                                                                vertical: 8),
                                                        child: Text(
                                                          jobDdetail['jobs'][0]
                                                                  ["jobType"] ??
                                                              "Paid",
                                                          style: poppinsBold
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .secondaryHeaderColor,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    NeumorphicButton(
                                                      margin: EdgeInsets.only(
                                                          top: 12),
                                                      onPressed: () {},
                                                      style: NeumorphicStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .hintColor
                                                              .withOpacity(0.7),
                                                          shape: NeumorphicShape
                                                              .flat,
                                                          boxShape: NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          shadowDarkColor:
                                                              Color(0xff292929),
                                                          shadowLightColor:
                                                              Color(0xff292929)
                                                          //border: NeumorphicBorder()
                                                          ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: Text(
                                                        jobDdetail['jobs'][0]
                                                            ['unionStatus'],
                                                        style: poppinsBold
                                                            .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .secondaryHeaderColor,
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InviteItemDetails(
                                                title: jobDdetail['jobs'][0]
                                                        ['productionType'] ??
                                                    jobDdetail['jobs'][0]
                                                        ['jobName'],
                                                dec: jobDdetail['jobs'][0]
                                                        ['jobDec']
                                                    .toString(),
                                              ),
                                              InviteItemDetails(
                                                title: jobDdetail['jobs'][0][
                                                        'productionPersonnel'] ??
                                                    jobDdetail['jobs'][0]
                                                        ['jobName'],
                                                dec: jobDdetail['jobs'][0][
                                                        'productionDescription']
                                                    .toString(),
                                              ),
                                              InviteItemDetails(
                                                title: jobDdetail['jobs'][0]
                                                    ['auditionTitle'],
                                                dec: jobDdetail['jobs'][0]
                                                        ['auditionInstruction']
                                                    .toString(),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      jobDdetail['jobs'][0][
                                                          'keyDatesAndLocation'],
                                                      style:
                                                          poppinsBold.copyWith(
                                                        color: Theme.of(context)
                                                            .cardColor
                                                            .withOpacity(0.9),
                                                        fontSize: Dimensions
                                                                .fontSizeDefault +
                                                            5,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      jobDdetail['jobs'][0]
                                                          ['productionCompany'],
                                                      style:
                                                          poppinsBold.copyWith(
                                                        color: Theme.of(context)
                                                            .cardColor
                                                            .withOpacity(0.9),
                                                        fontSize: Dimensions
                                                                .fontSizeDefault +
                                                            5,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              NeumorphicButton(
                                                  margin: EdgeInsets.only(
                                                      top: 12, left: 10),
                                                  onPressed: () {},
                                                  style: NeumorphicStyle(
                                                      color: Theme.of(context)
                                                          .hintColor
                                                          .withOpacity(0.7),
                                                      shape:
                                                          NeumorphicShape.flat,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      shadowDarkColor:
                                                          Color(0xff292929),
                                                      shadowLightColor:
                                                          Color(0xff292929)
                                                      //border: NeumorphicBorder()
                                                      ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                  child: Text(
                                                    "Profession Pay: ${jobDdetail['jobs'][0]['rateType']}",
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor,
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                    ),
                                                  )),
                                              NeumorphicButton(
                                                  margin: EdgeInsets.only(
                                                      top: 12, left: 10),
                                                  onPressed: () {},
                                                  style: NeumorphicStyle(
                                                      color: Theme.of(context)
                                                          .hintColor
                                                          .withOpacity(0.7),
                                                      shape:
                                                          NeumorphicShape.flat,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      shadowDarkColor:
                                                          Color(0xff292929),
                                                      shadowLightColor:
                                                          Color(0xff292929)
                                                      //border: NeumorphicBorder()
                                                      ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                  child: Text(
                                                    "${jobDdetail['jobs'][0]['productionWebsite']}",
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor,
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          )
        : Container();
  }
}

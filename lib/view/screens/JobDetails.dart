import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/Invitesdetails.dart';
import 'package:million/view/widget/listDetails.dart';

class JobDetailsScreen extends StatefulWidget {
  final String? appVersion;

  JobDetailsScreen({this.appVersion});

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GetBuilder<JobDetailController>(builder: (jobDetailController) {

          return Column(
            children: [
              SizedBox(
                height: 56,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: Theme.of(context).secondaryHeaderColor,
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
                 Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.1),
                              width: 1)),
                      child: Icon(
                        Icons.notifications,
                        color: Theme.of(context).cardColor.withOpacity((0.7)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).secondaryHeaderColor,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        jobDetailController.setSelectedActive(false);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Production Details",
                          style: poppinsBold.copyWith(
                            color: jobDetailController.selected
                                ? Theme.of(context).hintColor
                                : Theme.of(context).cardColor.withOpacity(0.7),
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        jobDetailController.setSelectedActive(true);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Roles",
                          style: poppinsBold.copyWith(
                            color: jobDetailController.selected
                                ? Theme.of(context).cardColor.withOpacity(0.7)
                                : Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: jobDetailController.selected
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: jobDetailController
                                                    .jobDetails['talent']
                                                    .length >
                                                0
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: jobDetailController
                                                    .jobDetails['talent']
                                                    .length,
                                                padding: const EdgeInsets.only(
                                                    left: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {

                                                  return InviteDetails(
                                                      talentType:jobDetailController.jobDetails['talent'][index]??"",
                                                    status: jobDetailController.jobDetails['status'].toString(),
                                                    title:
                                                        '${jobDetailController.jobDetails['jobName']} ( ${jobDetailController.jobDetails['talent'][index]} )',
                                                    desc: jobDetailController
                                                        .jobDetails['jobDec'],
                                                    index: index,
                                                    timeVal: jobDetailController
                                                        .time_passed(
                                                            DateTime.parse(
                                                                jobDetailController
                                                                        .jobDetails[
                                                                    "createdAt"]),
                                                            full: false),
                                                    item: true,
                                                  );
                                                },
                                              )
                                            : Center(
                                                child: Column(
                                                  children: [
                                                  SizedBox(height: Get.height * 0.3,),
                                                    Text(
                                                    'No Roles Found',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.whiteColor),
                                              ),
                                                  ],
                                                )),
                                      ),
                                    ),
                                  ],
                                )
                              :
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:10, vertical: 5),
                                  child: Text(
                                    // "Film : Feature films",
                                    "Job Name : ${jobDetailController.jobDetails["jobName"]}",
                                    style: poppinsBold.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize:
                                      Dimensions.fontSizeDefault + 2,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:10, vertical: 5),
                                  child: Text(
                                    "Created At :  ${DateFormat('dd/mm/yyyy').format(DateTime.parse(jobDetailController.jobDetails['createdAt']))}",
                                    style: poppinsBold.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize:
                                      Dimensions.fontSizeDefault + 2,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(

                                  padding: EdgeInsets.symmetric(
                                      horizontal:5, vertical: 5),
                                  child: Row(
                                    children: [
                                      NeumorphicButton(
                                          margin: EdgeInsets.only(top: 12),
                                          onPressed: () {},
                                          style: NeumorphicStyle(
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.7),
                                              shape: NeumorphicShape.flat,
                                              boxShape: NeumorphicBoxShape
                                                  .roundRect(
                                                  BorderRadius.circular(
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
                                            jobDetailController
                                                .jobDetails['locationType'],
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
                                              boxShape: NeumorphicBoxShape
                                                  .roundRect(
                                                  BorderRadius.circular(
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
                                            jobDetailController.jobDetails[
                                            "jobType"] ??
                                                "Paid",
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
                                              boxShape: NeumorphicBoxShape
                                                  .roundRect(
                                                  BorderRadius.circular(
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
                                            jobDetailController
                                                .jobDetails['unionStatus'],
                                            style: poppinsBold.copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize:
                                              Dimensions.fontSizeSmall,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                InviteItemDetails(
                                  title: jobDetailController
                                      .jobDetails['productionType'] ??
                                      jobDetailController
                                          .jobDetails['jobName'],
                                  dec: jobDetailController
                                      .jobDetails['jobDec']
                                      .toString(),
                                ),
                                InviteItemDetails(
                                  title: jobDetailController
                                      .jobDetails['productionPersonnel'] ??
                                      jobDetailController
                                          .jobDetails['jobName'],
                                  dec: jobDetailController
                                      .jobDetails['productionDescription']
                                      .toString(),
                                ),
                                InviteItemDetails(
                                  title: jobDetailController
                                      .jobDetails['auditionTitle'],
                                  dec:jobDetailController
                                      .jobDetails['auditionInstruction']
                                      .toString(),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(jobDetailController
                                          .jobDetails['keyDatesAndLocation'],style: poppinsBold.copyWith(
                                        color: Theme.of(context).cardColor.withOpacity(0.9),
                                        fontSize: Dimensions.fontSizeDefault+5,
                                      ),textAlign: TextAlign.start,),
                                      Text(jobDetailController
                                          .jobDetails['productionCompany'],style: poppinsBold.copyWith(
                                        color: Theme.of(context).cardColor.withOpacity(0.9),
                                        fontSize: Dimensions.fontSizeDefault+5,
                                      ),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                )
                                ,
                                NeumorphicButton(
                                    margin: EdgeInsets.only(
                                        top: 12, left: 10),
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
                                      "Profession Pay: ${jobDetailController
                                          .jobDetails['rateType']}",
                                      style: poppinsBold.copyWith(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize:
                                        Dimensions.fontSizeDefault,
                                      ),
                                    )),

                                NeumorphicButton(
                                    margin: EdgeInsets.only(
                                        top: 12, left: 10),
                                    onPressed: () {

                                    },
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
                                      "${jobDetailController
                                          .jobDetails['productionWebsite']}",
                                      style: poppinsBold.copyWith(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize:
                                        Dimensions.fontSizeDefault,
                                      ),
                                    )),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/customLoadingWidget.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/filteritem.dart';
import 'package:million/view/widget/list_invites.dart';

class HomeScreen extends StatefulWidget {
  final String? appVersion;

  HomeScreen({this.appVersion});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  var jobDetailController = Get.find<JobDetailController>();
  var authController = Get.find<AuthController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // jobDetailController.getJobUserWithPaginationApi(0);
    jobDetailController.getJobFilterApi(
        0,
        jobDetailController.productTypeItem,
        jobDetailController.roleTypeItem,
        authController.compensationVal,
        authController.unionStatus);
    jobDetailController.getProductionTypeList();
    jobDetailController.getRoleTypeList();
    scrollController.addListener(_scrollController);

    super.initState();
  }

  _scrollController() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      jobDetailController.updateJobsPageBottomLoading(true);
      if (jobDetailController.jobsUsersPaginationList.isNotEmpty) {
        print(
            'CHECK --- ${jobDetailController.jobsUsersPaginationList.length}');
        await jobDetailController.incrementJobCurrentPage(1);
        // await jobDetailController.getJobUserWithPaginationApi(0);
        jobDetailController.getJobFilterApi(
            0,
            jobDetailController.productTypeItem,
            jobDetailController.roleTypeItem,
            authController.compensationVal,
            authController.unionStatus);
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        jobDetailController.updateJobsPageBottomLoading(false);
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  showFilterBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Color(0xFF171717),
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<AuthController>(
          builder: (authController) {
      return   GetBuilder<JobDetailController>(
          builder: (jobDetailController) {
            return Container(
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).cardColor,
                          fontSize: Dimensions.fontSizeExtraLarge + 1,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, setState) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  jobDetailController.clearFilters();
                                  authController.clearFilters();
                                });
                              },
                              child: Text(
                                "Clear All",
                                style: poppinsBold.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            );
                          }),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              print('check Val...');
                              print(jobDetailController.productTypeItem);
                              jobDetailController.getJobFilterApi(
                                  0,
                                  jobDetailController.productTypeItem,
                                  jobDetailController.roleTypeItem,
                                  authController.compensationVal,
                                  authController.unionStatus);
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).cardColor.withOpacity(
                                    (0.7),
                                  ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Gender",
                      isAnyText: true,
                      anyText: (authController.genderVal == "Male")
                          ? 'Male'
                          : (authController.genderVal == "Female")
                              ? 'Female'
                              : (authController.genderVal == "Other")
                                  ? authController.sigupdata["gender"].toString() ??
                                      "Other"
                                  : "Any",
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Gender",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Male");
                                                authController.setGenderVal("Male");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Male",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Female");

                                                authController
                                                    .setGenderVal("Female");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Female",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender",
                                                    "Gender-Nonconforming");
                                                authController.setGenderVal(
                                                    "Gender-Nonconforming");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Gender-Nonconforming",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Non-Binary");
                                                authController
                                                    .setGenderVal("Non-Binary");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Non-Binary",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Trans Female");
                                                authController
                                                    .setGenderVal("Trans Female");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Trans Female",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Trans Male");
                                                authController
                                                    .setGenderVal("Trans Male");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Trans Male",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Agender");
                                                authController
                                                    .setGenderVal("Agender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Agender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Androgyne");
                                                authController
                                                    .setGenderVal("Androgyne");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Androgyne",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Aporagender");
                                                authController
                                                    .setGenderVal("Aporagender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Aporagender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Autigender");
                                                authController
                                                    .setGenderVal("Autigender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Autigender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Bigrnder");
                                                authController
                                                    .setGenderVal("Bigrnder");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Bigrnder",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Cisgender");
                                                authController
                                                    .setGenderVal("Cisgender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Cisgender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Demiboy");
                                                authController
                                                    .setGenderVal("Demiboy");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Demiboy",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Demibgirl");
                                                authController
                                                    .setGenderVal("Demibgirl");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Demibgirl",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender",
                                                    "Gender Questioninng");
                                                authController.setGenderVal(
                                                    "Gender Questioninng");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Gender Questioninng",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Genderfluid");
                                                authController
                                                    .setGenderVal("Genderfluid");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Genderfluid",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Genderfluid");
                                                authController
                                                    .setGenderVal("Genderfluid");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Genderflux",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Genderqueer");
                                                authController
                                                    .setGenderVal("Genderqueer");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Genderqueer",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Maverique");
                                                authController
                                                    .setGenderVal("Maverique");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Maverique",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Neutrois");
                                                authController
                                                    .setGenderVal("Neutrois");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Neutrois",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Pangender");
                                                authController
                                                    .setGenderVal("Pangender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Pangender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Polygender");
                                                authController
                                                    .setGenderVal("Polygender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Polygender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Third Gender");
                                                authController
                                                    .setGenderVal("Third Gender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Third Gender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Trandgender");
                                                authController
                                                    .setGenderVal("Trandgender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Trandgender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Trigender");
                                                authController
                                                    .setGenderVal("Trigender");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Trigender",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.addSigupdata(
                                                    "gender", "Two-Spirit");
                                                authController
                                                    .setGenderVal("Two-Spirit");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Two-Spirit",
                                              isinner: true),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Age Range",
                      isAnyText: true,
                      anyText: authController.ageRangeList.isNotEmpty
                          ? '${authController.ageRangeList[0]}-${authController.ageRangeList[1]}'
                          : 'Any',
                      onTap: () {
                        Picker(
                            adapter: NumberPickerAdapter(data: [
                              const NumberPickerColumn(begin: 1, end: 80),
                              const NumberPickerColumn(begin: 1, end: 80),
                            ]),
                            delimiter: [
                              PickerDelimiter(
                                child: Container(
                                  width: 30.0,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.more_vert),
                                ),
                              ),
                            ],
                            hideHeader: true,
                            title: const Text("Select Age Range"),
                            onConfirm: (Picker picker, List value) {
                              setState(() {
                                if (value[0] < value[1]) {
                                  authController.setAgeRangeList(value);
                                } else {
                                  Get.back();

                                  showCustomSnackBar(
                                      'Start age must be less then the end age.',
                                      context,
                                      isError: true);
                                }
                              });
                            }).showDialog(context);
                      },
                    );
                  }),
                  FilterItem(
                    title: "Location",
                  ),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Production Type",
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Production Type",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: FilterItem(
                                              onTap: () {
                                                jobDetailController
                                                    .setProductTypeItem('');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: 'Any',
                                              isinner: true),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return FilterItem(
                                                  onTap: () {
                                                    jobDetailController
                                                        .setProductTypeItem(
                                                            jobDetailController
                                                                    .productionTypeList[
                                                                index]['title']);
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  title: jobDetailController
                                                          .productionTypeList[index]
                                                      ['title'],
                                                  isinner: true);
                                            },
                                            itemCount: jobDetailController
                                                .productionTypeList.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      anyText: jobDetailController.productTypeItem != ""
                          ? jobDetailController.productTypeItem.toString()
                          : "Any",
                      isAnyText: true,
                    );
                  }),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Compensation",
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Compensation",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          FilterItem(
                                              onTap: () {
                                                jobDetailController
                                                    .setCompensationVal("");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Any",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                jobDetailController
                                                    .setCompensationVal('Paid');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Paid",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                jobDetailController
                                                    .setCompensationVal(
                                                        'No Pay/Deferred Pay');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "No Pay/Deferred Pay",
                                              isinner: true),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                        // setState(() {
                        //   setState;
                        //   Get.back();
                        //   showCompensationDialog(context);
                        // });
                      },
                      isAnyText: true,
                      anyText: jobDetailController.compensationVal != ''
                          ? jobDetailController.compensationVal.toString()
                          : 'Any',
                    );
                  }),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Role Type",
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Role Type",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: FilterItem(
                                              onTap: () {
                                                jobDetailController
                                                    .setRoleTypeItem('');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: 'Any',
                                              isinner: true),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return FilterItem(
                                                  onTap: () {
                                                    if (jobDetailController
                                                            .roleTypeList[index] ==
                                                        "Any") {
                                                      jobDetailController
                                                          .setRoleTypeItem("");
                                                      setState(() {});
                                                      Get.back();
                                                      return;
                                                    }
                                                    jobDetailController
                                                        .setRoleTypeItem(
                                                            jobDetailController
                                                                    .roleTypeList[
                                                                index]);
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  title: jobDetailController
                                                      .roleTypeList[index],
                                                  isinner: true);
                                            },
                                            itemCount: jobDetailController
                                                .roleTypeList.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      anyText: jobDetailController.roleTypeItem != ''
                          ? jobDetailController.roleTypeItem.toString()
                          : "Any",
                      isAnyText: true,
                    );
                  }),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Union",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          FilterItem(
                                              onTap: () {
                                                authController
                                                    .setUnionStatus('Any');

                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Any",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController
                                                    .setUnionStatus('Union');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Union",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController
                                                    .setUnionStatus('Nounion');
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Nounion",
                                              isinner: true),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                        // setState(() {
                        //   setState;
                        //   Get.back();
                        //   showUnionStatusDialog(context);
                        // });
                      },
                      isAnyText: true,
                      anyText: authController.unionStatus != ''
                          ? authController.unionStatus.toString()
                          : 'Any',
                      title: "Union Status",
                    );
                  }),
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    return FilterItem(
                      title: "Ethnicities",
                      anyText: authController.ethnicalVal != ""
                          ? authController.ethnicalVal.toString()
                          : 'Any',
                      isAnyText: true,
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF171717),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Ethnicities",
                                        style: poppinsBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge + 1,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(
                                                (0.7),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 156,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          FilterItem(
                                              onTap: () {
                                                authController
                                                    .setEthnicitiesVal("Any");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Any",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Black/African Descent");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Black/African Descent",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Ethnically Ambiguous/Multiracial");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title:
                                                  "Ethnically Ambiguous/Multiracial",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Indigenous People");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Indigenous People",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Latino / Hispanic");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Latino / Hispanic",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Middle Eastern");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "Middle Eastern",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "South Asian/ Indian");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "South Asian/ Indian",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "Southeast Asian/ Pacific Islander");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title:
                                                  "Southeast Asian/ Pacific Islander",
                                              isinner: true),
                                          FilterItem(
                                              onTap: () {
                                                authController.setEthnicitiesVal(
                                                    "White/ European Descent");
                                                setState(() {});
                                                Get.back();
                                              },
                                              title: "White/ European Descent",
                                              isinner: true),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            );
          }
        );}
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(
      builder: (jobDetailController) {
        return Scaffold(
          key: _globalKey,
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 56,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.09,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getSearchScreenRought());
                              },
                              child: Hero(
                                tag: "searchScreen",
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.1),
                                          width: 1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity((0.7)),
                                      ),
                                      StatefulBuilder(builder:
                                          (BuildContext context, setState) {
                                        return GestureDetector(
                                          onTap: () {
                                            showFilterBottomSheet();
                                          },
                                          child: Icon(
                                            Icons.filter_list,
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity((0.7)),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: 1,
                                  onTap: () async {
                                    jobDetailController
                                        .setRefreshShortingType("Newest");

                                    jobDetailController.getJobFilterApi(
                                        0,
                                        jobDetailController.productTypeItem
                                            .toString()
                                            .toLowerCase(),
                                        jobDetailController.roleTypeItem,
                                        authController.compensationVal,
                                        authController.unionStatus);
                                    // await jobDetailController.getJobList();
                                  },
                                  child: Text(
                                    'Newest',
                                    style: poppinsBold,
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    jobDetailController.setRefreshShortingType(
                                        "Audition Date");
                                    jobDetailController.getJobFilterApi(
                                        0,
                                        jobDetailController.productTypeItem
                                            .toString()
                                            .toLowerCase(),
                                        jobDetailController.roleTypeItem,
                                        authController.compensationVal,
                                        authController.unionStatus);
                                    // jobDetailController
                                    //     .getJobsAuditionApi(context);
                                  },
                                  value: 2,
                                  child:
                                      Text('Audition Date', style: poppinsBold),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    jobDetailController
                                        .setRefreshShortingType("Submit ASAP");
                                    jobDetailController.getJobFilterApi(
                                        0,
                                        jobDetailController.productTypeItem
                                            .toString()
                                            .toLowerCase(),
                                        jobDetailController.roleTypeItem,
                                        authController.compensationVal,
                                        authController.unionStatus);
                                    // jobDetailController.getJobsSubmitASAPApi();
                                  },
                                  value: 3,
                                  child:
                                      Text('Submit ASAP', style: poppinsBold),
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.all(10),
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
                                  Icons.switch_access_shortcut_add_rounded,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity((0.7)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                jobDetailController.getNotification();
                                Get.toNamed(
                                    RouteHelper.getNotificarionRought());
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
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
                                  Icons.notifications,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity((0.7)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          "Find the world's Most Amazing Job",
                          style: poppinsBold.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                            fontSize: Dimensions.fontSizeExtraLarge + 10,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            jobDetailController.getJobFilterApi(
                                0,
                                jobDetailController.productTypeItem
                                    .toString()
                                    .toLowerCase(),
                                jobDetailController.roleTypeItem,
                                authController.compensationVal,
                                authController.unionStatus);
                          },
                          child: FocusDetector(
                            onVisibilityGained: () async {
                              jobDetailController.getJobFilterApi(
                                  0,
                                  jobDetailController.productTypeItem
                                      .toString()
                                      .toLowerCase(),
                                  jobDetailController.roleTypeItem,
                                  authController.compensationVal,
                                  authController.unionStatus);

                              await authController.getUserRefreshToken();
                              await authController.getUserToken();
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  jobDetailController
                                          .jobsUsersPaginationList.isNotEmpty
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                controller: scrollController,
                                                shrinkWrap: true,
                                                itemCount: jobDetailController
                                                    .jobsUsersPaginationList
                                                    .length,
                                                padding: const EdgeInsets.only(
                                                    left: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return InviteItem(
                                                    jobDetail: jobDetailController
                                                            .jobsUsersPaginationList[
                                                        index],
                                                    title: jobDetailController
                                                                .jobsUsersPaginationList[
                                                            index]["jobName"] ??
                                                        "The Hitcher Girl",
                                                    desc: jobDetailController
                                                                .jobsUsersPaginationList[
                                                            index]["jobDec"] ??
                                                        "",
                                                    jobType: jobDetailController
                                                                .jobsUsersPaginationList[
                                                            index]["jobType"] ??
                                                        "",
                                                    roles: jobDetailController
                                                                .jobsUsersPaginationList[
                                                            index]["roles"] ??
                                                        "",
                                                    startDate: jobDetailController
                                                        .time_passed(
                                                            DateTime.parse(
                                                                jobDetailController
                                                                            .jobsUsersPaginationList[
                                                                        index][
                                                                    "createdAt"]),
                                                            full: false),
                                                    linkcolor: (index + 1) %
                                                                3 ==
                                                            0
                                                        ? Colors.amber
                                                        : (index + 1) % 2 == 0
                                                            ? Colors.blue
                                                            : Colors.green,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.3,
                                              ),
                                              Center(
                                                child: Text(
                                                  'No Job Found.',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.whiteColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  jobDetailController.isJobsPageBottomLoading ==
                                          false
                                      ? const SizedBox()
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                  jobDetailController.isJobFilterLoading ==
                                          false
                                      ? const SizedBox()
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  jobDetailController.isLoading == true
                      ? Positioned(
                          top: Get.height * 0.3,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

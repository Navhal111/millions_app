import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/ApplyFormScreen.dart';
import 'package:million/view/widget/customPopupDialog.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/dropDown_widget.dart';
import 'package:million/view/widget/filteritem.dart';
import 'package:million/view/widget/page_indicator.dart';
import 'package:million/view/widget/propfile_textbox.dart';

class CreateProfile extends StatefulWidget {
  final String? appVersion;

  CreateProfile({this.appVersion});

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  int currentPage = 0;
  PageController? _controller;
  late AnimationController animationController;
  BuildContext? _context;
  var authController = Get.find<AuthController>();
  var talantIndex;

  @override
  void initState() {
    talantIndex = Get.arguments;
    _fullNameController =
        TextEditingController(text: authController.sigupdata['fullName'] ?? "");
    _emailController =
        TextEditingController(text: authController.sigupdata['email'] ?? "");
    _zipCodeController =
        TextEditingController(text: authController.sigupdata['zipCode'] ?? "");
    authController.setGenderVal(authController.sigupdata['gender']);
    _ageController =
        TextEditingController(text: authController.sigupdata['age'] ?? "");
    _phoneController = TextEditingController(
        text: authController.sigupdata['phoneNumber'] ?? "");
    _bioControlelr =
        TextEditingController(text: authController.sigupdata['bio'] ?? "");
    authController.getCountryList();
    super.initState();
    _context = context;
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.8,
    )..addListener(() {});
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conPassController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _bioControlelr = TextEditingController();

  List<dynamic> selecterArray = [];
  String SelectTypeTitle = "";

  void showCountryDropdown(
      BuildContext context, AuthController authController) {
    FocusScope.of(context).unfocus();
    if (selecterArray.length == 0) {
      showCustomSnackBar("Country not Found", context);
      return;
    }
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        builder: (context) {
          return ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        SelectTypeTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 3,
                      endIndent: 0,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                Column(
                    children: selecterArray.map((entry) {
                  print('authController.countryNameList');

                  return ListTile(
                    leading: new Icon(
                      Icons.control_point,
                      color: AppColors.primaryColor,
                    ),
                    title: new Text(
                      entry["value"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                          fontSize: 14),
                    ),
                    onTap: () {
                      print("==================");
                      print(entry);
                      print(SelectTypeTitle);
                      if (SelectTypeTitle == "Select Country") {
                        setState(() {
                          authController.sigupdata["country"] = entry["value"];
                        });
                      }

                      Navigator.pop(context);
                    },
                  );
                }).toList())
              ]);
        });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> formlist = [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _fullNameController,
          maxLines: 1,
          indexmain: "1",
          capitalization: TextCapitalization.sentences,
          hintText: 'Enter your Full Name',
          titleText: 'Full Name',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.text,
          // onChanged: (text) => {print(text)},
          onChanged: (text) => authController.addSigupdata("fullName", text),
          onSubmit: () => {},
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _emailController,
          maxLines: 1,
          indexmain: "2",
          hintText: 'Enter your Email',
          titleText: 'Email Address',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.emailAddress,
          // onChanged: (text) => {print(text)},
          onChanged: (text) => authController.addSigupdata("email", text),
          onSubmit: () => {},
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _phoneController,
          maxLines: 1,
          indexmain: "3",
          capitalization: TextCapitalization.sentences,
          hintText: 'Enter Phone Number',
          titleText: 'Phone Number',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.text,
          // onChanged: (text) => {print(text)},
          onChanged: (text) => authController.addSigupdata("phoneNumber", text),
          onSubmit: () => {},
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _ageController,
          maxLines: 1,
          indexmain: "4",
          capitalization: TextCapitalization.sentences,
          hintText: 'Age for Roles',
          titleText: 'Age for Roles',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.number,
          onChanged: (text) => {print(text)},
          onSubmit: () => {},
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: Get.width * 0.09,
                  height: Get.height * 0.042,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor),
                  child: Center(
                    child: Text(
                      '5',
                      style: poppinsBold.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    "Gender",
                    style: poppinsRegular.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    authController.addSigupdata("gender", "Male");
                    authController.setGenderVal("Male");
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xFF171717).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: authController.genderVal == "Male"
                                    ? Color(0xFFE2A21D)
                                    : AppColors.blackColor,
                                width: 0.7)),
                        child: Image.asset(Images.boy, width: 35, height: 35),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Male",
                        style: poppinsBold.copyWith(
                          color: Color(0xFFE2A21D).withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    authController.addSigupdata("gender", "Female");

                    authController.setGenderVal("Female");
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xFF171717).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: authController.genderVal == "Female"
                                    ? Color(0xFFE2A21D)
                                    : AppColors.blackColor,
                                width: 0.7)),
                        child: Image.asset(Images.girl, width: 35, height: 35),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Female",
                        style: poppinsBold.copyWith(
                          color: Color(0xFFE2A21D).withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
                InkWell(
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
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xFF171717).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: authController.genderVal == "Other"
                                    ? Color(0xFFE2A21D)
                                    : AppColors.blackColor,
                                width: 0.7)),
                        child: Image.asset(Images.boy, width: 35, height: 35),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        (authController.genderVal == "Other")
                            ? authController.sigupdata["gender"].toString() ??
                                "Other"
                            : "Other",
                        style: poppinsBold.copyWith(
                          color: Color(0xFFE2A21D).withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _zipCodeController,
          maxLines: 1,
          indexmain: "6",
          capitalization: TextCapitalization.sentences,
          hintText: 'Zip Code',
          titleText: 'Zip Code',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.number,
          onChanged: (text) => {print(text)},
          onSubmit: () => {},
        ),
      ),
      Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: Get.width * 0.09,
                height: Get.height * 0.042,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor),
                child: Center(
                  child: Text(
                    '7',
                    style: poppinsBold.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "Country",
                  style: poppinsRegular.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              SelectTypeTitle = "Select Country";
              selecterArray = authController.countryList;
              showCountryDropdown(context, authController);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: DropdownTextFiled(
                // loading: authController.isLoading,
                isEditProfile: true,
                isFlagList: false,
                isSelected: authController.sigupdata["country"] != '' &&
                        authController.sigupdata["country"] != null
                    ? true
                    : false,
                depth: true,
                hint: authController.sigupdata["country"] != '' &&
                        authController.sigupdata["country"] != null
                    ? authController.sigupdata["country"]
                    : "Select Country",
                onChanged: (email) {
                  authController.addSigupdata("country", SelectTypeTitle);

                  print(email);
                },
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ProfileTextField(
          controller: _bioControlelr,
          maxLines: 1,
          indexmain: "8",
          capitalization: TextCapitalization.sentences,
          hintText: 'Bio',
          titleText: 'Bio',
          fillColor: Color(0xFF171717).withOpacity(0.7),
          onTap: () => {},
          inputType: TextInputType.streetAddress,
          onChanged: (text) => {print(text)},
          onSubmit: () => {},
        ),
      ),
    ];
    return GetBuilder<JobDetailController>(builder: (jobDetailController) {
      return WillPopScope(
        onWillPop: () {
          return showPopUpDialog('Do You want to save as draft ?', context,
              onClickYes: ()async {
            await jobDetailController.addDraftList(talantIndex);
            Get.back();
            Get.back();
          },
              onClickNo: () {
            Get.back();
            Get.back();
          });

        },
        child: Scaffold(
          key: _globalKey,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          "Create Profile",
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
                  height: 50,
                ),
                Container(
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 300,
                            child: PageView.builder(
                              itemCount: formlist.length,
                              onPageChanged: (index) {
                                setState(() {
                                  print(currentPage);
                                  currentPage = index;
                                });
                              },
                              scrollDirection: Axis.vertical,
                              controller: _controller,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnimatedBuilder(
                                    animation: _controller!,
                                    builder: (context, _) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        height:
                                            MediaQuery.of(context).size.height -
                                                150,
                                        child: Column(
                                          children: [
                                            AnimatedOpacity(
                                              opacity: index == currentPage
                                                  ? 1
                                                  : 0.5,
                                              duration:
                                                  Duration(microseconds: 500),
                                              child: index == 9
                                                  ? Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 30,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFE2A21D),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "3",
                                                                    style: poppinsBold
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  "Gender",
                                                                  style: poppinsRegular
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        Dimensions.fontSizeDefault +
                                                                            2,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  authController
                                                                      .addSigupdata(
                                                                          "gender",
                                                                          "Male");
                                                                  authController
                                                                      .setGenderVal(
                                                                          "Male");
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFF171717).withOpacity(
                                                                              0.7),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border: Border.all(
                                                                              color: authController.genderVal == "Male" ? Color(0xFFE2A21D) : AppColors.blackColor,
                                                                              width: 0.7)),
                                                                      child: Image.asset(
                                                                          Images
                                                                              .boy,
                                                                          width:
                                                                              35,
                                                                          height:
                                                                              35),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "Male",
                                                                      style: poppinsBold
                                                                          .copyWith(
                                                                        color: Color(0xFFE2A21D)
                                                                            .withOpacity(0.7),
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  authController
                                                                      .addSigupdata(
                                                                          "gender",
                                                                          "Female");

                                                                  authController
                                                                      .setGenderVal(
                                                                          "Female");
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFF171717).withOpacity(
                                                                              0.7),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border: Border.all(
                                                                              color: authController.genderVal == "Female" ? Color(0xFFE2A21D) : AppColors.blackColor,
                                                                              width: 0.7)),
                                                                      child: Image.asset(
                                                                          Images
                                                                              .girl,
                                                                          width:
                                                                              35,
                                                                          height:
                                                                              35),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "Female",
                                                                      style: poppinsBold
                                                                          .copyWith(
                                                                        color: Color(0xFFE2A21D)
                                                                            .withOpacity(0.7),
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                    ),
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFF171717),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                        height: MediaQuery.of(context).size.height -
                                                                            100,
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                15),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "Select Gender",
                                                                                  style: poppinsBold.copyWith(
                                                                                    color: Theme.of(context).cardColor,
                                                                                    fontSize: Dimensions.fontSizeExtraLarge + 1,
                                                                                  ),
                                                                                  textAlign: TextAlign.start,
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
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
                                                                            ),
                                                                            SizedBox(
                                                                              height: MediaQuery.of(context).size.height - 156,
                                                                              child: SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: [
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Gender-Nonconforming");
                                                                                          authController.setGenderVal("Gender-Nonconforming");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Gender-Nonconforming",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Non-Binary");
                                                                                          authController.setGenderVal("Non-Binary");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Non-Binary",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Trans Female");
                                                                                          authController.setGenderVal("Trans Female");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Trans Female",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Trans Male");
                                                                                          authController.setGenderVal("Trans Male");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Trans Male",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Agender");
                                                                                          authController.setGenderVal("Agender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Agender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Androgyne");
                                                                                          authController.setGenderVal("Androgyne");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Androgyne",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Aporagender");
                                                                                          authController.setGenderVal("Aporagender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Aporagender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Autigender");
                                                                                          authController.setGenderVal("Autigender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Autigender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Bigrnder");
                                                                                          authController.setGenderVal("Bigrnder");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Bigrnder",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Cisgender");
                                                                                          authController.setGenderVal("Cisgender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Cisgender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Demiboy");
                                                                                          authController.setGenderVal("Demiboy");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Demiboy",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Demibgirl");
                                                                                          authController.setGenderVal("Demibgirl");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Demibgirl",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Gender Questioninng");
                                                                                          authController.setGenderVal("Gender Questioninng");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Gender Questioninng",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Genderfluid");
                                                                                          authController.setGenderVal("Genderfluid");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Genderfluid",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Genderflux");
                                                                                          authController.setGenderVal("Genderflux");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Genderflux",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Genderqueer");
                                                                                          authController.setGenderVal("Genderqueer");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Genderqueer",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Maverique");
                                                                                          authController.setGenderVal("Maverique");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Maverique",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Neutrois");
                                                                                          authController.setGenderVal("Neutrois");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Neutrois",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Pangender");
                                                                                          authController.setGenderVal("Pangender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Pangender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Polygender");
                                                                                          authController.setGenderVal("Polygender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Polygender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Third Gender");
                                                                                          authController.setGenderVal("Third Gender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Third Gender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Trandgender");
                                                                                          authController.setGenderVal("Trandgender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Trandgender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Trigender");
                                                                                          authController.setGenderVal("Trigender");
                                                                                          Get.back();
                                                                                        },
                                                                                        title: "Trigender",
                                                                                        isinner: true),
                                                                                    FilterItem(
                                                                                        onTap: () {
                                                                                          authController.addSigupdata("gender", "Two-Spirit");
                                                                                          authController.setGenderVal("Two-Spirit");
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
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFF171717).withOpacity(
                                                                              0.7),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border: Border.all(
                                                                              color: Color(0xFFE2A21D),
                                                                              width: 0.7)),
                                                                      child: Image.asset(
                                                                          Images
                                                                              .boy,
                                                                          width:
                                                                              35,
                                                                          height:
                                                                              35),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "Other",
                                                                      style: poppinsBold
                                                                          .copyWith(
                                                                        color: Color(0xFFE2A21D)
                                                                            .withOpacity(0.7),
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : formlist[index],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _controller!.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).hintColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        print('---------initialPage--------------');

                        if (_controller?.page == 7.0) {
                          // print('Sign--------------------');
                          // print(talantIndex);
                          // print(jobDetailController.jobTalentVal);
                          jobDetailController.setTalentType(jobDetailController.talenttype);
                          Get.to(AppLyFormScreen(),
                              arguments: jobDetailController.jobTalentVal);
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward_sharp,
                            color: Theme.of(context).hintColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: PageIndicator(
                    type: IndicatorType.CIRCLE,
                    currentIndex: currentPage,
                    activeDotColor: Theme.of(context).cardColor,
                    inactiveDotColor: Theme.of(context).disabledColor,
                    pageCount: formlist.length+1,
                    onTap: () {
                      _controller!.animateTo(
                        _controller!.page!,
                        duration: Duration(
                          milliseconds: 400,
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

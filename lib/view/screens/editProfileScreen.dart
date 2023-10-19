import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/dropDown_widget.dart';
import 'package:million/view/widget/filteritem.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:million/view/widget/my_text_field.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController F_nameController = TextEditingController();
  TextEditingController P_TypeController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  var authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.getUserDetails();
    authController.setGenderVal(authController.sigupdata["gender"]);
    authController.getCountryList();
    F_nameController =
        TextEditingController(text: authController.sigupdata['fullName'] ?? '');

    P_TypeController = TextEditingController(
        text: authController.sigupdata['profileType'] ?? '');
    EmailController =
        TextEditingController(text: authController.sigupdata['email'] ?? '');
    PhoneController = TextEditingController(
        text: authController.sigupdata['phoneNumber'] ?? '');
    ageController =
        TextEditingController(text: authController.sigupdata['age'] ?? '');
    _zipCodeController =
        TextEditingController(text: authController.sigupdata['zipCode'] ?? '');
    _bioController =
        TextEditingController(text: authController.sigupdata['bio'] ?? '');
  }

  List<dynamic> selecterArray = [];
  String SelectTypeTitle = "";

  bool load = false;
  String imageData = "";

  @override
  void dispose() {
    super.dispose();
  }

  void _userUpdate(AuthController authController) async {
    print('authController.sigupdata["gender"]');
    print(authController.sigupdata["gender"]);
    if (authController.sigupdata["profilePic"] == null) {
      showCustomSnackBar('Please select your profile picture.', context);
    } else if (F_nameController.text.isEmpty) {
      showCustomSnackBar('Please enter your name.', context);
      return;
    } else if (EmailController.text.isEmpty) {
      showCustomSnackBar('Please enter your email address.', context);
      return;
    } else if (PhoneController.text.isEmpty) {
      showCustomSnackBar('Please enter your Phone number', context);
      return;
    } else if (ageController.text.isEmpty) {
      showCustomSnackBar('Please enter your age.', context);
      return;
    } else if (authController.sigupdata["gender"] == "") {
      showCustomSnackBar('Please select your gender.', context);
    } else if (authController.sigupdata["skills"] == "") {
      showCustomSnackBar('Please Enter Your Skills', context);
    } else if (_zipCodeController.text.isEmpty) {
      showCustomSnackBar('Please enter your zip code.', context);
      return;
    }
    /*else if (authController.sigupdata["fullName"] == null) {
      showCustomSnackBar('Enter your First Name', context);
    } else if (authController.sigupdata["phoneNumber"] == null) {
      showCustomSnackBar('Enter phoneNumber', context);
    }*/
    else if (authController.sigupdata["country"] == null) {
      showCustomSnackBar('Please select country.', context);
    } else if (_bioController.text.isEmpty) {
      showCustomSnackBar('Please enter your bio.', context);
    } else {
      authController
          .userUpdate(
              authController.sigupdata['profilePic'],
              authController.sigupdata['fullName'],
              authController.sigupdata['country'],
              PhoneController.text,
              authController.sigupdata['gender'],
              ageController.text,
              _zipCodeController.text,
              _bioController.text,
              authController.sigupdata['private'],
              authController.sigupdata['skills'])
          .then((status) {
        if (status.isSuccess) {
          authController.saveUserUpdate(
              authController.sigupdata['profilePic'],
              authController.sigupdata['fullName'],
              authController.sigupdata['country'],
              PhoneController.text,
              authController.sigupdata['gender'],
              ageController.text,
              _zipCodeController.text,
              _bioController.text,
              authController.sigupdata['private'],
              authController.sigupdata['skills']);
          showCustomSnackBar('Profile Updated', context, isError: false);
          print('UPDATE===========');
          Get.back();

          String _token = status.message.substring(1, status.message.length);
          debugPrint(_token);
        } else {
          debugPrint('message: ');
          print(status.message);
          showCustomSnackBar(status.message, context);
        }
      });
    }
  }

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
        backgroundColor: AppColors.blackColor,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Text(
                            SelectTypeTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 18),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
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

  String? tags = '';
  TextEditingController _skillController = TextEditingController();

  void showAddSkillDialog(AuthController authController, skillIndex) {
    print(authController.sigupdata['skills']);

    if (skillIndex != -1) {
      setState(() => _skillController.text =
          authController.sigupdata['skills'][skillIndex]!);
    } else {
      setState(() => _skillController.text = "");
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.all(30),
        backgroundColor: AppColors.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(width: 2, color: AppColors.blackColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Text(
                        'Write Skills',
                        textAlign: TextAlign.start,
                        style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  height: 1.5,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),

                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.1),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    style: poppinsRegular.copyWith(
                        fontSize: 14, color: Theme.of(context).hintColor),
                    controller: _skillController,
                    decoration: InputDecoration(
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text('Add Skill'),
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: AppColors.primaryColor)),
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_skillController.text == "") {
                          Get.back();
                          return;
                        }
                        if (skillIndex == -1) {
                          authController.setAddSkillList(_skillController.text);
                        } else {
                          authController.replaceValue(
                              _skillController.text, skillIndex);
                        }
                        Get.back();
                        _skillController.clear();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        width: Get.width * 0.3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                            colors: [Color(0xFFB216D7), Color(0xFFCE2EA1)],
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: Text(
                          skillIndex == -1 ? "Add" : 'Update',
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    skillIndex != -1
                        ? InkWell(
                            onTap: () {
                              print('call======================');
                              authController.removeSkillFromList(skillIndex);
                              Get.back();
                              _skillController.clear();
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: FractionalOffset.centerLeft,
                                  end: FractionalOffset.centerRight,
                                  colors: [
                                    Color(0xFFB216D7),
                                    Color(0xFFCE2EA1)
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Text(
                                'Remove',
                                textAlign: TextAlign.center,
                                style: poppinsMedium.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await authController.getUserDetails();
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              38,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    9),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .disabledColor
                                                    .withOpacity(0.1),
                                                width: 1)),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Theme.of(context)
                                                .disabledColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        "Edit Profile",
                                        style: poppinsRegular.copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.7),
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // showAddPostDialog(context,
                                          //     authController, 'profilePic');
                                          showBottomSheetImageTypePostDialog(
                                              context,
                                              authController,
                                              'profilePic');
                                        },
                                        child: Stack(
                                          children: [
                                            (authController.sigupdata[
                                                        'profilePic'] !=
                                                    null)
                                                ? Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 30),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        child: ImageCard(
                                                          imagePath: AppConstants
                                                                  .IMAGE_BASE_URL +
                                                              authController
                                                                      .sigupdata[
                                                                  'profilePic'],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    Images.avtar,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                  ),
                                            Positioned(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Theme.of(context)
                                                      .cardColor
                                                      .withOpacity((0.7)),
                                                ),
                                                bottom: 0,
                                                left: 30)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  controller: F_nameController,
                                  maxLines: 1,
                                  capitalization: TextCapitalization.sentences,
                                  hintText: 'Enter your Name',
                                  titleText: 'Name',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.text,
                                  onChanged: (text) => authController
                                      .addSigupdata("fullName", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  isReadOnly: true,
                                  controller: EmailController,
                                  maxLines: 1,
                                  hintText: 'Enter your Email',
                                  titleText: 'Email',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.emailAddress,
                                  onChanged: (text) => authController
                                      .addSigupdata("email", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  controller: PhoneController,
                                  maxLines: 1,
                                  capitalization: TextCapitalization.sentences,
                                  hintText: 'Enter Phone Number',
                                  titleText: 'Phone',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.phone,
                                  onChanged: (text) => authController
                                      .addSigupdata("phoneNumber", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  controller: ageController,
                                  maxLines: 1,
                                  capitalization: TextCapitalization.sentences,
                                  hintText: 'Age for Roles',
                                  titleText: 'Age',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.number,
                                  onChanged: (text) =>
                                      authController.addSigupdata("age", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Text(
                                            "Gender",
                                            style: poppinsRegular.copyWith(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FocusDetector(
                                      onVisibilityGained: () async {
                                        print(
                                            'authController.sigupdata["gender"]');
                                        print(
                                            authController.sigupdata["gender"]);
                                        await authController.setGenderVal(
                                            authController.sigupdata["gender"]);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              authController.addSigupdata(
                                                  "gender", "Male");
                                              authController
                                                  .setGenderVal("Male");
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF171717)
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: authController
                                                                      .genderVal ==
                                                                  "Male"
                                                              ? Color(
                                                                  0xFFE2A21D)
                                                              : AppColors
                                                                  .blackColor,
                                                          width: 0.7)),
                                                  child: Image.asset(Images.boy,
                                                      width: 35, height: 35),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Male",
                                                  style: poppinsBold.copyWith(
                                                    color: Color(0xFFE2A21D)
                                                        .withOpacity(0.7),
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              authController.addSigupdata(
                                                  "gender", "Female");

                                              authController
                                                  .setGenderVal("Female");
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF171717)
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: authController
                                                                      .genderVal ==
                                                                  "Female"
                                                              ? Color(
                                                                  0xFFE2A21D)
                                                              : AppColors
                                                                  .blackColor,
                                                          width: 0.7)),
                                                  child: Image.asset(
                                                      Images.girl,
                                                      width: 35,
                                                      height: 35),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Female",
                                                  style: poppinsBold.copyWith(
                                                    color: Color(0xFFE2A21D)
                                                        .withOpacity(0.7),
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                backgroundColor:
                                                    Color(0xFF171717),
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            100,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Select Gender",
                                                              style: poppinsBold
                                                                  .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                fontSize: Dimensions
                                                                        .fontSizeExtraLarge +
                                                                    1,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor
                                                                    .withOpacity(
                                                                      (0.7),
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height -
                                                              156,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Gender-Nonconforming");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Gender-Nonconforming");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Gender-Nonconforming",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Non-Binary");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Non-Binary");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Non-Binary",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Trans Female");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Trans Female");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Trans Female",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Trans Male");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Trans Male");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Trans Male",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Agender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Agender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Agender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Androgyne");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Androgyne");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Androgyne",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Aporagender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Aporagender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Aporagender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Autigender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Autigender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Autigender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Bigrnder");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Bigrnder");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Bigrnder",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Cisgender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Cisgender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Cisgender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Demiboy");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Demiboy");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Demiboy",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Demibgirl");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Demibgirl");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Demibgirl",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Gender Questioninng");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Gender Questioninng");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Gender Questioninng",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Genderfluid");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Genderfluid");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Genderfluid",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Genderfluid");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Genderfluid");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Genderflux",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Genderqueer");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Genderqueer");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Genderqueer",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Maverique");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Maverique");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Maverique",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Neutrois");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Neutrois");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Neutrois",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Pangender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Pangender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Pangender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Polygender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Polygender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Polygender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Third Gender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Third Gender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Third Gender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Trandgender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Trandgender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Trandgender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Trigender");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Trigender");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Trigender",
                                                                    isinner:
                                                                        true),
                                                                FilterItem(
                                                                    onTap: () {
                                                                      authController.addSigupdata(
                                                                          "gender",
                                                                          "Two-Spirit");
                                                                      authController
                                                                          .setGenderVal(
                                                                              "Two-Spirit");
                                                                      Get.back();
                                                                    },
                                                                    title:
                                                                        "Two-Spirit",
                                                                    isinner:
                                                                        true),
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
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF171717)
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: authController
                                                                      .genderVal ==
                                                                  "Other"
                                                              ? Color(
                                                                  0xFFE2A21D)
                                                              : AppColors
                                                                  .blackColor,
                                                          width: 0.7)),
                                                  child: Image.asset(Images.boy,
                                                      width: 35, height: 35),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  (authController.genderVal ==
                                                          "Other")
                                                      ? authController
                                                          .sigupdata["gender"]
                                                          .toString()
                                                      : "Other",
                                                  style: poppinsBold.copyWith(
                                                    color: Color(0xFFE2A21D)
                                                        .withOpacity(0.7),
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  controller: _zipCodeController,
                                  maxLines: 1,
                                  capitalization: TextCapitalization.sentences,
                                  hintText: 'Zip Code',
                                  titleText: 'Zip Code',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.number,
                                  onChanged: (text) => authController
                                      .addSigupdata("zipCode", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: const Text(
                                    'Country',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
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
                                    isSelected:
                                        authController.sigupdata["country"] !=
                                                    '' &&
                                                authController
                                                        .sigupdata["country"] !=
                                                    null
                                            ? true
                                            : false,
                                    depth: true,
                                    hint: authController.sigupdata["country"] !=
                                                '' &&
                                            authController
                                                    .sigupdata["country"] !=
                                                null
                                        ? authController.sigupdata["country"]
                                        : "Select Country",
                                    onChanged: (email) {
                                      authController.addSigupdata(
                                          "country", SelectTypeTitle);

                                      print(email);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: MyTextField(
                                  controller: _bioController,
                                  maxLines: 1,
                                  capitalization: TextCapitalization.sentences,
                                  hintText: 'Bio',
                                  titleText: 'Bio',
                                  fillColor: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  onTap: () => {},
                                  inputType: TextInputType.text,
                                  onChanged: (text) =>
                                      authController.addSigupdata("bio", text),
                                  onSubmit: () => {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Private Profile",
                                      textAlign: TextAlign.center,
                                      style: poppinsRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      // overrides the default green color of the track
                                      activeColor: Colors.pink.shade200,
                                      // color of the round icon, which moves from right to left
                                      thumbColor: Color(0xFFCE2EA1),
                                      // when the switch is off
                                      trackColor: Colors.grey,
                                      // boolean variable value
                                      value: authController.sigupdata["private"]
                                                  .toString() !=
                                              "true"
                                          ? false
                                          : true,
                                      // changes the state of the switch
                                      onChanged: (value) => {
                                        print(authController
                                            .sigupdata["private"]),
                                        authController.addSigupdata(
                                            "private", value.toString())
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showAddSkillDialog(authController, -1);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 110,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: FractionalOffset.centerLeft,
                                            end: FractionalOffset.centerRight,
                                            colors: [
                                              Color(0xFFB216D7),
                                              Color(0xFFCE2EA1)
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+ Add Skills',
                                            style: TextStyle(
                                                color: AppColors.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    authController.sigupdata['skills'] == null
                                        ? const SizedBox()
                                        : Container(
                                            width: Get.width * 0.52,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.topLeft,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              physics: ScrollPhysics(),
                                              child: Row(
                                                children: List.generate(
                                                    authController
                                                        .sigupdata['skills']
                                                        .length, (index) {
                                                  return Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showAddSkillDialog(
                                                              authController,
                                                              index);
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .whiteColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Center(
                                                            child: Text(
                                                              '${authController.sigupdata['skills'][index]}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                color: AppColors
                                                                    .whiteColor,
                                                                fontSize: Dimensions
                                                                    .fontSizeDefault,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 2,
                                                        right: 8,
                                                        child: InkWell(
                                                          onTap: () {
                                                            authController
                                                                .removeSkillFromList(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                15,
                                                              ),
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                loading: authController.isLoading,
                                onPressed: () {
                                  _userUpdate(authController);
                                },
                                buttonText: "Update",
                                fontSize: Dimensions.fontSizeLarge,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 40, bottom: 10),
                                radius: Dimensions.RADIUS_SMALL,
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
      },
    );
  }
}

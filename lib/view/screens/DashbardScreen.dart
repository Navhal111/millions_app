import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/app_notification.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/main.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/ChatScreen.dart';
import 'package:million/view/screens/ProfileScreen.dart';
import 'package:million/view/screens/SubmitionTab.dart';
import 'package:million/view/screens/callingScreen.dart';
import 'package:million/view/widget/bottom_nav_item.dart';
import 'package:million/view/widget/customPopupDialog.dart';
import 'package:million/view/widget/filteritem.dart';

import 'HomeScreen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  var authController = Get.find<AuthController>();
  var jobDetailController = Get.find<JobDetailController>();

  @override
  void initState() {
    AppNotificationHandler.getInitialMsg();

    notificationTokenApi(authController);

    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      ChatScreen(),
      SubmisionTab(),
      ProfileScreen(),
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }

// for picking up image from gallery
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

// for displaying snackbars
  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void notificationTokenApi(AuthController authController) async {
    var token = await AppNotificationHandler.getFcmToken();
    authController.fcmTokenUpdate(token);
    print('token>>>>>>....$token');
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      if (_pageIndex != 0) {
        _setPage(0);
        return false;
      } else {
        if (_canExit) {
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Back Press Again To Exit',
                style: TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).errorColor,
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          ));
          _canExit = true;
          Timer(Duration(seconds: 2), () {
            _canExit = false;
          });
          return false;
        }
      }
    }, child: GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).primaryColor,
            bottomNavigationBar: BottomAppBar(
              elevation: 5,
              notchMargin: 5,
              clipBehavior: Clip.antiAlias,
              shape: CircularNotchedRectangle(),
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Row(children: [
                  BottomNavItem(
                    iconData: Images.auddtion,
                    isSelected: _pageIndex == 0,
                    onTap: () => _setPage(0),
                    title: "Auditions",
                  ),
                  BottomNavItem(
                      iconData: Images.chat,
                      isSelected: _pageIndex == 1,
                      onTap: () => _setPage(1),
                      title: "Chat"),
                  // BottomNavItem(iconData: Images.profiles, isSelected: true, onTap: () => {}, title: ""),
                  BottomNavItem(
                    iconData: Images.submitions,
                    isSelected: _pageIndex == 2,
                    onTap: () => _setPage(2),
                    title: "Submissions",
                  ),
                  BottomNavItem(
                    iconData: Images.profiles,
                    isSelected: _pageIndex == 3,
                    onTap: () {
                      _setPage(3);
                    },
                    title: "Profile",
                  ),
                ]),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _screens.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _screens[index];
                    },
                  ),
                ),
                Positioned(
                  top: Get.height * 0.08,
                  left: Get.width * 0.02,
                  child: Container(
                    child: InkWell(
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
                              height: MediaQuery.of(context).size.height / 2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Options",
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
                                  FilterItem(
                                    title: "Edit Profile",
                                    isinner: true,
                                    onTap: () {
                                      Get.back();

                                      Get.toNamed(RouteHelper.getEditScreen());
                                    },
                                  ),
                                  FilterItem(title: "Policy", isinner: true),
                                  FilterItem(
                                      title: "Terms and Conditions",
                                      isinner: true),
                                  FilterItem(title: "Reset Password", isinner: true,onTap: (){
                                    print('reset password');
                                    Get.back();
                                    Get.toNamed(RouteHelper.getResetPassword());
                                  }),
                                  FilterItem(
                                      isLogout:
                                          (authController.sigupdata["_id"] !=
                                                  null)
                                              ? true
                                              : false,
                                      title: (authController.sigupdata["_id"] !=
                                              null)
                                          ? "Logout"
                                          : " Login",
                                      isinner: true,
                                      onTap: () async {
                                        print('bhbvhjdvbfhjfdvb');
                                        if (authController.sigupdata["_id"] !=
                                            null) {
                                          showPopUpDialog('Do you want to Logout?',context,onClickNo: (){
                                            Get.back();
                                          },onClickYes: ()async{
                                            await authController
                                                .clearSharedData();
                                            authController.clearsigupdata();
                                            await authController.isLoading ==
                                                false;
                                            authController
                                                .sigupdata["profileType"] = null;
                                            print(
                                                'calll logout====================');

                                            Get.offNamed(
                                                RouteHelper.getLoginRoute(
                                                    AppConstants.APP_VERSION));
                                          });

                                        } else {

                                          Get.offNamed(
                                              RouteHelper.getLoginRoute(
                                                  AppConstants.APP_VERSION));
                                        }
                                      }),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
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
                          Icons.menu,
                          color: Theme.of(context).cardColor.withOpacity((0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    ));
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}

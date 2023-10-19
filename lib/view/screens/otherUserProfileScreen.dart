import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/profile_followers.dart';
import 'package:million/view/widget/CutomebuttonProfile.dart';
import 'package:million/view/widget/ImagePost.dart';
import 'package:million/view/widget/VideoPost.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TabController? tabController;
  int _currentIndex = 0;
  var jobDetailController = Get.find<JobDetailController>();
  var authController = Get.find<AuthController>();

  var followUserId = Get.arguments;

  @override
  void initState() {
    super.initState();

    followUserId = Get.arguments;
    print(followUserId);

    tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    tabController?.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GetBuilder<JobDetailController>(builder: (jobDetailController) {
          return GetBuilder<AuthController>(
            builder: (authController) {
              return FocusDetector(
                onVisibilityGained: () async {},
                child: Column(
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          authController.FollowOtherApi(
                              authController.otherUserDetails['_id']);
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
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
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      'Profile',
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
                              SizedBox(
                                height: Get.height * 0.00,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: authController
                                          .otherUserDetails["fullName"],
                                      child: Card(
                                        color: AppColors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            // showAddPostDialog(context,
                                            //     authController, 'profilePic');
                                          },
                                          child: (authController
                                                          .otherUserDetails[
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
                                                      child: ImageCard(
                                                        imagePath: AppConstants
                                                                .IMAGE_BASE_URL +
                                                            authController
                                                                    .otherUserDetails[
                                                                'profilePic'],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  child: Image.asset(
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
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Hero(
                                      tag: authController
                                          .otherUserDetails["email"],
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            authController.otherUserDetails[
                                                        'fullName'] !=
                                                    null
                                                ? Text(
                                                    '${authController.otherUserDetails['fullName'].toString().capitalize}',
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  )
                                                : Text(
                                                    '-',
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                authController.otherUserDetails[
                                                            'fullName'] !=
                                                        null
                                                    ? FocusDetector(
                                                        onVisibilityGained:
                                                            () async {},
                                                        child:
                                                            CustomButtonPrfoile(
                                                          loading:
                                                              authController
                                                                  .isLoading,
                                                          onPressed: () {
                                                            print(
                                                                'val loading .. ${authController.isLoading}');
                                                            if (authController
                                                                        .getfollowerDetail[
                                                                    "following"] ==
                                                                0) {
                                                              authController.userFollowerApi(
                                                                  authController
                                                                          .otherUserDetails[
                                                                      '_id']);
                                                            } else {
                                                              authController.unFollowUserApi(
                                                                  authController
                                                                          .otherUserDetails[
                                                                      '_id']);
                                                            }
                                                          },
                                                          buttonText: authController
                                                                          .getfollowerDetail[
                                                                      "following"] ==
                                                                  0
                                                              ? "+ Follow"
                                                              : "Unfollow",
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          height: 35,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(),
                                                          radius: Dimensions
                                                              .RADIUS_SMALL,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                if (authController
                                                            .getfollowerDetail[
                                                        "following"] !=
                                                    0)
                                                  InkWell(
                                                    onTap: () async {
                                                      print('Send is CALL');
                                                      print(authController
                                                          .otherUserDetails);

                                                      await authController
                                                          .replaceReciverId(
                                                              authController
                                                                      .otherUserDetails[
                                                                  '_id']);
                                                      await authController.replaceReciverUserProfilePic(authController
                                                                      .otherUserDetails[
                                                                  'profilePic'] !=
                                                              null
                                                          ? AppConstants
                                                                  .IMAGE_BASE_URL +
                                                              authController
                                                                      .otherUserDetails[
                                                                  'profilePic']
                                                          : "");
                                                      await authController
                                                          .replaceReciverUserPhoneNumber(
                                                              authController
                                                                          .otherUserDetails[
                                                                      'phoneNumber'] ??
                                                                  "");
                                                      await authController
                                                          .replaceReciverUserName(
                                                              authController
                                                                          .otherUserDetails[
                                                                      'fullName'] ??
                                                                  "");
                                                      await authController
                                                          .replaceReceiverFCMToken(
                                                              authController
                                                                          .otherUserDetails[
                                                                      'fcmToken'] ??
                                                                  "");
                                                      Get.toNamed(RouteHelper
                                                          .getChatScreenRought(
                                                              '${authController.otherUserDetails['fullName'].toString().capitalize}',
                                                              authController
                                                                  .otherUserDetails[
                                                                      '_id']
                                                                  .toString(),
                                                              authController
                                                                      .otherUserDetails[
                                                                  '_id']));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              FractionalOffset
                                                                  .centerLeft,
                                                          end: FractionalOffset
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xFFB216D7),
                                                            Color(0xFFCE2EA1)
                                                          ],
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 10),
                                                      margin: EdgeInsets.all(0),
                                                      child: const Icon(
                                                        Icons.send,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              (authController.otherUserDetails['private'] ==
                                          "true" &&
                                      jobDetailController.checkPrivateUser ==
                                          false)
                                  ? Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.1,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30),
                                            child: Text(
                                              'This user is private',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        authController
                                                    .otherUserDetails['bio'] !=
                                                null
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5),
                                                child: Text(
                                                  authController
                                                          .otherUserDetails[
                                                              'bio']
                                                          .toString()
                                                          .capitalize ??
                                                      "",
                                                  style: poppinsBold.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              )
                                            : const SizedBox(),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 2,
                                                //                   <--- border width here
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.6)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  print('followUserId');
                                                  print(followUserId);
                                                  authController
                                                      .setFollowUserID(
                                                          followUserId);
                                                  Get.to(
                                                      () => ProfileFollowers(
                                                            isFollowers: true,
                                                          ),
                                                      arguments: followUserId);
                                                },
                                                child: Container(
                                                  // height: Get.height * 0.075,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        authController
                                                                .otherFollwe
                                                                .length
                                                                .toString() ??
                                                            "999",
                                                        style: poppinsBold
                                                            .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontSize: Dimensions
                                                                  .fontSizeExtraLarge +
                                                              8,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      Text(
                                                        "Following",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontSize: Dimensions
                                                              .fontSizeExtraLarge,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 3,
                                                height: 40,
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.7),
                                              ),
                                              InkWell(
                                                onTap: () async {

                                                  authController
                                                      .setFollowUserID(
                                                          followUserId);
                                                  Get.to(
                                                          () => ProfileFollowers(
                                                        isFollowers: false,followUSerID: followUserId,
                                                      ),
                                                      arguments: followUserId);

                                                },
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        authController
                                                                .otherFollowing
                                                                .length
                                                                .toString() ??
                                                            "65",
                                                        style: poppinsBold
                                                            .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontSize: Dimensions
                                                                  .fontSizeExtraLarge +
                                                              8,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      Text(
                                                        "Followers",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontSize: Dimensions
                                                              .fontSizeExtraLarge,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TabBar(
                                          controller: tabController,
                                          indicatorColor:
                                              Theme.of(context).cardColor,
                                          labelColor:
                                              Theme.of(context).cardColor,
                                          unselectedLabelColor: Colors.grey,
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          labelStyle: poppinsRegular.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                          tabs: [
                                            // Tab(
                                              // icon: Image.asset(
                                              //   Images.image,
                                              //   height: 25,
                                              //   width: MediaQuery.of(context)
                                              //       .size
                                              //       .width,
                                              //   color: _currentIndex == 0
                                              //       ? Theme.of(context)
                                              //           .cardColor
                                              //       : Theme.of(context)
                                              //           .disabledColor,
                                              // ),
                                            // ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Images.image,
                                                  height:50,
                                                  width: 25,
                                                  color: _currentIndex == 0
                                                      ? Theme.of(context)
                                                      .cardColor
                                                      : Theme.of(context)
                                                      .disabledColor,
                                                ),
                                                jobDetailController.otherPostList.isNotEmpty? Text(
                                                    '  ( ${jobDetailController.otherPostList.length} )'):SizedBox(),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Images.video,
                                                  height:50,
                                                  width: 25,
                                                  color: _currentIndex == 1
                                                      ? Theme.of(context)
                                                      .cardColor
                                                      : Theme.of(context)
                                                      .disabledColor,
                                                ),
                                                jobDetailController.otherPostVideoList.isNotEmpty?Text(
                                                    '  ( ${jobDetailController.otherPostVideoList.length} )'):SizedBox(),
                                              ],
                                            ),

                                            /*Tab(
                                              icon: Image.asset(
                                                Images.video,
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: _currentIndex == 1
                                                    ? Theme.of(context)
                                                        .cardColor
                                                    : Theme.of(context)
                                                        .disabledColor,
                                              ),
                                            ),*/
                                          ],
                                        ),
                                        Container(
                                          height: 420,
                                          child: TabBarView(
                                            controller: tabController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                  Expanded(
                                                    child: MyHomePage(
                                                      isOtherUserImagePostScreen:
                                                          true,
                                                      title: 'image post',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                  Expanded(
                                                    child: VideoPost(
                                                        isOtherUserVideoPostScreen:
                                                            true,
                                                        title: 'video post'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

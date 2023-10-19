import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/profile_followers.dart';
import 'package:million/view/widget/ImagePost.dart';
import 'package:million/view/widget/VideoPost.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';

class ProfileScreen extends StatefulWidget {
  final String? appVersion;

  ProfileScreen({this.appVersion});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late TabController tabController;
  int _currentIndex = 0;
  var jobDetailController = Get.find<JobDetailController>();
  var authController = Get.find<AuthController>();

  @override
  void initState() {
    print('IT snow----------------');
    super.initState();
    jobDetailController.getPostListVideo();

    tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = tabController.index;
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

  showCreateProfileDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.9),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Theme.of(context).secondaryHeaderColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.account,
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                  color: Theme.of(context).disabledColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Create New Profile",
                  style: poppinsBold.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Casting 'The Hitcher girl' Appersing from nowehere... A mysterious girl with the name of the hebrew demon,lili,hitchhiking",
                  style: poppinsRegular.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.7),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                          "Cancel",
                          style: poppinsBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        Get.toNamed(RouteHelper.getCreateProfileRought());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                          "Create Profile",
                          style: poppinsBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
              return Stack(
                children: [
                  FocusDetector(
                    onVisibilityGained: () async {
                      await authController.getUserDetails();

                      await authController
                          .setFollowUserID(authController.sigupdata['_id']);
                      await authController
                          .userFollowingApi(authController.sigupdata['_id']);
                      await authController.FollowerApi(
                          authController.sigupdata['_id']);

                      // await jobDetailController.getPostList();
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 56,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await authController.getUserDetails();

                              await authController
                                  .setFollowUserID(authController.sigupdata['_id']);
                              await authController
                                  .userFollowingApi(authController.sigupdata['_id']);
                              await authController.FollowerApi(
                                  authController.sigupdata['_id']);
                              print('hii');
                            },
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showBottomSheetImageTypePostDialogProfile(
                                                context,
                                                authController,
                                                'profilePic');
                                          },
                                          child: Stack(
                                            children: [
                                              (authController.sigupdata[
                                                          'profilePic'] !=
                                                      null)
                                                  ? authController
                                                              .isProfileImgLoading ==
                                                          true
                                                      ? const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      50),
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      60),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                bottom: 0,
                                                left: 60,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Theme.of(context)
                                                      .cardColor
                                                      .withOpacity((0.7)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            authController.sigupdata[
                                                        'fullName'] !=
                                                    null
                                                ? Text(
                                                    authController
                                                        .sigupdata['fullName']
                                                        .toString(),
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  )
                                                : Text(
                                                    'UnKnown',
                                                    style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if ((authController
                                                                    .sigupdata[
                                                                "_id"] !=
                                                            null) ==
                                                        true) {
                                                      showBottomSheetTypePostDialog(
                                                          context,
                                                          authController,
                                                          authController
                                                                  .postType ??
                                                              "");

                                                      jobDetailController
                                                          .getPostListVideo();
                                                    } else {
                                                      showCreateProfileDialog();
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin: FractionalOffset
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
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Text(
                                      authController.sigupdata['bio'] ?? "",
                                      style: poppinsBold.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
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
                                              onTap: () {
                                                Get.to(
                                                    () =>
                                                        const ProfileFollowers(
                                                          isFollowers: true,
                                                        ),
                                                    arguments: authController
                                                        .sigupdata['_id']);
                                              },
                                              child: Container(
                                                // height: Get.height * 0.075,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      authController
                                                          .follower.length
                                                          .toString(),
                                                      style:
                                                          poppinsBold.copyWith(
                                                        color: Theme.of(context)
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
                                                        color: Theme.of(context)
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
                                              onTap: () {
                                                Get.to(
                                                  const ProfileFollowers(
                                                    isFollowers: false,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      authController
                                                          .following.length
                                                          .toString(),
                                                      style:
                                                          poppinsBold.copyWith(
                                                        color: Theme.of(context)
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
                                                        color: Theme.of(context)
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
                                        labelColor: Theme.of(context).cardColor,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        labelStyle: poppinsRegular.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).cardColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault),
                                        tabs: [
                                          // Tab(
                                          //   icon: Image.asset(
                                          //     Images.image,
                                          //     height: 25,
                                          //     width: MediaQuery.of(context)
                                          //         .size
                                          //         .width,
                                          //     color: _currentIndex == 0
                                          //         ? Theme.of(context).cardColor
                                          //         : Theme.of(context)
                                          //             .disabledColor,
                                          //   ),
                                          // ),
                                          // Tab(
                                          //   icon: Image.asset(
                                          //     Images.video,
                                          //     height: 30,
                                          //     width: MediaQuery.of(context)
                                          //         .size
                                          //         .width,
                                          //     color: _currentIndex == 1
                                          //         ? Theme.of(context).cardColor
                                          //         : Theme.of(context)
                                          //             .disabledColor,
                                          //   ),
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
                                              jobDetailController.postList.isNotEmpty? Text(
                                                  '  ( ${jobDetailController.postList.length} )'):SizedBox(),
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
                                              jobDetailController.postListVideo.isNotEmpty?Text(
                                                  '  ( ${jobDetailController.postListVideo.length} )'):SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height:Get.height*0.45,
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
                                                      title: 'image post'),
                                                ),
                                              ],
                                            ),
                                            Flex(
                                              direction: Axis.vertical,
                                              children: [
                                                Expanded(
                                                    child: VideoPost(
                                                        title: 'video post')),
                                              ],
                                            ),
                                          ],
                                        ),
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
                  authController.isImgLoading == true
                      ? Container(
                          color: Colors.white.withOpacity(0.15),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryColor),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

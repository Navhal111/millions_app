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

class OtherUserProfileScreen extends StatefulWidget {
  final bool? isOtherFollowers;
  final String? otherFollowUSerID;

  const OtherUserProfileScreen(
      {Key? key, this.isOtherFollowers, this.otherFollowUSerID})
      : super(key: key);

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  var authController = Get.find<AuthController>();
  var jobDetailController = Get.find<JobDetailController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    print('followUserId>>  ${widget.otherFollowUSerID}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: AppColors.blackColor,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          FocusDetector(
            onVisibilityGained: () async {
              await authController.setFollowUserID(authController.folloUserId);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: widget.isOtherFollowers == false
                                ? Text(
                                    "Followers",
                                    style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                : Text(
                                    "Following",
                                    style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                    textAlign: TextAlign.start,
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
          widget.isOtherFollowers == true
              ? Expanded(
                  child: Container(
                    height: Get.height * 0.5,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          authController.followerList.length != 0
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: authController.followerList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        /*  await authController.userFollowingApi(
                                            authController.followerList[index]
                                                ['user']['_id']);*/

                                        await authController.FollowOtherApi(
                                            authController.followerList[index]
                                                ['user']['_id']);

                                        await authController
                                            .getFollowingUserProfile(
                                                authController
                                                        .followerList[index]
                                                    ['user']['_id']);

                                        await jobDetailController
                                            .getOtherPostList(authController
                                                    .followerList[index]['user']
                                                ['_id']);
 await jobDetailController
                                            .getOtherVideoPostList(authController
                                                    .followerList[index]['user']
                                                ['_id']);

                                        await authController
                                            .getOtherUserDetails(authController
                                                .followerList[index]['user']);

                                        Get.toNamed(
                                            RouteHelper.getUserProfileScreen(),
                                            arguments: authController
                                                    .followerList[index]['user']
                                                ['_id']);
                                      },
                                      child: Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        elevation: 2,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              (authController.followerList[
                                                                  index]['user']
                                                              ['profilePic'] !=
                                                          null &&
                                                      authController.followerList[
                                                                  index]['user']
                                                              ['profilePic'] !=
                                                          "")
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        AppConstants
                                                                .IMAGE_BASE_URL +
                                                            authController.followerList[
                                                                        index]
                                                                    ['user']
                                                                ['profilePic'],
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            15,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Container(
                                                      child: Image.asset(
                                                        Images.account,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            15,
                                                        fit: BoxFit.fill,
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            authController.followerList[
                                                                        index]
                                                                    ['user']
                                                                ['fullName'],
                                                            style: poppinsBold
                                                                .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              height: 0.05,
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              Get.width * 0.35,
                                                          child: Text(
                                                            authController
                                                                        .followerList[
                                                                    index]
                                                                ['user']['bio'],
                                                            maxLines: 1,
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                                      child: Text(
                                                        "Remove",
                                                        style: poppinsBold
                                                            .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .hintColor
                                                              .withOpacity(0.7),
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    /*  Container(
                                                      width: 15,
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .more_horiz_outlined,
                                                          color: AppColors
                                                              .whiteColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    'No List Found',
                                    style:
                                        TextStyle(color: AppColors.whiteColor),
                                  ),
                                ),
                          // SizedBox(
                          //   width: 12 * 0.01,
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          authController.followingList.length != 0
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      authController.followingList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        // await authController.userFollowingApi(
                                        //     authController.followingList[index]
                                        //         ['user']['_id']);

                                        await authController.FollowOtherApi(
                                            authController.followingList[index]
                                                ['user']['_id']);

                                        await authController
                                            .getFollowingUserProfile(
                                                authController
                                                        .followingList[index]
                                                    ['user']['_id']);

                                        await jobDetailController
                                            .getOtherPostList(authController
                                                    .followingList[index]
                                                ['user']['_id']);

                                        await jobDetailController
                                            .getOtherVideoPostList(authController
                                                    .followingList[index]
                                                ['user']['_id']);

                                        await authController
                                            .getOtherUserDetails(authController
                                                .followingList[index]['user']);

                                        Get.toNamed(
                                            RouteHelper.getUserProfileScreen(),
                                            arguments: authController
                                                    .followingList[index]
                                                ['user']['_id']);
                                      },
                                      child: Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        elevation: 2,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              authController.followingList[
                                                              index]['user']
                                                          ['profilePic'] !=
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        AppConstants
                                                                .IMAGE_BASE_URL +
                                                            authController.followingList[
                                                                        index]
                                                                    ['user']
                                                                ['profilePic'],
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            15,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Container(
                                                      child: Image.asset(
                                                        Images.account,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            15,
                                                        fit: BoxFit.fill,
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            authController.followingList[
                                                                        index]
                                                                    ['user']
                                                                ['fullName'],
                                                            style: poppinsBold
                                                                .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              height: 0.05,
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          width:
                                                              Get.width * 0.35,
                                                          child: Text(
                                                            authController
                                                                        .followingList[
                                                                    index]
                                                                ['user']['bio'],
                                                            maxLines: 1,
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        // authController.unFollowUserApi(
                                                        //     authController
                                                        //                 .followingList[
                                                        //             index][
                                                        //         'user']['_id']);

                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8,
                                                                horizontal: 10),
                                                        margin:
                                                            EdgeInsets.all(0),
                                                        child: Text(
                                                          authController.getfollowerDetail[
                                                                      "following"] ==
                                                                  0
                                                              ? "Follow"
                                                              : "Following",
                                                          style: poppinsBold
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   margin:
                                                    //       EdgeInsets.symmetric(
                                                    //           horizontal: 10),
                                                    //   padding:
                                                    //       EdgeInsets.symmetric(
                                                    //           horizontal: 10,
                                                    //           vertical: 10),
                                                    //   decoration: BoxDecoration(
                                                    //       border: Border.all(
                                                    //           color: Theme.of(
                                                    //                   context)
                                                    //               .cardColor),
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(25)),
                                                    //   child: Text(
                                                    //     widget.isFollowers ==
                                                    //             false
                                                    //         ? "Following"
                                                    //         : "Followers",
                                                    //     style:
                                                    //         poppinsBold.copyWith(
                                                    //       color: Theme.of(context)
                                                    //           .hintColor
                                                    //           .withOpacity(0.7),
                                                    //       fontSize: Dimensions
                                                    //           .fontSizeSmall,
                                                    //     ),
                                                    //     textAlign:
                                                    //         TextAlign.start,
                                                    //   ),
                                                    // ),
                                                    /*   Container(
                                                      width: 15,
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .more_horiz_outlined,
                                                          color: AppColors
                                                              .whiteColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    'No List Found',
                                    style:
                                        TextStyle(color: AppColors.whiteColor),
                                  ),
                                ),
                          // SizedBox(
                          //   width: 12 * 0.01,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }
}

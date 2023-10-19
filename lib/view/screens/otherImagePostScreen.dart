import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/like_animation.dart';
import 'package:million/view/widget/other_post_image_widget.dart';
import 'package:million/view/widget/post_image_widget.dart';

class OtherPostImage extends StatefulWidget {
  final String? url, type;
  const OtherPostImage({super.key, this.url, this.type});

  @override
  State<OtherPostImage> createState() => _OtherPostImageState();
}

class _OtherPostImageState extends State<OtherPostImage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool isAnimating = false;
  bool showanimation = false;
  var jobDetailController = Get.find<JobDetailController>();
  var authController = Get.find<AuthController>();

  final pageController = PageController(viewportFraction: 1.0, keepPage: true);
  @override
  void initState() {
    print('OTHER IMAGE /............... ');
    print(authController.otherUserDetails['_id']);
    jobDetailController.getOtherPostList(authController.otherUserDetails['_id']);
    // TODO: implement initState
    super.initState();
  }
  final myController = TextEditingController();

  double loginWidth = 0.0;


  @override
  void dispose() {
    super.dispose();
  }

  Container chatTextField(BuildContext context, dynamic postDetail) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
            ),
            width: MediaQuery.of(context).size.width - 35,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: BorderRadius.circular(50),

              border: Border.all(
                  width: 1, //                   <--- border width here
                  color: Theme.of(context).cardColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: myController,
                    style: poppinsRegular.copyWith(
                        color: AppColors.whiteColor, height: 0.02),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write a message...',
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      if (text != "") {
                        setState(() {
                          loginWidth = 80;
                        });
                      } else {
                        this.setState(() {
                          loginWidth = 0;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    print('------------------2----------------');

                    await jobDetailController.addCommentToList(
                        myController.text,
                        jobDetailController.setCommentPostId.toString(),
                        context);

                    await jobDetailController.setPostID(
                        jobDetailController.setCommentPostId.toString());
                    myController.clear();
                    await jobDetailController
                        .getCommentList(jobDetailController.setCommentPostId);
                    FocusScope.of(context).unfocus();
                  },
                  child: jobDetailController.isLoading == true
                      ? CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )
                      : Icon(
                    Icons.send,
                    color: Theme.of(context).cardColor,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          key: _globalKey,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          body: Column(
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
                      child: Text(
                        "Post",
                        style: poppinsRegular.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
              GetBuilder<JobDetailController>(
                  builder: (jobController) {
                    return  Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [

                            jobDetailController.otherPostList.isNotEmpty
                                ? SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: jobDetailController.otherPostList.length,
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_DEFAULT),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {


                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child:
                                            (/*authController.sigupdata[
                                              "profilePic"] != "" ||*/
                                                authController
                                                    .otherUserDetails[
                                                "profilePic"] !=
                                                    null)
                                                ? ClipRRect(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(50),
                                              child: Image.network(
                                                AppConstants
                                                    .IMAGE_BASE_URL +
                                                    authController
                                                        .otherUserDetails[
                                                    "profilePic"]
                                                        .toString(),
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    10,
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    10,
                                                fit: BoxFit.fill,
                                                // color: Theme.of(context).disabledColor,
                                              ),
                                            )
                                                : ClipRRect(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(50),
                                              child: Image.asset(
                                                Images.avtar,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    10,
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    10,
                                                color: Theme.of(
                                                    context)
                                                    .disabledColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    authController.otherUserDetails[
                                                    "fullName"] ??
                                                        "richers",
                                                    style: poppinsBold.copyWith(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize: Dimensions
                                                            .fontSizeDefault),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OtherPostImageWidget(index: index),
                                      Row(
                                        children: <Widget>[
                                          LikeAnimation(
                                            isAnimating: jobController.otherPostList[index]["likes"].length >= 1,
                                            smallLike: true,
                                            child: IconButton(
                                              icon: jobController.otherPostList[index]["likes"].length >= 1
                                                  ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                                  : Icon(
                                                Icons.favorite_border,
                                                color: Theme.of(context)
                                                    .hintColor,
                                              ),
                                              onPressed: ()  {
                                                jobController.setLikeCommentOtherList(jobDetailController.otherPostList[index]["_id"],index);
                                                setState(() => {
                                                  isAnimating = true
                                                });
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.comment_outlined,
                                              color:
                                              Theme.of(context).hintColor,
                                            ),
                                            onPressed: () async {
                                              print('------------------3----------------');

                                              await jobDetailController
                                                  .getCommentList(
                                                  jobDetailController
                                                      .otherPostList[index]
                                                  ["_id"]);
                                              await jobDetailController
                                                  .setPostID(jobDetailController
                                                  .otherPostList[index]['_id']);
                                              await showModalBottomSheet<void>(
                                                  isScrollControlled: true,
                                                  enableDrag: true,
                                                  isDismissible: true,
                                                  useRootNavigator: true,
                                                  elevation: 0,
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      maxHeight: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height // here increase or decrease in width
                                                  ),
                                                  shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(20.0),
                                                      topRight:
                                                      Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                  context: context!,
                                                  barrierColor:
                                                  AppColors.blackColor,
                                                  builder: (context) {
                                                    return FractionallySizedBox(
                                                      heightFactor: 0.9,
                                                      child: Scaffold(
                                                        backgroundColor:
                                                        AppColors
                                                            .blackColor,
                                                        body: Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 5,
                                                                color: AppColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                    0.2),
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                    5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                                                    // border: Border.all(
                                                                    //     color: AppColors
                                                                    //         .whiteColor,
                                                                    //     width:
                                                                    //         1),
                                                                    color: AppColors.blackColor),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Spacer(),
                                                                    Container(
                                                                      child:
                                                                      Text(
                                                                        "Comments",
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            color: AppColors.whiteColor,
                                                                            fontSize: 18),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                          .width *
                                                                          0.25,
                                                                    ),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                        Icon(
                                                                          Icons
                                                                              .send,
                                                                          color:
                                                                          AppColors.whiteColor,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 20,
                                                                thickness: 1,
                                                                endIndent: 0,
                                                                color: AppColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                    0.2),
                                                              ),
                                                              Expanded(
                                                                flex: 6,
                                                                child: jobDetailController
                                                                    .commentList
                                                                    .isNotEmpty
                                                                    ? RefreshIndicator(
                                                                  onRefresh:
                                                                      () async {
                                                                    print('-----------------4----------------');


                                                                    await jobDetailController
                                                                        .getCommentList(jobDetailController.setCommentPostId);
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: 10),
                                                                    child:
                                                                    ListView.builder(
                                                                      physics:
                                                                      BouncingScrollPhysics(),
                                                                      padding:
                                                                      EdgeInsets.symmetric(vertical: 8),
                                                                      shrinkWrap:
                                                                      true,
                                                                      itemCount:
                                                                      jobDetailController.commentList.length,
                                                                      itemBuilder:
                                                                          (context, index) {
                                                                        // String formattedDate = DateFormat('kk:mm').format(
                                                                        //     DateTime.parse(jobDetailController
                                                                        //         .commentList[index]['user']['createdAt']));
                                                                        return FocusDetector(
                                                                          onFocusGained: () async {
                                                                            print('------------------1----------------');
                                                                            await jobDetailController.getCommentList(jobDetailController.setCommentPostId);
                                                                          },
                                                                          child: Container(
                                                                            margin: EdgeInsets.symmetric(vertical: 8),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  child: jobDetailController.commentList[index]['user']['profilePic'] != null
                                                                                      ? ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                    child: Image.network(
                                                                                      AppConstants.IMAGE_BASE_URL + jobDetailController.commentList[index]['user']['profilePic'].toString(),
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                      fit: BoxFit.fill,
                                                                                      // color: Theme.of(context).disabledColor,
                                                                                    ),
                                                                                  )
                                                                                      : ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                    child: Image.asset(
                                                                                      Images.avtar,
                                                                                      width: MediaQuery.of(context).size.width / 10,
                                                                                      height: MediaQuery.of(context).size.width / 10,
                                                                                      color: Theme.of(context).disabledColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                jobDetailController.commentList[index]['user']['fullName'] ?? "",
                                                                                                style: const TextStyle(color: Colors.white),
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Text(
                                                                                                DateFormat('HH:mm aa').format(DateTime.parse(jobDetailController.commentList[index]['createdAt'])),
                                                                                                style: TextStyle(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w600),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 5,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              jobDetailController.commentList[index]['text'],
                                                                                              style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800, color: AppColors.whiteColor),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Spacer(),
                                                                                IconButton(
                                                                                  onPressed: () {},
                                                                                  icon: Icon(
                                                                                    Icons.favorite_border,
                                                                                    color: Theme.of(context).disabledColor,
                                                                                    size: 15,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                )
                                                                    : Container(
                                                                  width: double.infinity,
                                                                ),
                                                              ),
                                                              chatTextField(
                                                                  context,
                                                                  jobDetailController
                                                                      .commentDetails),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });

                                              // Get.toNamed(
                                              //     RouteHelper.getCommentScreen());
                                            },
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.send,
                                                color:
                                                Theme.of(context).hintColor,
                                              ),
                                              onPressed: () {}),
                                          Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: IconButton(
                                                    icon: const Icon(
                                                        Icons.bookmark_border),
                                                    onPressed: () {}),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            if(jobController.otherPostList[index]["likeCount"]!=null)
                                              DefaultTextStyle(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                    fontWeight:
                                                    FontWeight.w800),
                                                child: Text(
                                                  '${jobController.otherPostList[index]["likeCount"]} likes',
                                                  style: poppinsBold.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeDefault),
                                                ),
                                              ),
                                            // Container(
                                            //   width: double.infinity,
                                            //   padding: const EdgeInsets.only(
                                            //     top: 8,
                                            //   ),
                                            //   child: RichText(
                                            //     text: TextSpan(
                                            //       style: TextStyle(
                                            //           color: Theme.of(context)
                                            //               .hintColor),
                                            //       children: const [
                                            //         TextSpan(
                                            //           text: "milanlight",
                                            //           style: TextStyle(
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //           ),
                                            //         ),
                                            //         TextSpan(
                                            //           text: ' nerpost likes',
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            jobController.otherPostList[index]["comments"].length > 0?
                                            InkWell(
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Text(
                                                  'View all ${jobController.otherPostList[index]["comments"].length} comments',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                              ),
                                              onTap: () => {},
                                            ):
                                            InkWell(
                                              child: Container(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Text(
                                                  'No comments',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                              ),
                                              onTap: () => {},
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                                : const Center(
                              child: Text('Not Found'),
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
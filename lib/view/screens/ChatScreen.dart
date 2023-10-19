import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/controllers/coman_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/convert_date_format_chat.dart';
import 'package:million/view/widget/ChatItem.dart';
import 'package:million/view/widget/RequestItem.dart';

class ChatScreen extends StatefulWidget {
  final String? appVersion;

  ChatScreen({this.appVersion});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late TabController tabController;
  var authController = Get.find<AuthController>();
  var jobDetailController = Get.find<JobDetailController>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GetBuilder<ComanController>(
          builder: (comanController) {
            return Column(
              children: [
                const SizedBox(
                  height: 56,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.09,
                      ),
                      Text(
                        "Chat List",
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault + 5,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, setState) {
                            return InkWell(
                              onTap: () async {
                                Get.toNamed(RouteHelper.getSearcgUserScreen());
                              },
                              child: Hero(
                                tag: "userSearchScreen",
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
                                        width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity((0.7)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                TabBar(
                  controller: tabController,
                  indicatorColor: Theme.of(context).cardColor,
                  labelColor: Theme.of(context).cardColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: poppinsRegular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).cardColor,
                      fontSize: Dimensions.fontSizeDefault),
                  tabs: const [
                    Tab(
                      icon: Text(
                        "Chat",
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Requests",
                      ),
                    ),
                  ],
                ),

                // Container(
                //   height: MediaQuery.of(context).size.height - 227,
                //   padding: EdgeInsets.only(top: 10),
                //   child: TabBarView(
                //     controller: tabController,
                //     physics: NeverScrollableScrollPhysics(),
                //     children: [
                //       StreamBuilder<QuerySnapshot>(
                // stream: FirebaseFirestore.instance
                //     .collection("ChatUserList")
                //     .where('chatUserId2',
                //     isEqualTo: authController.sigupdata["_id"])
                //     .snapshots(),
                // builder: (BuildContext context,
                //     AsyncSnapshot<dynamic> snapshot) {
                //
                //           return Flex(
                //             direction: Axis.vertical,
                //             children: [
                //               Expanded(
                //                 child: RefreshIndicator(
                //                   onRefresh: () async {},
                //                   child: SingleChildScrollView(
                //                     physics: const BouncingScrollPhysics(),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                       MainAxisAlignment.start,
                //                       children: [
                //                         Column(
                //                           children: [
                //                             SizedBox(
                //                               height: comanController
                //                                   .chatList.length *
                //                                   (MediaQuery.of(context)
                //                                       .size
                //                                       .height /
                //                                       6),
                //                               child: ListView.builder(
                //                                 itemCount: snapshot
                //                                     .data?.docs.length,
                //                                 padding: const EdgeInsets
                //                                     .only(
                //                                     left: Dimensions
                //                                         .PADDING_SIZE_SMALL),
                //                                 physics:
                //                                 const NeverScrollableScrollPhysics(),
                //                                 itemBuilder:
                //                                     (context, index) {
                //                                      if( snapshot.data!.docs[
                //                                      index]
                //                                      [
                //                                      'chatUserId1'] !=
                //                                          null &&
                //                                          snapshot.data!.docs[
                //                                          index]
                //                                          [
                //                                          'requested'] ==
                //                                              "0")
                //                                {
                //                                  snapshot.data!.docs[
                //                                  index]
                //                                  [
                //                                  'chatUserId1'] !=
                //                                      null &&
                //                                      snapshot.data!.docs[
                //                                      index]
                //                                      [
                //                                      'requested'] ==
                //                                          "0"
                //                                      ? ChatItem(
                //                                    receiverFCMToken: snapshot
                //                                        .data!
                //                                        .docs[
                //                                    index][
                //                                    "deviceToken"],
                //                                    phone: snapshot
                //                                        .data!
                //                                        .docs[
                //                                    index][
                //                                    "phoneNumber"],
                //                                    profileUrl: snapshot
                //                                        .data!
                //                                        .docs[
                //                                    index][
                //                                    'profilePic'],
                //                                    title: snapshot
                //                                        .data!
                //                                        .docs[index]
                //                                    [
                //                                    'chatUserName'] ??
                //                                        "",
                //                                    tag:
                //                                    '${comanController.chatList[index]["chatUserName"]} ${index}',
                //                                    dec:
                //                                    "${snapshot.data!.docs[index]['lastText']}",
                //                                    chatUserId:
                //                                    comanController
                //                                        .sigupdata[
                //                                    "_id"],
                //                                    index: index,
                //                                  )
                //                                      : const SizedBox();
                //                                }
                //                                 },
                //                               ),
                //                             )
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         }
                //       ),
                //       StreamBuilder<QuerySnapshot>(
                //           stream: FirebaseFirestore.instance
                //               .collection("ChatUserList")
                //               .where('chatUserId2',
                //               isEqualTo: authController.sigupdata["_id"])
                //               .snapshots(),
                //           builder: (BuildContext context,
                //               AsyncSnapshot<dynamic> snapshot) {
                //           return Flex(
                //             direction: Axis.vertical,
                //             children: [
                //               Expanded(
                //                 child: RefreshIndicator(
                //                   onRefresh: () async {},
                //                   child: SingleChildScrollView(
                //                     physics: const BouncingScrollPhysics(),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                       MainAxisAlignment.start,
                //                       children: [
                //                         Column(
                //                           children: [
                //                             SizedBox(
                //                               height: comanController
                //                                   .chatList.length *
                //                                   (MediaQuery.of(context)
                //                                       .size
                //                                       .height /
                //                                       6),
                //                               child: ListView.builder(
                //                                 itemCount: snapshot
                //                                     .data?.docs.length,
                //                                 padding: const EdgeInsets
                //                                     .only(
                //                                     left: Dimensions
                //                                         .PADDING_SIZE_SMALL),
                //                                 physics:
                //                                 const NeverScrollableScrollPhysics(),
                //                                 itemBuilder:
                //                                     (context, index) {
                //                                   print(snapshot
                //                                       .data!.docs[index]
                //                                   ['chatUserId1']);
                //                                   print(snapshot
                //                                       .data!.docs[index]
                //                                   ['chatUserId2']);
                //                                   print(authController
                //                                       .sigupdata["_id"]);
                //
                //                                   return snapshot.data!.docs[
                //                                   index]
                //                                   [
                //                                   'chatUserId1'] !=
                //                                       null &&
                //                                       snapshot.data!.docs[
                //                                       index]
                //                                       [
                //                                       'requested'] ==
                //                                           "1"
                //                                       ? ChatItem(
                //                                     receiverFCMToken: snapshot
                //                                         .data!
                //                                         .docs[
                //                                     index][
                //                                     "deviceToken"],
                //                                     phone: snapshot
                //                                         .data!
                //                                         .docs[
                //                                     index][
                //                                     "phoneNumber"],
                //                                     profileUrl: snapshot
                //                                         .data!
                //                                         .docs[
                //                                     index][
                //                                     'profilePic'],
                //                                     title: snapshot
                //                                         .data!
                //                                         .docs[index]
                //                                     [
                //                                     'chatUserName'] ??
                //                                         "",
                //                                     tag:
                //                                     '${comanController.chatList[index]["chatUserName"]} ${index}',
                //                                     dec:
                //                                     "${snapshot.data!.docs[index]['lastText']}",
                //                                     chatUserId: snapshot
                //                                         .data!
                //                                         .docs[index]
                //                                     [
                //                                     'chatUserId1'],
                //                                     sender: authController
                //                                         .sigupdata[
                //                                     "_id"] ==
                //                                         snapshot.data!
                //                                             .docs[
                //                                         index]
                //                                         [
                //                                         'chatUserId1'],
                //                                     index: index,
                //                                   )
                //                                       : const SizedBox();
                //                                 },
                //                               ),
                //                             )
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         }
                //       ),
                //     ],
                //   ),
                // )
                ///--------------
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("ChatUserList")
                        .where('chatUserId2',
                        isEqualTo: authController.sigupdata["_id"])
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.3,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.3,
                            ),
                            Center(
                                child: Text(
                              'No Chat Found',
                              style: TextStyle(color: AppColors.whiteColor),
                            )),
                          ],
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height - 227,
                          padding: EdgeInsets.only(top: 10),
                          child: TabBarView(
                            controller: tabController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {},
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: comanController
                                                          .chatList.length *
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          6),
                                                  child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data?.docs.length,
                                                    padding: const EdgeInsets
                                                            .only(
                                                        left: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return snapshot.data!.docs[
                                                                          index]
                                                                      [
                                                                      'chatUserId1'] !=
                                                                  null &&
                                                              snapshot.data!.docs[
                                                                          index]
                                                                      [
                                                                      'requested'] ==
                                                                  "0"
                                                          ? ChatItem(
                                                              receiverFCMToken: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "deviceToken"],
                                                              phone: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "phoneNumber"],
                                                              profileUrl: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'profilePic'],
                                                              title: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'chatUserName'] ??
                                                                  "",
                                                              tag:
                                                                  '${comanController.chatList[index]["chatUserName"]} ${index}',
                                                              dec:
                                                                  "${snapshot.data!.docs[index]['lastText']}",
                                                              chatUserId:
                                                                  comanController
                                                                          .sigupdata[
                                                                      "_id"],
                                                              index: index,
                                                            )
                                                          : const SizedBox();
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {},
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: comanController
                                                          .chatList.length *
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          6),
                                                  child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data?.docs.length,
                                                    padding: const EdgeInsets
                                                            .only(
                                                        left: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      print(snapshot
                                                              .data!.docs[index]
                                                          ['chatUserId1']);
                                                      print(snapshot
                                                              .data!.docs[index]
                                                          ['chatUserId2']);
                                                      print(authController
                                                          .sigupdata["_id"]);

                                                      return snapshot.data!.docs[
                                                                          index]
                                                                      [
                                                                      'chatUserId1'] !=
                                                                  null &&
                                                              snapshot.data!.docs[
                                                                          index]
                                                                      [
                                                                      'requested'] ==
                                                                  "1"
                                                          ? ChatItem(
                                                              receiverFCMToken: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "deviceToken"],
                                                              phone: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  "phoneNumber"],
                                                              profileUrl: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'profilePic'],
                                                              title: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'chatUserName'] ??
                                                                  "",
                                                              tag:
                                                                  '${comanController.chatList[index]["chatUserName"]} ${index}',
                                                              dec:
                                                                  "${snapshot.data!.docs[index]['lastText']}",
                                                              chatUserId: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'chatUserId1'],
                                                              sender: authController
                                                                          .sigupdata[
                                                                      "_id"] ==
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'chatUserId1'],
                                                              index: index,
                                                            )
                                                          : const SizedBox();
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}

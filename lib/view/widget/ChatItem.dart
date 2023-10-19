import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
import 'package:million/view/screens/ChatScreen.dart';
import 'package:million/view/screens/convert_date_format_chat.dart';

class ChatItem extends StatefulWidget {
  final String title;
  final String? dec;
  final String? profileUrl;
  final String? email;
  final String? bio;
  final String? tag;
  final String? tag2;
  final String? chatUserId;
  final String? phone;
  final String? receiverFCMToken;
  final int? index;
  final bool? isSearchUSerScreen;
  final VoidCallback? onTap;
  final Map<String, dynamic>? userDetail;
  final bool? sender;
  ChatItem(
      {required this.title,
      this.dec,
      this.tag,
      this.tag2,
      this.isSearchUSerScreen = false,
      this.email,
      this.onTap,
      this.profileUrl,
      this.chatUserId,
      this.index,
      this.sender=false,
      this.phone,
      this.userDetail,
      this.receiverFCMToken, this.bio});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  var authController = Get.find<AuthController>();

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, setState) {




      return FocusDetector(
        onFocusGained: () async {
          await authController.getFollowingUserProfile(widget.chatUserId??authController.sigupdata['_id']);
        },
        child: GetBuilder<JobDetailController>(
          builder: (jobDetailController) {
            return InkWell(
              onTap: widget.isSearchUSerScreen == true
                  ? widget.onTap
                  : () async {
                print('Tile.....${widget.title}');
                      await authController.replaceReciverId(widget.chatUserId!);
                      await authController.setSenderChat(widget.sender!);
                      await authController
                          .getFollowingUserProfile(widget.chatUserId!);



                      await authController
                          .replaceReciverUserProfilePic(widget.profileUrl ?? "");
                      await authController
                          .replaceReciverUserPhoneNumber(widget.phone ?? "");
                      await authController
                          .replaceReciverUserName(widget.title ?? "");
                      await authController
                          .replaceReceiverFCMToken(widget.receiverFCMToken ?? "");

                      await authController
                          .getSearchUserApi(widget.title.toString());

                      Get.toNamed(RouteHelper.getChatScreenRought(
                          widget.title, widget.chatUserId!, widget.chatUserId!));
                    },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical:0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.isSearchUSerScreen == true
                                ? (widget.profileUrl!.isEmpty ||
                                        widget.profileUrl == "")
                                    ? Image.asset(
                              Images.account,
                              width:
                              MediaQuery.of(context).size.width / 7,
                              height:
                              MediaQuery.of(context).size.width / 7,
                              color: Theme.of(context).disabledColor,
                            )
                                    : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                AppConstants.IMAGE_BASE_URL +
                                    widget.profileUrl.toString(),
                                width:
                                MediaQuery.of(context).size.width / 7,
                                height:
                                MediaQuery.of(context).size.width / 7, fit: BoxFit.fill,
                                // color: Theme.of(context).disabledColor,
                              ),
                            )
                                : (widget.profileUrl!.isNotEmpty || widget.profileUrl!= "")
                                    ? Hero(
                                        tag: widget.tag!,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            widget.profileUrl.toString(),
                                            width: 50,
                                            height: 50, fit: BoxFit.fill,
                                            // color: Theme.of(context).disabledColor,
                                          ),
                                        ),
                                      )
                                    : Hero(
                                        tag: widget.tag!,
                                        child: Image.asset(
                                          Images.account,
                                          width:
                                              MediaQuery.of(context).size.width / 7,
                                          height:
                                              MediaQuery.of(context).size.width / 7,
                                          color: Theme.of(context).disabledColor,
                                        ),
                                      ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 130,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      widget.isSearchUSerScreen == true
                                          ? Text(
                                              widget.title,
                                              style: poppinsBold.copyWith(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.7),
                                                fontSize: Dimensions.fontSizeDefault,
                                              ),
                                              textAlign: TextAlign.start,
                                            )
                                          : Text(
                                              widget.title,
                                              style: poppinsBold.copyWith(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.7),
                                                fontSize: Dimensions.fontSizeDefault,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                      widget.isSearchUSerScreen == true
                                          ? SizedBox()
                                          : _time(/*widget.chatUserId!*/authController.sigupdata['_id'], widget.index!)
                                      /*,Text(
                                          time!,
                                                style: poppinsBold.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor
                                                      .withOpacity(0.7),
                                                  fontSize: Dimensions.fontSizeSmall,
                                                ),
                                                textAlign: TextAlign.start,
                                              )*/
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                    widget.isSearchUSerScreen == true
                                        ? widget.bio??""
                                        // ? widget.email!
                                        : widget.dec??"",
                                    style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        color: Theme.of(context).secondaryHeaderColor,
                        height: 2,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      );
    });
  }
}

Column _time(String id, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      // StreamBuilder<QuerySnapshot>(
      //   stream: getLastMsgData(id),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return SizedBox();
      //     }
      //     String? lastMsg;
      //     List<DocumentSnapshot> docs = snapshot.data!.docs;
      //     if (docs.length == 1) {
      //       lastMsg = docs[0].get('msg');
      //     }
      //     print('last Msg :$lastMsg');
      //     return lastMsg == null
      //         ? SizedBox()
      //         : Text(lastMsg,maxLines: 1,style: TextStyle(color: Colors.white),);
      //   },
      // ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: getPendingSeenData(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int length = 0;
                  length = snapshot.data!.docs.fold(
                      0,
                      (previousValue, element) =>
                          previousValue +
                          (element.get('senderId') == id ? 1 : 0));
                  return length == 0
                      ? SizedBox()
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text(
                                '$length',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        );
                } else {
                  return SizedBox();
                }
              }),
          SizedBox(
            width: Get.width * 0.04,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getLastMsgData(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print('.................................');
                return SizedBox();
              }
              DateTime? lastMsgTime;
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              if (docs.length == 1) {
                lastMsgTime = docs[0].get('date').toDate();
              }
              print('last Msg :$lastMsgTime');
              return lastMsgTime == null
                  ? SizedBox()
                  : MsgDate(
                      date: docs[0].get('date').toDate(),
                    );
            },
          ),
        ],
      ),
    ],
  );
}

var authController = Get.find<AuthController>();

Stream<QuerySnapshot> getPendingSeenData(String id) {
  String senderId = authController.sigupdata['_id'];
  String receiverId = id.toString();
  return FirebaseFirestore.instance
      // .collection('ChatData')
      // .doc(senderId)
      .collection('Chat')
      .doc(chatId(senderId, receiverId))
      .collection('Data')
      .where('seen', isEqualTo: false)
      .snapshots();
}

Stream<QuerySnapshot> getLastMsgData(String id) {
  String senderId = authController.sigupdata['_id'];
  String receiverId = id.toString();
  return FirebaseFirestore.instance
      // .collection('ChatData')
      // .doc(senderId)
      .collection('Chat')
      .doc(chatId(senderId, receiverId))
      .collection('Data')
      .orderBy('date')
      .limitToLast(1)
      .snapshots();
}

Stream<QuerySnapshot> getLastMsg(String id) {
  String senderId = authController.sigupdata['_id'];
  String receiverId = id.toString();
  return FirebaseFirestore.instance
      // .collection('ChatData')
      // .doc(senderId)
      .collection('Chat')
      .doc(chatId(senderId, receiverId))
      .collection('Data')
      .orderBy('date')
      .limitToLast(1)
      .snapshots();
}

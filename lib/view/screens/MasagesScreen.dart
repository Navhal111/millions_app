import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart' as foundation;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/controllers/local_file_controller.dart';
import 'package:million/helper/app_notification.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/agoraVideoCall.dart';
import 'package:million/view/screens/agoraAudioCall.dart';
import 'package:million/view/screens/convert_date_format_chat.dart';
import 'package:million/view/screens/zoomChatImage.dart';
import 'package:million/view/widget/ChatItem.dart';
import 'package:million/view/widget/ChatMasage.dart';
import 'package:million/view/widget/MasageItem.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:octo_image/octo_image.dart';

class MassageScreen extends StatefulWidget {
  final String? title;
  final String? tag;
  final String? recieverID;
  final String? receiverFCMToken;

  MassageScreen(
      {required this.title,
      required this.tag,
      this.recieverID,
      this.receiverFCMToken});

  @override
  _MassageScreenState createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Tween<double> tween = Tween(begin: 0.9, end: 1.2);
  bool emojiShowing = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final myController = TextEditingController();
  double loginWidth = 0.0;
  File? file;
  String? senderId;
  String? recieverId;
  var authController = Get.find<AuthController>();

  _onBackspacePressed() {
    myController
      ..text = myController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: myController.text.length));
  }

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);

    // senderId = authController.sendterChat?authController.sigupdata['_id']:authController.reciverId;
    // recieverId = authController.sendterChat?authController.reciverId:authController.sigupdata['_id'];
    getChatUserInfo();
    senderId = authController.sigupdata['_id'];
    recieverId = authController.reciverId;
    print("senderId============================${senderId}");
    print("recieverId============================${recieverId}");
    print(
        "chatRequestStatus============================${authController.chatRequestStatus}");
    seenOldMessage();

    super.initState();
  }

  Future<void> addMsg() async {
    if (myController.text.isEmpty) {
      log('Please first write meaage..');
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(senderId!, recieverId!))
          .collection('Data')
          .add({
            'date': DateTime.now(),
            'Type': 'Text',
            'senderId': senderId,
            'receiveId': recieverId,
            'seen': false,
            'msg': myController.text,
            'image': 'image',
            'status': 'active',
            'requested': '1',
            'time': DateTime.now().toString(),
          })
          .then((value) => myController.clear())
          .catchError((e) => print(e));
    }
  }

  CollectionReference ProfileCollection =
      FirebaseFirestore.instance.collection('Chat');
  DocumentReference userCollection =
      FirebaseFirestore.instance.collection('ChatUserList').doc();

  updateStatus(status) {
    var getstatus = ProfileCollection.doc(chatId(senderId!, recieverId!))
        .collection('Data')
        .doc()
        .update({'requested': status});
    print('getstatus');
    print(getstatus);
  }

  checkBothConversation() {
    final user1 = FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId!, recieverId!));
    final user2 = FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(recieverId!, senderId!));
    if (user1 == user2) {
      print('yes-----------------');
    } else {
      print('no------------------');
    }
    print('USER1>>>>>>>>>>>>>>>>>>>> ${user1.id}');
    print('USER2>>>>>>>>>>>>>>>>>>>> ${user2.id}');
  }

  Future<void> addImage() async {
    if (authController.sigupdata['chatPic'] == '') {
      print('=========================================1');
      log('Please select image first..');
    } else {
      print('=========================================2');

      FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(senderId!, recieverId!))
          .collection('Data')
          .add({
        'date': DateTime.now(),
        'time': DateTime.now().toString(),
        'Type': 'Image',
        'senderId': senderId,
        'receiveId': recieverId,
        'seen': false,
        'msg': myController.text,
        'text': true,
        'requested': '1',
        'image': authController.sigupdata['chatPic'] != null
            ? AppConstants.IMAGE_BASE_URL + authController.sigupdata['chatPic']
            : "",
      }).then((value) {
        print('=========================================3');
        // authController.chatImageUpload("", "", context);
        authController.sigupdata['chatPic'] == null;
        authController.sigupdata['chatPic'] == "";
        myController.clear();
      }).catchError((e) => print(e));
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? chatUserId;
  String? chatUserName;

  // String? chatInfo;

  Future<void> getChatUserInfo() async {
    print('RECEVER ID >>> ${recieverId}');
    DocumentReference chatCollection =
        _firestore.collection('ChatUserList').doc(authController.reciverId);

    print('chatCollection.....${chatCollection}');

    final user = await chatCollection.get();
    print('user=============${user.id}');
    print('user=============${user.id}');
    var m = user.data();
    print('--chatCollectionWidget----user----${user.data()}');
    print('--chatCollectionWidget----m---1-$m');
    dynamic getChatUser = m;
    setState(() {
      chatUserId = getChatUser?['chatUserId1'];
      chatUserName = getChatUser?['chatUserName'];
    });
    authController.setChatRequestStatus(getChatUser['requested']);
    print('chatUserInfo............... ${authController.chatRequestStatus}');

    print('chatInfo............... ${authController.chatRequestStatus}');
  }

  Future<void> getChatMessageInfo() async {
    print('RECEVER ID   ${recieverId}');
    DocumentReference chatCollection = FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId!, recieverId!))
        .collection('Data')
        .doc();
    // _firestore.collection('ChatUserList').doc(recieverId);

    print(' ....${chatCollection}');

    final user = await chatCollection.get();

    var m = user.data();
    print('- -m----$m');
    dynamic getChatUser = m;
    setState(() {
      chatUserId = getChatUser?['chatUserId1'];
      chatUserName = getChatUser?['chatUserName'];
    });
    // snapShot.data!.docs[index]
    // ['senderId'] ==
    //     senderId

    print('chatUserId: -$chatUserId');

    print('chatUserName: -$chatUserName');
  }

  Future<void> addChatUser() async {
    print('kkkkkkkkk');
    AppNotificationHandler.getFcmToken();
    getChatMessageInfo();

    CollectionReference profileCollection =
        _firestore.collection('ChatUserList');
    try {
      print('NOTI CALL >${authController.otherUserDetails['fcmToken']}');
      await profileCollection
          .where('chatUserId1', isNotEqualTo: chatUserId)
          .get()
          .then((value) async {
        print('TOKEN FCM ${authController.otherUserDetails['fcmToken']}');
        FirebaseFirestore.instance
            .collection('ChatUserList')
            .doc(authController.otherUserDetails['_id'])
            .set({
          'date': DateTime.now(),
          'Type': 'Text',
          'chatUserId1': authController.otherUserDetails['_id'],
          'chatUserId2': authController.sigupdata['_id'],
          'lastText': myController.text,
          'chatUserEmail': authController.otherUserDetails['email'],
          'chatUserName': authController.otherUserDetails['fullName'],
          'phoneNumber': authController.otherUserDetails['phoneNumber'],
          'zipCode': authController.otherUserDetails['zipCode'],
          'gender': authController.otherUserDetails['gender'],
          'bio': authController.otherUserDetails['bio'],
          'age': authController.otherUserDetails['age'],
          'country': authController.otherUserDetails['country'],
          'deviceToken': authController.otherUserDetails['fcmToken'],
          'profilePic': authController.otherUserDetails['profilePic'] != null
              ? AppConstants.IMAGE_BASE_URL +
                  authController.otherUserDetails['profilePic']
              : "",
          'requested': '1',
          'time': DateTime.now().toString(),
        });
      });

      await profileCollection
          .where('chatUserId2', isNotEqualTo: authController.sigupdata["_id"])
          .get()
          .then((value) async {
        print('TOKEN FCM ${authController.sigupdata['fcmToken']}');
        FirebaseFirestore.instance
            .collection('ChatUserList')
            .doc(authController.sigupdata['_id'])
            .set({
          'date': DateTime.now(),
          'Type': 'Text',
          'chatUserId1': authController.sigupdata['_id'],
          'chatUserId2': authController.reciverId,
          'lastText': myController.text,
          'chatUserEmail': authController.sigupdata['email'],
          'chatUserName': authController.sigupdata['fullName'],
          'phoneNumber': authController.sigupdata['phoneNumber'],
          'zipCode': authController.sigupdata['zipCode'],
          'gender': authController.sigupdata['gender'],
          'bio': authController.sigupdata['bio'],
          'age': authController.sigupdata['age'],
          'country': authController.sigupdata['country'],
          'deviceToken': authController.sigupdata['fcmToken'],
          'profilePic': authController.sigupdata['profilePic'] != null
              ? AppConstants.IMAGE_BASE_URL +
                  authController.sigupdata['profilePic']
              : "",
          'requested': '1',
          'time': DateTime.now().toString(),
        });
      });
    } catch (e) {
      print(e);
    }
  }

  String chatId(String id1, String id2) {
    print('--------id1--id1--------$id1');

    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    if (id1.compareTo(id2) > 0) {
      return id1 + '-' + id2;
    } else {
      return id2 + '-' + id1;
    }
  }

  Future<void> seenOldMessage() async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId!, recieverId!))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .get();

    data.docs.forEach((element) {
      if (recieverId! == element.get('senderId')) {
        FirebaseFirestore.instance
            .collection('Chat')
            .doc(chatId(senderId!, recieverId!))
            .collection('Data')
            .doc(element.id)
            .update({'seen': true});
      }
    });
  }

  final LocalFileController con = Get.put(LocalFileController());

  @override
  void dispose() {
    this._controller!.dispose();
    super.dispose();
  }

  List<XFile?> image = [];

  CollectionReference? chatReference;

  // Future<void> getChatRequestInfo() async {
  //   print('RECEVER ID >>> ${recieverId}');
  //   DocumentReference chatCollection =
  //   _firestore.collection('ChatUserList').doc(recieverId);
  //
  //   print('chatCollection.....${chatCollection}');
  //
  //   final user = await chatCollection.get();
  //
  //   var m = user.data();
  //   print('--chatCollectionWidget----m----$m');
  //   dynamic getChatUser = m;
  //   setState(() {
  //
  //     // chatInfo = getChatUser?['chatUserName'];
  //   });
  //
  // }

  Container chatTextField(BuildContext context) {
    return Container(
      height: 66,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width - 35,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  width: 1, //                   <--- border width here
                  color: Theme.of(context).cardColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () async {
                    authController.getSendMsgNoti(recieverId!, 'Image');
                    pickFile();
                  },
                ),
                SizedBox(
                  width: 12 * 0.01,
                ),
                Expanded(
                  child: TextField(
                    controller: myController,
                    style: poppinsRegular.copyWith(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write a message...',
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      if (text != "") {
                        this.setState(() {
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
                  onTap: () {
                    // final a = [12];
                    // print(a[1]);
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                  },
                  child: Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: loginWidth > 0 ? 1 : 0,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          authController.getSendMsgNoti(
                              recieverId!, myController.text);
                          getChatMessageInfo();
                          addChatUser();
                          addMsg();
                        },
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  File? path;

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'PNG', 'JPG', 'jpeg', 'image'],
    );
    String? splites = result!.paths[0];
    path = File(splites!);
    print('PATH::::$path');
    authController.chatImageUpload("image", "image", context, path);
    String attach = splites.split('.').last;
    print('PATH  ${attach}');
    if (path != null) {
      Get.to(ShowDocument(
        receiverId: recieverId,
        senderId: senderId,
        file: path,
        type: attach == 'jpg' ||
                attach == 'png' ||
                attach == 'PNG' ||
                attach == 'JPG' ||
                attach == ' jpeg'
            ? 'image'
            : '',
      ));
    } else {
      SizedBox();
    }
    //file=File(file!.path);
    //return uploadDocumentFirebaseStorage(file: File(path!));
  }

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var jobDetailController = Get.find<JobDetailController>();

  void chatTimeSection(BuildContext context, time) {
    switch (jobDetailController.difTimeInDays) {
      case 0:
        print('today');
        break; // The switch statement must be told to exit, or it will execute every case.
      case 1:
        print('yesterday');
        break;

      default:
        print('today');
    }
  }

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    jobDetailController.getDifValOfDays(DateTime.now());

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        key: _globalKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: FocusDetector(
          onVisibilityGained: () async {
            getChatUserInfo();
          },
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                SizedBox(
                  height: 46,
                ),
                StatefulBuilder(builder: (BuildContext context, setState) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                                  width: 1),
                            ),
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
                          child: Hero(
                            tag: widget.tag!,
                            child: Row(
                              children: [
                                (/*authController.chatProfilePic == null ||*/
                                        authController.chatProfilePic == "")
                                    ? Image.asset(
                                        Images.account,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        color: Theme.of(context).disabledColor,
                                        fit: BoxFit.fill,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          authController.chatProfilePic,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.title!,
                                  style: poppinsRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge + 4,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        if (authController.sigupdata["_id"] !=
                            authController.reciverId)
                          IconButton(
                            onPressed: () async {
                              await authController
                                  .getSearchUserApi(widget.title.toString());

                              await authController.setCallingType("Audio");
                              await authController.setCallingUserId(
                                  authController.sigupdata["_id"] +
                                      "_" +
                                      authController.reciverId);
                              // await authController.getFollowingUserProfile(widget.recieverID);
                              await authController.sendPhoneNotification(
                                  authController.reciverId,
                                  '${authController.sigupdata['fullName'].toString().capitalize} is calling ...',
                                  authController.sigupdata['phoneNumber'],
                                  authController.getOtherUserFcmToken,
                                  "Audio",
                                  authController.sigupdata["_id"] +
                                      "_" +
                                      authController.reciverId);

                              Get.back();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AgoraAudioCallScreen(
                                    chatUserName:
                                        authController.chatUserName.toString(),
                                    chatUserPhone: authController.chatUserPhone,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.call,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        if (authController.sigupdata["_id"] !=
                            authController.reciverId)
                          IconButton(
                            onPressed: () async {
                              await authController
                                  .getSearchUserApi(widget.title.toString());

                              await authController.setCallingType("Video");
                              await authController.setCallingUserId(
                                  authController.sigupdata["_id"] +
                                      "_" +
                                      authController.reciverId);

                              // await authController.getFollowingUserProfile(widget.recieverID);
                              await authController.sendPhoneNotification(
                                  authController.reciverId,
                                  '${authController.sigupdata['fullName'].toString().capitalize} is calling ...',
                                  authController.sigupdata['phoneNumber']
                                      .toString(),
                                  authController.getOtherUserFcmToken,
                                  "Video",
                                  authController.sigupdata["_id"] +
                                      "_" +
                                      authController.reciverId);

                              Get.back();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AgoraVideoCallScreen(
                                      userName: widget.title,
                                      userPhone: authController
                                          .otherUserDetails['phoneNumber']),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.videocam,
                              color: AppColors.primaryColor,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Chat')
                                .doc(chatId(senderId!, recieverId!))
                                .collection('Data')
                                .orderBy('date', descending: false)
                                .snapshots(),
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapShot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Timestamp? formattedDateTime;
                                    formattedDateTime =
                                        snapShot.data?.docs[index]['date'];

                                    startDate = DateTime.now();
                                    endDate = formattedDateTime?.toDate();
                                    final difference =
                                        endDate?.difference(startDate!).inDays;
                                    Duration difference1 =
                                        startDate!.difference(DateTime.now());
                                    Duration twoDay = new Duration(days: 2);

                                    print(difference1.compareTo(twoDay));
                                    // snapShot.data!.docs[index]
                                    // ['senderId'] ==
                                    //     senderId

                                    return snapShot.data!.docs[index]['Type'] ==
                                            'Text'
                                        ? Column(
                                            children: [
                                              // if (difference1.compareTo(twoDay) < 1)
                                              //   Padding(
                                              //     padding: const EdgeInsets.only(
                                              //         right: 10, bottom: 15),
                                              //     child: MsgDate(
                                              //       date: (snapShot
                                              //                   .data!.docs[index]
                                              //               ['date'] as Timestamp)
                                              //           .toDate(),
                                              //     ),
                                              //   ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: MassageItem(
                                                    hart: false,
                                                    authController:
                                                        authController,
                                                    msg: snapShot.data!
                                                        .docs[index]['msg'],
                                                    align: snapShot.data!
                                                                .docs[index]
                                                            ['senderId'] ==
                                                        senderId,
                                                    date: (snapShot
                                                            .data!.docs[index]
                                                        ['date'] as Timestamp),
                                                    likeHandaler: (like) => {
                                                          print("Like ${like}")
                                                        }),
                                              ),
                                            ],
                                          )
                                        : snapShot.data!.docs[index]['Type'] ==
                                                'Image'
                                            ? snapShot.data!.docs[index]
                                                        ['senderId'] ==
                                                    senderId
                                                ? snapShot.data!.docs[index]
                                                            ['msg'] !=
                                                        ''
                                                    ? Stack(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      constraints:
                                                                          const BoxConstraints(
                                                                        maxHeight:
                                                                            double.infinity,
                                                                      ),
                                                                      height: Get
                                                                              .height *
                                                                          0.45,
                                                                      width: Get
                                                                              .width *
                                                                          0.6,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .primaryColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 0, top: 0),
                                                                            child:
                                                                                Center(
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  print('------------------img2------------------');

                                                                                  Get.to(ZoomImage(
                                                                                    img: snapShot.data!.docs[index]['image'],
                                                                                  ));
                                                                                },
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  child: OctoImage(
                                                                                    image: CachedNetworkImageProvider(snapShot.data!.docs[index]['image']),
                                                                                    placeholderBuilder: OctoPlaceholder.blurHash(
                                                                                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                                                    ),
                                                                                    errorBuilder: OctoError.icon(color: Colors.red),
                                                                                    height: Get.height * 0.3,
                                                                                    width: Get.width * 0.6,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(
                                                                                /*5
                                                                        .sp*/
                                                                                15),
                                                                            child:
                                                                                Text(
                                                                              "${snapShot.data!.docs[index]['msg']}",
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.white,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10, bottom: 15),
                                                                            child:
                                                                                MsgDate(
                                                                              date: (snapShot.data!.docs[index]['date'] as Timestamp).toDate(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Positioned(
                                                            bottom: 45,
                                                            left: 18,
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 0),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                // color: Colors.red,
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        Images
                                                                            .doubletick),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : StatefulBuilder(builder:
                                                        (BuildContext context,
                                                            setState) {
                                                        print(
                                                            'vvvvvvvvvvvvvvvvvvvvvvvvvvv');

                                                        return Stack(
                                                          alignment: Alignment
                                                              .topRight,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        height: Get.height *
                                                                            0.35,
                                                                        width: Get.width *
                                                                            0.6,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.only(bottom: 5, top: 5, right: 5, left: 5),
                                                                              child: Center(
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    print('------------------img3------------------');

                                                                                    Get.to(ZoomImage(
                                                                                      img: snapShot.data!.docs[index]['image'],
                                                                                    ));
                                                                                  },
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: OctoImage(
                                                                                      image: CachedNetworkImageProvider(snapShot.data!.docs[index]['image']),
                                                                                      placeholderBuilder: OctoPlaceholder.blurHash(
                                                                                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                                                      ),
                                                                                      errorBuilder: OctoError.icon(color: Colors.red),
                                                                                      height: Get.height * 0.3,
                                                                                      width: Get.width * 0.6,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: MsgDate(
                                                                                date: (snapShot.data!.docs[index]['date'] as Timestamp).toDate(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Positioned(
                                                              bottom: 45,
                                                              right: 18,
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          Images
                                                                              .doubletick),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      })
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            maxHeight:
                                                                double.infinity,
                                                          ),
                                                          // height: Get.height * 0.3,
                                                          width:
                                                              Get.width * 0.6,

                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              (authController
                                                                          .chatProfilePic !=
                                                                      "")
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      child: Image
                                                                          .network(
                                                                        authController
                                                                            .chatProfilePic,
                                                                        width: MediaQuery.of(context).size.width /
                                                                            14,
                                                                        height:
                                                                            MediaQuery.of(context).size.width /
                                                                                14,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    )
                                                                  : Image.asset(
                                                                      Images
                                                                          .account,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          12,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          12,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .disabledColor,
                                                                    ),
                                                              Stack(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            15,
                                                                        top: 8),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              '------------------img1------------------');
                                                                          Get.to(
                                                                            ZoomImage(
                                                                              img: snapShot.data!.docs[index]['image'],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          child:
                                                                              OctoImage(
                                                                            image:
                                                                                CachedNetworkImageProvider(snapShot.data!.docs[index]['image']),
                                                                            placeholderBuilder:
                                                                                OctoPlaceholder.blurHash(
                                                                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                                            ),
                                                                            errorBuilder:
                                                                                OctoError.icon(color: Colors.red),
                                                                            height:
                                                                                Get.height * 0.3,
                                                                            width:
                                                                                Get.width * 0.6,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 20,
                                                                    right: 18,
                                                                    child:
                                                                        Container(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                AssetImage(Images.doubletick),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                child: Text(
                                                                  "${snapShot.data!.docs[index]['msg']}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            15),
                                                                child: MsgDate(
                                                                  date: (snapShot
                                                                          .data!
                                                                          .docs[index]['date'] as Timestamp)
                                                                      .toDate(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                            : const SizedBox();
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // if (authController.chatRequestStatus == '1' &&
                //     authController.sigupdata['_id'] == senderId)
                //   StatefulBuilder(builder: (BuildContext context, setState) {
                //     print('recieverId');
                //     print(recieverId);
                //     print('authController');
                //     print(authController.reciverId);
                //
                //     return InkWell(
                //       onTap: () async {
                //         setState(() {
                //           CollectionReference ProfileCollection =
                //               FirebaseFirestore.instance
                //                   .collection('ChatUserList');
                //           if (authController.sigupdata['_id'] != senderId) {
                //             ProfileCollection.doc(chatUserId)
                //                 .update({'requested': "0"}).then((value) async {
                //               setState;
                //
                //               DocumentReference chatCollection = _firestore
                //                   .collection('ChatUserList')
                //                   .doc(recieverId);
                //
                //               final user = await chatCollection.get();
                //
                //               var m = user.data();
                //
                //               dynamic getChatUser = m;
                //               setState(() {
                //                 chatUserId = getChatUser?['chatUserId1'];
                //                 chatUserName = getChatUser?['chatUserName'];
                //
                //                 authController.setChatRequestStatus(
                //                     getChatUser?['requested']!);
                //                 print(
                //                     'chatRequestStatus............... ${authController.chatRequestStatus}');
                //               });
                //             }).catchError((e) => print('stats error'));
                //           }
                //         });
                //       },
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 5),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Container(
                //               width: Get.width * 0.4,
                //               height: Get.height * 0.07,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(15),
                //                   color:
                //                       Theme.of(context).secondaryHeaderColor),
                //               child: Center(
                //                 child: Text(
                //                   'Accept',
                //                   style: poppinsBold.copyWith(
                //                     color: Theme.of(context).cardColor,
                //                     fontSize: Dimensions.fontSizeExtraLarge + 1,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             InkWell(
                //               onTap: () async {
                //                 setState;
                //                 await _firestore
                //                     .collection('ChatUserList')
                //                     .doc(recieverId)
                //                     .delete();
                //                 FirebaseFirestore.instance
                //                     .collection('Chat')
                //                     .doc(chatId(
                //                         senderId!, authController.reciverId))
                //                     .collection('Data')
                //                     .doc()
                //                     .delete();
                //                 Get.back();
                //               },
                //               child: Container(
                //                 width: Get.width * 0.4,
                //                 height: Get.height * 0.07,
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(15),
                //                     color:
                //                         Theme.of(context).secondaryHeaderColor),
                //                 child: Center(
                //                   child: Text(
                //                     'Block',
                //                     style: poppinsBold.copyWith(
                //                       color: Theme.of(context).cardColor,
                //                       fontSize:
                //                           Dimensions.fontSizeExtraLarge + 1,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     );
                //   }),
                // if (authController.chatRequestStatus == '0' &&
                //     authController.sigupdata['_id'] == senderId)
                  StatefulBuilder(builder: (BuildContext context, setState) {
                    print('chatUserID1');
                    print(chatUserId);
                    print('authController2');
                    print(authController.sigupdata['_id']);
                    return InkWell(
                      onTap: () async {},
                      child: Container(
                        child: Column(
                          children: [
                            chatTextField(context),
                            Offstage(
                              offstage: !emojiShowing,
                              child: SizedBox(
                                height: 250,
                                child: EmojiPicker(
                                  onEmojiSelected:
                                      (Category? category, Emoji emoji) {
                                    setState(() {
                                      loginWidth = 80;
                                    });
                                    // Do something when emoji is tapped (optional)
                                  },
                                  textEditingController: myController,
                                  onBackspacePressed: _onBackspacePressed,
                                  config: Config(
                                    columns: 7,
                                    // Issue: https://github.com/flutter/flutter/issues/28894
                                    emojiSizeMax: 32 *
                                        (foundation.defaultTargetPlatform ==
                                                TargetPlatform.iOS
                                            ? 1.30
                                            : 1.0),
                                    verticalSpacing: 0,
                                    horizontalSpacing: 0,
                                    gridPadding: EdgeInsets.zero,
                                    initCategory: Category.RECENT,
                                    bgColor: AppColors.blackColor,
                                    indicatorColor: Colors.blue,
                                    iconColor: Colors.grey,
                                    iconColorSelected: Colors.blue,
                                    backspaceColor: Colors.blue,
                                    skinToneDialogBgColor: Colors.white,
                                    skinToneIndicatorColor: Colors.grey,
                                    enableSkinTones: true,
                                    recentTabBehavior: RecentTabBehavior.RECENT,
                                    recentsLimit: 28,
                                    replaceEmojiOnLimitExceed: false,
                                    noRecents: const Text(
                                      'No Resents',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    loadingIndicator: const SizedBox.shrink(),
                                    tabIndicatorAnimDuration:
                                        kTabScrollDuration,
                                    categoryIcons: const CategoryIcons(),
                                    buttonMode: ButtonMode.CUPERTINO,
                                    checkPlatformCompatibility: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ShowDocument extends StatelessWidget {
  final String? senderId, receiverId;
  final String? type;
  final File? file;
  final LocalFileController con = Get.put(LocalFileController());
  TextEditingController textEditingController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  ShowDocument({Key? key, this.senderId, this.receiverId, this.type, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RECEVER ID: $receiverId');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  child: Type != null && file != null
                      ? Image.file(
                          file!,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textEditingController,
                      style: const TextStyle(
                        color: Color(0xFFA2A2A2),
                      ),
                      decoration: const InputDecoration(
                        hintText: "Write your message...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    uploadImgFirebaseStorage(
                        file: file, msg: textEditingController.text);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.send,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  uploadImgFirebaseStorage({File? file, String? msg}) async {
    FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId!, receiverId!))
        .collection('Data')
        .add({
      'date': DateTime.now(),
      'Type': 'Image',
      'senderId': senderId,
      'receiveId': receiverId,
      'seen': false,
      'msg': msg,
      'text': true,
      'image': type == "image"
          ? AppConstants.IMAGE_BASE_URL + authController.sigupdata['chatPic']
          : "",
    }).then((value) {
      print('successfully uploaded image');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }
}

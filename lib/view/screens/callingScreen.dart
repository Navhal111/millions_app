import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/main.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/agoraAudioCall.dart';
import 'package:million/view/screens/agoraVideoCall.dart';
import 'package:million/view/widget/ChatItem.dart';
import 'package:permission_handler/permission_handler.dart';

class CallingScreen extends StatefulWidget {
  final String? userId, userName, phone, profilePic;

  const CallingScreen(
      {Key? key, this.userName, this.phone, this.profilePic, this.userId})
      : super(key: key);

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  // RtcEngine? _engin;

  int? _remoteID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? chatUserId;
  String? chatUserName;
  String? chatUserPhone;
  String? chatUserProfilePic;

  Future<void> getChatUserInfo() async {
    DocumentReference chatCollection =
        _firestore.collection('ChatUserList').doc(authController.reciverId);



    final user = await chatCollection.get();

    var m = user.data();

    dynamic getChatUser = m;
    setState(() {
      chatUserId = getChatUser?['chatUserId'];
      chatUserName = getChatUser?['chatUserName'];
      chatUserPhone = getChatUser?['phoneNumber'];
      chatUserProfilePic = getChatUser?['profilePic'];
    });

  }

  Future<void> initForAgora() async {
    print('INIT CALL AGORA ............. ');
    await [Permission.microphone].request();
    authController.engin?.setEventHandler(
      RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {

          authController.setRemoteIdForAudio(uid);
        });
      }, leaveChannel: (stats) {

        setState(() {
          authController.setRemoteIdForAudio(0);
          authController.engin?.destroy();
          authController.engin?.leaveChannel();
        });
      }, audioDeviceStateChanged: (deviceId, deviceType, deviceState) {
        authController.setCallingUserId(
            authController.sigupdata["_id"] + "_" + authController.reciverId);

        deviceType = MediaDeviceType.AudioPlayoutDevice;
      }, localAudioStateChanged: (state, error) {

      }),
    );
  }

  onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }


    await authController.setCallingType(authController.callingType);


    Get.to(const CallingScreen());

    // authController.callNotiMsg=="Audio" ?  Get.to(AgoraAudioCallScreen()) : Get.to(AgoraVideoCallScreen());

    // Navigator.push(
    //   navigator!.context,
    //   MaterialPageRoute<void>(
    //     builder: (context) => CallingScreen(
    //       userName: authController.chatUserName ?? "",
    //       phone: authController.chatUserPhone ?? "",
    //       profilePic: authController.chatProfilePic ?? "",
    //       userId: authController.reciverId,
    //     ),
    //   ),
    // );
  }

  @override
  void initState() {
    getChatUserInfo();
    initForAgora();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print('call dispose> ');

    print(authController.remoteIDForAudio);
    print(authController.remoteIDForAudio);
    if (authController.callingType == 'Audio' &&
        authController.remoteIDForAudio == 0) {
      authController.engin?.destroy();
      authController.engin?.leaveChannel();
    }

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: StatefulBuilder(builder: (BuildContext context, setState) {
          return FocusDetector(
            onFocusGained: () {},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: (authController.chatProfilePic != "")
                        ? Image.network(
                            authController.chatProfilePic.toString(),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.4)),
                            child: Icon(
                              Icons.person,
                              size: 70,
                              color: AppColors.whiteColor.withOpacity(0.8),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  authController.chatUserName != ""
                      ? Text(
                          authController.chatUserName,
                          style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeExtraLarge + 10,
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  authController.chatUserPhone != ""
                      ? Text(
                          '+91 ${authController.chatUserPhone ?? 'Phone'}',
                          style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.7),
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: Get.height * 0.25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          print(
                              'Call Type>>>>>>>>>>>>> ${authController.callingType}');
                          setState;


                          Get.back();

                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: AppColors.errorColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.call_end,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          print(
                              ' widget.phone > ${authController.chatUserPhone}');
                          print(authController.callingType);

                          if (authController.callingType == 'Audio') {
                            await [Permission.microphone].request();

                            Get.off(
                              AgoraAudioCallScreen(
                                chatUserName: authController.chatUserName,
                                chatUserPhone: authController.chatUserPhone,
                              ),
                            );
                          } else if (authController.callingType == 'Video') {
                            await [Permission.microphone, Permission.camera]
                                .request();

                            Get.off(
                              AgoraVideoCallScreen(
                                userName: authController.chatUserName,
                                userPhone: authController.chatUserPhone,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.call,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

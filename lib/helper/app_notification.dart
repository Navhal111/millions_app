import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:million/controllers/auth_controller.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/view/screens/callingScreen.dart';
import 'package:million/view/widget/ChatItem.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future getFcmToken() async {
    print('======================text======================1');

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // var comanController = Get.find<ComanController>();

    try {
      String? token = await firebaseMessaging.getToken();
      print("=========fcm-token===$token");
      AppConstants.FCM_TOKEN = token!;
      print('FCM_TOKEN ${AppConstants.FCM_TOKEN}');
      Get.find<AuthController>().setFcmToken(AppConstants.FCM_TOKEN);

      return token;
    } catch (e) {
      print("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    print('======================text======================2');

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      print('MESSAGE >>>>>>>>>>>> ${message}');

      print('MESSAGE ID >>>>>>>>>>>> ${message.data['id']}');

      print(
          'NOtification Call :${notification?.apple}${notification!.body}${notification.title}${notification.bodyLocKey}${notification.bodyLocKey}');
      // FlutterRingtonePlayer.stop();
      // flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     payload: "Notification",
      //      NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           authController.reciverId // id
      //           ,'High Importance Notifications', // title
      //           //'This channel is used for important notifications.',
      //           // description
      //           importance: Importance.high,
      //           icon: '@mipmap/ic_launcher',
      //           // icon: '@mipmap/printo',
      //         ),
      //         iOS: IOSNotificationDetails()));
      if (message != null) {
        print('message>> ${message.data}');

        print(
            "action==onMessage.listen====1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        showMsg(notification, message.data);
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    print('======================text======================3');

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('------RemoteMessage message------$message');
      if (message != null) {
        //  FlutterRingtonePlayer.stop();

        print("action======1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(
      RemoteNotification notification, Map<String, dynamic> data) {

    authController.replaceReciverId(data['id']);

    print('ReciverId >>> ${authController.reciverId}');

    if (data['type'] == 'Audio') {
      print('----in this app');
      print(data['channelName']);

      print(authController.reciverId);
      authController.setCallingType('Audio');

      authController.setCallingUserId(data['channelName']);
      authController.setChannelToken(data['token']);

      print('dataId >>> ${data['id']}');
      print('User Calid >  ${authController.setUserId}');

      // FlutterRingtonePlayer.playRingtone(
      //     looping: false, volume: 50, asAlarm: false);
    } else {
      authController.setCallingType('Video');
      authController.setCallingUserId(data['channelName']);
      authController.setChannelToken(data['token']);

      print('video dataId >>> ${data['id']}');
      print(authController.reciverId);
      print('video  Calid >  ${authController.setUserId}');
    }
    print('======================text======================4');
    print(notification.body);
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Notification Channel",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        ticker: 'ticker');

    flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      payload: "item x",
      NotificationDetails(
          android: androidNotificationDetails,
          iOS: null),
    ).onError((error, stackTrace) => {
        print('======================error error======================  4'),
        print(error)
    });
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('======================text======================5');

    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification? notification = message.notification;
    print(
        '--------split body ${notification!.body.toString().split(' ').first}');
    if (notification.body.toString().split(' ').first == 'calling') {
      print('----in this app');

      print(notification);

      print(notification.android);

      // FlutterRingtonePlayer.playRingtone(
      //     looping: false, volume: 50, asAlarm: false);
    }

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('======================text======================6');

      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
      // FlutterRingtonePlayer.stop();

      if (message != null) {
        // print("action======1=== ${message?.data['action_click']}");
        print("action======2=== ${message.data['action_click']}");
        //  FlutterRingtonePlayer.stop();

        // _barViewModel.selectedRoute('DashBoardScreen');
        // _barViewModel.selectedBottomIndex(0);
      }
    });
  }

  /// send notification device to device
  static Future<bool?> sendMessage(
      {String? receiverFcmToken, String? msg, String? name}) async {
    print('======================text======================7');
    var serverKey =
        'AAAAIUXmXPE:APA91bHJJ3viL1swEVsr0p2xy2eBrWdJF2V7femtC_5DWQQetEfYnC9A3JYpZnSMUrJ8nr73xIJvP4obC5TTNocVw-BK5n5twH3i0LTSD_0cwJ_i9yxYPo1BVgf_x99fLKKLM56hORwc';
    try {
      // for (String token in receiverFcmToken) {
      print("RESPONSE TOKEN  $receiverFcmToken");

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg ?? 'msg',
              'title': name,
              'bodyLocKey': 'true'
            },
            'priority': 'high',
            'to': receiverFcmToken,
          },
        ),
      );
      print("RESPONSE CODE ${response.statusCode}");

      print("RESPONSE BODY ${response.body}");
      // return true}
    } catch (e) {
      print("error push notification");
      // return false;
    }
  }
}

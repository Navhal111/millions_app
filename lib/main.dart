import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:million/controllers/splash_controller.dart';
import 'package:million/controllers/theme_controller.dart';
import 'package:million/helper/app_notification.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/theme/dark_theme.dart';
import 'package:million/theme/light_theme.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/agoraAudioCall.dart';
import 'package:million/view/widget/ChatItem.dart';
import 'package:permission_handler/permission_handler.dart';

import 'helper/get_di.dart' as di;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

String? token;

getToken() async {
  token = await FirebaseMessaging.instance.getToken();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppNotificationHandler.getFcmToken();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await GetStorage.init();

  ///
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  AppNotificationHandler.getInitialMsg();
  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  AppNotificationHandler.showMsgHandler();
  await di.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("=====================_route _route=================================");
  runApp(MyApp());
}

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print("=====================_route onDidReceiveLocalNotification =================================");
    // display a dialog with the notification details, tap ok to go to another page
  }

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;

  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }

  await authController.setCallingType(authController.callingType);

  if (notificationResponse.actionId == 'accept') {
    Get.to(AgoraAudioCallScreen());
  } else if (notificationResponse.actionId == "reject") {
    Get.back();
  }

}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status ${e}');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<SplashController>(builder: (splashController) {
        return (ConnectivityResult.none == _connectionStatus)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.wifi,
                    width: MediaQuery.of(context).size.width / 1,
                    height: Get.height * 0.2,
                  ),
                  Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.1,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Center(
                        child: Text(
                          'No internet connection. Please check your connectivity',
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeLarge + 4,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : (GetPlatform.isWeb)
                ? const SizedBox()
                : GetMaterialApp(
                    title: AppConstants.APP_NAME,
                    debugShowCheckedModeBanner: false,
                    navigatorKey: Get.key,
                    scrollBehavior: MaterialScrollBehavior(),
                    theme: themeController.darkTheme ? dark : light,
                    locale: Locale("en", "US"),
                    fallbackLocale: Locale("en", "US"),
                    initialRoute: GetPlatform.isWeb
                        ? RouteHelper.getInitialRoute()
                        : RouteHelper.getSplashRoute(AppConstants.APP_VERSION),
                    getPages: RouteHelper.routes,
                    defaultTransition: Transition.rightToLeft,
                    transitionDuration: Duration(milliseconds: 500),
                  );
      },);
    },);
  }
}

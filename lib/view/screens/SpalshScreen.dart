import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  final String? appVersion;
  SplashScreen({this.appVersion});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool showkabke = false;
  bool showquate = false;
  late AnimationController _animationController;
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  late final AnimationController _controller = AnimationController(
    duration: Duration(microseconds: 600),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));
  var authController = Get.find<AuthController>();
  void _onPressed() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  double _opacity = 0.1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 8000),
    );
    _controller.forward().then((value) => {
          _controller.reverse().then((value) => {
                // setState(() {
                showkabke = true,
                // }),
                Timer(Duration(/*seconds: 1*/ microseconds: 600), () async {

                  _onPressed();
                  // setState(() {
                  showquate = true;
                  setState(() => _opacity = 1);
                  // });
                })
              })
        });
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        print('check connection........$isNotConnected');
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 8000 : 3),
          content: Text(
            isNotConnected ? 'No Connection' : 'Connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
    });
    Timer(Duration(milliseconds: 4500), () async {
      setState(() {
        _opacity = 1;
      });

      await authController.getUserRefreshToken();
      await authController.getUserToken();
      await authController.getUserDetails();

      print('authController.sigupdata["_id"] ');

      print(authController.sigupdata["_id"]);

      if ((authController.sigupdata["_id"] != null) == true) {
        Get.offNamed(RouteHelper.getDashBoardRought(0));
      } else {
        Get.offNamed(RouteHelper.getLoginRoute(AppConstants.APP_VERSION));
      }
      setState(() {});
    });
  }

  @override
  void dispose() {

    _controller.dispose();
    _animationController.dispose();
    _onConnectivityChanged.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Image.asset(
                    Images.spalshScreen,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                  ),
                ),
                FocusDetector(
                  onVisibilityGained: () async {
                    await showkabke;
                  },
                  child: AnimatedContainer(
                    width: showkabke ? 165 : 0,
                    duration: Duration(seconds: 1),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3.3,
                      margin: EdgeInsets.only(top: 0, bottom: 13),
                      padding: EdgeInsets.only(left: 5, top: 52),
                      child: Text(
                        "illion",
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(1),
                          fontSize: MediaQuery.of(context).size.width / 6,
                          letterSpacing: 0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            AnimatedOpacity(
              opacity: _opacity,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1000),
              child: Text(
                "Where big dreams come true.",
                style: poppinsBold.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(1),
                  fontSize: Dimensions.fontSizeExtraLarge + 5,
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            // AnimatedContainer(
            //   height: showquate ? Dimensions.fontSizeExtraLarge + 10 : 0,
            //   duration: Duration(seconds: 1),
            //   child: Text(
            //     "Where big dreams come true.",
            //     style: poppinsBold.copyWith(
            //       color: Theme.of(context).hintColor.withOpacity(1),
            //       fontSize: Dimensions.fontSizeExtraLarge + 5,
            //       letterSpacing: 0,
            //     ),
            //     textAlign: TextAlign.start,
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.only(left: 5),
            //   child: DefaultTextStyle(
            //     style: poppinsBold.copyWith(
            //       color: Theme.of(context).hintColor,
            //       fontSize: Dimensions.fontSizeExtraLarge + 5,
            //     ),
            //     child: AnimatedTextKit(
            //       isRepeatingAnimation: true,
            //       animatedTexts: [
            //         WavyAnimatedText('Where big dreams come true.',
            //             speed: Duration(milliseconds: 100)),
            //       ],
            //       onTap: () {},
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ],
        )),
      ),
    );
  }
}

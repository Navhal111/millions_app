import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/screens/convert_date_format_chat.dart';
import 'package:million/view/widget/ShadowWidget.dart';

class MassageItem extends StatefulWidget {
  final String msg;
  final bool align;
  final Timestamp date;
  final bool? hart;
  final AuthController authController;
  final Function likeHandaler;

  MassageItem(
      {required this.msg,
      required this.align,
      required this.date,
      required this.hart,
      required this.likeHandaler,
      required this.authController});

  @override
  _MassageItemState createState() => _MassageItemState();
}

class _MassageItemState extends State<MassageItem>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Tween<double> tween = Tween(begin: 0.9, end: 1.2);
  bool showheart = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    super.initState();

    Timer(Duration(milliseconds: 4500), () async {
      // Get.offNamed(RouteHelper.getLoginRoute(AppConstants.APP_VERSION));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.align ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: widget.align
            ? EdgeInsets.only(left: Get.width / 5, right: 10)
            : const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment:
              widget.align ? CrossAxisAlignment.end : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.align
                ? Container()
                : (widget.authController.chatProfilePic != "" ||
                        widget.authController.chatProfilePic != "")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.authController.chatProfilePic,
                          width: MediaQuery.of(context).size.width / 14,
                          height: MediaQuery.of(context).size.width / 14,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.asset(
                        Images.account,
                        width: MediaQuery.of(context).size.width / 12,
                        height: MediaQuery.of(context).size.width / 12,
                        color: Theme.of(context).disabledColor,
                      ),
            Stack(
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    _controller!.forward(from: 0.9);
                    _controller!.reverse();
                    widget.likeHandaler(!showheart);
                    Timer(Duration(milliseconds: 700), () async {
                      setState(() {
                        showheart = !showheart;
                      });
                    });
                  },
                  child: ScaleTransition(
                    scale: tween.animate(
                      CurvedAnimation(
                          parent: _controller!, curve: Curves.elasticOut),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: widget.align
                          ? AppColors.primaryColor
                          : AppColors.whiteColor.withOpacity(0.3),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      elevation: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.msg,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu-Regular',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            child: MsgDate(
                              date: (widget.date).toDate(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 25,right: 5,bottom: 5),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.doubletick),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                showheart || widget.hart!
                    ? Positioned(
                        left: 10,
                        bottom: 0,
                        child: AnimatedSwitcher(
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          duration: Duration(microseconds: 700),
                          child: Image.asset(
                            Images.heart,
                            width: 10,
                            height: 10,
                          ),
                        ))
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ShadowWidget extends StatelessWidget {
  final Widget widget;
  final Color? color;
  ShadowWidget({required this.widget, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 180,
      margin: EdgeInsets.only(right: 15, left: 10, top: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.1),
          //     offset: Offset(-6.0, -6.0),
          //     blurRadius: 10.0,
          //   ),
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.4),
          //     offset: Offset(6.0, 6.0),
          //     blurRadius: 16.0,
          //   ),
          // ],
          // border: Border.all(
          //     width: 1, color: Theme.of(context).cardColor.withOpacity(0.3)),
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget,
      ),
    );
  }
}

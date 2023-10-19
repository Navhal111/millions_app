import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/view/widget/ChatItem.dart';

String? convertDateForm(DateTime tm) {
  DateTime today = new DateTime.now();
  Duration oneDay = new Duration(days: 1);
  Duration twoDay = new Duration(days: 2);
  Duration oneWeek = new Duration(days: 7);
  String? month;
  switch (tm.month) {
    case 1:
      month = "january";
      break;
    case 2:
      month = "february";
      break;
    case 3:
      month = "march";
      break;
    case 4:
      month = "april";
      break;
    case 5:
      month = "may";
      break;
    case 6:
      month = "june";
      break;
    case 7:
      month = "july";
      break;
    case 8:
      month = "august";
      break;
    case 9:
      month = "september";
      break;
    case 10:
      month = "october";
      break;
    case 11:
      month = "november";
      break;
    case 12:
      month = "december";
      break;
  }

  Duration difference = today.difference(tm);
  if (difference.compareTo(Duration(minutes: 1)) < 1) {
    return '${DateFormat.jm().format(tm)}';
  } else if (difference.compareTo(Duration(hours: 1)) < 1) {
    // return '${difference.inMinutes} minute';
    return '${DateFormat.jm().format(tm)}';
  } else if (difference.compareTo(oneDay) < 1) {
    return '${DateFormat.jm().format(tm)}';
    // return '${difference.inHours} hours';
  } else if (difference.compareTo(twoDay) < 1) {
    authController.setChatAfterOneDay(true);
    authController.setChatDateAfterDay("yesterday");

    return "yesterday";
  } else if (difference.compareTo(oneWeek) < 1) {
    authController.setChatAfterOneDay(true);

    switch (tm.weekday) {
      case 1:
        authController.setChatDateAfterDay("monday");
        return "monday";

      case 2:
        authController.setChatDateAfterDay("tuesday");
        return "tuesday";

      case 3:
        authController.setChatDateAfterDay("wednesday");
        return "wednesday";

      case 4:
        authController.setChatDateAfterDay("thursday");
        return "thursday";

      case 5:
        authController.setChatDateAfterDay("friday");
        return "friday";

      case 6:
        authController.setChatDateAfterDay("saturday");
        return "saturday";

      case 7:
        authController.setChatDateAfterDay("sunday");
        return "sunday";
    }
  } else if (tm.year == today.year) {
    return '${tm.day} $month';
  } else {
    return '${tm.day} $month ${tm.year}';
  }
}

String chatId(String id1, String id2) {
  print('id1 length => ${id1.length} id2 length=> ${id2.length}');
  if (id1.compareTo(id2) > 0) {
    return id1 + '-' + id2;
  } else {
    return id2 + '-' + id1;
  }
}

class MsgDate extends StatefulWidget {
  const MsgDate({Key? key, this.date}) : super(key: key);
  final date;

  @override
  State<MsgDate> createState() => _MsgDateState();
}

class _MsgDateState extends State<MsgDate> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${convertDateForm(widget.date)}',
      style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: Dimensions.fontSizeExtraSmall,
          fontWeight: FontWeight.w600),
      textAlign: TextAlign.start,
    );
  }
}

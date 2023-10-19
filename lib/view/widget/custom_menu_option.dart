import 'package:flutter/material.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/filteritem.dart';

class CustomMenuOption extends StatefulWidget {
  const CustomMenuOption({Key? key}) : super(key: key);

  @override
  State<CustomMenuOption> createState() => _CustomMenuOptionState();
}

class _CustomMenuOptionState extends State<CustomMenuOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Options",
                style: poppinsBold.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: Dimensions.fontSizeExtraLarge + 1,
                ),
                textAlign: TextAlign.start,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).cardColor.withOpacity(
                        (0.7),
                      ),
                ),
              )
            ],
          ),
          FilterItem(title: "Policy", isinner: true),
          FilterItem(title: "Terms and Conditions", isinner: true),
          FilterItem(title: "Settings", isinner: true),
        ],
      ),
    );
  }
}

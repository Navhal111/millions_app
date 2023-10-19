import 'package:flutter/material.dart';
import 'package:million/theme/app_colors.dart';

class AppliedDocsWidget extends StatelessWidget {
  final List? applyDocsumnet;
  const AppliedDocsWidget({super.key, this.applyDocsumnet});

  @override
  Widget build(BuildContext context) {
    return Container(
     child: ListView.builder(
        itemCount:applyDocsumnet?.length ,shrinkWrap: true,
        itemBuilder: (context, index) {
          print(applyDocsumnet?[index]);
        return Container(
          child: Text(applyDocsumnet?[index]),
        );
      },),
    );
  }
}

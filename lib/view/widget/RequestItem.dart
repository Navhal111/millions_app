import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';

class RequestList extends StatelessWidget {
  final String title;
  final String dec;
  RequestList({required this.title, required this.dec});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(RouteHelper.getJobdetailsRought());
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.avtar,
                        width: MediaQuery.of(context).size.width / 6,
                        height: MediaQuery.of(context).size.width / 6,
                        color: Theme.of(context).disabledColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: poppinsBold.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "3:25 PM",
                                  style: poppinsBold.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Text(
                                      "Accept",
                                      style: poppinsBold.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Text(
                                      "Reject",
                                      style: poppinsBold.copyWith(
                                        color: Theme.of(context).errorColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    color: Theme.of(context).secondaryHeaderColor,
                    height: 2,
                  )
                ],
              )),
        ));
  }
}

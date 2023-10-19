import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/my_text_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  final String? appVersion;

  OtpScreen({this.appVersion});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController? contrller1;
  TextEditingController? contrller2;
  TextEditingController? contrller3;
  TextEditingController? contrller4;

  @override
  void initState() {
    contrller1 = TextEditingController();
    contrller2 = TextEditingController();
    contrller3 = TextEditingController();
    contrller4 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          key: _globalKey,
          backgroundColor: Theme.of(context).primaryColor,
          body: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 56,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.width / 9,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 38,
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 9),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.1),
                                    width: 1)),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Enter OTP",
                            style: poppinsRegular.copyWith(
                              color: Theme.of(context).hintColor.withOpacity(0.7),
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text(
                      "Please enter your OTP send to your register mobile number",
                      style: poppinsBold.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                        fontSize: Dimensions.fontSizeExtraLarge - 2,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(
                          first: true, last: false, controllerr: contrller1),
                      _textFieldOTP(
                          first: false, last: false, controllerr: contrller2),
                      _textFieldOTP(
                          first: false, last: false, controllerr: contrller3),
                      _textFieldOTP(
                          first: false, last: true, controllerr: contrller4),
                    ],
                  ),
                  CustomButton(loading:authController.isLoading ,
                    onPressed: () async{
                      print('OTP<<< ${contrller1!.text+ contrller2!.text+ contrller3!.text+ contrller4!.text}');
                      await  authController.checkOTP(context,otp: contrller1!.text+ contrller2!.text+ contrller3!.text+ contrller4!.text);

                    },
                    buttonText: "Verify",
                    fontSize: Dimensions.fontSizeLarge,
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
                    radius: Dimensions.RADIUS_SMALL,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                        onTap: () => {
                              Get.back(),
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: poppinsRegular.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.3),
                                    fontSize: Dimensions.fontSizeDefault)),
                            Text(" Sign In",
                                style: poppinsBold.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeDefault))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }



  Widget _textFieldOTP(
      {bool? first, last, TextEditingController? controllerr}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.blackColor,
      height:60,
      width: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controllerr,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,

          textAlign: TextAlign.center,
          style: poppinsRegular.copyWith(
              fontFamily: 'DMSans',
              fontSize: 14,
              color: Theme.of(context).hintColor),
          keyboardType: TextInputType.number,
          maxLength: 1,
          cursorColor: Theme.of(context).backgroundColor,
          decoration: InputDecoration(

            fillColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            counter: Offstage(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color:  Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  width: Dimensions.border_width),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color:  Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  width: Dimensions.border_width),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                  color: Theme.of(context).backgroundColor,
                  width: Dimensions.border_width),
            ),
            hintStyle:
                poppinsRegular.copyWith(color: Theme.of(context).hintColor),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/ChatItem.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/my_text_field.dart';

class ForgotPassword extends StatefulWidget {
  final String? appVersion;

  ForgotPassword({this.appVersion});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController textController = TextEditingController();

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
                              "Password Reset",
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
                        "Please enter your register Email or Phone number.",
                        // "Please enter your country code and your register Email",
                        style: poppinsBold.copyWith(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontSize: Dimensions.fontSizeExtraLarge - 2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MyTextField(
                        controller: textController,
                        maxLines: 1,
                        autoFocus: true,  inputType: TextInputType.emailAddress,

                        hintText: 'Enter your Email / Phone Number',
                        titleText: 'Email / Phone Number',
                        fillColor:
                            Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                        onTap: () => {},

                        onChanged: (text) => {print(text)},
                        onSubmit: () => {},
                      ),
                    ),
                    CustomButton(
                      loading: authController.isLoading,
                      onPressed: () async {
                        print('authController.isLoading');
                        print(authController.isLoading);
                        if (textController.text.isNotEmpty) {

                            authController.forgatePass(context,
                              forgateText: textController.text);
                        } else {
                          showCustomSnackBar(
                              'Please Enter Register Email or Phone Number.',
                              context!,
                              isError: true);
                        }
                      },
                      buttonText: "Send",
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
              )),
        );
      }
    );
  }
}

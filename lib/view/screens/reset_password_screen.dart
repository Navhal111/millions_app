import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/my_text_field.dart';

class ResetPassword extends StatefulWidget {
  final String? appVersion;

  ResetPassword({this.appVersion});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        key: _globalKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 56,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                    left:
                                        MediaQuery.of(context).size.width / 38,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width /
                                              9),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Text(
                                  "Password Reset",
                                  style: poppinsRegular.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            "Please enter your new Password",
                            style: poppinsBold.copyWith(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5),
                              fontSize: Dimensions.fontSizeExtraLarge - 2,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: MyTextField(
                            controller: oldPass,
                            maxLines: 1,
                            capitalization: TextCapitalization.sentences,
                            hintText: 'Enter Old Password',
                            titleText: 'Old Password',
                            fillColor: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.7),
                            onTap: () => {},
                            inputType: TextInputType.text,
                            onChanged: (text) => {print(text)},
                            onSubmit: () => {},
                            isPassword: true,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: MyTextField(
                            controller: newPass,
                            maxLines: 1,
                            capitalization: TextCapitalization.sentences,
                            hintText: 'Enter New Password',
                            titleText: 'New Password',
                            fillColor: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.7),
                            onTap: () => {},
                            inputType: TextInputType.text,
                            onChanged: (text) => {print(text)},
                            onSubmit: () => {},
                            isPassword: true,
                          ),
                        ),
                        CustomButton(
                          onPressed: () async{
                            if(oldPass.text.isNotEmpty && newPass.text.isNotEmpty){
                             await authController.resetPassword(context,password: oldPass.text , newpassword: newPass.text);
                            }else{
                              showCustomSnackBar(
                                  'Please Enter all Details', context!,
                                  isError: true);
                            }
                            Get.back();
                          },
                          buttonText: "Reset",
                          fontSize: Dimensions.fontSizeLarge,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 25, bottom: 10),
                          radius: Dimensions.RADIUS_SMALL,
                         ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

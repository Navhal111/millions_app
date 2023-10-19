import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/custom_button.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  final String? appVersion;
  LoginScreen({this.appVersion});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _login(
    AuthController authController,
  ) async {
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (_email.isEmpty) {
      showCustomSnackBar('Please enter your  email.', context);
    } else if (_password.isEmpty) {
      showCustomSnackBar('Please enter your password.', context);
    } else if (_password.length < 6) {
      showCustomSnackBar(
          'Password should be greater than 6 characters', context);
    } else if (emailValid == false) {
      showCustomSnackBar('Email id should be valid', context);
    } else {
      // authController.sigupdata['status'] == 1;
      authController.login(_email, _password).then((status) async {
        if (status.isSuccess) {
          authController.saveUserEmailAndPassword(
            _email,
            _password,
          );
          String _token = status.message.substring(1, status.message.length);
          debugPrint('Sign In Token: ');
          // authController.userdetails['status'] = 1;
          // authController.sigupdata['status'] = 1;
          // authController.userdetails['profileType'] = "eventplanner";
          // authController.sigupdata['profileType'] = "eventplanner";
          // bottomController.selectedScreen('HomePage');
          // bottomController.bottomIndex.value = 0;
          Get.offAndToNamed(RouteHelper.getDashBoardRought(0));
        } else {
          debugPrint('Messssssage: ');
          print(status.message);
          showCustomSnackBar('Invalid username or password!', context);
        }
      });
    }
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          InkWell(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Sign In",
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MyTextField(
                        controller: _emailController,
                        maxLines: 1,
                        hintText: 'Enter your Email  ',
                        titleText: 'Email  ',
                        fillColor: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.7),
                        onTap: () => {},
                        inputType: TextInputType.emailAddress,
                        onChanged: (text) => {print(text)},
                        onSubmit: () => {},
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MyTextField(
                        controller: _passwordController,
                        maxLines: 1,
                        capitalization: TextCapitalization.sentences,
                        hintText: 'Enter your Password',
                        titleText: 'Password',
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
                    InkWell(
                      onTap: () =>
                          {Get.toNamed(RouteHelper.getForgotpassRought())},
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          "Forgot Password",
                          style: poppinsBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeExtraLarge - 2,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    CustomButton(
                      loading: authController.isLoading,
                      onPressed: () {
                        _login(authController);
                      },
                      buttonText: "Sign In",
                      fontSize: Dimensions.fontSizeLarge,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 25, bottom: 10),
                      radius: Dimensions.RADIUS_SMALL,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: InkWell(
                          onTap: () => {
                                Get.toNamed(RouteHelper.getSignupRoute()),
                              },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Don't Have an Acoount?",
                                  style: poppinsRegular.copyWith(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeDefault)),
                              Text(" Sign up",
                                  style: poppinsBold.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeDefault))
                            ],
                          )),
                    ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    //   child: Text(
                    //     "or",
                    //     style: poppinsRegular.copyWith(
                    //       color: Theme.of(context).hintColor.withOpacity(0.7),
                    //       fontSize: Dimensions.fontSizeLarge,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    //   child: Text(
                    //     "Log in with one of the following options",
                    //     style: poppinsRegular.copyWith(
                    //       color: Theme.of(context).hintColor.withOpacity(0.7),
                    //       fontSize: Dimensions.fontSizeDefault,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width/2,
                    //   padding:EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       InkWell(
                    //         child: Container(
                    //           width:
                    //               (MediaQuery.of(context).size.width / 4) - 30,
                    //           height:
                    //               (MediaQuery.of(context).size.width / 4) - 30,
                    //           padding: EdgeInsets.only(
                    //             left: 5,
                    //           ),
                    //           decoration: BoxDecoration(
                    //               color: Theme.of(context).secondaryHeaderColor,
                    //               borderRadius: BorderRadius.circular(10),
                    //               border: Border.all(
                    //                   color: Theme.of(context)
                    //                       .disabledColor
                    //                       .withOpacity(0.1),
                    //                   width: 1)),
                    //           child: Center(
                    //             child: Image.asset(
                    //               Images.fb,
                    //               width: MediaQuery.of(context).size.width / 14,
                    //               height:
                    //                   MediaQuery.of(context).size.width / 14,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         child: Container(
                    //           width:
                    //               (MediaQuery.of(context).size.width / 4) - 30,
                    //           height:
                    //               (MediaQuery.of(context).size.width / 4) - 30,
                    //           padding: EdgeInsets.only(
                    //             left: 5,
                    //           ),
                    //           decoration: BoxDecoration(
                    //               color: Theme.of(context).secondaryHeaderColor,
                    //               borderRadius: BorderRadius.circular(10),
                    //               border: Border.all(
                    //                   color: Theme.of(context)
                    //                       .disabledColor
                    //                       .withOpacity(0.1),
                    //                   width: 1)),
                    //           child: Center(
                    //             child: Image.asset(
                    //               Images.google,
                    //               width: MediaQuery.of(context).size.width / 15,
                    //               height:
                    //                   MediaQuery.of(context).size.width / 15,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

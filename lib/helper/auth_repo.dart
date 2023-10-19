import 'dart:convert';
import 'dart:io' as Io;

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;
import 'package:million/api/api_client.dart';
import 'package:million/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.REFRESH_TOKEN);
    sharedPreferences.remove(AppConstants.USER_EMAIL);
    sharedPreferences.remove(AppConstants.USER_PASSWORD);

    apiClient.token = null;
    apiClient.reToken = null;
    apiClient.updateHeader(
      "",
      "",
    );
    return true;
  }

  Future<Response> fcmTokenUpdate(fcmToken) async {

    print(fcmToken);

    return await apiClient.putData(AppConstants.USER_UPDATE, {
      "fcmToken": fcmToken,
    });
  }

  String getUserRefreshToken() {
    // sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    return sharedPreferences.getString(AppConstants.REFRESH_TOKEN) ?? "";
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  // for  user token
  Future<bool> saveUserToken(
    String accessToken,
    String refreshToken,
  ) async {
    apiClient.token = accessToken;
    apiClient.reToken = refreshToken;
    apiClient.updateHeader(
      accessToken,
      refreshToken,
    );

    print('accessToken---  $accessToken');
    print('refreshToken--  $refreshToken');
    await sharedPreferences.setString(AppConstants.REFRESH_TOKEN, refreshToken);
    return await sharedPreferences.setString(AppConstants.TOKEN, accessToken);
  }

  Future<Response> getRegister(Map<String, dynamic> signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER, signUpBody);
  }

  Future<Response> login(
      {required String email, required String password}) async {
    return await apiClient
        .postData(AppConstants.LOGIN, {"email": email, "password": password});
  }

 Future<Response> forgatePass(
      {required String forgateText }) async {
    return await apiClient
        .postData(AppConstants.FORGOT_PASSWORD, {"forgateText": forgateText });
  }
Future<Response> updatePassword(
      {required String userid ,password}) async {
    return await apiClient
        .postData(AppConstants.UPDATE_PASSWORD, {"userid": userid ,"password":password});
  }

  Future<Response> resetPassword(
      {required String password ,newpassword}) async {
    return await apiClient
        .postData(AppConstants.RESET_PASSWORD, {"password": password ,"newpassword":newpassword});
  }

Future<Response> checkOTP(
      {required String otp }) async {
    return await apiClient
        .postData(AppConstants.CHECK_OTP, {"otp": otp });
  }

  Future<Response> getUserDetails() async {
    return await apiClient.getData(AppConstants.USER_DETAILS);
  }

  Future<Response> getFollowingUserProfile(String userID) async {
    return await apiClient.getData(AppConstants.USER_DETAILS + userID);
  }

  Future<Response> userUpdate(
    profilePic,
    String fullName,
    country,
    phoneNumber,
    gender,
    age,
    zipCode,
    bio,
    private,skills
  ) async {
    return await apiClient.putData(AppConstants.USER_UPDATE, {
      "profilePic": profilePic,
      "fullName": fullName,
      "country": country,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "age": age,
      "zipCode": zipCode,
      "bio": bio,
      "private":private,
      "skills": skills
    });
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }



  Future<Response> getSearchUserApi(String searchText) async {
    return await apiClient.getData(AppConstants.SEARCH_USER + searchText);
  }



  Future<Response> FollowOtherApi(String userId) async {
    //
    return await apiClient.getData(AppConstants.USER_GET_FOLLOW_OTHER + userId);
  }

  Future<Response> userFollowerApi({
    required dynamic followerId,
  }) async {
    return await apiClient.postData(AppConstants.USER_FOLLOW, {
      "follower": followerId,
    });
  }
  Future<Response> getSendMsgNoti({
    required dynamic otherid,
    required dynamic massage,
  }) async {
    return await apiClient.postData(AppConstants.SEND_MSG, {
      "otherid": otherid,
      "massage": massage,
    });
  }

  Future<Response> getRemoveFollowApi({
    required dynamic follower,
  }) async {
    return await apiClient.postData(AppConstants.REMOVE_FOLLOWER, {
      "follower": follower,
    });
  }

  Future<Response> unFollowUserApi({
    required dynamic followerId,
  }) async {
    return await apiClient.postData(AppConstants.UNFOLLOW, {
      "follower": followerId,
    });
  }

  Future<Response> userFollowingApi({
    required dynamic followerId,
  }) async {

    return await apiClient
        .getData(AppConstants.USER_FOLLOWING_API + followerId);
  }

  Future<Response> sendPhoneNotification({
    required dynamic receverId,title,dec,fcm_token,type,channelName
  }) async {
    return await apiClient.postData(AppConstants.SEND_PHONE_NOTIFICATION, {
      "userid": receverId,
      "title": title,
      "dec": dec,
      "token": fcm_token,
      "type": type,
      "channelName": channelName,

    });
  }

  Future<dynamic> uploadImage(
    key,
    String? file,
    String path,
  ) async {
    final postUri = Uri.parse(AppConstants.BASE_URL + AppConstants.UPLOAD_FILE);

    Http.MultipartRequest request = Http.MultipartRequest('POST', postUri);
    List<int> imageBytes = Io.File(path).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    // debugPrint("image $base64Image");
    return await apiClient.appUserUploadFileAsyncProfile(
      file,
      base64Image,
    );
  }
  Future<dynamic> uploadDocs(
      key,
      String? file,
      String path,
      ) async {
    final postUri = Uri.parse(AppConstants.BASE_URL + AppConstants.UPLOAD_DOCS);

    Http.MultipartRequest request = Http.MultipartRequest('POST', postUri);
    List<int> imageBytes = Io.File(path).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    // debugPrint("image $base64Image");
    return await apiClient.appUserUploadFileAsyncProfileUpload(
      file,
      base64Image,
    );
  }


  Future<Response> country() async {
    return await apiClient.getData(AppConstants.USER_COUNTRY);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:million/helper/app_notification.dart';
import 'package:million/helper/auth_repo.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/response_model.dart';
import 'package:million/view/screens/callingScreen.dart';
import 'package:million/view/widget/customPopupDialog.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isImgLoading = false;


  bool get isImgLoading => _isImgLoading;

  bool _isProfileImgLoading = false;


  bool get isProfileImgLoading => _isProfileImgLoading;

  bool _isAfterWholeDay = false;

  bool get isAfterWholeDay => _isAfterWholeDay;
  String _chatDateAfterDay = "";

  String get chatDateAfterDay => _chatDateAfterDay;

  String _genderVal = "";

  String get genderVal => _genderVal;
  String _ethnicalVal = "";

  String get ethnicalVal => _ethnicalVal;
  String _callingType = "";

  String get callingType => _callingType;
  String _callNotiToken = "";

  String get callNotiToken => _callNotiToken;
  String _setUserId = "";

  String get setUserId => _setUserId;
  String _channelToken = "";

  String get channelToken => _channelToken;
  String _imageData = "";

  String get imageData => _imageData;
  int _remoteIDForAudio = 0;

  int get remoteIDForAudio => _remoteIDForAudio;
  List<dynamic> _countryList = [];

  List<dynamic> get countryList => _countryList;
  String _fcmToken = "";

  String get fcmToken => _fcmToken;

  dynamic _engin;

  dynamic get engin => _engin;

  createRtcEngineAudio(dynamic app_id) {
    _engin = app_id;
  }

  String _reciverId = "";

  String get reciverId => _reciverId;
  String _chatProfilePic = "";

  String get chatProfilePic => _chatProfilePic;

  String _chatUserPhone = "";

  String get chatUserPhone => _chatUserPhone;

  String _chatUserName = "";

  String get chatUserName => _chatUserName;

  String _receiverFCMToken = "";

  String get receiverFCMToken => _receiverFCMToken;

  String _postType = "";

  String get postType => _postType;

  Map<String, dynamic> _sigupdata = {};

  Map<String, dynamic> get sigupdata => _sigupdata;

  Map<String, dynamic> _documnetData = {};

  Map<String, dynamic> get documnetData => _documnetData;

  Map<String, dynamic> _otherUserDetails = {};

  Map<String, dynamic> get otherUserDetails => _otherUserDetails;

  Map<String, dynamic> _getfollowerDetail = {};

  Map<String, dynamic> get getfollowerDetail => _getfollowerDetail;

  String _userFollowersDetail = "";

  String get userFollowersDetail => _userFollowersDetail;

  String _getOtherUserFcmToken = "";

  String get getOtherUserFcmToken => _getOtherUserFcmToken;

  String _unFollow = "";

  String get unFollow => _unFollow;

  List<dynamic> _otherFollwe = [];

  List<dynamic> get otherFollwe => _otherFollwe;

  List<dynamic> _otherFollowing = [];

  List<dynamic> get otherFollowing => _otherFollowing;

  List<dynamic> _follower = [];

  List<dynamic> get follower => _follower;

  String _folloUserId = "";

  String get folloUserId => _folloUserId;

  String _chatUserfollowUserId = "";

  String get chatUserfollowUserId => _chatUserfollowUserId;

  List<dynamic> _following = [];

  List<dynamic> get following => _following;

  List<dynamic> _followerList = [];

  List<dynamic> get followerList => _followerList;

  List<dynamic> _followingList = [];

  List<dynamic> get followingList => _followingList;

  String _unionStatus = "";

  String get unionStatus => _unionStatus;

  String _compensationVal = "";

  String get compensationVal => _compensationVal;
  String _chatRequestStatus = "0";

  String get chatRequestStatus => _chatRequestStatus;

  List<dynamic> _ageRangeList = [];

  List<dynamic> get ageRangeList => _ageRangeList;

  bool _sendterChat = false;

  bool get sendterChat => _sendterChat;

  dynamic _picDocs;

  File get picDocs => _picDocs;

  List<dynamic> _pichDocsList = [];

  List<dynamic> get pichDocsList => _pichDocsList;

  Map<String, dynamic> _getforgotUserDetail = {};

  Map<String, dynamic> get getforgotUserDetail => _getforgotUserDetail;

  setChatRequestStatus(String newStatus){
    _chatRequestStatus = newStatus;
    update();
  }
  setAgeRangeList(List newAgeList) {
    _ageRangeList = newAgeList;
    update();
  }

  setSenderChat(bool send) {
    _sendterChat = send;
    update();
  }

  setUnionStatus(String unionStatus) {
    _unionStatus = unionStatus;
    update();
  }

  setCompensationVal(String compensationVal) {
    _compensationVal = compensationVal;
    update();
  }

  setRemoteIdForAudio(int remoteId) async {
    _remoteIDForAudio = remoteId;
  }

  getOtherUserDetails(Map<String, dynamic> otherDetail) async {
    _otherUserDetails = otherDetail;

    update();
  }

  setChatAfterOneDay(bool isAfterOneDay) async {
    _isAfterWholeDay = isAfterOneDay;
  }

  setChatDateAfterDay(String chatDateAfterDay) async {
    _chatDateAfterDay = chatDateAfterDay;
  }

  replaceReciverId(String reciverId) async {
    _reciverId = reciverId;
    update();
  }

  replaceReciverUserProfilePic(String chatProfilePic) async {
    _chatProfilePic = chatProfilePic;
    update();
  }

  replaceReciverUserPhoneNumber(String chatUserPhone) async {
    _chatUserPhone = chatUserPhone;
    update();
  }

  replaceReciverUserName(String chatUserName) async {
    _chatUserName = chatUserName;
    update();
  }

  replaceReceiverFCMToken(String receiverFCMToken) async {
    _receiverFCMToken = receiverFCMToken;
    update();
  }

  setTypeofPost(String postType) async {
    print('post type............. $postType');
    _postType = postType;
    update();
  }

  List<dynamic> _searchList = [];

  List<dynamic> get searchList => _searchList;

  setClearSearchList() {
    _searchList = [];
  }

  void addSigupdata(String key, dynamic value) {
    _sigupdata[key] = value;

    update();
  }

  setFcmToken(String value) {
    _fcmToken = value;
  }

  clearFilters() {
    _compensationVal = "";
    _unionStatus = "";
    _genderVal = "";
    _ageRangeList = [];
    _ethnicalVal = "";
    update();
  }

  Future<ResponseModel> fcmTokenUpdate(String fcmToken) async {
    _isLoading = true;
    update();
    Response response = await authRepo.fcmTokenUpdate(fcmToken);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("UserUpdate");
      print(response.body);

      responseModel =
          ResponseModel(true, '${response.body['message']}', response.body);
    } else {
      responseModel = ResponseModel(false, response.statusText!, {});
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getRegister(Map<String, dynamic> signUpBody) async {
    _isLoading = true;
    update();

    Response response = await authRepo.getRegister(signUpBody);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print(response.body);
      responseModel =
          ResponseModel(true, response.body?["email"], response.body);
    } else {
      print(response.statusCode);
      responseModel = ResponseModel(false, response.statusText!, {});
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email: email, password: password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(
        response.body['refreshToken'],
        response.body['accessToken'],
      );
      AppNotificationHandler.getFcmToken();
      responseModel = ResponseModel(response.body['data'] == 0 ? false : true,
          response.body['accessToken'], response.body);
      await getUserDetails();
    } else {
      responseModel = ResponseModel(false, response.statusText!, {});
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  String getUserRefreshToken() {
    return authRepo.getUserRefreshToken();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  Future<void> getUserDetails() async {
    Response response = await authRepo.getUserDetails();

    if (response.statusCode == 200) {
      AppNotificationHandler.getFcmToken();

      _sigupdata = response.body["data"];
      update();
    } else {}
  }

  Future<void> getFollowingUserProfile(String userID) async {
    Response response = await authRepo.getFollowingUserProfile(userID);

    if (response.statusCode == 200) {
      _getfollowerDetail = response.body;

      _getOtherUserFcmToken =
          await _getfollowerDetail["data"]["fcmToken"] ?? "";

      update();
    } else {}
  }

  void saveUserEmailAndPassword(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  Future<void> getSearchUserApi(String searchText) async {
    Response response = await authRepo.getSearchUserApi(searchText);

    if (response.statusCode == 200) {
      _searchList = response.body['data'];
      print('_searchList>>>>>>>>>>>> ${_searchList}');
      update();
    } else {}
  }

  Future<void> FollowOtherApi(String userId) async {
    Response response = await authRepo.FollowOtherApi(userId);

    if (response.statusCode == 200) {
      _otherFollwe = response.body['follow'];
      _otherFollowing = response.body['following'];

      update();
    } else {}
  }

  Future<void> FollowerApi(String userId) async {
    Response response = await authRepo.FollowOtherApi(userId);

    if (response.statusCode == 200) {
      _follower = response.body['follow'];
      _following = response.body['following'];
      setFollowUserID(userId);
      update();
    } else {}
  }

  Future<void> userFollowerApi(String followerId) async {
    _isLoading = true;
    update();

    Response response = await authRepo.userFollowerApi(
      followerId: followerId,
    );

    if (response.statusCode == 200) {
      print('userFollowerApi......................');
      _getfollowerDetail["following"] = 1;
      FollowOtherApi(followerId);
    } else {}
    _isLoading = false;

    update();
  }

  Future<void> getSendMsgNoti(String otherid, massage) async {
    print('otherid==================');
    print(otherid);
    print(massage);
    _isLoading = true;
    update();

    Response response =
        await authRepo.getSendMsgNoti(otherid: otherid, massage: massage);
    print('getSendMsgNoti.............. ...... ${response.statusCode}');
    if (response.statusCode == 200) {
      print('getSendMsgNoti....................');
      print(response.body);
    } else {}
    _isLoading = false;

    update();
  }

  Future<void> getRemoveFollowApi(String follower ) async {
    print('follower==================');
    print(follower);
    _isLoading = true;
    update();

    Response response =
    await authRepo.getRemoveFollowApi(follower: follower, );
    print('getRemoveFollowApi.............. ...... ${response.statusCode}');
    if (response.statusCode == 200) {
      print('getRemoveFollowApi....................');
      print(response.body);
      userFollowingApi(sigupdata["_id"]);
    } else {}
    _isLoading = false;

    update();
  }

  Future<void> unFollowUserApi(String followerId) async {
    _isLoading = true;
    update();

    Response response = await authRepo.unFollowUserApi(
      followerId: followerId,
    );

    if (response.statusCode == 200) {
      _unFollow = response.body['message'];

      _getfollowerDetail["following"] = 0;
      FollowOtherApi(followerId);
    } else {}
    _isLoading = false;

    update();
  }

  setFollowUserID(String followUSerID) {
    _folloUserId = followUSerID;
  }

  setChatFollowUserID(String chatUserfollowUserId) {
    _chatUserfollowUserId = chatUserfollowUserId;
  }

  Future<void> userFollowingApi(String followerId) async {
    _isLoading = true;

    Response response = await authRepo.userFollowingApi(followerId: followerId);

    if (response.statusCode == 200) {
      print('userFollowingApi');
      _followerList = response.body['follower'];
      _followingList = response.body['followings'];
      update();
      print(_followerList.length);
      print(_followerList);
      print(_followingList.length);
      print(_followingList);
    } else {}
    _isLoading = false;
    update();
  }

  setCallingType(String callingType) async {
    _callingType = callingType;
    update();
  }

  setCallingUserId(String setUserId) async {
    _setUserId = setUserId;
    update();
  }

  setChannelToken(String channelToken) async {
    _callNotiToken = channelToken;
    update();
  }

  Future<void> forgatePass(BuildContext context,
      {required dynamic forgateText}) async {
    print('-------------------1------------------------');
    _isLoading = true;
    update();
    Response response = await authRepo.forgatePass(forgateText: forgateText);
    if (response.statusCode == 200) {
      if (response.body['message'] != null) {
        _getforgotUserDetail = response.body['data'];
        print('>_getforgotUserDetail>>  ${_getforgotUserDetail}');
        Get.offNamed(RouteHelper.getOtpScreenRought());
      }
    } else if (response.statusCode == 409) {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    } else {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    }
    _isLoading = false;
    update();
  }

  Future<void> checkOTP(BuildContext context, {required dynamic otp}) async {
    _isLoading = true;
    update();
    Response response = await authRepo.checkOTP(otp: otp);
    if (response.statusCode == 200) {
      if (response.body['message'] != null) {
        Get.offNamed(RouteHelper.getChnagetepasspassRought());
      }
    } else if (response.statusCode == 409) {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    } else {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    }
    _isLoading = false;
    update();
  }

  Future<void> updatePassword(BuildContext context,
      {required dynamic password}) async {
    print(' _getforgotUserDetail["id"]...${_getforgotUserDetail["_id"]}');
    _isLoading = true;
    update();
    Response response = await authRepo.updatePassword(
        userid: _getforgotUserDetail["_id"], password: password);
    if (response.statusCode == 200) {
      if (response.body['message'] != null) {
        print('updatePassword  ${response.body}');
        Get.offNamed(RouteHelper.getLoginRoute(AppConstants.APP_VERSION));
      }
    } else if (response.statusCode == 409) {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    } else {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    }
    _isLoading = false;
    update();
  }

  Future<void> resetPassword(BuildContext context,
      {required dynamic password, required dynamic newpassword}) async {
    // _isLoading = true;
    Response response = await authRepo.resetPassword(
        password: password, newpassword: newpassword);
    if (response.statusCode == 200) {
      if (response.body['message'] != null) {
        print('resetPassword-------  ${response.body}');
        showPopUpDialog('Are you want to log off?', context!, onClickYes: () {
          SystemNavigator.pop();
        }, onClickNo: () {
          Get.back();
        });
        Get.back();
        showCustomSnackBar('Password Reset Successfully.', context!,
            isError: false);
        // Get.offNamed(RouteHelper.getLoginRoute(AppConstants.APP_VERSION));
      }
    } else if (response.statusCode == 409) {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    } else {
      showCustomSnackBar(response.body['message'], context!, isError: true);
    }
    // _isLoading = false;
    update();
  }

  Future<void> sendPhoneNotification(
      String followerId, title, dec, fcm_token, type, channelName) async {
    // _isLoading = true;

    Response response = await authRepo.sendPhoneNotification(
        receverId: followerId,
        title: title,
        dec: dec,
        fcm_token: fcm_token,
        type: type,
        channelName: channelName);

    if (response.statusCode == 200) {
      print('sendPhoneNotification');
      if (response.body['message'] != null) {
        print('TYPE >>>>>>>>>> ${response.body}');
        _callingType = response.body['message']['type'];
        _callNotiToken = await response.body['message']['token'];

        print('CHANNEL TOKEN >>>> $_callNotiToken');
      }
    } else {}

    // _isLoading = false;
    update();
  }

  Future<ResponseModel> userUpdate(String? profilePic, fullName, country,
      phoneNumber, gender, age, zipCode, bio, private, skills) async {
    _isLoading = true;
    update();
    Response response = await authRepo.userUpdate(profilePic, fullName, country,
        phoneNumber, gender, age, zipCode, bio, private, skills);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("UserUpdate");
      if (kDebugMode) {
        print(response.body);
      }

      responseModel =
          ResponseModel(true, '${response.body['message']}', response.body);
    } else {
      responseModel = ResponseModel(false, response.statusText!, {});
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserUpdate(String profilePic, fullName, phoneNumber, age, gender,
      zipCode, country, bio, private, skills) {
    _sigupdata["profilePic"] = profilePic;
    _sigupdata["fullName"] = fullName;
    _sigupdata["phoneNumber"] = phoneNumber;
    _sigupdata["age"] = age;
    _sigupdata["gender"] = gender;
    _sigupdata["zipCode"] = zipCode;
    _sigupdata["country"] = country;
    _sigupdata["bio"] = bio;
    _sigupdata["private"] = private;
    _sigupdata["skills"] = skills;
    update();
  }

  setEthnicitiesVal(String newVal) {
    _ethnicalVal = newVal;
    update();
  }

  setGenderVal(String newVal) async {
    if (newVal == 'Male') {
      _genderVal = 'Male';
    } else if (newVal == 'Female') {
      _genderVal = 'Female';
    } else {
      _genderVal = 'Other';
    }
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void clearsigupdata() {
    _sigupdata = {
      /*  "email": "",
      "fullName": "",
      "password": "",
      "status": "1",
      "passwordConfirmation": "",
      "zipCode": "",
      "country": "",
      "gender": "",
      "age": "",
      "postUrl": "",
      "phoneNumber": "",
      "profilePic": "",
      "bio": "",
      "profileType": "",*/
    };
    _genderVal = '';
    update();
  }

  Uint8List? _file = null;

  Uint8List? get file => _file;

  void setUint8List(dynamic uriset) {
    _file = uriset;
    update();
  }

  void removeImageFromMultiSelect(int? item, String key) {
    if (_sigupdata[key] != "") {
      print(key);
      print(item);
      _sigupdata[key].removeAt(item);
    } else {
      print('No Image');
    }
    update();
  }

  void removeImageFromMultiSelectDeument(int item, String key) {
    if (_documnetData.isNotEmpty) {
      print(key);
      print(item);
      _documnetData['documents'].removeAt(item);
    } else {
      print('No Image');
    }
    update();
  }

  List<dynamic> _addSkillList = [];

  List<dynamic> get addSkillList => _addSkillList;

  setAddSkillList(String newText) {
    print('--------------');
    print(newText);
    _addSkillList.add(newText);

    _sigupdata['skills'] = _addSkillList;
    print('result-------------');
    print(_sigupdata["skills"]);
    print(_addSkillList);
    update();
  }

  replaceValue(String newVal, int index) {
    _addSkillList[index] = newVal;
    update();
  }

  removeSkillFromList(int index) {
    _addSkillList.removeAt(index);
    update();
  }

  void removePDF(int? item, String key) {
    if (_sigupdata[key] != "") {
      print(key);
      print(item);
      _sigupdata[key].remove(item);
    } else {
      print('No Image');
    }
    update();
  }

  uploadVideoCameraPost(
      String type, String keyType, BuildContext context) async {
    ImagePicker _picker = ImagePicker();
    File? _video;
    XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    _video = File(video!.path);
    appUserUploadFileAsync(
      keyType,
      video.path,
      type,
    );
  }

  uploadVideoGalleryPost(
      String type, String keyType, BuildContext context) async {
    ImagePicker _picker = ImagePicker();
    File? _video;
    XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    appUserUploadFileAsync(
      keyType,
      video.path,
      type,
    );
  }

  Future _cropImage(
    filePath,
    String type,
    String keyType,
  ) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

    if (croppedImage == null) {
      return;
    }
    appUserUploadFileAsync(
      keyType,
      croppedImage.path,
      type,
    );
    update();
  }

  uploadCameraImage(String type, String keyType, BuildContext context) async {
    if (type == "") {
      MotionToast(
        icon: Icons.error_outline,
        title: Text("Error"),
        description: Text("Select Type first"),
        primaryColor: Colors.red,
      ).show(context);
      return;
    }

    ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    _cropImage(image!.path, type, keyType);
  }

  uploadCameraImageGalery(
      String type, String keyType, BuildContext context) async {
    if (type == "") {
      MotionToast(
        icon: Icons.error_outline,
        title: Text("Error"),
        description: Text("Select Type first"),
        primaryColor: Colors.red,
      ).show(context);
      return;
    }

    ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    _cropImage(image!.path, type, keyType);
  }

  uploadMultipleCameraImage(
      String type, String keyType, BuildContext context) async {
    if (type == "") {
      MotionToast(
        icon: Icons.error_outline,
        title: const Text("Error"),
        description: const Text("Select Type first"),
        primaryColor: Colors.red,
      ).show(context);
      return;
    }

    ImagePicker _picker = ImagePicker();

    List<XFile?> image = await _picker.pickMultiImage();
    for (int i = 0; i < image.length; i++) {
      if (image[i]!.path.isNotEmpty) {
        print('image.path1');
        print(image[i]!.path);

        appUserUploadFileAsync(
          keyType,
          image[i]!.path,
          type,
        );
      }
    }
  }

  Future<File?> pickFile(AuthController controller, keyType, type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'PNG', 'JPG', 'jpeg', 'image'],
    );
    String? splites = result!.paths[0];
    _picDocs = File(splites!);
    print('PATH::::$_picDocs');

    String attach = splites.split('.').last;
    print('PATH  ${attach}');
    if (_picDocs != null) {
      print('path------------ ${_picDocs}');
      print('splites------------ ${splites}');
      if (_pichDocsList.contains(splites)) {
        print('path-------------1 ${splites}');
      } else {
        _pichDocsList.addAll(splites.split(','));
        print('path-------------2 ${_pichDocsList}');
      }
      appUserUploadFileAsyncDocs(
        keyType,
        splites,
        type,
      );
    } else {
      print('errrrrrr------------- ');
    }
    update();
  }

  uploadImage(String type, String keyType, BuildContext context) async {
    if (type == "") {
      MotionToast(
        icon: Icons.error_outline,
        title: const Text("Error"),
        description: const Text("Select Type first"),
        primaryColor: Colors.red,
      ).show(context);
      return;
    }

    ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    print('cropImage-----------------.path');

    if (image!.path.isNotEmpty) {
      print('image.path2');

      _imageData = image.path;
      _cropImage(image.path, type, keyType);
    }
  }

  chatImageUpload(
      String type, String keyType, BuildContext context, imagePath) async {
    if (imagePath!.path.isNotEmpty) {
      print('image.path4');
      print(imagePath.path);

      _imageData = imagePath.path;
      print('++++++++++++++++++++++++++++3');
      print(_imageData);
    }
    chatUserUploadFileAsync(
      keyType,
      _imageData,
      type,
    );
  }

  Future<dynamic> chatUserUploadFileAsync(
    String key,
    String path,
    String type,
  ) async {
    _isLoading = true;
    update();
    dynamic response = await authRepo.uploadImage(
      key,
      path,
      path,
    );

    print(type);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('----------------------------1');
      final decodeBody = json.decode(response.body);

      _sigupdata['chatPic'] = decodeBody['filename'];
      print('----------------------------2');
      print(_sigupdata['chatPic']);

      _isLoading = false;
      update();

      return response;
    } else {}
  }

  Future<dynamic> appUserUploadFileAsyncDocs(
    String key,
    String path,
    String type,
  ) async {
    _isLoading = true;
    update();
    dynamic response = await authRepo.uploadDocs(
      key,
      path,
      path,
    );

    print(type);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodeBody = json.decode(response.body);

      print('-------docs----------');
      print(decodeBody);
      print('docs=====================${key}');
      print(decodeBody['filename']);

      if (key == 'documents') {
        print('documents-------------  ${_documnetData['documents']}');
        if (_documnetData['documents'] == null) {
          _documnetData['documents'] = [];
        }
        _documnetData['documents'].add(decodeBody['filename']);

        print('document==================== ${_documnetData['documents']}');
        update();
      }

      _isLoading = false;
      update();

      return response;
    } else {}
  }

  Future<dynamic> appUserUploadFileAsync(
    String key,
    String path,
    String type,
  ) async {
    // _isLoading = true;
   if( key == 'profilePic'){
     _isProfileImgLoading = true;
   }else{
     _isImgLoading = true;
   }



    update();
    dynamic response = await authRepo.uploadImage(
      key,
      path,
      path,
    );

    print(type);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodeBody = json.decode(response.body);

      print('-------decode_body-1----------');
      print(decodeBody);
      print('key=====================${key}');
      print(decodeBody['filename']);

      // _sigupdata['profilePic'] = decodeBody['filename'];
      if (key == 'document') {
        print('document-------------  ${_documnetData['document']}');
        if (_documnetData['document'] == null) {
          _documnetData['document'] = [];
        }
        _documnetData['document'].add(decodeBody['filename']);
        print('document==================== ${_documnetData['document']}');
        update();
      }
      if (key == 'postImage') {
        print('ninPic-------------  ${_sigupdata['ninPic']}');
        if (_sigupdata['ninPic'] == null) {
          _sigupdata['ninPic'] = [];
        }
        _sigupdata['ninPic'].add(decodeBody['filename']);
        update();
      }

      if (type == "image") {
        if (key == 'applyImage') {
          if (_sigupdata['applyImage'] == null) {
            _sigupdata['applyImage'] = [];
          }
          _sigupdata['applyImage'].add(decodeBody['filename']);
          print('come tis= applyImage====================== ');
          print(_sigupdata['applyImage']);
        }
        if (key == 'image') {
          if (_sigupdata['postImage'] == null) {
            _sigupdata['postImage'] = [];
          }
          _sigupdata['postImage'].add(decodeBody['filename']);
          print('come tis======================= ');
          Get.back();

          Get.toNamed(RouteHelper.getCreatePostRought());
        }
        if (key == 'profilePic') {
          if (_sigupdata['profilePic'] == null) {
            _sigupdata['profilePic'] = "";
          }
          // _sigupdata['profilePic'].add(decodeBody['filename']);
          _sigupdata['profilePic'] = (decodeBody['filename']);
        }
        userUpdate(
            _sigupdata['profilePic'],
            _sigupdata['fullName'],
            _sigupdata['country'],
            _sigupdata['phoneNumber'],
            _sigupdata['gender'],
            _sigupdata['age'],
            _sigupdata['zipCode'],
            _sigupdata['bio'],
            _sigupdata['private'],
            _sigupdata['skills']);
        print('postImage-------------  ${_sigupdata['postImage']}');
        print('profilePic-------------  ${_sigupdata['profilePic']}');
      }
      if (type == "video") {
        if (key == 'applyVideo') {
          if (_sigupdata['applyVideo'] == null) {
            _sigupdata['applyVideo'] = [];
          }
          _sigupdata['applyVideo'].add(decodeBody['filename']);
          print('come tis= applyVideo====================== ');
          print(_sigupdata['applyVideo']);
        }
        print('TYPE VIDEO IS ACTIVE');
        print(key);
        print(type);
        print(_sigupdata['postImage']);
        if (key == 'video') {
          if (_sigupdata['postImage'] == null) {
            _sigupdata['postImage'] = [];
          }
          _sigupdata['postImage'].add(decodeBody['filename']);
          print('come tis======================= ');
          print(_sigupdata['postImage']);
          Get.back();

          Get.toNamed(RouteHelper.getCreatePostRought());
        }
      }
      // _isLoading = false;
      if( key == 'profilePic'){
        _isProfileImgLoading = false;
      }else{
        _isImgLoading = false;
      }
      // _isImgLoading = false;
      // _isProfileImgLoading = false;
      update();

      return response;
    } else {}
  }

  Future<void> getCountryList() async {
    Response response = await authRepo.country();

    if (response.statusCode == 200) {
      print('getCountryList==========');
      print(response.body);

      var countryTemp = [];
      List<dynamic> sourceOfFundListtemp = response.body["data"];
      sourceOfFundListtemp.forEach((key) {
        countryTemp.add({"key": key["isoCode"], "value": key['name']});
      });
      _countryList = countryTemp;

      update();
    } else {}
  }

  final List<dynamic> _selecterArray = [];

  List<dynamic> get selecterArray => _selecterArray;
  String _SelectTypeTitle = "";

  String get SelectTypeTitle => _SelectTypeTitle;

  setCountrySelectTitle(String title) {
    _SelectTypeTitle = title;
  }

  setselecterArray(List countryList) {
    _countryList = countryList;
  }

  showCountryDropdown(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_selecterArray.length == 0) {
      showCustomSnackBar("Country not Found", context);
      return;
    }
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: AppColors.cardColor,
        builder: (context) {
          return ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        SelectTypeTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            fontSize: 18),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 5,
                      endIndent: 0,
                      color: AppColors.blackColor,
                    )
                  ],
                ),
                Column(
                    children: selecterArray.map((entry) {
                  print('authController.countryNameList');

                  return ListTile(
                    leading: Icon(Icons.control_point),
                    title: Text(entry["value"]),
                    onTap: () {
                      print(entry);
                      print(SelectTypeTitle);
                      if (SelectTypeTitle == "Select Country") {
                        _sigupdata["country"] = entry["value"];
                      }

                      Navigator.pop(context);
                    },
                  );
                }).toList())
              ]);
        });
  }
}

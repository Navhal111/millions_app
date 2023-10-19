import 'package:get/get.dart';
import 'package:million/view/screens/Addnewpost.dart';
import 'package:million/view/screens/ApplyJobInfoDetailScreen.dart';
import 'package:million/view/screens/ChnagePass.dart';
import 'package:million/view/screens/CreateProfile.dart';
import 'package:million/view/screens/DashbardScreen.dart';
import 'package:million/view/screens/ImagePost.dart';
import 'package:million/view/screens/JobDetails.dart';
import 'package:million/view/screens/MasagesScreen.dart';
import 'package:million/view/screens/NotificationScreen.dart';
import 'package:million/view/screens/OtpScreen.dart';
import 'package:million/view/screens/PasswordReset.dart';
import 'package:million/view/screens/ProfileScreen.dart';
import 'package:million/view/screens/newvideopost/videoPostView.dart';
import 'package:million/view/screens/otherImagePostScreen.dart';
import 'package:million/view/screens/reset_password_screen.dart';
import 'package:million/view/screens/search_job_user_screen.dart';
import 'package:million/view/screens/SignInScreen.dart';
import 'package:million/view/screens/SignUpScreen.dart';
import 'package:million/view/screens/SpalshScreen.dart';
import 'package:million/view/screens/editProfileScreen.dart';
import 'package:million/view/screens/other_profile_followScreen.dart';
import 'package:million/view/screens/profile_followers.dart';
import 'package:million/view/screens/search_chat_user_screen.dart';
import 'package:million/view/screens/otherUserProfileScreen.dart';
import 'package:million/view/screens/videopost/videopost.dart';


class RouteHelper {
  static const String initial = '/splash';
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String jobdetails = '/jobdetails';
  static const String forgatepass = '/forgatepass';
  static const String chnagetepass = '/chnagetepass';
  static const String notificartion = '/notificartion';
  static const String chatscreen = '/chatscreen';
  static const String search = '/search';
  static const String imagepostview = '/imagepostview';
  // static const String videopostview = '/videopostview';
  static const String createprofile = '/createprofile';
  static const String createimagepost = '/createimagepost';
  static const String otpscreen = '/otpscreen';
  static const String profileScreen = '/profileScreen';
  static const String editScreen = '/editScreen';
  static const String searcgUserScreen = '/searcgUserScreen';
  static const String userProfileScreen = '/userProfileScreen';
  static const String otherUserFollowProfileScreen = '/otherUserFollowProfileScreen';
  static const String profileFollowers = '/profileFollowers';
  static const String commentScreen = '/commentScreen';
  static const String otherPostImage = '/OtherPostImage';
  static const String otherProfileScreen = '/otherProfileScreen';
  static const String applyJobInfoDetailScreen = '/applyJobInfoDetailScreen';
  static const String resetPassword = '/resetPassword';
  static const String newVideoPost = '/newVideoPost';

  static String getInitialRoute() => '$initial';
  static String getSplashRoute(double appVersion) => '$splash?id=$appVersion';
  static String getLoginRoute(double appVersion) => '$login?id=$appVersion';
  static String getSignupRoute() => '$signup';
  static String getDashBoardRought(pageIndex) =>
      '$dashboard?pageIndex=$pageIndex';
  static String getJobdetailsRought() => '$jobdetails';
  static String getForgotpassRought() => '$forgatepass';
  static String getChnagetepasspassRought() => '$chnagetepass';
  static String getNotificarionRought() => '$notificartion';
  static String getChatScreenRought(String title, String tag,String reciverID) =>
      '$chatscreen?title=$title&tag=$tag&reciverID=$reciverID';
  static String getSearchScreenRought() => '$search';
  static String getPostImageRought(String url) => '$imagepostview?url=$url';
  static String getOtherPostImage(String url) => '$otherPostImage?url=$url';
  // static String getVideoPOstRought() => '$videopostview';
  static String getCreateProfileRought() => '$createprofile';
  static String getCreatePostRought() => '$createimagepost';
  static String getOtpScreenRought() => '$otpscreen';
  static String getProfileScreen() => '$profileScreen';
  static String getEditScreen() => '$editScreen';
  static String getSearcgUserScreen() => '$searcgUserScreen';
  static String getUserProfileScreen() => '$userProfileScreen';
  static String getOtherUserProfileScreen() => '$otherUserFollowProfileScreen';
  static String getProfileFollowers() => '$profileFollowers';
  static String getCommentScreen() => '$commentScreen';
  static String getApplyJobInfoDetailScreen() => '$applyJobInfoDetailScreen';
  static String getResetPassword() => '$resetPassword';
  static String getNewVideoPostScreen() => '$newVideoPost';

  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () => SplashScreen(
            appVersion:
                Get.parameters['id'] == 'null' ? null : Get.parameters['id'])),
    GetPage(
        name: login,
        page: () => LoginScreen(
            appVersion:
                Get.parameters['id'] == 'null' ? null : Get.parameters['id'])),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(
        name: dashboard,
        page: () => DashboardScreen(
              pageIndex: Get.parameters['pageIndex'] != null
                  ? int.parse(Get.parameters['pageIndex']!)
                  : 0,
            )),
    GetPage(name: jobdetails, page: () => JobDetailsScreen()),
    GetPage(name: forgatepass, page: () => ForgotPassword()),
    GetPage(name: chnagetepass, page: () => ChangePassword()),
    GetPage(name: notificartion, page: () => NotificationScreen()),
    GetPage(
        name: chatscreen,
        page: () => MassageScreen(
            title: Get.parameters['title'] == 'null'
                ? null
                : Get.parameters['title'].toString(),
            tag: Get.parameters['tag'] == 'null'
                ? null
                : Get.parameters['tag'])),
    GetPage(name: search, page: () => SearchScreen()),
    GetPage(
        name: imagepostview,
        page: () => ImagePostView(
            url: Get.parameters['url'] == 'null'
                ? null
                : Get.parameters['url'].toString())),
    GetPage(
        name: otherPostImage,
        page: () => OtherPostImage(
            url: Get.parameters['url'] == 'null'
                ? null
                : Get.parameters['url'].toString())),
    // GetPage(name: videopostview, page: () => VideoPostView()),
    GetPage(name: createprofile, page: () => CreateProfile()),
    GetPage(name: createimagepost, page: () => AddPostScreen()),
    GetPage(name: otpscreen, page: () => OtpScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editScreen, page: () => EditProfile()),
    GetPage(name: searcgUserScreen, page: () => SearchUserScreen()),
    GetPage(name: userProfileScreen, page: () => UserProfileScreen()),
    GetPage(name: profileFollowers, page: () => ProfileFollowers()),
    GetPage(name: otherUserFollowProfileScreen, page: () => OtherUserProfileScreen()),
    GetPage(name: applyJobInfoDetailScreen, page: () => ApplyJobInfoDetailScreen()),
    GetPage(name: resetPassword, page: () => ResetPassword()),
    GetPage(name: newVideoPost, page: () => NewVideoPostScreen()),
  ];
}

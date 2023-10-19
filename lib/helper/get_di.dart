import 'package:get/get.dart';
import 'package:million/api/api_client.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/controllers/coman_controller.dart';
import 'package:million/controllers/splash_controller.dart';
import 'package:million/controllers/theme_controller.dart';
import 'package:million/helper/auth_repo.dart';
import 'package:million/helper/coman_repo.dart';
import 'package:million/helper/job_repo.dart';
import 'package:million/helper/splash_repo.dart';
import 'package:million/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(
      () => ApiClient(
          appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()),
      fenix: true);
  // Repository
  Get.lazyPut(
      () => ComanRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => JobRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(() => AuthController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() => SplashController(splashRepo: Get.find()), fenix: true);
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(() => ComanController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() => ComanController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() => JobDetailController(jobRepo: Get.find()), fenix: true);
}

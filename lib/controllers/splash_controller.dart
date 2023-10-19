import 'package:get/get.dart';
import 'package:million/helper/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  SplashController({required this.splashRepo});
  final SplashRepo splashRepo;
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

  Future<bool> getConfigData() async {
    _hasConnection = true;
    return _hasConnection;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }
  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }
}

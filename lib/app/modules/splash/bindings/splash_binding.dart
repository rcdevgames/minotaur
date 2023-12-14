import 'package:get/get.dart';
import 'package:temres_apps/app/modules/auth/controllers/auth_controller.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    // Get.lazyPut<AuthController>(
    //   () => AuthController(),
    // );
  }
}

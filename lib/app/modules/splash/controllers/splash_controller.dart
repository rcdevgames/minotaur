import 'package:get/get.dart';
import 'package:temres_apps/app/modules/auth/controllers/auth_controller.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  @override
  void onInit() {
    authController.autoLogin();
    Future.delayed(const Duration(microseconds: 100), () {
      if (authController.isAuth()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    });

    super.onInit();
  }
}

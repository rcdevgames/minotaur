import 'package:get/get.dart';
import 'package:temres_apps/app/modules/pendukung/controllers/tambah_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

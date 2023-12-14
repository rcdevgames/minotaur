import 'package:get/get.dart';

import '../controllers/wilayah_controller.dart';

class WilayahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WilayahController>(
      () => WilayahController(),
    );
  }
}

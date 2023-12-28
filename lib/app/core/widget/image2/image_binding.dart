import 'package:get/get.dart';

import 'image_controller.dart';

class ImageBinding2 extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageController2>(() => ImageController2());
  }
}

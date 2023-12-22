import 'package:get/get.dart';

import 'image_controller.dart';
import 'image_controller2.dart';

class ImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageController>(() => ImageController());
    Get.lazyPut<ImageController2>(() => ImageController2());
  }
}

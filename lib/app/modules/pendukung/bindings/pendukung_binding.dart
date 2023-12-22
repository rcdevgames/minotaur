import 'package:get/get.dart';

import 'package:temres_apps/app/modules/pendukung/controllers/tambah_controller.dart';
import 'package:temres_apps/app/modules/pendukung/controllers/tambah_keluarga_controller.dart';

import '../../../core/widget/image/image_controller.dart';
import '../../../core/widget/image/image_controller2.dart';
import '../controllers/pendukung_controller.dart';

class PendukungBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahController>(
      () => TambahController(),
    );

    Get.lazyPut<PendukungController>(
      () => PendukungController(),
    );

    Get.lazyPut<TambahKeluargaController>(
      () => TambahKeluargaController(),
    );

    Get.lazyPut<ImageController>(
      () => ImageController(),
    );
    
    Get.lazyPut<ImageController2>(
      () => ImageController2(),
    );
  }
}

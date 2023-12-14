import 'package:get/get.dart';

import '../../../core/widget/image/image_controller.dart';
import '../provider/pendukung_model.dart';
import '../provider/pendukung_provider.dart';
import 'package:temres_apps/app/modules/pendukung/provider/upload_provider.dart';

class PendukungController extends GetxController {
  //TODO: Implement PendukungController
  final ImageController imageController = Get.put(ImageController());

  var dtArgumen = Get.arguments;

  var isLoading = true.obs;
  List<PendukungModel> pendukungList = [];

  final PendukungProvider pendukungProvider = PendukungProvider();

  @override
  void onInit() {
    getPendukung();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  refreshPage() {
    getPendukung();
  }

  getPendukung() async {
    try {
      isLoading(true);
      // var pendukung = await pendukungProvider.fetchPendukung('${dtArgumen[0]}');
      var pendukung = await UploadProvider().getPendukung();
      print("xlogx get pendukung?");
      if (pendukung != null) {
        pendukungList.clear();
        pendukung = pendukung.toList();
        for (final e in pendukung) {
          var currentElement = e;
          pendukungList.add(PendukungModel(
            id:e['nik'],
            nama:e['nama'],
            hp:e['hp'],
            kecamatan:e['kecamatan'],
            kelurahanId:"1",
            kelurahan:e['kelurahan'],
            rw:e['rw'],
            rt:e['rt'],
            umur:e['umur'],
            img:e['fotoktp'],
            ));
        }
        print("xlogx get pendukung ${pendukungList.length}");
        update();
      } else {
        pendukungList.isEmpty;
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}

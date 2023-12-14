import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temres_apps/app/modules/dpt/provider/dpt_model.dart';
import 'package:temres_apps/app/modules/dpt/provider/dpt_provider.dart';

class DptController extends GetxController {
  //TODO: Implement DptController
  final DptProvider dptProvider = DptProvider();
  final GlobalKey<FormState> cariFormKey = GlobalKey<FormState>();
  late TextEditingController nama, rt, rw, kabkot, kecamatan, deskel;

  var isLoading = false.obs;
  var ejaan = false.obs;

  List<DptModel> dptList = [];

  var dtArguments = Get.arguments;

  var kabkotId = ''.obs;
  var kecamatanId = ''.obs;
  var deskelId = ''.obs;

  var fastButtonAdd = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    print('_________${dtArguments[0]}');
    nama = TextEditingController();
    rt = TextEditingController();
    rw = TextEditingController();
    kabkot = TextEditingController();
    kecamatan = TextEditingController();
    deskel = TextEditingController();
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

  setEjaan(value) {
    print(value);
    ejaan(value!);
  }

  getDptByName() async {
    bool isValidate = cariFormKey.currentState!.validate();
    if (isValidate) {
      try {
        isLoading(true);
        var dpt = await dptProvider.fetchDpt(
          kelId: '${dtArguments[0]}',
          nama: nama.text,
          rt: rt.text,
          rw: rw.text,
          // ejaan: ejaan ? '1' : '0',
          ejaan: ejaan.value ? '1' : '0',
        );
        if (dpt != null) {
          dptList.clear();
          dptList.addAll(dpt);
          update();
        } else {
          fastButtonAdd.value = true;
          dptList.isEmpty;
          update();
        }
      } finally {
        isLoading(false);
      }
    }
  }

  String? validateForm(String value) {
    if (value.isEmpty) {
      return "Field tidak boleh kosong!";
    } else {
      return null;
    }
  }
}

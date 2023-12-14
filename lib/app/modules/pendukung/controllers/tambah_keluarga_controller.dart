import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/core/widget/image/image_controller.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';
import 'package:temres_apps/app/modules/pendukung/provider/respon_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_provider.dart';

import '../../../core/helper/get_location.dart';

// enum Pilihan { sudah mempunyai pilihan, jefferson }

enum Bersedia { lafayette, jefferson }

class TambahKeluargaController extends GetxController with BaseController {
  //TODO: Implement TambahController

  final PendukungProvider pendukungProvider = PendukungProvider();
  final HomeController homeController = Get.put(HomeController());
  final PallateColors pallateColors = PallateColors();
  final ImageController imageController = Get.find();

  final GlobalKey<FormState> pendukungFormKey = GlobalKey<FormState>();

  final pilihan = ['Sudah', 'Belum'];

  final bersedia = ['Sudah', 'Tidak tahu'];

  final terdaftarMemilih = ['Iya', 'Tidak'];

  final kembali = ['Bersedia', 'Tidak Bersedia'];
  final keluarga = ['Bersedia', 'Ragu-ragu', 'Tidak Bersedia'];

  late TextEditingController tps,
      nik,
      nama,
      jk,
      alamat,
      rw,
      rt,
      hp,
      tanggallahir;

  var dataArgumen = Get.arguments;

  var jpilihan = ''.obs;
  var jbersedia = ''.obs;
  var jterdaftar = ''.obs;

  var jkembali = ''.obs;
  var jkeluarga = ''.obs;

  var jpilihanValue = ''.obs;
  var jbersediaValue = ''.obs;
  var jterdaftarValue = ''.obs;

  var jkembaliValue = ''.obs;
  var jkeluargaValue = ''.obs;

  var relawanId = '0'.obs;
  var dptId = '0'.obs;
  var kelurahanId = '0'.obs;

  var lat = 0.0.obs;
  var long = 0.0.obs;
  var akurasi = '0'.obs;

  @override
  void onInit() {
    print(dataArgumen[2]);
    getLoc();
    getLatlong();
    nik = TextEditingController();
    nama = TextEditingController(text: (dataArgumen[1]));
    jk = TextEditingController();
    alamat = TextEditingController();
    rw = TextEditingController(text: dataArgumen[3]);
    rt = TextEditingController(text: dataArgumen[4]);
    tps = TextEditingController(text: dataArgumen[5]);
    hp = TextEditingController(text: '0');
    tanggallahir = TextEditingController();
    super.onInit();
  }

  getLatlong() async {
    location.onLocationChanged.listen((LocationData currentLocation) {
      akurasi.value = currentLocation.accuracy.toString().substring(0, 3);

      lat.value = currentLocation.latitude!;
      long.value = currentLocation.longitude!;
    });
  }

  Map<String, String> dataPendukung() {
    return {
      'relawan_id': homeController.relawanId.value,
      'dpt_id': (dataArgumen[0] == null) ? dptId.value : dataArgumen[0],
      'kelurahan_id': '${dataArgumen[2]}',
      'tps': tps.text,
      'nik': nik.text,
      'nama': nama.text,
      'jk': jk.text,
      'alamat': alamat.text,
      'rw': rw.text,
      'rt': rt.text,
      'hp': hp.text,
      'pilihan': jpilihanValue.value,
      'mendukung': jbersediaValue.value,
      'terdaftar': jterdaftarValue.value,
      'kembali': jkembaliValue.value,
      'keluarga': jkeluargaValue.value,
      'gps': '${lat.value}, ${long.value}'
    };
  }

  // newPendukung() async {
  //   showLoading('Menyimpan data...');
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     bool isValidate = pendukungFormKey.currentState!.validate();
  //     if (isValidate) {
  //       // var data = jsonEncode(dataPendukung());
  //       var respon = pendukungProvider.createPendukung(body: dataPendukung());
  //       print(respon);

  //       if (respon == true) {
  //         Future.delayed(const Duration(seconds: 5));
  //         clearForm();
  //       } else {
  //         dialogError(
  //             color: Colors.red,
  //             content: const Text('gagal simpan data.'),
  //             title: 'Failed');
  //         hideLoading();
  //       }
  //     }
  //     hideLoading();
  //   });
  // }

  addPendukung() async {
    bool isValidate = pendukungFormKey.currentState!.validate();
    if (isValidate) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print(dataPendukung());
        // var data = jsonEncode(dataPendukung());
        showLoading('Menyimpan data...');
        var respon = pendukungProvider.addPendukung(
          body: dataPendukung(),
          filepath: imageController.cropImagePath.value,
          fotowajah: imageController.cropImageFotoWajahPath.value,
        );
      });
    }
  }

  void clearForm() {
    nik.text = '';
    nama.text = '';
    jk.text = '';
    alamat.text = '';
    rw.text = '';
    rt.text = '';
    tps.text = '';
    hp.text = '';
    tanggallahir.text = '';
  }

  String? validateForm(String value) {
    if (value.isEmpty) {
      return "Field tidak boleh kosong!";
    } else {
      return null;
    }
  }
}

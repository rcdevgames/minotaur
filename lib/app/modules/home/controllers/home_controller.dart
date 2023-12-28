import 'dart:convert';

import 'package:cron/cron.dart';
import 'package:cron/cron.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/modules/auth/provider/login_model.dart';
import 'package:temres_apps/app/modules/dpt/provider/dpt_model.dart';
import 'package:temres_apps/app/modules/home/controllers/jumlah_model.dart';
import 'package:temres_apps/app/modules/home/provider/home_provider.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_provider.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../../../core/helper/get_location.dart';
import '../../pendukung/provider/pendukung_model.dart';

class HomeController extends GetxController with BaseController {

  final PendukungProvider pendukungProvider = PendukungProvider();
  final HomeProvider homeProvider = HomeProvider();
  final cron = Cron();
  var dataCount = ''.obs;
  var count = '0'.obs;

  var dataUser = ''.obs;
  var nama = ''.obs;
  var relawanId = '0'.obs;
  var kelurahanId = ''.obs;
  var kelurahan = ''.obs;

  var lat = 0.0.obs;
  var long = 0.0.obs;

  var isLoading = true.obs;
  List<PendukungModel> pendukungList = [];

  final RxBool isLoadingMore = false.obs;
  int _currentPage = 1;

  Future<void> loadMorePendukung() async {
    print('Loading more data...');
    if (!isLoadingMore.value) {
      try {
        isLoadingMore(true);
        _currentPage++;
        var morePendukung =
        await pendukungProvider.fetchPendukung(relawanId.value, page: _currentPage);
        if (morePendukung != null) {
          pendukungList.addAll(morePendukung);
          update();
        }
      } finally {
        isLoadingMore(false);
        update();
      }
    }
  }

  @override
  void onInit() {
    // refreshPage();

    PendukungProvider().initKabupaten();
    PendukungProvider().initKecamatan();
    PendukungProvider().initKelurahan();

    getUserData();
    setUser();
    getPendukung();
    getCountPendukung();
    getCount();
    setCount();
    getLoc();
    getLatlong();
    cronJobRUn();
    super.onInit();
  }

  refreshPage() {
    newPosisi();
    getCountPendukung();
    getCount();
    setCount();
    getPendukung();
  }

  getFirstData() {
    getUserData();
    setUser();
    getCountPendukung();
    getCount();
    setCount();
  }

  getLatlong() async {
    location.onLocationChanged.listen((LocationData currentLocation) {
      lat.value = currentLocation.latitude!;
      long.value = currentLocation.longitude!;
    });
  }

  getCount() async {
    final box = GetStorage();
    if (box.read("count") != null) {
      var data = box.read("count");
      dataCount.value = jsonEncode(data);
      print('______${dataCount.value}');
      update();
    }
  }

  setCount() {
    var dataDecode = jsonDecode(dataCount.value.toString());
    var dataJson = JumlahModel.fromJson(dataDecode);
    count.value = dataJson.jumlah;
    update();
  }

  getUserData() {
    final box = GetStorage();
    if (box.read("dataUser") != null) {
      var data = box.read("dataUser");
      dataUser.value = jsonEncode(data);
      print(dataUser.value);
      update();
    }
  }

  setUser() async {
    var dataDecode = jsonDecode(dataUser.value);
    var datajson = LoginModel.fromJson(dataDecode);
    nama.value = datajson.nama;
    relawanId.value = datajson.userId;
    kelurahanId.value = datajson.kelurahanId;
    kelurahan.value = datajson.kelurahan;
    update();
  }

  getCountPendukung() async {
    await homeProvider.fetchCount(relawanId.value);
  }

  getPendukung() async {
    try {
      isLoading(true);
      _currentPage = 1; // Reset ke 1 ketika melakukan fetch pertama kali
      var pendukung = await pendukungProvider.fetchPendukung(relawanId.value, page: _currentPage);
      if (pendukung != null) {
        pendukungList.clear();
        pendukungList.addAll(pendukung);
        update();
      } else {
        pendukungList.isEmpty;
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  cronJobRUn() {
    cron.schedule(Schedule.parse('*/10 * * * *'), () async {
      print('_____kirim posisi_______');
      newPosisi();
    });
  }

  logout() {
    Get.defaultDialog(
        title: "Konfirmasi",
        content: const Text('Yakin anda akan keluar.'),
        buttonColor: PallateColors().primaryColor,
        onConfirm: () async {
          // Get.back();
          showLoading('Logout..');
          hideLoading();
          final box = GetStorage();
          box.erase();
          Get.offAllNamed(Routes.AUTH);
          cron.close();
        });
  }

  Map<String, String> dataPosisi() {
    return {'relawan_id': relawanId.value, 'gps': '${lat.value},${long.value}'};
  }

  newPosisi() async {
    await homeProvider.createPosisi(body: dataPosisi());
  }
}

import 'dart:async';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temres_apps/app/core/constant/service.dart';
import 'package:temres_apps/app/modules/pendukung/provider/respon_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/upload_model.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:temres_apps/app/routes/app_pages.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'dart:convert';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';

// print(jsondata.msg);
class UploadProvider extends GetConnect with BaseController {
  final HomeController homeController = Get.put(HomeController());
  final ApiProvider apiProvider = ApiProvider();
  static var client = http.Client();
  Future<Iterable<dynamic>> getPendukung() async {
    String? dir;
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory.path;
    } catch (e) {}
    Hive.init(dir);
    var box = await Hive.openBox('pendukungBox');
    final alls = await box.values;
    print(alls);
    return alls;
  }

  upload(String nik) async {
    String? dir;
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory.path;
    } catch (e) {}
    Hive.init(dir);
    var box = await Hive.openBox('pendukungBox');
    final pend = await box.get(nik);
    // print(pend);
    var img64= pend?['img64'] ?? '';
    Map<String, String> dataPendukung = {
      'relawan_id': homeController.relawanId.value,
      'kelurahan_id': '',
      'nik': nik,
      'nama': pend['nama'],
      'hp': pend['hp'],
      'umur': pend['umur'],
      'jk': pend['jk'],
      'kecamatan': pend['kecamatan'],
      'kelurahan': pend['kelurahan'],
      'alamat': pend['alamat'],
      'rw': pend['rw'],
      'rt': pend['rt'],
      'pilihanPartai2019': pend['pilihanPartai2019'],
      'pilihanPartai': pend['pilihanPartai'],
      'pilihan': pend['pilihan'],
      'pilihanCapres': pend['pilihanCapres'],
      'gps': pend['gps'],
      'img64':img64 ,

    };
    print(dataPendukung);

    // print(dataPendukung);
//
    Future.delayed(const Duration(milliseconds: 500), () {
      showLoading('Menimpan data...');
      addPendukung(
        body: dataPendukung,
      );
    });
  }

  Future<bool> addPendukung({required Map<String, String> body}) async {

    String? dir;
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory.path;
    } catch (e) {}
    Hive.init(dir);
    var box = await Hive.openBox('pendukungBox');

    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/input-with-image-kirim.php');

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    print(body);

    var request = http.MultipartRequest('POST', baseUrl)
      ..fields.addAll(body)
      ..headers.addAll(headers);
    // if (filepath != "") {
      // request..files.add(await http.MultipartFile.fromBytes(field, value);
    // }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);

      var data = json.decode(response.body);
      var jsondata = ResponModel.fromJson(data);
      print(jsondata.msg);
      if (jsondata.kode == '200') {
        Get.defaultDialog(
          buttonColor: PallateColors().primaryColor,
          confirmTextColor: Colors.white,
          title: "Sukses",
          content: const Text('data berhasil disimpan'),
          onConfirm: () {
            hideLoading();
            hideLoading();
            hideLoading();

            box.delete(body['nik']);
            Get.offAllNamed(Routes.HOME);
          },
        );
      }
      if (jsondata.kode == '422') {
        Get.defaultDialog(
          buttonColor: PallateColors().primaryColor,
          confirmTextColor: Colors.white,
          title: "Gagal",
          content: const Text('data nik sudah ada.'),
          onConfirm: () {
            hideLoading();
            box.delete(body['nik']);
            Get.offAllNamed(Routes.HOME);
            // Get.back();
          },
        );
        await Future.delayed(const Duration(microseconds: 500));
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<UploadModel>?> insertPendukung({
    String? relawan_id,
    String? kelurahan_id,
    String? nik,
    String? nama,
    String? hp,
    String? umur,
    String? jk,
    String? kecamatan,
    String? kelurahan,
    String? alamat,
    String? rw,
    String? rt,
    String? pilihanPartai2019,
    String? pilihanPartai,
    String? pilihan,
    String? pilihanCapres,
    String? img64,
    String? gps,
  }) async {
    String? dir;
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory.path;
    } catch (e) {}
    Hive.init(dir);
    print(relawan_id);
    print(nik);
    var box = await Hive.openBox('pendukungBox');
    box.put(nik, {
      'nama': nama,
      'nik': nik,
      'hp': hp,
      'umur': umur,
      'jk': jk,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'alamat': alamat,
      'rt': rt,
      'rw': rw,
      'pilihanPartai2019': pilihanPartai2019,
      'pilihanPartai': pilihanPartai,
      'pilihan': pilihan,
      'pilihanCapres': pilihanCapres,
      'gps': gps,
      'img64': img64
    });

    var pend = box.get(nik);
    print(pend);
    print('Name: ${pend?['nama']}');

    Get.defaultDialog(
      buttonColor: PallateColors().primaryColor,
      confirmTextColor: Colors.white,
      title: "Sukses",
      content: const Text('data disimpan untuk di kirim nanti'),
      onConfirm: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  Future<List<UploadModel>?> editPendukung({
    String? relawan_id,
    // String? kelurahan_id,
    String? nik,
    // String? nama,
    String? hp,
    // String? umur,
    // String? jk,
    // String? kecamatan,
    // String? kelurahan,
    // String? alamat,
    // String? rw,
    // String? rt,
    // String? pilihanPartai2019,
    // String? pilihanPartai,
    // String? pilihan,
    // String? pilihanCapres,
    String? img64,
    // String? gps,
  }) async {
    String? dir;
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory.path;
    } catch (e) {}
    Hive.init(dir);
    print(relawan_id);
    print(nik);
    var box = await Hive.openBox('pendukungBox');
    box.put(nik, {
      // 'nama': nama,
      'nik': nik,
      'hp': hp,
      // 'umur': umur,
      // 'jk': jk,
      // 'kecamatan': kecamatan,
      // 'kelurahan': kelurahan,
      // 'alamat': alamat,
      // 'rt': rt,
      // 'rw': rw,
      // 'pilihanPartai2019': pilihanPartai2019,
      // 'pilihanPartai': pilihanPartai,
      // 'pilihan': pilihan,
      // 'pilihanCapres': pilihanCapres,
      // 'gps': gps,
      'img64': img64
    });

    var pend = box.get(nik);
    print(pend);
    print('Name: ${pend?['nama']}');

    Get.defaultDialog(
      buttonColor: PallateColors().primaryColor,
      confirmTextColor: Colors.white,
      title: "Sukses",
      content: const Text('data disimpan untuk di kirim nanti'),
      onConfirm: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }
}

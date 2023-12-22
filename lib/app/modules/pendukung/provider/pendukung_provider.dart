import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temres_apps/app/core/constant/service.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kabupaten_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kecamatan_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kelurahan_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/respon_model.dart';
import 'package:temres_apps/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constant/color.dart';

class PendukungProvider extends GetConnect {
  final ApiProvider apiProvider = ApiProvider();
  static var client = http.Client();

  Future<bool> createPendukung({required Map<String, String> body}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/input_baru.php');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    print(body);
    var response = await client.post(baseUrl, body: body, headers: headers);
    var data = json.decode(response.body);
    var jsondata = ResponModel.fromJson(data);
    print(jsondata.msg);
    if (jsondata.kode == '200') {
      // tambahController.clearForm();
      Get.defaultDialog(
        buttonColor: PallateColors().primaryColor,
        confirmTextColor: Colors.white,
        title: "Sukses",
        content: const Text('data berhasil disimpan'),
        onConfirm: () {
          // tambahController.clearForm();
          Get.back();
        },
      );
      print(jsondata.msg);
    }
    return false;
  }

  Future<bool> addPendukung(
      {required Map<String, String> body,
      required String filepath,
      required String fotowajah}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/input-with-image.php');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    print(body);
    print(filepath);

    // List<http.MultipartFile> files = [
    //   {'image': filepath}
    // ];
    var request = http.MultipartRequest('POST', baseUrl)
      ..fields.addAll(body)
      ..headers.addAll(headers);
    if (filepath != "") {
      request..files.add(await http.MultipartFile.fromPath('image', filepath));
    }

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
            // tambahController.clearForm();
            Get.offAllNamed(Routes.HOME);
          },
        );
        // Get.toNamed(Routes.HOME);
        // print(jsondata.msg);
      }
      if (jsondata.kode == '422') {
        Get.defaultDialog(
          buttonColor: PallateColors().primaryColor,
          confirmTextColor: Colors.white,
          title: "Gagal",
          content: const Text('data nik sudah ada.'),
          onConfirm: () {
            Get.back();
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

  Future<bool> editPendukung(
      {required Map<String, String> body,
      required String filepath,
      required String fotowajah
      }) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/edit-with-image.php');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    print(body);
    print(filepath);

    // List<http.MultipartFile> files = [
    //   {'image': filepath}
    // ];
    var request = http.MultipartRequest('POST', baseUrl)
      ..fields.addAll(body)
      ..headers.addAll(headers);
    if (filepath != "") {
      request..files.add(await http.MultipartFile.fromPath('image', filepath));
    }

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
            // tambahController.clearForm();
            Get.offAllNamed(Routes.HOME);
          },
        );
        // Get.toNamed(Routes.HOME);
        // print(jsondata.msg);
      }
      if (jsondata.kode == '422') {
        Get.defaultDialog(
          buttonColor: PallateColors().primaryColor,
          confirmTextColor: Colors.white,
          title: "Gagal",
          content: const Text('terjadi kesalahan.'),
          onConfirm: () {
            Get.back();
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

  void initKabupaten() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kabupaten');
    box.put('1', {'nama': 'KAB. TANGERANG', 'id': '1'});
    box.put('2', {'nama': 'KOTA TANGERANG', 'id': '2'});
    box.put('3', {'nama': 'KOTA TANGERANG SELATAN', 'id': '3'});
  }

  void initKecamatan() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kecamatan');
    box.put('1', {'nama': 'Balaraja', 'id': '1', 'kabkota': 'KAB. TANGERANG'});
    box.put('2', {'nama': 'Jayanti', 'id': '2', 'kabkota': 'KAB. TANGERANG'});
    box.put('3', {'nama': 'Tigaraksa', 'id': '3', 'kabkota': 'KAB. TANGERANG'});
    box.put('4', {'nama': 'Jambe', 'id': '4', 'kabkota': 'KAB. TANGERANG'});
    box.put('5', {'nama': 'Cisoka', 'id': '5', 'kabkota': 'KAB. TANGERANG'});
    box.put('6', {'nama': 'Kresek', 'id': '6', 'kabkota': 'KAB. TANGERANG'});
    box.put('7', {'nama': 'Kronjo', 'id': '7', 'kabkota': 'KAB. TANGERANG'});
    box.put('8', {'nama': 'Mauk', 'id': '8', 'kabkota': 'KAB. TANGERANG'});
    box.put('9', {'nama': 'Kemiri', 'id': '9', 'kabkota': 'KAB. TANGERANG'});
    box.put('10', {'nama': 'Sukadiri', 'id': '10', 'kabkota': 'KAB. TANGERANG'});
    box.put('11', {'nama': 'Rajeg', 'id': '11', 'kabkota': 'KAB. TANGERANG'});
    box.put('12', {'nama': 'Pasar Kemis', 'id': '12', 'kabkota': 'KAB. TANGERANG'});
    box.put('13', {'nama': 'Teluknaga', 'id': '13', 'kabkota': 'KAB. TANGERANG'});
    box.put('14', {'nama': 'Kosambi', 'id': '14', 'kabkota': 'KAB. TANGERANG'});
    box.put('15', {'nama': 'Pakuhaji', 'id': '15', 'kabkota': 'KAB. TANGERANG'});
    box.put('16', {'nama': 'Sepatan', 'id': '16', 'kabkota': 'KAB. TANGERANG'});
    box.put('17', {'nama': 'Curug', 'id': '17', 'kabkota': 'KAB. TANGERANG'});
    box.put('18', {'nama': 'Cikupa', 'id': '18', 'kabkota': 'KAB. TANGERANG'});
    box.put('19', {'nama': 'Panongan', 'id': '19', 'kabkota': 'KAB. TANGERANG'});
    box.put('20', {'nama': 'Legok', 'id': '20', 'kabkota': 'KAB. TANGERANG'});
    box.put('21', {'nama': 'Pagedangan', 'id': '21', 'kabkota': 'KAB. TANGERANG'});
    box.put('22', {'nama': 'Cisauk', 'id': '22', 'kabkota': 'KAB. TANGERANG'});
    box.put('23', {'nama': 'Sukamulya', 'id': '23', 'kabkota': 'KAB. TANGERANG'});
    box.put('24', {'nama': 'Kelapa Dua', 'id': '24', 'kabkota': 'KAB. TANGERANG'});
    box.put('25', {'nama': 'Sindang Jaya', 'id': '25', 'kabkota': 'KAB. TANGERANG'});
    box.put('26', {'nama': 'Sepatan Timur', 'id': '26', 'kabkota': 'KAB. TANGERANG'});
    box.put('27', {'nama': 'Solear', 'id': '27', 'kabkota': 'KAB. TANGERANG'});
    box.put('28', {'nama': 'Gunung Kaler', 'id': '28', 'kabkota': 'KAB. TANGERANG'});
    box.put('29', {'nama': 'Mekar Baru', 'id': '29', 'kabkota': 'KAB. TANGERANG'});
    box.put('30', {'nama': 'Tangerang', 'id': '30', 'kabkota': 'KOTA TANGERANG'});
    box.put('31', {'nama': 'Jatiuwung', 'id': '31', 'kabkota': 'KOTA TANGERANG'});
    box.put('32', {'nama': 'Batuceper', 'id': '32', 'kabkota': 'KOTA TANGERANG'});
    box.put('33', {'nama': 'Benda', 'id': '33', 'kabkota': 'KOTA TANGERANG'});
    box.put('34', {'nama': 'Cipondoh', 'id': '34', 'kabkota': 'KOTA TANGERANG'});
    box.put('35', {'nama': 'Ciledug', 'id': '35', 'kabkota': 'KOTA TANGERANG'});
    box.put('36', {'nama': 'Karawaci', 'id': '36', 'kabkota': 'KOTA TANGERANG'});
    box.put('37', {'nama': 'Periuk', 'id': '37', 'kabkota': 'KOTA TANGERANG'});
    box.put('38', {'nama': 'Cibodas', 'id': '38', 'kabkota': 'KOTA TANGERANG'});
    box.put('39', {'nama': 'Neglasari', 'id': '39', 'kabkota': 'KOTA TANGERANG'});
    box.put('40', {'nama': 'Pinang', 'id': '40', 'kabkota': 'KOTA TANGERANG'});
    box.put('41', {'nama': 'Karang Tengah', 'id': '41', 'kabkota': 'KOTA TANGERANG'});
    box.put('42', {'nama': 'Larangan', 'id': '42', 'kabkota': 'KOTA TANGERANG'});
    box.put('43', {'nama': 'Serpong', 'id': '43', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('44', {'nama': 'Serpong Utara', 'id': '44', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('45', {'nama': 'Pondok Aren', 'id': '45', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('46', {'nama': 'Ciputat', 'id': '46', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('47', {'nama': 'Ciputat Timur', 'id': '47', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('48', {'nama': 'Pamulang', 'id': '48', 'kabkota': 'KOTA TANGERANG SELATAN'});
    box.put('49', {'nama': 'Setu', 'id': '49', 'kabkota': 'KOTA TANGERANG SELATAN'});
  }

  Future<List<KecamatanModel>?> fetchKecamatan(String kabId) async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kecamatan');
    final pend = await box.values.toList();
    List<KecamatanModel> kecList = [];
    for (var e in pend) {
      if (kabId == e['kabkota']) {
        kecList.add(KecamatanModel(id: e['id'], nama: e['nama']));
      }
    }
    return kecList;
  }

  Future<List<KelurahanModel>?> fetchKelurahan(String kecId) async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kelurahan');
    final pend = await box.values.toList();
    List<KelurahanModel> kelList = [];
    for (var e in pend) {
      if (kecId == e['kecamatan']) {
        kelList.add(KelurahanModel(id: e['id'], nama: e['nama']));
      }
    }
    return kelList;
  }

  Future<List<KabupatenModel>?> fetchKabupaten() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kabupaten');
    final pend = await box.values.toList();
    List<KabupatenModel> kabList = [];
    for (var e in pend) {
      kabList.add(KabupatenModel(id: e['id'], nama: e['nama']));
    }
    return kabList;
  }

  // var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get_pendukung.php?relawan_id=$id&page=1');

  Future<List<PendukungModel>?> fetchPendukung_back(String id) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get_pendukung.php?relawan_id=$id');

    print("xlogx _pendukung url : ${baseUrl}");

    var response =
        await client.get(baseUrl, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      // print(response.body);
      List<dynamic> data = json.decode(response.body);
      return data.map((dynamic json) {
        return PendukungModel.fromJson(json);
      }).toList();
    }
    return null;
  }

  Future<List<PendukungModel>?> fetchPendukung_v2(String id, {int page = 1}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get_pendukung_page.php?relawan_id=$id&page=$page');

    print("xlogx _pendukung url : ${baseUrl}");

    var response =
    await client.get(baseUrl, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dynamic json) {
        return PendukungModel.fromJson(json);
      }).toList();
    }
    return null;
  }

  Future<List<PendukungModel>?> fetchPendukung(String id, {int page = 1}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get_pendukung_page.php?relawan_id=$id&page=$page');

    print("xlogx _pendukung url : ${baseUrl}");

    var response = await client.get(baseUrl, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> data = responseData['data'];

      return data.map((dynamic json) {
        return PendukungModel.fromJson(json);
      }).toList();
    }
    return null;
  }

  void initKelurahan() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox<Map>('kelurahan');
    box.put('1', {'nama': 'Balaraja', 'id': '1', 'kecamatan': 'Balaraja'});
    box.put('2', {'nama': 'Cangkudu', 'id': '2', 'kecamatan': 'Balaraja'});
    box.put('3', {'nama': 'Talagasari', 'id': '3', 'kecamatan': 'Balaraja'});
    box.put('4', {'nama': 'Tobat', 'id': '4', 'kecamatan': 'Balaraja'});
    box.put('5', {'nama': 'Sentul', 'id': '5', 'kecamatan': 'Balaraja'});
    box.put('6', {'nama': 'Gembong', 'id': '6', 'kecamatan': 'Balaraja'});
    box.put('7', {'nama': 'Sukamurni', 'id': '7', 'kecamatan': 'Balaraja'});
    box.put('8', {'nama': 'Saga', 'id': '8', 'kecamatan': 'Balaraja'});
    box.put('9', {'nama': 'Sentul Jaya', 'id': '9', 'kecamatan': 'Balaraja'});
    box.put('10', {'nama': 'Batuceper', 'id': '10', 'kecamatan': 'Batuceper'});
    box.put('11', {'nama': 'Batujaya', 'id': '11', 'kecamatan': 'Batuceper'});
    box.put('12', {'nama': 'Poris Gaga', 'id': '12', 'kecamatan': 'Batuceper'});
    box.put('13', {'nama': 'Poris Gaga Baru', 'id': '13', 'kecamatan': 'Batuceper'});
    box.put('14', {'nama': 'Kebon Besar', 'id': '14', 'kecamatan': 'Batuceper'});
    box.put('15', {'nama': 'Batusari', 'id': '15', 'kecamatan': 'Batuceper'});
    box.put('16', {'nama': 'Poris Jaya', 'id': '16', 'kecamatan': 'Batuceper'});
    box.put('17', {'nama': 'Belendung', 'id': '17', 'kecamatan': 'Benda'});
    box.put('18', {'nama': 'Jurumudi', 'id': '18', 'kecamatan': 'Benda'});
    box.put('19', {'nama': 'Benda', 'id': '19', 'kecamatan': 'Benda'});
    box.put('20', {'nama': 'Pajang', 'id': '20', 'kecamatan': 'Benda'});
    box.put('21', {'nama': 'Jurumudi Baru', 'id': '21', 'kecamatan': 'Benda'});
    box.put('22', {'nama': 'Cibodas', 'id': '22', 'kecamatan': 'Cibodas'});
    box.put('23', {'nama': 'Cibodasari', 'id': '23', 'kecamatan': 'Cibodas'});
    box.put('24', {'nama': 'Cibodas Baru', 'id': '24', 'kecamatan': 'Cibodas'});
    box.put('25', {'nama': 'Panunggangan Barat', 'id': '25', 'kecamatan': 'Cibodas'});
    box.put('26', {'nama': 'Uwung Jaya', 'id': '26', 'kecamatan': 'Cibodas'});
    box.put('27', {'nama': 'Jatiuwung', 'id': '27', 'kecamatan': 'Cibodas'});
    box.put('28', {'nama': 'Sukamulya', 'id': '28', 'kecamatan': 'Cikupa'});
    box.put('29', {'nama': 'Bunder', 'id': '29', 'kecamatan': 'Cikupa'});
    box.put('30', {'nama': 'Cibadak', 'id': '30', 'kecamatan': 'Cikupa'});
    box.put('31', {'nama': 'Talaga', 'id': '31', 'kecamatan': 'Cikupa'});
    box.put('32', {'nama': 'Talagasari', 'id': '32', 'kecamatan': 'Cikupa'});
    box.put('33', {'nama': 'Dukuh', 'id': '33', 'kecamatan': 'Cikupa'});
    box.put('34', {'nama': 'Cikupa', 'id': '34', 'kecamatan': 'Cikupa'});
    box.put('35', {'nama': 'Sukanagara', 'id': '35', 'kecamatan': 'Cikupa'});
    box.put('36', {'nama': 'Bitung Jaya', 'id': '36', 'kecamatan': 'Cikupa'});
    box.put('37', {'nama': 'Pasir Gadung', 'id': '37', 'kecamatan': 'Cikupa'});
    box.put('38', {'nama': 'Sukadamai', 'id': '38', 'kecamatan': 'Cikupa'});
    box.put('39', {'nama': 'Pasir Jaya', 'id': '39', 'kecamatan': 'Cikupa'});
    box.put('40', {'nama': 'Budi Mulya', 'id': '40', 'kecamatan': 'Cikupa'});
    box.put('41', {'nama': 'Bojong', 'id': '41', 'kecamatan': 'Cikupa'});
    box.put('42', {'nama': 'Paninggilan', 'id': '42', 'kecamatan': 'Ciledug'});
    box.put('43', {'nama': 'Sudimara Barat', 'id': '43', 'kecamatan': 'Ciledug'});
    box.put('44', {'nama': 'Sudimara Timur', 'id': '44', 'kecamatan': 'Ciledug'});
    box.put('45', {'nama': 'Tajur', 'id': '45', 'kecamatan': 'Ciledug'});
    box.put('46', {'nama': 'Parung Serab', 'id': '46', 'kecamatan': 'Ciledug'});
    box.put('47', {'nama': 'Sudimara Jaya', 'id': '47', 'kecamatan': 'Ciledug'});
    box.put('48', {'nama': 'Sudimara Selatan', 'id': '48', 'kecamatan': 'Ciledug'});
    box.put('49', {'nama': 'Paninggilan Utara', 'id': '49', 'kecamatan': 'Ciledug'});
    box.put('50', {'nama': 'Cipondoh', 'id': '50', 'kecamatan': 'Cipondoh'});
    box.put('51', {'nama': 'Cipondoh Makmur', 'id': '51', 'kecamatan': 'Cipondoh'});
    box.put('52', {'nama': 'Cipondoh Indah', 'id': '52', 'kecamatan': 'Cipondoh'});
    box.put('53', {'nama': 'Gondrong', 'id': '53', 'kecamatan': 'Cipondoh'});
    box.put('54', {'nama': 'Kenanga', 'id': '54', 'kecamatan': 'Cipondoh'});
    box.put('55', {'nama': 'Petir', 'id': '55', 'kecamatan': 'Cipondoh'});
    box.put('56', {'nama': 'Ketapang', 'id': '56', 'kecamatan': 'Cipondoh'});
    box.put('57', {'nama': 'Poris Plawad', 'id': '57', 'kecamatan': 'Cipondoh'});
    box.put('58', {'nama': 'Poris Plawad Utara', 'id': '58', 'kecamatan': 'Cipondoh'});
    box.put('59', {'nama': 'Poris Plawad Indah', 'id': '59', 'kecamatan': 'Cipondoh'});
    box.put('60', {'nama': 'Sawah Baru', 'id': '60', 'kecamatan': 'Ciputat'});
    box.put('61', {'nama': 'Serua', 'id': '61', 'kecamatan': 'Ciputat'});
    box.put('62', {'nama': 'Ciputat', 'id': '62', 'kecamatan': 'Ciputat'});
    box.put('63', {'nama': 'Sawah Lama', 'id': '63', 'kecamatan': 'Ciputat'});
    box.put('64', {'nama': 'Serua Indah', 'id': '64', 'kecamatan': 'Ciputat'});
    box.put('65', {'nama': 'Jombang', 'id': '65', 'kecamatan': 'Ciputat'});
    box.put('66', {'nama': 'Cipayung', 'id': '66', 'kecamatan': 'Ciputat'});
    box.put('67', {'nama': 'Cempaka Putih', 'id': '67', 'kecamatan': 'Ciputat Timur'});
    box.put('68', {'nama': 'Pondok Ranji', 'id': '68', 'kecamatan': 'Ciputat Timur'});
    box.put('69', {'nama': 'Pisangan', 'id': '69', 'kecamatan': 'Ciputat Timur'});
    box.put('70', {'nama': 'Cireundeu', 'id': '70', 'kecamatan': 'Ciputat Timur'});
    box.put('71', {'nama': 'Rempoa', 'id': '71', 'kecamatan': 'Ciputat Timur'});
    box.put('72', {'nama': 'Rengas', 'id': '72', 'kecamatan': 'Ciputat Timur'});
    box.put('73', {'nama': 'Cisauk', 'id': '73', 'kecamatan': 'Cisauk'});
    box.put('74', {'nama': 'Mekar Wangi', 'id': '74', 'kecamatan': 'Cisauk'});
    box.put('75', {'nama': 'Suradita', 'id': '75', 'kecamatan': 'Cisauk'});
    box.put('76', {'nama': 'Sampora', 'id': '76', 'kecamatan': 'Cisauk'});
    box.put('77', {'nama': 'Dangdang', 'id': '77', 'kecamatan': 'Cisauk'});
    box.put('78', {'nama': 'Cibogo', 'id': '78', 'kecamatan': 'Cisauk'});
    box.put('79', {'nama': 'Cisoka', 'id': '79', 'kecamatan': 'Cisoka'});
    box.put('80', {'nama': 'Caringin', 'id': '80', 'kecamatan': 'Cisoka'});
    box.put('81', {'nama': 'Selapajang', 'id': '81', 'kecamatan': 'Cisoka'});
    box.put('82', {'nama': 'Sukatani', 'id': '82', 'kecamatan': 'Cisoka'});
    box.put('83', {'nama': 'Bojong Loa', 'id': '83', 'kecamatan': 'Cisoka'});
    box.put('84', {'nama': 'Cibugel', 'id': '84', 'kecamatan': 'Cisoka'});
    box.put('85', {'nama': 'Cempaka', 'id': '85', 'kecamatan': 'Cisoka'});
    box.put('86', {'nama': 'Carenang', 'id': '86', 'kecamatan': 'Cisoka'});
    box.put('87', {'nama': 'Karang Harja', 'id': '87', 'kecamatan': 'Cisoka'});
    box.put('88', {'nama': 'Jeungjing', 'id': '88', 'kecamatan': 'Cisoka'});
    box.put('89', {'nama': 'Curug Kulon', 'id': '89', 'kecamatan': 'Curug'});
    box.put('90', {'nama': 'Sukabakti', 'id': '90', 'kecamatan': 'Curug'});
    box.put('91', {'nama': 'Binong', 'id': '91', 'kecamatan': 'Curug'});
    box.put('92', {'nama': 'Curug Wetan', 'id': '92', 'kecamatan': 'Curug'});
    box.put('93', {'nama': 'Kadu', 'id': '93', 'kecamatan': 'Curug'});
    box.put('94', {'nama': 'Kadu Jaya', 'id': '94', 'kecamatan': 'Curug'});
    box.put('95', {'nama': 'Cukanggalih', 'id': '95', 'kecamatan': 'Curug'});
    box.put('96', {'nama': 'Gunung Kaler', 'id': '96', 'kecamatan': 'Gunung Kaler'});
    box.put('97', {'nama': 'Sidoko', 'id': '97', 'kecamatan': 'Gunung Kaler'});
    box.put('98', {'nama': 'Rancagede', 'id': '98', 'kecamatan': 'Gunung Kaler'});
    box.put('99', {'nama': 'Kedung', 'id': '99', 'kecamatan': 'Gunung Kaler'});
    box.put('100', {'nama': 'Cipaeh', 'id': '100', 'kecamatan': 'Gunung Kaler'});
    box.put('101', {'nama': 'Onyam', 'id': '101', 'kecamatan': 'Gunung Kaler'});
    box.put('102', {'nama': 'Tamiang', 'id': '102', 'kecamatan': 'Gunung Kaler'});
    box.put('103', {'nama': 'Kandawati', 'id': '103', 'kecamatan': 'Gunung Kaler'});
    box.put('104', {'nama': 'Cibetok', 'id': '104', 'kecamatan': 'Gunung Kaler'});
    box.put('105', {'nama': 'Sukamanah', 'id': '105', 'kecamatan': 'Jambe'});
    box.put('106', {'nama': 'Jambe', 'id': '106', 'kecamatan': 'Jambe'});
    box.put('107', {'nama': 'Tipar Raya', 'id': '107', 'kecamatan': 'Jambe'});
    box.put('108', {'nama': 'Taban', 'id': '108', 'kecamatan': 'Jambe'});
    box.put('109', {'nama': 'Daru', 'id': '109', 'kecamatan': 'Jambe'});
    box.put('110', {'nama': 'Kutruk', 'id': '110', 'kecamatan': 'Jambe'});
    box.put('111', {'nama': 'Ranca Buaya', 'id': '111', 'kecamatan': 'Jambe'});
    box.put('112', {'nama': 'Mekarsari', 'id': '112', 'kecamatan': 'Jambe'});
    box.put('113', {'nama': 'Ancol Pasir', 'id': '113', 'kecamatan': 'Jambe'});
    box.put('114', {'nama': 'Pasir Barat', 'id': '114', 'kecamatan': 'Jambe'});
    box.put('115', {'nama': 'Keroncong', 'id': '115', 'kecamatan': 'Jatiuwung'});
    box.put('116', {'nama': 'Jatake', 'id': '116', 'kecamatan': 'Jatiuwung'});
    box.put('117', {'nama': 'Pasir Jaya', 'id': '117', 'kecamatan': 'Jatiuwung'});
    box.put('118', {'nama': 'Gandasari', 'id': '118', 'kecamatan': 'Jatiuwung'});
    box.put('119', {'nama': 'Manis Jaya', 'id': '119', 'kecamatan': 'Jatiuwung'});
    box.put('120', {'nama': 'Alam Jaya', 'id': '120', 'kecamatan': 'Jatiuwung'});
    box.put('121', {'nama': 'Pangkat', 'id': '121', 'kecamatan': 'Jayanti'});
    box.put('122', {'nama': 'Pabuaran', 'id': '122', 'kecamatan': 'Jayanti'});
    box.put('123', {'nama': 'Pasir Muncang', 'id': '123', 'kecamatan': 'Jayanti'});
    box.put('124', {'nama': 'Sumur Bandung', 'id': '124', 'kecamatan': 'Jayanti'});
    box.put('125', {'nama': 'Jayanti', 'id': '125', 'kecamatan': 'Jayanti'});
    box.put('126', {'nama': 'Dangdeur', 'id': '126', 'kecamatan': 'Jayanti'});
    box.put('127', {'nama': 'Cikande', 'id': '127', 'kecamatan': 'Jayanti'});
    box.put('128', {'nama': 'Pasir Gintung', 'id': '128', 'kecamatan': 'Jayanti'});
    box.put('129', {'nama': 'Karang Tengah', 'id': '129', 'kecamatan': 'Karang Tengah'});
    box.put('130', {'nama': 'Karang Mulya', 'id': '130', 'kecamatan': 'Karang Tengah'});
    box.put('131', {'nama': 'Pondok Bahar', 'id': '131', 'kecamatan': 'Karang Tengah'});
    box.put('132', {'nama': 'Pondok Pucung', 'id': '132', 'kecamatan': 'Karang Tengah'});
    box.put('133', {'nama': 'Karang Timur', 'id': '133', 'kecamatan': 'Karang Tengah'});
    box.put('134', {'nama': 'Padurenan', 'id': '134', 'kecamatan': 'Karang Tengah'});
    box.put('135', {'nama': 'Parung Jaya', 'id': '135', 'kecamatan': 'Karang Tengah'});
    box.put('136', {'nama': 'Karawaci', 'id': '136', 'kecamatan': 'Karawaci'});
    box.put('137', {'nama': 'Bojong Jaya', 'id': '137', 'kecamatan': 'Karawaci'});
    box.put('138', {'nama': 'Karawaci Baru', 'id': '138', 'kecamatan': 'Karawaci'});
    box.put('139', {'nama': 'Nusa Jaya', 'id': '139', 'kecamatan': 'Karawaci'});
    box.put('140', {'nama': 'Cimone', 'id': '140', 'kecamatan': 'Karawaci'});
    box.put('141', {'nama': 'Cimone Jaya', 'id': '141', 'kecamatan': 'Karawaci'});
    box.put('142', {'nama': 'Pabuaran', 'id': '142', 'kecamatan': 'Karawaci'});
    box.put('143', {'nama': 'Sumur Pacing', 'id': '143', 'kecamatan': 'Karawaci'});
    box.put('144', {'nama': 'Bugel', 'id': '144', 'kecamatan': 'Karawaci'});
    box.put('145', {'nama': 'Margasari', 'id': '145', 'kecamatan': 'Karawaci'});
    box.put('146', {'nama': 'Pabuaran Tumpeng', 'id': '146', 'kecamatan': 'Karawaci'});
    box.put('147', {'nama': 'Nambo Jaya', 'id': '147', 'kecamatan': 'Karawaci'});
    box.put('148', {'nama': 'Gerendeng', 'id': '148', 'kecamatan': 'Karawaci'});
    box.put('149', {'nama': 'Sukajadi', 'id': '149', 'kecamatan': 'Karawaci'});
    box.put('150', {'nama': 'Pasar Baru', 'id': '150', 'kecamatan': 'Karawaci'});
    box.put('151', {'nama': 'Koang Jaya', 'id': '151', 'kecamatan': 'Karawaci'});
    box.put('152', {'nama': 'Kelapa Dua', 'id': '152', 'kecamatan': 'Kelapa Dua'});
    box.put('153', {'nama': 'Bencongan', 'id': '153', 'kecamatan': 'Kelapa Dua'});
    box.put('154', {'nama': 'Bencongan Indah', 'id': '154', 'kecamatan': 'Kelapa Dua'});
    box.put('155', {'nama': 'Pakulonan Barat', 'id': '155', 'kecamatan': 'Kelapa Dua'});
    box.put('156', {'nama': 'Bojong Nangka', 'id': '156', 'kecamatan': 'Kelapa Dua'});
    box.put('157', {'nama': 'Curug Sangereng', 'id': '157', 'kecamatan': 'Kelapa Dua'});
    box.put('158', {'nama': 'Patramanggala', 'id': '158', 'kecamatan': 'Kemiri'});
    box.put('159', {'nama': 'Karang Anyar', 'id': '159', 'kecamatan': 'Kemiri'});
    box.put('160', {'nama': 'Lontar', 'id': '160', 'kecamatan': 'Kemiri'});
    box.put('161', {'nama': 'Kemiri', 'id': '161', 'kecamatan': 'Kemiri'});
    box.put('162', {'nama': 'Ranca Labuh', 'id': '162', 'kecamatan': 'Kemiri'});
    box.put('163', {'nama': 'Klebet', 'id': '163', 'kecamatan': 'Kemiri'});
    box.put('164', {'nama': 'Legok Suka Maju', 'id': '164', 'kecamatan': 'Kemiri'});
    box.put('165', {'nama': 'Kosambi Barat', 'id': '165', 'kecamatan': 'Kosambi'});
    box.put('166', {'nama': 'Salembaran Jaya', 'id': '166', 'kecamatan': 'Kosambi'});
    box.put('167', {'nama': 'Dadap', 'id': '167', 'kecamatan': 'Kosambi'});
    box.put('168', {'nama': 'Kosambi Timur', 'id': '168', 'kecamatan': 'Kosambi'});
    box.put('169', {'nama': 'Salembaran Jati', 'id': '169', 'kecamatan': 'Kosambi'});
    box.put('170', {'nama': 'Ranga Rengas', 'id': '170', 'kecamatan': 'Kosambi'});
    box.put('171', {'nama': 'Rawa Burung', 'id': '171', 'kecamatan': 'Kosambi'});
    box.put('172', {'nama': 'Cengklong', 'id': '172', 'kecamatan': 'Kosambi'});
    box.put('173', {'nama': 'Belimbing', 'id': '173', 'kecamatan': 'Kosambi'});
    box.put('174', {'nama': 'Jati Mulya', 'id': '174', 'kecamatan': 'Kosambi'});
    box.put('175', {'nama': 'Pasir Ampo', 'id': '175', 'kecamatan': 'Kresek'});
    box.put('176', {'nama': 'Rancailat', 'id': '176', 'kecamatan': 'Kresek'});
    box.put('177', {'nama': 'Kemuning', 'id': '177', 'kecamatan': 'Kresek'});
    box.put('178', {'nama': 'Renged', 'id': '178', 'kecamatan': 'Kresek'});
    box.put('179', {'nama': 'Talok', 'id': '179', 'kecamatan': 'Kresek'});
    box.put('180', {'nama': 'Koper', 'id': '180', 'kecamatan': 'Kresek'});
    box.put('181', {'nama': 'Jengkol', 'id': '181', 'kecamatan': 'Kresek'});
    box.put('182', {'nama': 'Patrasana', 'id': '182', 'kecamatan': 'Kresek'});
    box.put('183', {'nama': 'Kresek', 'id': '183', 'kecamatan': 'Kresek'});
    box.put('184', {'nama': 'Kronjo', 'id': '184', 'kecamatan': 'Kronjo'});
    box.put('185', {'nama': 'Pagenjahan', 'id': '185', 'kecamatan': 'Kronjo'});
    box.put('186', {'nama': 'Pasir', 'id': '186', 'kecamatan': 'Kronjo'});
    box.put('187', {'nama': 'Muncung', 'id': '187', 'kecamatan': 'Kronjo'});
    box.put('188', {'nama': 'Pagedangan Ilir', 'id': '188', 'kecamatan': 'Kronjo'});
    box.put('189', {'nama': 'Pagedangan Udik', 'id': '189', 'kecamatan': 'Kronjo'});
    box.put('190', {'nama': 'Pasilian', 'id': '190', 'kecamatan': 'Kronjo'});
    box.put('191', {'nama': 'Bakung', 'id': '191', 'kecamatan': 'Kronjo'});
    box.put('192', {'nama': 'Blukbuk', 'id': '192', 'kecamatan': 'Kronjo'});
    box.put('193', {'nama': 'Cirumpak', 'id': '193', 'kecamatan': 'Kronjo'});
    box.put('194', {'nama': 'Larangan Utara', 'id': '194', 'kecamatan': 'Larangan'});
    box.put('195', {'nama': 'Larangan Selatan', 'id': '195', 'kecamatan': 'Larangan'});
    box.put('196', {'nama': 'Cipadu', 'id': '196', 'kecamatan': 'Larangan'});
    box.put('197', {'nama': 'Kreo', 'id': '197', 'kecamatan': 'Larangan'});
    box.put('198', {'nama': 'Larangan Indah', 'id': '198', 'kecamatan': 'Larangan'});
    box.put('199', {'nama': 'Gaga', 'id': '199', 'kecamatan': 'Larangan'});
    box.put('200', {'nama': 'Cipadu Jaya', 'id': '200', 'kecamatan': 'Larangan'});
    box.put('201', {'nama': 'Kreo Selatan', 'id': '201', 'kecamatan': 'Larangan'});
    box.put('202', {'nama': 'Babakan', 'id': '202', 'kecamatan': 'Legok'});
    box.put('203', {'nama': 'Caringin', 'id': '203', 'kecamatan': 'Legok'});
    box.put('204', {'nama': 'Serdang Wetan', 'id': '204', 'kecamatan': 'Legok'});
    box.put('205', {'nama': 'Babat', 'id': '205', 'kecamatan': 'Legok'});
    box.put('206', {'nama': 'Ciangir', 'id': '206', 'kecamatan': 'Legok'});
    box.put('207', {'nama': 'Legok', 'id': '207', 'kecamatan': 'Legok'});
    box.put('208', {'nama': 'Palasari', 'id': '208', 'kecamatan': 'Legok'});
    box.put('209', {'nama': 'Bojongkamal', 'id': '209', 'kecamatan': 'Legok'});
    box.put('210', {'nama': 'Rancagong', 'id': '210', 'kecamatan': 'Legok'});
    box.put('211', {'nama': 'Kemuning', 'id': '211', 'kecamatan': 'Legok'});
    box.put('212', {'nama': 'Cirarab', 'id': '212', 'kecamatan': 'Legok'});
    box.put('213', {'nama': 'Mauk Timur', 'id': '213', 'kecamatan': 'Mauk'});
    box.put('214', {'nama': 'Mauk Barat', 'id': '214', 'kecamatan': 'Mauk'});
    box.put('215', {'nama': 'Tegal Kunir Kidul', 'id': '215', 'kecamatan': 'Mauk'});
    box.put('216', {'nama': 'Tegal Kunir Lor', 'id': '216', 'kecamatan': 'Mauk'});
    box.put('217', {'nama': 'Sasak', 'id': '217', 'kecamatan': 'Mauk'});
    box.put('218', {'nama': 'Gunung Sari', 'id': '218', 'kecamatan': 'Mauk'});
    box.put('219', {'nama': 'Kedung Dalem', 'id': '219', 'kecamatan': 'Mauk'});
    box.put('220', {'nama': 'Marga Mulya', 'id': '220', 'kecamatan': 'Mauk'});
    box.put('221', {'nama': 'Tanjung Anom', 'id': '221', 'kecamatan': 'Mauk'});
    box.put('222', {'nama': 'Jatiwaringin', 'id': '222', 'kecamatan': 'Mauk'});
    box.put('223', {'nama': 'Banyu Asih', 'id': '223', 'kecamatan': 'Mauk'});
    box.put('224', {'nama': 'Ketapang', 'id': '224', 'kecamatan': 'Mauk'});
    box.put('225', {'nama': 'Mekar Baru', 'id': '225', 'kecamatan': 'Mekar Baru'});
    box.put('226', {'nama': 'Kedaung', 'id': '226', 'kecamatan': 'Mekar Baru'});
    box.put('227', {'nama': 'Cijeruk', 'id': '227', 'kecamatan': 'Mekar Baru'});
    box.put('228', {'nama': 'Waliwis', 'id': '228', 'kecamatan': 'Mekar Baru'});
    box.put('229', {'nama': 'Klutuk', 'id': '229', 'kecamatan': 'Mekar Baru'});
    box.put('230', {'nama': 'Jenggot', 'id': '230', 'kecamatan': 'Mekar Baru'});
    box.put('231', {'nama': 'Kosambi Dalam', 'id': '231', 'kecamatan': 'Mekar Baru'});
    box.put('232', {'nama': 'Gandaria', 'id': '232', 'kecamatan': 'Mekar Baru'});
    box.put('233', {'nama': 'Neglasari', 'id': '233', 'kecamatan': 'Neglasari'});
    box.put('234', {'nama': 'Karang Sari', 'id': '234', 'kecamatan': 'Neglasari'});
    box.put('235', {'nama': 'Selapajang Jaya', 'id': '235', 'kecamatan': 'Neglasari'});
    box.put('236', {'nama': 'Kedaung Wetan', 'id': '236', 'kecamatan': 'Neglasari'});
    box.put('237', {'nama': 'Mekarsari', 'id': '237', 'kecamatan': 'Neglasari'});
    box.put('238', {'nama': 'Karang Anyar', 'id': '238', 'kecamatan': 'Neglasari'});
    box.put('239', {'nama': 'Kedaung Baru', 'id': '239', 'kecamatan': 'Neglasari'});
    box.put('240', {'nama': 'Medang', 'id': '240', 'kecamatan': 'Pagedangan'});
    box.put('241', {'nama': 'Cicalengka', 'id': '241', 'kecamatan': 'Pagedangan'});
    box.put('242', {'nama': 'Pagedangan', 'id': '242', 'kecamatan': 'Pagedangan'});
    box.put('243', {'nama': 'Cijantra', 'id': '243', 'kecamatan': 'Pagedangan'});
    box.put('244', {'nama': 'Lengkong Kulon', 'id': '244', 'kecamatan': 'Pagedangan'});
    box.put('245', {'nama': 'Situ Gadung', 'id': '245', 'kecamatan': 'Pagedangan'});
    box.put('246', {'nama': 'Jatake', 'id': '246', 'kecamatan': 'Pagedangan'});
    box.put('247', {'nama': 'Cihuni', 'id': '247', 'kecamatan': 'Pagedangan'});
    box.put('248', {'nama': 'Kadu Sirung', 'id': '248', 'kecamatan': 'Pagedangan'});
    box.put('249', {'nama': 'Malang Nengah', 'id': '249', 'kecamatan': 'Pagedangan'});
    box.put('250', {'nama': 'Karang Tengah', 'id': '250', 'kecamatan': 'Pagedangan'});
    box.put('251', {'nama': 'Pakuhaji', 'id': '251', 'kecamatan': 'Pakuhaji'});
    box.put('252', {'nama': 'Paku Alam', 'id': '252', 'kecamatan': 'Pakuhaji'});
    box.put('253', {'nama': 'Bonasari', 'id': '253', 'kecamatan': 'Pakuhaji'});
    box.put('254', {'nama': 'Rawa Boni', 'id': '254', 'kecamatan': 'Pakuhaji'});
    box.put('255', {'nama': 'Buaran Mangga', 'id': '255', 'kecamatan': 'Pakuhaji'});
    box.put('256', {'nama': 'Buaran Bambu', 'id': '256', 'kecamatan': 'Pakuhaji'});
    box.put('257', {'nama': 'Kalibaru', 'id': '257', 'kecamatan': 'Pakuhaji'});
    box.put('258', {'nama': 'Kohod', 'id': '258', 'kecamatan': 'Pakuhaji'});
    box.put('259', {'nama': 'Kramat', 'id': '259', 'kecamatan': 'Pakuhaji'});
    box.put('260', {'nama': 'Sukawali', 'id': '260', 'kecamatan': 'Pakuhaji'});
    box.put('261', {'nama': 'Surya Bahari', 'id': '261', 'kecamatan': 'Pakuhaji'});
    box.put('262', {'nama': 'Kiara Payung', 'id': '262', 'kecamatan': 'Pakuhaji'});
    box.put('263', {'nama': 'Laksana', 'id': '263', 'kecamatan': 'Pakuhaji'});
    box.put('264', {'nama': 'Gaga', 'id': '264', 'kecamatan': 'Pakuhaji'});
    box.put('265', {'nama': 'Pamulang Barat', 'id': '265', 'kecamatan': 'Pamulang'});
    box.put('266', {'nama': 'Benda Baru', 'id': '266', 'kecamatan': 'Pamulang'});
    box.put('267', {'nama': 'Pondok Benda', 'id': '267', 'kecamatan': 'Pamulang'});
    box.put('268', {'nama': 'Pondok Cabe Udik', 'id': '268', 'kecamatan': 'Pamulang'});
    box.put('269', {'nama': 'Pondok Cabe Ilir', 'id': '269', 'kecamatan': 'Pamulang'});
    box.put('270', {'nama': 'Kedaung', 'id': '270', 'kecamatan': 'Pamulang'});
    box.put('271', {'nama': 'Bambuapus', 'id': '271', 'kecamatan': 'Pamulang'});
    box.put('272', {'nama': 'Pamulang Timur', 'id': '272', 'kecamatan': 'Pamulang'});
    box.put('273', {'nama': 'Mekar Bakti', 'id': '273', 'kecamatan': 'Panongan'});
    box.put('274', {'nama': 'Ranca Iyuh', 'id': '274', 'kecamatan': 'Panongan'});
    box.put('275', {'nama': 'Peusar', 'id': '275', 'kecamatan': 'Panongan'});
    box.put('276', {'nama': 'Ranca Kalapa', 'id': '276', 'kecamatan': 'Panongan'});
    box.put('277', {'nama': 'Serdang Kulon', 'id': '277', 'kecamatan': 'Panongan'});
    box.put('278', {'nama': 'Mekar Jaya', 'id': '278', 'kecamatan': 'Panongan'});
    box.put('279', {'nama': 'Ciakar', 'id': '279', 'kecamatan': 'Panongan'});
    box.put('280', {'nama': 'Panongan', 'id': '280', 'kecamatan': 'Panongan'});
    box.put('281', {'nama': 'Sindangsari', 'id': '281', 'kecamatan': 'Pasar Kemis'});
    box.put('282', {'nama': 'Kutabumi', 'id': '282', 'kecamatan': 'Pasar Kemis'});
    box.put('283', {'nama': 'Kuta Jaya', 'id': '283', 'kecamatan': 'Pasar Kemis'});
    box.put('284', {'nama': 'Kuta Baru', 'id': '284', 'kecamatan': 'Pasar Kemis'});
    box.put('285', {'nama': 'Pasar Kemis', 'id': '285', 'kecamatan': 'Pasar Kemis'});
    box.put('286', {'nama': 'Sukamantri', 'id': '286', 'kecamatan': 'Pasar Kemis'});
    box.put('287', {'nama': 'Pangadegan', 'id': '287', 'kecamatan': 'Pasar Kemis'});
    box.put('288', {'nama': 'Gelam Jaya', 'id': '288', 'kecamatan': 'Pasar Kemis'});
    box.put('289', {'nama': 'Suka Asih', 'id': '289', 'kecamatan': 'Pasar Kemis'});
    box.put('290', {'nama': 'Periuk', 'id': '290', 'kecamatan': 'Periuk'});
    box.put('291', {'nama': 'Gembor', 'id': '291', 'kecamatan': 'Periuk'});
    box.put('292', {'nama': 'Gebang Raya', 'id': '292', 'kecamatan': 'Periuk'});
    box.put('293', {'nama': 'Sangiang Jaya', 'id': '293', 'kecamatan': 'Periuk'});
    box.put('294', {'nama': 'Periuk Jaya', 'id': '294', 'kecamatan': 'Periuk'});
    box.put('295', {'nama': 'Pinang', 'id': '295', 'kecamatan': 'Pinang'});
    box.put('296', {'nama': 'Sudimara Pinang', 'id': '296', 'kecamatan': 'Pinang'});
    box.put('297', {'nama': 'Nerogtog', 'id': '297', 'kecamatan': 'Pinang'});
    box.put('298', {'nama': 'Kunciran', 'id': '298', 'kecamatan': 'Pinang'});
    box.put('299', {'nama': 'Kunciran Indah', 'id': '299', 'kecamatan': 'Pinang'});
    box.put('300', {'nama': 'Kunciran Jaya', 'id': '300', 'kecamatan': 'Pinang'});
    box.put('301', {'nama': 'Cipete', 'id': '301', 'kecamatan': 'Pinang'});
    box.put('302', {'nama': 'Pakojan', 'id': '302', 'kecamatan': 'Pinang'});
    box.put('303', {'nama': 'Panunggangan', 'id': '303', 'kecamatan': 'Pinang'});
    box.put('304', {'nama': 'Panunggangan Utara', 'id': '304', 'kecamatan': 'Pinang'});
    box.put('305', {'nama': 'Panunggangan Timur', 'id': '305', 'kecamatan': 'Pinang'});
    box.put('306', {'nama': 'Pondok Betung', 'id': '306', 'kecamatan': 'Pondok Aren'});
    box.put('307', {'nama': 'Pondok Pucung', 'id': '307', 'kecamatan': 'Pondok Aren'});
    box.put('308', {'nama': 'Pondok Karya', 'id': '308', 'kecamatan': 'Pondok Aren'});
    box.put('309', {'nama': 'Pondok Jaya', 'id': '309', 'kecamatan': 'Pondok Aren'});
    box.put('310', {'nama': 'Pondok Aren', 'id': '310', 'kecamatan': 'Pondok Aren'});
    box.put('311', {'nama': 'Pondok Kacang Barat', 'id': '311', 'kecamatan': 'Pondok Aren'});
    box.put('312', {'nama': 'Pondok Kacang Timur', 'id': '312', 'kecamatan': 'Pondok Aren'});
    box.put('313', {'nama': 'Parigi', 'id': '313', 'kecamatan': 'Pondok Aren'});
    box.put('314', {'nama': 'Parigi Baru', 'id': '314', 'kecamatan': 'Pondok Aren'});
    box.put('315', {'nama': 'Jurangmangu Barat', 'id': '315', 'kecamatan': 'Pondok Aren'});
    box.put('316', {'nama': 'Jurangmangu Timur', 'id': '316', 'kecamatan': 'Pondok Aren'});
    box.put('317', {'nama': 'Sukatani', 'id': '317', 'kecamatan': 'Rajeg'});
    box.put('318', {'nama': 'Rajeg', 'id': '318', 'kecamatan': 'Rajeg'});
    box.put('319', {'nama': 'Rajeg Mulya', 'id': '319', 'kecamatan': 'Rajeg'});
    box.put('320', {'nama': 'Pangarengan', 'id': '320', 'kecamatan': 'Rajeg'});
    box.put('321', {'nama': 'Jambu Karya', 'id': '321', 'kecamatan': 'Rajeg'});
    box.put('322', {'nama': 'Lembangsari', 'id': '322', 'kecamatan': 'Rajeg'});
    box.put('323', {'nama': 'Sukamanah', 'id': '323', 'kecamatan': 'Rajeg'});
    box.put('324', {'nama': 'Tanjakan', 'id': '324', 'kecamatan': 'Rajeg'});
    box.put('325', {'nama': 'Tanjakan Mekar', 'id': '325', 'kecamatan': 'Rajeg'});
    box.put('326', {'nama': 'Sukasari', 'id': '326', 'kecamatan': 'Rajeg'});
    box.put('327', {'nama': 'Ranca Bango', 'id': '327', 'kecamatan': 'Rajeg'});
    box.put('328', {'nama': 'Daon', 'id': '328', 'kecamatan': 'Rajeg'});
    box.put('329', {'nama': 'Mekarsari', 'id': '329', 'kecamatan': 'Rajeg'});
    box.put('330', {'nama': 'Sepatan', 'id': '330', 'kecamatan': 'Sepatan'});
    box.put('331', {'nama': 'Karet', 'id': '331', 'kecamatan': 'Sepatan'});
    box.put('332', {'nama': 'Kayu Agung', 'id': '332', 'kecamatan': 'Sepatan'});
    box.put('333', {'nama': 'Kayu Bongkok', 'id': '333', 'kecamatan': 'Sepatan'});
    box.put('334', {'nama': 'Pondok Jaya', 'id': '334', 'kecamatan': 'Sepatan'});
    box.put('335', {'nama': 'Pisangan Jaya', 'id': '335', 'kecamatan': 'Sepatan'});
    box.put('336', {'nama': 'Mekar Jaya', 'id': '336', 'kecamatan': 'Sepatan'});
    box.put('337', {'nama': 'Sarakan', 'id': '337', 'kecamatan': 'Sepatan'});
    box.put('338', {'nama': 'Kedaung Barat', 'id': '338', 'kecamatan': 'Sepatan Timur'});
    box.put('339', {'nama': 'Lebak Wangi', 'id': '339', 'kecamatan': 'Sepatan Timur'});
    box.put('340', {'nama': 'Jati Mulya', 'id': '340', 'kecamatan': 'Sepatan Timur'});
    box.put('341', {'nama': 'Sangiang', 'id': '341', 'kecamatan': 'Sepatan Timur'});
    box.put('342', {'nama': 'Gempol Sari', 'id': '342', 'kecamatan': 'Sepatan Timur'});
    box.put('343', {'nama': 'Kampung Kelor', 'id': '343', 'kecamatan': 'Sepatan Timur'});
    box.put('344', {'nama': 'Pondok Kelor', 'id': '344', 'kecamatan': 'Sepatan Timur'});
    box.put('345', {'nama': 'Tanah Merah', 'id': '345', 'kecamatan': 'Sepatan Timur'});
    box.put('346', {'nama': 'Ciater', 'id': '346', 'kecamatan': 'Serpong'});
    box.put('347', {'nama': 'Rawabuntu', 'id': '347', 'kecamatan': 'Serpong'});
    box.put('348', {'nama': 'Rawa Mekarjaya', 'id': '348', 'kecamatan': 'Serpong'});
    box.put('349', {'nama': 'Lengkong Gudang', 'id': '349', 'kecamatan': 'Serpong'});
    box.put('350', {'nama': 'Lengkong Wetan', 'id': '350', 'kecamatan': 'Serpong'});
    box.put('351', {'nama': 'Buaran', 'id': '351', 'kecamatan': 'Serpong'});
    box.put('352', {'nama': 'Lengkong Gudang Timur', 'id': '352', 'kecamatan': 'Serpong'});
    box.put('353', {'nama': 'Cilenggang', 'id': '353', 'kecamatan': 'Serpong'});
    box.put('354', {'nama': 'Serpong', 'id': '354', 'kecamatan': 'Serpong'});
    box.put('355', {'nama': 'Pakulonan', 'id': '355', 'kecamatan': 'Serpong Utara'});
    box.put('356', {'nama': 'Pakualam', 'id': '356', 'kecamatan': 'Serpong Utara'});
    box.put('357', {'nama': 'Pakujaya', 'id': '357', 'kecamatan': 'Serpong Utara'});
    box.put('358', {'nama': 'Pondok Jagung', 'id': '358', 'kecamatan': 'Serpong Utara'});
    box.put('359', {'nama': 'Pondok Jagung Timur', 'id': '359', 'kecamatan': 'Serpong Utara'});
    box.put('360', {'nama': 'Jelupang', 'id': '360', 'kecamatan': 'Serpong Utara'});
    box.put('361', {'nama': 'Lengkong Karya', 'id': '361', 'kecamatan': 'Serpong Utara'});
    box.put('362', {'nama': 'Muncul', 'id': '362', 'kecamatan': 'Setu'});
    box.put('363', {'nama': 'Setu', 'id': '363', 'kecamatan': 'Setu'});
    box.put('364', {'nama': 'Keranggan', 'id': '364', 'kecamatan': 'Setu'});
    box.put('365', {'nama': 'Kademangan', 'id': '365', 'kecamatan': 'Setu'});
    box.put('366', {'nama': 'Babakan', 'id': '366', 'kecamatan': 'Setu'});
    box.put('367', {'nama': 'Bakti Jaya', 'id': '367', 'kecamatan': 'Setu'});
    box.put('368', {'nama': 'Sindang Jaya', 'id': '368', 'kecamatan': 'Sindang Jaya'});
    box.put('369', {'nama': 'Wanakerta', 'id': '369', 'kecamatan': 'Sindang Jaya'});
    box.put('370', {'nama': 'Sukaharja', 'id': '370', 'kecamatan': 'Sindang Jaya'});
    box.put('371', {'nama': 'Sindangasih', 'id': '371', 'kecamatan': 'Sindang Jaya'});
    box.put('372', {'nama': 'Sindangpanon', 'id': '372', 'kecamatan': 'Sindang Jaya'});
    box.put('373', {'nama': 'Sindangsono', 'id': '373', 'kecamatan': 'Sindang Jaya'});
    box.put('374', {'nama': 'Badak Anom', 'id': '374', 'kecamatan': 'Sindang Jaya'});
    box.put('375', {'nama': 'Solear', 'id': '375', 'kecamatan': 'Solear'});
    box.put('376', {'nama': 'Cikuya', 'id': '376', 'kecamatan': 'Solear'});
    box.put('377', {'nama': 'Cikasungka', 'id': '377', 'kecamatan': 'Solear'});
    box.put('378', {'nama': 'Cireundeu', 'id': '378', 'kecamatan': 'Solear'});
    box.put('379', {'nama': 'Cikareo', 'id': '379', 'kecamatan': 'Solear'});
    box.put('380', {'nama': 'Pasanggrahan', 'id': '380', 'kecamatan': 'Solear'});
    box.put('381', {'nama': 'Munjul', 'id': '381', 'kecamatan': 'Solear'});
    box.put('382', {'nama': 'Sukadiri', 'id': '382', 'kecamatan': 'Sukadiri'});
    box.put('383', {'nama': 'Buaran Jati', 'id': '383', 'kecamatan': 'Sukadiri'});
    box.put('384', {'nama': 'Rawa Kidang', 'id': '384', 'kecamatan': 'Sukadiri'});
    box.put('385', {'nama': 'Pekayon', 'id': '385', 'kecamatan': 'Sukadiri'});
    box.put('386', {'nama': 'Karang Serang', 'id': '386', 'kecamatan': 'Sukadiri'});
    box.put('387', {'nama': 'Kosambi', 'id': '387', 'kecamatan': 'Sukadiri'});
    box.put('388', {'nama': 'Mekar Kondang', 'id': '388', 'kecamatan': 'Sukadiri'});
    box.put('389', {'nama': 'Gintung', 'id': '389', 'kecamatan': 'Sukadiri'});
    box.put('390', {'nama': 'Benda', 'id': '390', 'kecamatan': 'Sukamulya'});
    box.put('391', {'nama': 'Sukamulya', 'id': '391', 'kecamatan': 'Sukamulya'});
    box.put('392', {'nama': 'Kaliasin', 'id': '392', 'kecamatan': 'Sukamulya'});
    box.put('393', {'nama': 'Buniayu', 'id': '393', 'kecamatan': 'Sukamulya'});
    box.put('394', {'nama': 'Parahu', 'id': '394', 'kecamatan': 'Sukamulya'});
    box.put('395', {'nama': 'Merak', 'id': '395', 'kecamatan': 'Sukamulya'});
    box.put('396', {'nama': 'Bunar', 'id': '396', 'kecamatan': 'Sukamulya'});
    box.put('397', {'nama': 'Kubang', 'id': '397', 'kecamatan': 'Sukamulya'});
    box.put('398', {'nama': 'Sukarasa', 'id': '398', 'kecamatan': 'Tangerang'});
    box.put('399', {'nama': 'Sukaasih', 'id': '399', 'kecamatan': 'Tangerang'});
    box.put('400', {'nama': 'Tanah Tinggi', 'id': '400', 'kecamatan': 'Tangerang'});
    box.put('401', {'nama': 'Buaran Indah', 'id': '401', 'kecamatan': 'Tangerang'});
    box.put('402', {'nama': 'Cikokol', 'id': '402', 'kecamatan': 'Tangerang'});
    box.put('403', {'nama': 'Kelapa Indah', 'id': '403', 'kecamatan': 'Tangerang'});
    box.put('404', {'nama': 'Sukasari', 'id': '404', 'kecamatan': 'Tangerang'});
    box.put('405', {'nama': 'Babakan', 'id': '405', 'kecamatan': 'Tangerang'});
    box.put('406', {'nama': 'Teluknaga', 'id': '406', 'kecamatan': 'Teluknaga'});
    box.put('407', {'nama': 'Bojong Renged', 'id': '407', 'kecamatan': 'Teluknaga'});
    box.put('408', {'nama': 'Babakan Asem', 'id': '408', 'kecamatan': 'Teluknaga'});
    box.put('409', {'nama': 'Keboncau', 'id': '409', 'kecamatan': 'Teluknaga'});
    box.put('410', {'nama': 'Pangkalan', 'id': '410', 'kecamatan': 'Teluknaga'});
    box.put('411', {'nama': 'Kmp Melayu Tim', 'id': '411', 'kecamatan': 'Teluknaga'});
    box.put('412', {'nama': 'Kmp Melayu Brt', 'id': '412', 'kecamatan': 'Teluknaga'});
    box.put('413', {'nama': 'Muara', 'id': '413', 'kecamatan': 'Teluknaga'});
    box.put('414', {'nama': 'Lemo', 'id': '414', 'kecamatan': 'Teluknaga'});
    box.put('415', {'nama': 'Tanjung Pasir', 'id': '415', 'kecamatan': 'Teluknaga'});
    box.put('416', {'nama': 'Tegal Angus', 'id': '416', 'kecamatan': 'Teluknaga'});
    box.put('417', {'nama': 'Tanjung Burung', 'id': '417', 'kecamatan': 'Teluknaga'});
    box.put('418', {'nama': 'Kampung Besar', 'id': '418', 'kecamatan': 'Teluknaga'});
    box.put('419', {'nama': 'Tigaraksa', 'id': '419', 'kecamatan': 'Tigaraksa'});
    box.put('420', {'nama': 'Kadu Agung', 'id': '420', 'kecamatan': 'Tigaraksa'});
    box.put('421', {'nama': 'Pasir Bolang', 'id': '421', 'kecamatan': 'Tigaraksa'});
    box.put('422', {'nama': 'Matagara', 'id': '422', 'kecamatan': 'Tigaraksa'});
    box.put('423', {'nama': 'Pasir Nangka', 'id': '423', 'kecamatan': 'Tigaraksa'});
    box.put('424', {'nama': 'Pete', 'id': '424', 'kecamatan': 'Tigaraksa'});
    box.put('425', {'nama': 'Tegalsari', 'id': '425', 'kecamatan': 'Tigaraksa'});
    box.put('426', {'nama': 'Pematang', 'id': '426', 'kecamatan': 'Tigaraksa'});
    box.put('427', {'nama': 'Cisereh', 'id': '427', 'kecamatan': 'Tigaraksa'});
    box.put('428', {'nama': 'Margasari', 'id': '428', 'kecamatan': 'Tigaraksa'});
    box.put('429', {'nama': 'Cileles', 'id': '429', 'kecamatan': 'Tigaraksa'});
    box.put('430', {'nama': 'Sodong', 'id': '430', 'kecamatan': 'Tigaraksa'});
    box.put('431', {'nama': 'Tapos', 'id': '431', 'kecamatan': 'Tigaraksa'});
    box.put('432', {'nama': 'Bantar Panjang', 'id': '432', 'kecamatan': 'Tigaraksa'});
  }
}

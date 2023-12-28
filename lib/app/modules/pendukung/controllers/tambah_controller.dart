import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' as io;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/core/widget/image/image_controller.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kabupaten_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kecamatan_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/kelurahan_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_provider.dart';
import 'package:temres_apps/app/modules/pendukung/provider/upload_provider.dart';
import '../../../core/helper/get_location.dart';


enum Bersedia { lafayette, jefferson }

class TambahController extends GetxController with BaseController {
  final PendukungProvider pendukungProvider = PendukungProvider();
  final HomeController homeController = Get.put(HomeController());
  final PallateColors pallateColors = PallateColors();
  final ImageController imageController = Get.find();

  final GlobalKey<FormState> pendukungFormKey = GlobalKey<FormState>();

  final pilihanList = [
    'Kenal',
    'Tidak Kenal'
  ];
  final capresList = [
    'Bersedia',
    'Tidak Bersedia'
  ];

  var id_pendukung = '';

  late TextEditingController nik,
      kk,
      nama,
      hp,
      umur,
      jk,
      kabupaten,
      kecamatan,
      kelurahan,
      alamat,
      rw,
      rt,
      keluarga1,
      keluarga2,
      keluarga3,
      keluarga4,
      keluarga5,
      pilihanPartai2019,
      pilihanPartai;

  var dataArgumen = Get.arguments;

  var jpilihan = ''.obs; //kenal
  var jpilihanValue = ''.obs;

  var buttonClicked = false;
  var jpilihanHasSelected = false;

  var jpilihanCapres = ''.obs; //kenal
  var jpilihanCapresValue = ''.obs;

  var relawanId = '0'.obs;

  var lat = 0.0.obs;
  var long = 0.0.obs;
  var akurasi = '0'.obs;
  var kabupatenList = <KabupatenModel>[].obs;
  var kecamatanList = <KecamatanModel>[].obs;
  var kelurahanList = <KelurahanModel>[].obs;

  @override
  void onInit() async {
    print(dataArgumen[2]);
    getLoc();
    getLatlong();
    nik = TextEditingController();
    kk = TextEditingController();
    nama = TextEditingController(text: (dataArgumen[1]));
    jk = TextEditingController();
    umur = TextEditingController();
    kabupaten = TextEditingController();
    kecamatan = TextEditingController();
    kelurahan = TextEditingController();
    alamat = TextEditingController();
    pilihanPartai2019 = TextEditingController();
    pilihanPartai = TextEditingController();
    keluarga1 = TextEditingController();
    keluarga2 = TextEditingController();
    keluarga3 = TextEditingController();
    keluarga4 = TextEditingController();
    keluarga5 = TextEditingController();
    rw = TextEditingController(text: dataArgumen[3]);
    rt = TextEditingController(text: dataArgumen[4]);
    hp = TextEditingController(text: '0');

    //get Kabupaten
    var kabListTemp = await pendukungProvider.fetchKabupaten();
    if (kabListTemp != null) {
      kabupatenList.value = kabListTemp;
      print(kabupatenList.map((element) => element.nama));
      print('>>>>');
      print(kabListTemp[0].nama);
      for (var i = 0; i < kabupatenList.length; i++) {
        print(kabupatenList[i].nama);
      }
      update();
    }

    super.onInit();
  }

  getKecamatan(String value) async {
    kecamatan.clear();
    print('>>>> Get Kecamatan ${value}');
    var kecListTemp = await pendukungProvider.fetchKecamatan(value);
    if (kecListTemp != null) {
      kecamatanList.value = kecListTemp;
      print(kecamatanList.map((element) => element.nama));
    }
  }

  getKelurahan(String value) async {
    kelurahan.clear();
    print('>>>> Get Kelurahan ${value}');
    var kelListTemp = await pendukungProvider.fetchKelurahan(value);
    if (kelListTemp != null) {
      kelurahanList.value = kelListTemp;
      print(kelurahanList.map((element) => element.nama));
    }
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
      'kelurahan_id': '${dataArgumen[2]}',
      'nik': nik.text,
      'kk': kk.text,
      'nama': nama.text,
      'hp': hp.text,
      'umur': umur.text,
      'jk': jk.text,
      'kecamatan': kecamatan.text,
      'kelurahan': kelurahan.text,
      'alamat': alamat.text,
      'rw': rw.text,
      'rt': rt.text,
      'pilihanPartai2019': pilihanPartai2019.text,
      'pilihanPartai': pilihanPartai.text,
      'pilihan': jpilihanValue.value,
      'pilihanCapres': jpilihanCapresValue.value,
      'keluarga1': keluarga1.text,
      'keluarga2': keluarga2.text,
      'keluarga3': keluarga3.text,
      'keluarga4': keluarga4.text,
      'keluarga5': keluarga5.text,
      'gps': '${lat.value}, ${long.value}'
    };
  }


  Map<String, String> dataEditPendukung() {
    return {
      'id': '${dataArgumen[0]}',
      'hp': hp.text,
    };
  }

  void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

  addPendukungUploadCheck(BuildContext context){
    if(jpilihanValue.value.isEmpty){
      final snackBar = SnackBar(
        content: const Text('Pilihan Golkar atau tidak harap dipilih!', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else if(jpilihanCapresValue.value.isEmpty){
      final snackBar = SnackBar(
        content: const Text('Pilihan Presiden harap dipilih!', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else{
      addPendukungUpload();
    }
  }

  addPendukungUpload() async {
    final bytes = io.File(imageController.cropImagePath.value).readAsBytesSync();

    String img64 = "data:image/jog;base64,"+base64Encode(bytes);

    // print(img64);
    print(img64.length);
    printWrapped(img64);

    bool isValidate = pendukungFormKey.currentState!.validate();
    if (isValidate) {
      showLoading('Menimpan data...');
      UploadProvider().insertPendukung(
          relawan_id: homeController.relawanId.value,
          kelurahan_id: '${dataArgumen[2]}',
          kk: kk.text,
          nik: nik.text,
          nama: nama.text,
          hp: hp.text,
          umur: umur.text,
          jk: jk.text,
          kecamatan: kecamatan.text,
          kelurahan: kelurahan.text,
          alamat: alamat.text,
          rw: rw.text,
          rt: rt.text,
          pilihanPartai2019: pilihanPartai2019.text,
          pilihanPartai: pilihanPartai.text,
          pilihan: jpilihanValue.value,
          pilihanCapres: jpilihanCapresValue.value,
          keluarga1: keluarga1.text,
          keluarga2: keluarga2.text,
          keluarga3: keluarga3.text,
          keluarga4: keluarga4.text,
          keluarga5: keluarga5.text,
          img64: img64,
          img64_2: "",
          gps: '${lat.value}, ${long.value}');
    }
  }

  addPendukung(BuildContext context) async {
    print(dataPendukung());
    // return;
    bool isValidate = pendukungFormKey.currentState!.validate();
    if (isValidate) {

      if(jpilihanValue.value.isEmpty){
        final snackBar = SnackBar(
          content: const Text('Pilihan Golkar atau tidak harap dipilih!', style: TextStyle(color: Colors.yellow)),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(jpilihanCapresValue.value.isEmpty){
        final snackBar = SnackBar(
          content: const Text('Pilihan Presiden harap dipilih!', style: TextStyle(color: Colors.yellow)),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else{

        Future.delayed(const Duration(milliseconds: 500), () {
          // var data = jsonEncode(dataPendukung());

          showLoading('Menimpan data...');
          pendukungProvider.addPendukung(
            body: dataPendukung(),
            filepath: imageController.cropImagePath.value,
            fotowajah: imageController.cropImageFotoWajahPath.value,
          );
        });
      }
    }
  }

  editPendukungUpload() async {
    final bytes = io.File(imageController.cropImagePath.value).readAsBytesSync();

    String img64 = "data:image/jpg;base64,"+base64Encode(bytes);

    // print(img64);
    print(img64.length);
    printWrapped(img64);

    bool isValidate = pendukungFormKey.currentState!.validate();
    if (isValidate) {
      showLoading('Menimpan data...');
      UploadProvider().editPendukung(
          // relawan_id: homeController.relawanId.value,
          nik : '${dataArgumen[0]}',
          // kelurahan_id: '${dataArgumen[2]}',
          // nik: nik.text,
          // nama: nama.text,
          hp: hp.text,
          // umur: umur.text,
          // jk: jk.text,
          // kecamatan: kecamatan.text,
          // kelurahan: kelurahan.text,
          // alamat: alamat.text,
          // rw: rw.text,
          // rt: rt.text,
          // pilihanPartai2019: pilihanPartai2019.text,
          // pilihanPartai: pilihanPartai.text,
          // pilihan: jpilihanValue.value,
          // pilihanCapres: jpilihanCapresValue.value,
          img64: img64,
          img64_2: "",
          // gps: '${lat.value}, ${long.value}'
      );
    }
  }

  editPendukung() async {
    print(dataEditPendukung());
    // return;
    bool isValidate = pendukungFormKey.currentState!.validate();
    if (isValidate) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // var data = jsonEncode(dataPendukung());

        showLoading('Menimpan data...');
        pendukungProvider.editPendukung(
          body: dataEditPendukung(),
          filepath: imageController.cropImagePath.value,
          fotowajah: imageController.cropImageFotoWajahPath.value,
        );
      });
    }
  }

  String? validateForm(String value) {
    if (value.isEmpty) {
      return "Field tidak boleh kosong!";
    } else {
      return null;
    }
  }

  String? validateNoHP(String value) {
    if (value.isEmpty) {
      return "Field tidak boleh kosong!";
    } else {
      if (value.length < 10) {
        return "No. HP minimal 10 digit";
      }else {
        return null;
      }
    }
  }
}

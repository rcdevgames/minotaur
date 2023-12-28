import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/modules/auth/provider/auth_provider.dart';
import 'package:temres_apps/app/routes/app_pages.dart';


class AuthController extends GetxController with BaseController {
  var isAuth = false.obs;

  final PallateColors pallateColors = PallateColors();
  final AuthProvider authProvider = AuthProvider();
  // final HomeController homeController = Get.find();

  late TextEditingController hp, password;

  @override
  void onInit() {
    autoLogin();
    hp = TextEditingController();
    password = TextEditingController();

    hp.text = '0811945222';
    password.text = '12345';
    super.onInit();
  }

  Future<void> autoLogin() async {
    final box = GetStorage();
    if (box.read("dataUser") != null) {
      // final data = box.read("dataUser") as Map<String, String>;
      // print(data[0]);
      isAuth.value = true;
      // cekToken();
    }
  }

  Map<String, String> formLogin() {
    return {
      'hp': hp.text,
      'password': password.text,
    };
  }

  void login(String hp, String password) async {
    if (hp != '' && password != '') {
      showLoading('Mohon tunggu ...');
      try {
        // Get.offAllNamed(Routes.HOME);

        var dataLogin = await authProvider.loginUser(body: formLogin());
        if (dataLogin) {
          // hideLoading();
          // homeController.getFirstData();
          Get.offAllNamed(Routes.HOME);
          // homeController.getFirstData();
        } else {
          hideLoading();
          Get.defaultDialog(
            buttonColor: Colors.yellow,
            confirmTextColor: Colors.white,
            title: "Gagal Login",
            content: const Text(
                'Periksa username dan password atau hubungin pihak terkait.'),
            onConfirm: () {
              Get.back();
            },
          );
          await Future.delayed(const Duration(microseconds: 5000));
        }
      } finally {
        hideLoading();
      }
    } else {
      dialogError(
          color: Colors.yellow,
          content: const Text(
            'Semua data input harus diisi.',
          ),
          title: 'Failed.');
    }
  }
}

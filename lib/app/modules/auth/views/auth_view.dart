import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/widget/button_fill.dart';
import 'package:temres_apps/app/core/widget/field_outline.dart';
import 'package:temres_apps/app/core/widget/field_outline_password.dart';
import 'package:temres_apps/app/core/widget/logo.dart';
import 'package:temres_apps/app/core/widget/text.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                logo(
                  size: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextForm(),
                const SizedBox(
                  height: 10,
                ),
                Forms(
                  contrroler: controller.hp,
                  enable: true,
                  hintext: '',
                  label: 'Nomor HP',
                  suffixText: '',
                  typeKeyboard: TextInputType.number,
                  validator: (value) {
                    return null;
                  },
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormsPassword(
                  contrroler: controller.password,
                  enable: true,
                  hintext: '',
                  label: 'Password',
                  suffixText: '',
                  typeKeyboard: TextInputType.text,
                  validator: (value) {
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonFill(
                  color: controller.pallateColors.primaryColor,
                  label: 'Masuk',
                  onPressed: () {
                    controller.login(
                        controller.hp.text, controller.password.text);
                    // Get.toNamed(Routes.HOME);
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

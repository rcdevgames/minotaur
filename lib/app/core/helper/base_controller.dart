import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import 'dialog_helper.dart';

class BaseController {
  final PallateColors _pallateColors = PallateColors();
  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  dialogError({
    required String title,
    required Text content,
    required Color color,
  }) async {
    hideLoading();
    Get.defaultDialog(
      radius: 10.0,
      buttonColor: color,
      confirmTextColor: Colors.white,
      title: title,
      content: content,
      onConfirm: () {
        Get.back();
      },
    );
    await Future.delayed(const Duration(seconds: 1));
  }

  dialogSuccess(
      {void Function()? onConfirm,
      required String title,
      required String body}) async {
    hideLoading();
    Get.defaultDialog(
      buttonColor: _pallateColors.primaryColor,
      confirmTextColor: Colors.white,
      radius: 10.0,
      title: title,
      content: Builder(builder: (context) {
        return Text(body);
      }),
      onConfirm: () {
        onConfirm;
        Get.back();
      },
    );
    await Future.delayed(const Duration(seconds: 1));
  }
}

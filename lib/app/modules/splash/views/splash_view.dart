import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/core/widget/logo.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
                color: Color.fromARGB(214, 170, 16, 16)),
          ),
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       logo(
        //         size: 150,
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Text(
        //         'TEMRES APPS',
        //         style: mBrandStyle,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

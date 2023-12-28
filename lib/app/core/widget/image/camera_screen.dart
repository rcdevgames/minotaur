// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/base_controller.dart';
import 'image_controller.dart';

class CameraScreen extends StatelessWidget with BaseController {
  CameraScreen();

  final ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder<void>(
            future: imageController.cameraController.initialize(),
            builder: (context, snapshot) {
              print(snapshot.connectionState.toString());
              print(snapshot.stackTrace.toString());
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: CameraPreview(imageController.cameraController));
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    showLoading('Menyiapkan editor...');
                    var file =
                        await imageController.cameraController.takePicture();
                    if (file != null) {
                      try {
                        print('>>>>>>>>>>>>>>');
                        print(imageController.argumets);
                        print(Get.parameters['image']);
                        // imageController.cropImage(
                        //     File(file.path), imageController.argumets[0]);
                        imageController.cropImage(
                            File(file.path), Get.parameters['image']!, context);
                        hideLoading();
                      } catch (e) {
                        imageController.getSnakbar(
                            'Gagal', 'Tidak ada image yang dipilih.');

                        Get.back();
                      }
                      Get.back();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

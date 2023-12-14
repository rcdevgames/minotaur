import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../constant/color.dart';
import '../../helper/base_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageController extends GetxController with BaseController {
  late List<CameraDescription> camera;

  final PallateColors pallateColors = PallateColors();

  late CameraController cameraController; //To control the camera
  late Future<void>?
      initializeControllerFuture; //Future to wait until camera initializes
  var argumets = Get.arguments;
  var src = '0'.obs;

  var img = ''.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

//crop image
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;
//crop image
  var cropImageFotoWajahPath = ''.obs;

  @override
  void onInit() async {
    src.value = argumets[0];
    print('_____${argumets[0]}');
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    cameraController.setFlashMode(FlashMode.off);
    initializeControllerFuture = cameraController.initialize();

    super.onInit();
  }

  @override
  void onClose() {
    cameraController.dispose();
    _clearCachedFiles();
  }

  Future<File> compressFile({required File? file}) async {
    final filePath = file!.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      outPath,
      quality: 30,
    );
    return result!;
  }

  void fileImage(String src) async {
    showLoading('Menyiapkan galeri...');

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      // copy the file to a new path
      // File file = File(result.files.single.path!);
      img.value = file.path!;

      print('>>>>>>>>>>>>>>');
      print(src);

      cropImage(File(img.value), src);
      Get.back();
    } else {
      hideLoading();
      getSnakbar('Gagal', 'Tidak ada image yang dipilih.');
    }
  }

  getSnakbar(String title, String label) {
    Get.snackbar(title, label,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        colorText: Colors.black);
  }

  void _clearCachedFiles() async {
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      if (result!) {
        print('clear: $result');
      } else {
        print("Gagal clear cache.");
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      Get.back();
    }
  }

  void _logException(String message) {
    print(message);
    SnackBar(
      content: Text(message),
    );
  }

  cropImage(File file, String srcx) async {
    final img = await compressFile(file: file);
    file = img;
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = p.join(dir.path, file.path);

    final cropImageFile = await ImageCropper().cropImage(
        sourcePath: pathName,
        // compressQuality: 1,
        aspectRatioPresets: [CropAspectRatioPreset.original],
        compressFormat: ImageCompressFormat.jpg);

    if (cropImageFile!.path != "") {
      if (srcx == "1") {
        cropImagePath.value = cropImageFile.path;
        print('>>>>>>>>>>>>>>>>>>>>>>');
        print(cropImageFile);
      } else if (srcx == "2") {
        cropImageFotoWajahPath.value = cropImageFile.path;
      } else {
        null;
      }

    }
  }
}

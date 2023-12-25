import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:path/path.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/core/widget/button_fill.dart';
import 'package:temres_apps/app/modules/dpt/provider/dpt_model.dart';
import 'package:temres_apps/app/modules/pendukung/controllers/tambah_controller.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../../../core/constant/service.dart';
import '../../../core/constant/strings.dart';
import '../../../core/widget/field_outline.dart';
import '../../../core/widget/form_option.dart';
import '../../../core/widget/form_option_cb.dart';
import '../../../core/widget/form_option_kec.dart';
import '../../../core/widget/form_option_kel.dart';
import '../../../core/widget/image/image_controller.dart';
import '../provider/pendukung_model.dart';

class EditView extends GetView<TambahController> with BaseController {

  final ApiProvider apiProvider = ApiProvider();
  var id_pendukung = "";
  var url_img = "";
  EditView({Key? key}) : super(key: key);

  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {

    if(Get.arguments!= null) {
      List<dynamic> arguments = Get.arguments;

      if (id_pendukung.isEmpty) {
        id_pendukung = arguments[0].toString();
        controller.id_pendukung = arguments[0];
        controller.hp.text = arguments[2];
        controller.umur.text = arguments[3];
        url_img = arguments[4];

        url_img = "${apiProvider.baseUrl}image/$url_img";

        print("url image ${url_img} ");
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: PallateColors().primaryColor,
          title: const Text('Edit Pendukung'),
          centerTitle: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                key: controller.pendukungFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Lengkapi Data Survey',
                                  style: TextStyle(
                                    color: Color(0xFF59676C),
                                    fontSize: 25,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Forms(
                      contrroler: controller.nama,
                      enable: false,
                      hintext: 'Contoh: Jonh Lemos',
                      label: 'Nama Lengkap',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.text,
                      validator: (value) {
                        return controller.validateForm(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Forms(
                      contrroler: controller.hp,
                      enable: true,
                      hintext: 'Contoh: 085255xxxx',
                      label: 'No HP aktif',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.number,
                      validator: (value) {
                        return controller.validateNoHP(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: Text(controller.kabupatenList.join(" ")),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: Text(controller.kecamatanList.join(" ")),
                    ),

                    Image.network(url_img,
                        height: 150,
                        fit:BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                      return Text('Gambar tidak ada');
                      },


                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (() {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  "Pilih foto",
                                  style: mLabelStyle,
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          // showLoading('loading Progres');
                                          Future.delayed(
                                              const Duration(microseconds: 100),
                                              () {
                                            hideLoading();
                                            Get.toNamed(Routes.CAMERA,
                                                parameters: {"image": "1"});
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.camera_alt,
                                              size: 30,
                                              color: imageController
                                                  .pallateColors.primaryColor,
                                            ),
                                            Text(
                                              'Camera',
                                              style: kHintTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();

                                          Future.delayed(
                                              const Duration(microseconds: 100),
                                              () {
                                            hideLoading();
                                            imageController.fileImage('1', context);
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.photo_album,
                                              size: 30,
                                              color: imageController
                                                  .pallateColors.primaryColor,
                                            ),
                                            Text('Galeri',
                                                style: kHintTextStyle)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                          child: SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Obx(
                              () => imageController.cropImagePath.value == ''
                                  ? Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                PallateColors().primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        // 'Kirim Foto\r\n * tidak wajib',
                                        'Kirim Foto',
                                        style: kHintTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: controller
                                              .pallateColors.bgNavBarColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.file(
                                        File(imageController
                                            .cropImagePath.value),
                                        width: double.infinity,
                                        height: 300,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonFill(
                        label: "Simpan & Kirim Sekarang",
                        onPressed: () {
                          controller.editPendukung();
                        },
                        color: PallateColors().primaryColor),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonFill(
                        label: "Simpan & Kirim nanti",
                        onPressed: () {
                          controller.editPendukungUpload();
                        },
                        color: PallateColors().primaryColor),
                  ],
                ),
              )),
        ));
  }
}

class DataBundleToEdit {
  final String id;
  final String name;
  final PendukungModel dpt;
  DataBundleToEdit({required this.id, required this.name, required this.dpt});
}
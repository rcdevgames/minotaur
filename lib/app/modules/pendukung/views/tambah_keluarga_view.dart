
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/core/helper/base_controller.dart';
import 'package:temres_apps/app/core/widget/button_fill.dart';
import 'package:temres_apps/app/modules/pendukung/controllers/tambah_keluarga_controller.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../../../core/constant/strings.dart';
import '../../../core/widget/field_outline.dart';
import '../../../core/widget/form_option.dart';
import '../../../core/widget/image/image_controller.dart';

class TambahKeluargaView extends GetView<TambahKeluargaController> with BaseController {
  TambahKeluargaView({Key? key}) : super(key: key);
  final ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PallateColors().primaryColor,
          title: const Text('Tambah Pendukung'),
          centerTitle: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                key: controller.pendukungFormKey,
                child: Column(
                  children: <Widget>[
                    Forms(
                      contrroler: controller.nik,
                      enable: true,
                      hintext: 'Contoh: 747203081098288',
                      label: 'NIK',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.number,
                      validator: (value) {
                        return controller.validateForm(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Forms(
                      contrroler: controller.nama,
                      enable: true,
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
                    FormOption(
                      controller: controller.jk,
                      options: genderItems,
                      title: 'Jenis Kelamin',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Forms(
                      contrroler: controller.alamat,
                      enable: true,
                      hintext: 'Contoh: Jalan Srikaya No. 02',
                      label: 'Alamat',
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
                      contrroler: controller.rw,
                      enable: (controller.rw.text == '0') ? true : false,
                      hintext: 'Contoh: 01',
                      label: 'RW',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.number,
                      validator: (value) {
                        return controller.validateForm(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Forms(
                      contrroler: controller.rt,
                      enable: (controller.rt.text == '0') ? true : false,
                      hintext: 'Contoh: 01',
                      label: 'RT',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.number,
                      validator: (value) {
                        return controller.validateForm(value!);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Forms(
                      contrroler: controller.tps,
                      enable: (controller.tps.text == '0') ? true : false,
                      hintext: 'Contoh: 1',
                      label: 'TPS',
                      obscureText: false,
                      suffixText: '',
                      typeKeyboard: TextInputType.number,
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
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apakah ibu/bapak/saudara sudah terdata dalam DPT dan memilih di TPS kelurahan ini?',
                          style: mLabelStyle,
                        ),
                        RadioGroup<String>.builder(
                          groupValue: controller.jterdaftar.value,
                          onChanged: (value) {
                            controller.jterdaftar.value = value!;

                            (value == controller.terdaftarMemilih[0])
                                ? controller.jterdaftarValue.value = '1'
                                : (value == controller.terdaftarMemilih[1])
                                    ? controller.jterdaftarValue.value = '2'
                                    : "0";
                            print(controller.jterdaftarValue.value);
                          },
                          items: controller.terdaftarMemilih,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apakah ibu/bapak/saudara sudah ada pilihan caleg DPR RI?',
                          style: mLabelStyle,
                        ),
                        RadioGroup<String>.builder(
                          groupValue: controller.jpilihan.value,
                          onChanged: (value) {
                            controller.jpilihan.value = value!;

                            (value == controller.pilihan[0])
                                ? controller.jpilihanValue.value = '1'
                                : (value == controller.pilihan[1])
                                    ? controller.jpilihanValue.value = '2'
                                    : "0";
                            print(controller.jpilihanValue.value);
                          },
                          items: controller.pilihan,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apakah ibu/bapak/saudara sudah tahu/kenal Ida Fauziyah?',
                          style: mLabelStyle,
                        ),
                        RadioGroup<String>.builder(
                          groupValue: controller.jbersedia.value,
                          onChanged: (value) {
                            controller.jbersedia.value = value!;

                            (value == controller.bersedia[0])
                                ? controller.jbersediaValue.value = '1'
                                : (value == controller.bersedia[1])
                                    ? controller.jbersediaValue.value = '2'
                                    : "0";
                            print(controller.jbersediaValue.value);
                          },
                          items: controller.bersedia,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'apakah ibu/bapak/saudari bersedia jika kami akan berkunjung kembali untuk mensosialisasikan program ibu Ida Fauziyah?',
                          style: mLabelStyle,
                        ),
                        RadioGroup<String>.builder(
                          groupValue: controller.jkembali.value,
                          onChanged: (value) {
                            controller.jkembali.value = value!;

                            (value == controller.kembali[0])
                                ? controller.jkembaliValue.value = '1'
                                : (value == controller.kembali[1])
                                    ? controller.jkembaliValue.value = '2'
                                    : "0";
                            print(controller.jkembaliValue.value);
                          },
                          items: controller.kembali,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apakah Ibu/bapak bersedia menjadi bagian dari keluarga besar  pemilih Ida Fauziyah?',
                          style: mLabelStyle,
                        ),
                        RadioGroup<String>.builder(
                          groupValue: controller.jkeluarga.value,
                          onChanged: (value) {
                            controller.jkeluarga.value = value!;

                            (value == controller.keluarga[0])
                                ? controller.jkeluargaValue.value = '1'
                                : (value == controller.keluarga[1])
                                    ? controller.jkeluargaValue.value = '2'
                                    : (value == controller.keluarga[2])
                                        ? controller.jkeluargaValue.value = '3'
                                        : "0";
                            print(controller.jkeluargaValue.value);
                          },
                          items: controller.keluarga,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ],
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
                                      // InkWell(
                                      //   onTap: () {
                                      //     Get.back();
                                      //     // showLoading('loading Progres');
                                      //     Future.delayed(
                                      //         const Duration(microseconds: 100),
                                      //         () {
                                      //       hideLoading();
                                      //       Get.toNamed(Routes.CAMERA,
                                      //           arguments: ['1']);
                                      //     });
                                      //   },
                                      //   child: Column(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: <Widget>[
                                      //       Icon(
                                      //         Icons.camera_alt,
                                      //         size: 30,
                                      //         color: imageController
                                      //             .pallateColors.primaryColor,
                                      //       ),
                                      //       Text(
                                      //         'Camera',
                                      //         style: kHintTextStyle,
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   width: 50,
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();

                                          Future.delayed(
                                              const Duration(microseconds: 100),
                                              () {
                                            hideLoading();
                                            imageController.fileImage('1');
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
                                        'Upload foto KTP',
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
                                      // InkWell(
                                      //   onTap: () {
                                      //     Get.back();
                                      //     // showLoading('loading Progres');
                                      //     Future.delayed(
                                      //         const Duration(microseconds: 100),
                                      //         () {
                                      //       hideLoading();
                                      //       Get.toNamed(Routes.CAMERA,
                                      //           arguments: ['2']);
                                      //     });
                                      //   },
                                      //   child: Column(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: <Widget>[
                                      //       Icon(
                                      //         Icons.camera_alt,
                                      //         size: 30,
                                      //         color: imageController
                                      //             .pallateColors.primaryColor,
                                      //       ),
                                      //       Text(
                                      //         'Camera',
                                      //         style: kHintTextStyle,
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   width: 50,
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();

                                          Future.delayed(
                                              const Duration(microseconds: 100),
                                              () {
                                            hideLoading();
                                            imageController.fileImage('2');
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
                              () => imageController
                                          .cropImageFotoWajahPath.value ==
                                      ''
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
                                        'Upload foto Selfi',
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
                                            .cropImageFotoWajahPath.value),
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
                        label: "Simpan",
                        onPressed: () {
                          controller.addPendukung();
                        },
                        color: PallateColors().primaryColor),
                  ],
                ),
              )),
        ));
  }
}

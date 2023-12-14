import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/widget/button_fill.dart';
import 'package:temres_apps/app/core/widget/field_outline.dart';
import 'package:temres_apps/app/modules/dpt/provider/deskel_model.dart';
import 'package:temres_apps/app/modules/dpt/views/dptcard_view.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../../../core/constant/text_styles.dart';
import '../controllers/dpt_controller.dart';
import '../provider/dpt_provider.dart';
import '../provider/kabkota_model.dart';
import '../provider/kecamatan_model.dart';

class DptView extends GetView<DptController> {
  DptView({Key? key}) : super(key: key);
  final DptProvider dptProvider = DptProvider();

  Widget _customPopupItemBuilderExample2(
      BuildContext context, KabkotaModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.id),
        subtitle: Text(item.kabkota.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PallateColors().primaryColor,
        title: const Text('Daftar Pemilih Tetap'),
        centerTitle: true,
      ),
      body: Obx(() => Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: controller.cariFormKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        padding: EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF9C717),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text.rich(TextSpan(
                          children: [
                            TextSpan(
                              text: 'Wilayah Kerja\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'KEL. ${controller.dtArguments[1]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Forms(
                          contrroler: controller.nama,
                          label: 'Masukkan Nama',
                          hintext: 'Contoh: John Sample',
                          typeKeyboard: TextInputType.text,
                          enable: true,
                          obscureText: false,
                          suffixText: '',
                          validator: (value) {
                            return controller.validateForm(value!);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Forms(
                          contrroler: controller.rt,
                          label: 'RT',
                          hintext: 'Contoh: 001',
                          typeKeyboard: TextInputType.text,
                          enable: true,
                          obscureText: false,
                          suffixText: '',
                          validator: (value) {
                            return null;
                            return controller.validateForm(value!);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Forms(
                          contrroler: controller.rw,
                          label: 'RW',
                          hintext: 'Contoh: 001',
                          typeKeyboard: TextInputType.text,
                          enable: true,
                          obscureText: false,
                          suffixText: '',
                          validator: (value) {
                            return null;
                            return controller.validateForm(value!);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        title: Text("Cari sesuai ejaan"),
                        value: controller.ejaan.value,
                        onChanged: (newValue) {
                          // print(newValue);
                          controller.setEjaan(newValue);
                          // controller.ejaan(false);
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonFill(
                          label: 'Cari',
                          onPressed: () {
                            controller.getDptByName();
                          },
                          color: PallateColors().primaryColor),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Result ${controller.dptList.length}",
                              style: kHintTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: controller.isLoading.value
                    ? Container(
                        margin: EdgeInsets.all(10),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : controller.dptList.isEmpty
                        ? Column(
                            children: [
                              Center(
                                  child: Text(
                                'Data tidak ada',
                                style: kHintTextStyle,
                              )),
                              (controller.dptList.isEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.TAMBAHPENDUKUNG,
                                            arguments: [
                                              "0",
                                              controller.nama.text,
                                              controller.dtArguments[0],
                                              "0",
                                              "0",
                                              "0"
                                            ]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: PallateColors().primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text('Tambahkan Pendukung',
                                            style: mBtn),
                                      ))
                                  : Container(),
                            ],
                          )
                        : ListView.builder(
                            itemCount: controller.dptList.length,
                            itemBuilder: (context, index) {
                              return DptcardView(controller.dptList[index]);
                            },
                          ),
              )
            ],
          )),
    );
  }
}

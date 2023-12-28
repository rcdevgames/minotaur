import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_model.dart';
import 'package:temres_apps/app/modules/pendukung/views/edit_view.dart';

import '../../../routes/app_pages.dart';

class PendukungcardView extends GetView {
  final PendukungModel dptModel;
  PendukungcardView(this.dptModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: PallateColors().primaryColor),
          borderRadius: BorderRadius.circular(10)),
      height: 100,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        onTap: (){
          print("go klik first! ${dptModel.id} - ${dptModel.nama} - ${dptModel.hp}");
          Get.toNamed(Routes.EDITPENDUKUNG,
              arguments: [
                dptModel.id,
                dptModel.nama,
                dptModel.hp,
                dptModel.umur,
                dptModel.img,
                "0"
              ]);

          // final dataBundle = DataBundleToEdit(id: dptModel.id, name: dptModel.nama, dpt: dptModel);
          // Get.to(() => EditView(dataBundle: dataBundle));
        },
        child: ListTile(
          leading: InkWell(
              onTap: () {
              },
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  'assets/png/logo.jpeg',
                  scale: 1,
                ),
              )),
          title: Text(
            dptModel.nama,
            style: titleCard,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KEC: ${dptModel.kecamatan} \n'
                'KEL:${dptModel.kelurahan}',
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: bodyCard,
              ),
              Text(
                'RW ${dptModel.rw} / RT ${dptModel.rt} \n'
                'Umur ${dptModel.umur} Tahun',
                style: bodyCard,
              ),
            ],
          ),

        ),
      ),
    );
  }
}

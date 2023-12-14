import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../provider/dpt_model.dart';

class DptcardView extends GetView {
  final DptModel dptModel;
  DptcardView(this.dptModel);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(Routes.TAMBAHPENDUKUNG, arguments: [
            dptModel.id,
            dptModel.nama,
            dptModel.kelurahanId,
            dptModel.rw,
            dptModel.rt,
            dptModel.tps
          ]);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: PallateColors().primaryColor),
              borderRadius: BorderRadius.circular(10)),
          height: 100,
          margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          child: ListTile(
            leading: InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    'assets/png/logo.png',
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
                  'TPS: ${dptModel.tps} ',
                  style: bodyCard,
                ),
              ],
            ),
          ),
        ));
  }
}

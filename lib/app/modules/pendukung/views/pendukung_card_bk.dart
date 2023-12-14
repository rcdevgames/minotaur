import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/modules/pendukung/provider/pendukung_model.dart';
import 'package:temres_apps/app/modules/pendukung/provider/upload_provider.dart';

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
              'Umur ${dptModel.umur} Tahun',
              style: bodyCard,
            ),
          ],
        ),
        trailing: OutlinedButton.icon(
          onPressed: () {
            print("cek upload ${dptModel.id}");
            print(dptModel.id);
            UploadProvider().upload(dptModel.id);
          },
          icon: Icon(
            Icons.file_upload_rounded,
            size: 16.0,
            color: PallateColors().primaryColor,
          ),
          label: const Text(
            'Kirim',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

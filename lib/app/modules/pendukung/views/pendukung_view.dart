import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/color.dart';
// import 'package:temres_apps/app/modules/pendukung/views/pendukung_card.dart';
import 'package:temres_apps/app/modules/pendukung/views/pendukung_card_bk.dart';

import '../../../core/constant/text_styles.dart';
import '../controllers/pendukung_controller.dart';

class PendukungView extends GetView<PendukungController> {
  const PendukungView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PallateColors().primaryColor,
          title: const Text('Belum dikirim'),
          centerTitle: true,
        ),
        body: Obx(() => RefreshIndicator(
              onRefresh: () async {
                controller.refreshPage();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total ${controller.pendukungList.length}",
                            style: kHintTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: controller.isLoading.value
                            ? Container(
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : controller.pendukungList.isEmpty
                                ? Center(
                                    child: Text(
                                    'Data tidak ada',
                                    style: kHintTextStyle,
                                  ))
                                : ListView.builder(
                                    itemCount: controller.pendukungList.length,
                                    itemBuilder: (context, index) {
                                      return PendukungcardView(
                                          controller.pendukungList[index]);
                                    },
                                  )),
                  ],
                ),
              ),
            )));
  }
}

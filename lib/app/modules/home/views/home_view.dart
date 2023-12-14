import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/constant/text_styles.dart';
import 'package:temres_apps/app/core/widget/appbar.dart';
import 'package:temres_apps/app/core/widget/cardCount.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../../pendukung/views/pendukung_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('xlogx Reached bottom of the list. Loading more data...');
        controller.loadMorePendukung();
      }
    });

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshPage();
        },
        child: Obx(
              () => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                AppBarCustom(),
                CardCount(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Data Pendukung Terbaru",
                        style: kHintTextStyle,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.PENDUKUNG,
                              arguments: [controller.relawanId]);
                        },
                        child: Text("Belum dikirim", style: kHintTextStyle),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.pendukungList.length,
                    itemBuilder: (context, index) {
                      return PendukungcardView(
                        controller.pendukungList[index],
                      );
                    },
                  ),
                ),
                if (controller.isLoadingMore.value)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                if (controller.pendukungList.isEmpty && !controller.isLoading.value)
                  Center(
                    child: Text(
                      'Data tidak ada',
                      style: kHintTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PallateColors().primaryColor,
        onPressed: () {
          Get.toNamed(Routes.TAMBAHPENDUKUNG,
              arguments: ["0", "", "", "0", "0", "0"]);
        },
        child: Icon(Icons.post_add),
      ),
    );
  }
}

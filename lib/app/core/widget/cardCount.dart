import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';

class CardCount extends StatelessWidget {
  CardCount({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        decoration: ShapeDecoration(
          color: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            // height: 35,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total input\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '${homeController.count.value} Survey',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )),
                  InkWell(
                    onTap: () {
                      homeController.refreshPage();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(Icons.refresh_outlined)),
                  ),
                ])),
      ),
    );
  }
}

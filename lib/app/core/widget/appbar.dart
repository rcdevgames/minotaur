// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:temres_apps/app/core/constant/color.dart';
import 'package:temres_apps/app/core/widget/button_fill.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';
import 'package:temres_apps/app/routes/app_pages.dart';

import '../constant/text_styles.dart';

class AppBarCustom extends StatelessWidget {
  AppBarCustom({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sahabat Syafaat\n',
                      style: TextStyle(
                        color: Color(0xFF59676C),
                        fontSize: 25,
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '${homeController.nama.toUpperCase()}',
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
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        // ignore: avoid_print
                        print('Notif ditekan');
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: HexColor('#FAFCF8')),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset('assets/svg/notif.svg'),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        homeController.logout();
                        // ignore: avoid_print
                        print('Notif ditekan');
                      },
                      child: Container(
                          width: 31,
                          height: 31,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            image: DecorationImage(
                                image: AssetImage('assets/png/logo.jpeg'),
                                fit: BoxFit.fitWidth),
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 0.50, color: Color(0xFF0E7899)),
                            ),
                          )))
                ],
              )
            ],
          ),
        ));
  }
}

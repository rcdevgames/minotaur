import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wilayah_controller.dart';

class WilayahView extends GetView<WilayahController> {
  const WilayahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WilayahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WilayahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final deskelModel = deskelModelFromJson(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';

import '../../../core/constant/service.dart';
import '../controllers/dpt_controller.dart';

class DeskelModel {
  final String id;
  final String kelurahan;

  DeskelModel({
    required this.id,
    required this.kelurahan,
  });

  factory DeskelModel.fromRawJson(String str) =>
      DeskelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeskelModel.fromJson(Map<String, dynamic> json) => DeskelModel(
        id: json["id"],
        kelurahan: json["kelurahan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kelurahan": kelurahan,
      };
}

class SearchDeskel {
  static var client = http.Client();
  static final ApiProvider apiProvider = ApiProvider();
  static final DptController dptController = Get.find();
  static final HomeController homeController = Get.find();

  static Future<List<DeskelModel>> getDeskel(String query) async {
    var relawanId = homeController.relawanId.value;
    final baseUrl = Uri.parse(
        '${apiProvider.baseUrl}/api/get-deskel.php?relawan_id=$relawanId');
    final response =
        await client.get(baseUrl, headers: {'Accept': 'applcation/json'});

    // print("cek respon: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> responseMap = json.decode(response.body);

      return responseMap
          .map((json) => DeskelModel.fromJson(json))
          .where((deskel) {
        final nameLower = deskel.kelurahan.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

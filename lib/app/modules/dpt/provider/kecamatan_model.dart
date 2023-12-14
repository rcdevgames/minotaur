// To parse this JSON data, do
//
//     final kecamatanModel = kecamatanModelFromJson(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:temres_apps/app/modules/dpt/controllers/dpt_controller.dart';

import '../../../core/constant/service.dart';

class KecamatanModel {
  final String id;
  final String kecamatan;

  KecamatanModel({
    required this.id,
    required this.kecamatan,
  });

  factory KecamatanModel.fromRawJson(String str) =>
      KecamatanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
        id: json["id"],
        kecamatan: json["kecamatan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kecamatan": kecamatan,
      };
}

class SearchKecamatan {
  static var client = http.Client();
  static final ApiProvider apiProvider = ApiProvider();
  static final DptController dptController = Get.find();

  static Future<List<KecamatanModel>> getKecamatan(String query) async {
    var kabkotid = dptController.kabkotId.value;
    final baseUrl = Uri.parse(
        '${apiProvider.baseUrl}/api/get-kecamatan.php?kabkota_id=$kabkotid');
    final response =
        await client.get(baseUrl, headers: {'Accept': 'applcation/json'});

    // print("cek respon: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> responseMap = json.decode(response.body);

      return responseMap
          .map((json) => KecamatanModel.fromJson(json))
          .where((kecamatan) {
        final nameLower = kecamatan.kecamatan.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

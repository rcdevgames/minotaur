// To parse this JSON data, do
//
//     final kabkotaModel = kabkotaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constant/service.dart';

class KabkotaModel {
  final String id;
  final String kabkota;

  KabkotaModel({
    required this.id,
    required this.kabkota,
  });

  factory KabkotaModel.fromRawJson(String str) =>
      KabkotaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KabkotaModel.fromJson(Map<String, dynamic> json) => KabkotaModel(
        id: json["id"],
        kabkota: json["kabkota"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kabkota": kabkota,
      };
}

class SearchKabkota {
  static var client = http.Client();
  static final ApiProvider apiProvider = ApiProvider();

  static Future<List<KabkotaModel>> getKabkota(String query) async {
    final baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get-kabkota.php');
    final response =
        await client.get(baseUrl, headers: {'Accept': 'applcation/json'});

    // print("cek respon: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> responseMap = json.decode(response.body);

      return responseMap
          .map((json) => KabkotaModel.fromJson(json))
          .where((kabkota) {
        final nameLower = kabkota.kabkota.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

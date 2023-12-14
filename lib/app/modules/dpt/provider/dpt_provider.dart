import 'dart:convert';

import 'package:get/get.dart';
import 'package:temres_apps/app/core/constant/service.dart';
import 'package:temres_apps/app/modules/dpt/provider/dpt_model.dart';

import 'package:http/http.dart' as http;

import 'kabkota_model.dart';

class DptProvider extends GetConnect {
  final ApiProvider apiProvider = ApiProvider();
  static var client = http.Client();
  Future<List<DptModel>?> fetchDpt(
      {required nama, required String kelId, required rt, required rw, required ejaan}) async {
    var baseUrl = Uri.parse(
        '${apiProvider.baseUrl}/api/get-dpt-byname.php?nama=$nama&kelurahan_id=$kelId&rt=$rt&rw=$rw&ejaan=$ejaan');
    print(baseUrl);
    var response =
        await client.get(baseUrl, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dynamic json) {
        return DptModel.fromJson(json);
      }).toList();
    }
    return null;
  }

  Future<List<KabkotaModel>> getKabkota() async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/get-kabkota.php');
    var response =
        await client.get(baseUrl, headers: {'Accept': 'application/json'});
    List<dynamic> data = json.decode(response.body);
    return data.map((dynamic json) {
      return KabkotaModel.fromJson(json);
    }).toList();
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant/service.dart';
import '../controllers/jumlah_model.dart';

class HomeProvider extends GetConnect {
  final ApiProvider apiProvider = ApiProvider();
  static var client = http.Client();
  fetchCount(String user_id) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/count_pendukung.php?relawan_id=$user_id');
    var response =await client.get(baseUrl, headers: {'Accept': 'application/json'});
    print(response.body);
    var jsonResponse = json.decode(response.body);
    var dataTojson = JumlahModel.fromJson(jsonResponse);

    if (response.statusCode == 200) {
      final box = GetStorage();
      box.write('count', dataTojson);
    }
  }

  createPosisi({required Map<String, String> body}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/tambah-posisi.php');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    var response = await client.post(baseUrl, body: body, headers: headers);
    print(response.body);
  }
}

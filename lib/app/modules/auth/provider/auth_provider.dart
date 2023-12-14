import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temres_apps/app/core/constant/service.dart';

import 'package:http/http.dart' as http;
import 'package:temres_apps/app/modules/auth/provider/login_model.dart';
import 'package:temres_apps/app/modules/home/controllers/home_controller.dart';

class AuthProvider extends GetConnect {
  final ApiProvider apiProvider = ApiProvider();
  static var client = http.Client();

  // Post request
  Future<bool> loginUser({required Map<String, String> body}) async {
    var baseUrl = Uri.parse('${apiProvider.baseUrl}/api/login.php');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content': 'application/json',
    };
    var response = await client.post(baseUrl, body: body, headers: headers);
    var jsonResponse = json.decode(response.body);

    print(jsonResponse);
    print(response.statusCode);
    if (response.statusCode == 401) {
      return false;
    }
    var dataTojson = LoginModel.fromJson(jsonResponse);

    if (response.statusCode == 200) {
      final box = GetStorage();
      box.write('dataUser', dataTojson);
      return true;
    }
    return false;
  }
}




  //   var baseUrl = Uri.parse(
  //       'https://9234-2001-448a-2076-2061-281e-a57f-b6c0-eb61.ngrok-free.app/api/login.php');
  //   return post(baseUrl.toString(), dataLogin, headers: {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json'
  //   });
  // }
// }

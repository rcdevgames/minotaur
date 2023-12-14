import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String userId;
  final String nama;
  final String hp;
  final String kelurahanId;
  final String kelurahan;

  LoginModel({
    required this.userId,
    required this.nama,
    required this.hp,
    required this.kelurahanId,
    required this.kelurahan,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userId: json["userId"],
        nama: json["nama"],
        hp: json["hp"],
        kelurahanId: json["kelurahanId"],
        kelurahan: json["kelurahan"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nama": nama,
        "hp": hp,
        "kelurahanId": kelurahanId,
        "kelurahan": kelurahan,
      };
}

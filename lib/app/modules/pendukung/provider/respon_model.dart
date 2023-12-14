import 'dart:convert';

class ResponModel {
  final String kode;
  final String msg;

  ResponModel({
    required this.kode,
    required this.msg,
  });

  factory ResponModel.fromRawJson(String str) =>
      ResponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponModel.fromJson(Map<String, dynamic> json) => ResponModel(
        kode: json["kode"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "kode": kode,
        "msg": msg,
      };
}

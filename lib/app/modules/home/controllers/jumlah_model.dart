import 'dart:convert';

class JumlahModel {
  final String jumlah;

  JumlahModel({
    required this.jumlah,
  });

  factory JumlahModel.fromRawJson(String str) =>
      JumlahModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JumlahModel.fromJson(Map<String, dynamic> json) => JumlahModel(
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
      };
}

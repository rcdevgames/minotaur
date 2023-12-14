import 'dart:convert';

class KelurahanModel {
  final String id;
  final String nama;

  KelurahanModel({
    required this.id,
    required this.nama,
  });

  factory KelurahanModel.fromRawJson(String str) =>
      KelurahanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KelurahanModel.fromJson(Map<String, dynamic> json) => KelurahanModel(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

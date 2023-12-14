import 'dart:convert';

class KabupatenModel {
  final String id;
  final String nama;

  KabupatenModel({
    required this.id,
    required this.nama,
  });

  factory KabupatenModel.fromRawJson(String str) =>
      KabupatenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KabupatenModel.fromJson(Map<String, dynamic> json) => KabupatenModel(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

import 'dart:convert';

class KecamatanModel {
  final String id;
  final String nama;

  KecamatanModel({
    required this.id,
    required this.nama,
  });

  factory KecamatanModel.fromRawJson(String str) =>
      KecamatanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

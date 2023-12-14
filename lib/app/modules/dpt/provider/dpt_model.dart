import 'dart:convert';

class DptModel {
  final String id;
  final String nama;
  final String kecamatan;
  final String kelurahanId;
  final String kelurahan;
  final String rw;
  final String rt;
  final String tps;

  DptModel({
    required this.id,
    required this.nama,
    required this.kecamatan,
    required this.kelurahanId,
    required this.kelurahan,
    required this.rw,
    required this.rt,
    required this.tps,
  });

  factory DptModel.fromRawJson(String str) =>
      DptModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DptModel.fromJson(Map<String, dynamic> json) => DptModel(
        id: json["id"],
        nama: json["nama"],
        kecamatan: json["kecamatan"],
        kelurahanId: json["kelurahan_id"],
        kelurahan: json["kelurahan"],
        rw: json["rw"],
        rt: json["rt"],
        tps: json["tps"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kecamatan": kecamatan,
        "kelurahan_id": kelurahanId,
        "kelurahan": kelurahan,
        "rw": rw,
        "rt": rt,
        "tps": tps,
      };
}

import 'dart:convert';

class PendukungModel {
  final String id;
  final String nama;
  final String hp;
  final String kecamatan;
  final String kelurahanId;
  final String kelurahan;
  final String rw;
  final String rt;
  final String umur;
  final String img;

  PendukungModel({
    required this.id,
    required this.nama,
    required this.hp,
    required this.kecamatan,
    required this.kelurahanId,
    required this.kelurahan,
    required this.rw,
    required this.rt,
    required this.umur,
    required this.img,
  });

  factory PendukungModel.fromRawJson(String str) =>
      PendukungModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PendukungModel.fromJson(Map<String, dynamic> json) => PendukungModel(
        id: json["id"]??"",
        nama: json["nama"]??"",
        hp: json["hp"]??"",
        kecamatan: json["kecamatan"]??"",
        kelurahanId: json["kelurahan_id"]??"",
        kelurahan: json["kelurahan"]??"",
        rw: json["rw"]??"",
        rt: json["rt"]??"",
        umur: json["umur"]??"",
        img: json["fotoktp"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kecamatan": kecamatan,
        "kelurahan_id": kelurahanId,
        "kelurahan": kelurahan,
        "rw": rw,
        "rt": rt,
        "umur": umur,
        "img": img,
      };
}

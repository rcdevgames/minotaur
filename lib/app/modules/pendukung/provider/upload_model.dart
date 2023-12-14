import 'dart:convert';

class UploadModel{
  final int id;
  final String relawan_id;
  final String kelurahan_id;
  final String nik;
  final String nama;
  final String hp;
  final String umur;
  final String jk;
  final String kecamatan;
  final String kelurahan;
  final String alamat;
  final String rw;
  final String rt;
  final String pilihanPartai2019;
  final String pilihanPartai;
  final String pilihan;
  final String pilihanCapres;
  final String gambar;
  final String gps;

  UploadModel({
    required this.id,
    required this.relawan_id,
    required this.kelurahan_id,
    required this.nik,
    required this.nama,
    required this.hp,
    required this.umur,
    required this.jk,
    required this.kecamatan,
    required this.kelurahan,
    required this.alamat,
    required this.rw,
    required this.rt,
    required this.pilihanPartai2019,
    required this.pilihanPartai,
    required this.pilihan,
    required this.pilihanCapres,
    required this.gambar,
    required this.gps,
  });

  factory UploadModel.fromRawJson(String str) =>
      UploadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
        id: json["id"],
        relawan_id: json["relawan_id"],
        kelurahan_id: json["kelurahan_id"],
        nik: json["nik"],
        nama: json["nama"],
        hp: json["hp"],
        umur: json["umur"],
        jk: json["jk"],
        kecamatan: json["kecamatan"],
        kelurahan: json["kelurahan"],
        alamat: json["alamat"],
        rw: json["rw"],
        rt: json["rt"],
        pilihanPartai2019: json["pilihanPartai2019"],
        pilihanPartai: json["pilihanPartai"],
        pilihan: json["pilihan"],
        pilihanCapres: json["pilihanCapres"],
        gambar: json["gambar"],
        gps: json["gps"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "relawan_id": relawan_id,
        "kelurahan_id": kelurahan_id,
        "nik": nik,
        "nama": nama,
        "hp": hp,
        "umur": umur,
        "jk": jk,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "alamat": alamat,
        "rw": rw,
        "rt": rt,
        "pilihanPartai2019": pilihanPartai2019,
        "pilihanPartai": pilihanPartai,
        "pilihan": pilihan,
        "pilihanCapres": pilihanCapres,
        "gambar": gambar,
        "gps": gps,
      };
}

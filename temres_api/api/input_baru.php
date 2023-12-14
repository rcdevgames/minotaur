<?php

// Membuat koneksi ke database
require_once('../config/connection.php');
global $link;
// Memeriksa apakah form telah terkirim
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Menangkap data yang dikirim dari form
    $user_id                     = $_POST['user_id']; //id relawan
    $tanggalgabung               = date("Y-m-d"); //generate otomatis date now()
    $ref_id                      = 1;  // isikan 1
    $dpt_id                      = $_POST['dpt_id']; // ambil dari tabel dpt
    $kelurahan_id                = $_POST['kelurahan_id'];;
    $tps                         = $_POST['tps'];      // terbuka
    $jumlahak                    = 0; // isi nol
    $nik                         = $_POST['nik'];       //terbuka
    $nama                        = $_POST['nama'];      // terbuka, default isi dari dari dpt
    $jk                          = ($_POST['jk']);       // terbuka
    $alamat                      = $_POST['alamat'];  // terbuka
    $rw                          = $_POST['rw'];     //terbuka
    $rt                          = $_POST['rt'];     //terbuka
    $hp                          = $_POST['hp'];     //terb// terbuka
    $gps                         = $_POST['gps'];     // generate otomatis
    $lewat                       = 2;    // default 2
    $dibuat                      = date("Y-m-d H:i:s");

    // Menyimpan data ke database

    $query = "INSERT INTO pendukung (user_id, tanggalgabung, ref_id, dpt_id, kelurahan_id, tps, jumlahak, nik, nama, jk, alamat, rw, rt, hp, gps, dibuat, lewat) VALUES ('$user_id', '$tanggalgabung', '$ref_id','$dpt_id', '$kelurahan_id', '$tps', '$jumlahak', '$nik', '$nama', '$jk', '$alamat', '$rw', '$rt', '$hp', '$gps', '$dibuat', '$lewat')";
    $result = mysqli_query($link, $query);

    // Memberikan pesan sukses atau error

    if ($result) {
        $query2 = "UPDATE dpt SET sudah='1' WHERE id= '$dpt_id'";
        mysqli_query($link, $query2);

        $response["kode"] = "200";
        $response["msg"] = "data berhasil dikirim!";
        echo json_encode($response);
    } else {
        $response["kode"] = "400";
        $response["msg"] = "Terjadi kesalahan. data tidak dapat dikirim.";
        echo json_encode($response);
    }
}

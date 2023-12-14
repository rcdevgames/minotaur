<?php

// Membuat koneksi ke database
require_once('../config/connection.php');
global $link;
// Memeriksa apakah form telah terkirim
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $relawanId                   = $_POST['relawan_id'];
    $gps                         = $_POST['gps'];
    // Menyimpan data ke database
    $query = "INSERT INTO posisi (relawan_id, gps) VALUES ('$relawanId', '$gps')";
    $result = mysqli_query($link, $query);
    // Memberikan pesan sukses atau error

    if ($result) {
        $response["kode"] = "200";
        $response["msg"] = "data berhasil dikirim!";
        echo json_encode($response);
    } else {
        $response["kode"] = "400";
        $response["msg"] = "Terjadi kesalahan. data tidak dapat dikirim.";
        echo json_encode($response);
    }
}

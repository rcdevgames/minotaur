<?php
require_once "../core/init.php";
//mengecek parameter post
if (isset($_POST['hp']) && isset($_POST['password'])) {

    //menampung parameter ke dalam variabel

    $hp  = $_POST['hp'];
    $pass = $_POST['password'];

    $user = cek_data_user($hp, $pass); //validasi user
    if ($user != false) {
        //jika berhasil login
        $response["userId"] = $user["userId"];
        $response["nama"] = $user["nama"];
        $response["hp"] = $user["hp"];
        $response["kelurahanId"] = $user["kelurahanId"];
        $response["kelurahan"] = $user["kelurahan"];
        echo json_encode($response);
    } else {
        // user tidak ditemukan password/email salah

        header("HTTP/1.1 401 Unauthorized");
        $response["error_msg"] = "Login gagal";
        echo json_encode($response);
    }
}

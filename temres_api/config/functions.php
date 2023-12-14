<?php
//-------------- mendaftarkan user -------------------//
function register_user($hp, $password)
{
    global $link;

    //mencegah sql injection
    $hp = escape($hp);
    $pass = escape($password);

    $hash = hashSSHA($pass); //mengencrypt password

    $salt = $hash["salt"]; //berisi kode string random yang nantinya                             digunakan saat proses decrypt pada proses validasi

    $encrypted_password = $hash["encrypted"]; //mengambil data password yang sudah di enkripsi untuk ditampung pada variabel encrypted_password


    $query = "INSERT INTO users(hp, password) VALUES('$hp', '$encrypted_password', '$salt') ON DUPLICATE KEY UPDATE unique_id = '$salt'";

    $user_new = mysqli_query($link, $query);
    if ($user_new) {
        $usr = "SELECT * FROM relawan WHERE hp = '$hp'";
        $result = mysqli_query($link, $usr);
        $user = mysqli_fetch_assoc($result);
        return $user;
    } else {
        return NULL;
    }
}
//-------------- *** end *** -------------------//

//---- mencegah sql injection -----//
function escape($data)
{
    global $link;
    return mysqli_real_escape_string($link, $data);
}
//----------- *** end *** ---------//

//--- mengecek nama apakah sudah terdaftar atau belum ---//
function cek_nama($name)
{
    global $link;
    $query = "SELECT * FROM users WHERE user_username = '$name'";
    if ($result = mysqli_query($link, $query)) return mysqli_num_rows($result);
}
//---------------- *** end ***-------------------------//

//------------ mengenkripsi password ----------------//
function hashSSHA($password)
{
    $salt = sha1(rand());
    $salt = substr($salt, 0, 10);
    $encrypted = base64_encode(sha1($password . $salt, true) . $salt);
    $hash = array("salt" => $salt, "encrypted" => $encrypted);
    return $hash;
}
//------------ *** end *** -------------------------//

// -------- mengenkripsi password yang dimasukkan user saat login -->
function checkhashSSHA($salt, $password)
{
    $hash = base64_encode(sha1($password . $salt, true) . $salt);
    return $hash;
}
//------------ *** end *** -------------------------//
//----------------- cek data user dan validasi------------------//
function cek_data_user($hp, $pass)
{
    global $link;
    //mencegah sql injection
    $hp = escape($hp);
    $password = escape($pass);

    $query  = "SELECT relawan.id as userId, relawan.nama, relawan.hp, relawan.password, kelurahan.id as kelurahanId, kelurahan.kelurahan FROM relawan INNER JOIN kelurahan ON relawan.tabel_id=kelurahan.id WHERE relawan.hp = '$hp'";
    $result = mysqli_query($link, $query);
    $data = mysqli_fetch_assoc($result);

    // return $data;

    // $unique_id = $data['id'];
    $encrypted_password = @$data['password'];
    // mengencrypt password
    // $hash = checkhashSSHA($unique_id, $password);
    // validasi password
    if ($encrypted_password == $password) {
        return $data;
    } else {
        return false;
    }
}
//---------------------- *** end *** -------------------------//
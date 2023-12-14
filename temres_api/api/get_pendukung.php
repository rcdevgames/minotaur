<?php
require_once('../config/connection.php');
global $link;
if (isset($_GET['relawan_id'])) {

    $relawan_id  = $_GET['relawan_id'];
    $data = array();
    if ($result = mysqli_query($link, "SELECT pendukung.id, pendukung.nama,umur,  kecamatan.kecamatan, pendukung.kelurahan_id, kelurahan.kelurahan,pendukung.rw, pendukung.rt, pendukung.tps FROM pendukung  INNER JOIN kelurahan ON pendukung.kelurahan_id=kelurahan.id INNER JOIN kecamatan ON kelurahan.kecamatan_id=kecamatan.id  where pendukung.ref_id='$relawan_id' ORDER BY pendukung.id DESC limit 100  ")) {
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $data[] = $row;
        }
        mysqli_close($link);
        echo json_encode($data);
    }
}

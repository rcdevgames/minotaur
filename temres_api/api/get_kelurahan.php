<?php
require_once('../config/connection.php');
global $link;

//cek if kab exist
$kecamatan=$_GET['kecamatan'];
$cq=mysqli_query($link,"select id from kecamatan where kecamatan ='$kecamatan'");
$cek=$cq->fetch_row();
if(!is_array($cek)){
exit;
}
$kecamatanId = $cek[0];
    $data = array();
    if ($result = mysqli_query($link, "SELECT id, kelurahan as nama FROM kelurahan where kecamatan_id='$kecamatanId '")) {
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $data[] = $row;
        }
        mysqli_close($link);
        echo json_encode($data);
    }

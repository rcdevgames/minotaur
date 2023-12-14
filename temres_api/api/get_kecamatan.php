<?php
require_once('../config/connection.php');
global $link;

//cek if kab exist
$kabkota=$_GET['kabkota'];
$cq=mysqli_query($link,"select id from kabkota where kabkota ='$kabkota'");
$cek=$cq->fetch_row();
if(!is_array($cek)){
exit;
}
$kabkotaId = $cek[0];
    $data = array();
    if ($result = mysqli_query($link, "SELECT id, kecamatan as nama FROM kecamatan where kabkota_id='$kabkotaId '")) {
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $data[] = $row;
        }
        mysqli_close($link);
        echo json_encode($data);
    }

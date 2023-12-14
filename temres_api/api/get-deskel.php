<?php
require_once('../config/connection.php');
global $link;
if (isset($_GET['relawan_id'])) {

    $relawanId  = $_GET['relawan_id'];
    $data = array();
    if ($result = mysqli_query($link, "SELECT kelurahan.id, kelurahan.kelurahan FROM kelurahan INNER JOIN relawan on kelurahan.id=relawan.tabel_id where relawan.id=' $relawanId'")) {
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $data[] = $row;
        }
        mysqli_close($link);
        echo json_encode($data);
    }
}

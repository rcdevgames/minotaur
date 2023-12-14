<?php
require_once('../config/connection.php');
global $link;
if (isset($_GET['relawan_id'])) {

    $relawan_id  = $_GET['relawan_id'];
    $data = array();
    if ($result = mysqli_query($link, "SELECT COUNT(*) as jumlah FROM pendukung where ref_id='$relawan_id'  ")) {
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $data  = $row;
        }
        mysqli_close($link);
        echo json_encode($data);
    }
}

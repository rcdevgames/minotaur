<?php
require_once('../config/connection.php');
global $link;

$data = array();
if ($result = mysqli_query($link, "SELECT id, kabkota as nama FROM kabkota ")) {
    while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
        $data[] = $row;
    }
    mysqli_close($link);
    echo json_encode($data);
}

<?php
require_once('../config/connection.php');
global $link;
if (isset($_GET['nama']) && isset($_GET['kelurahan_id'])) {
  $nama  = $_GET['nama'];
  $kelurahanId  = $_GET['kelurahan_id'];
  $rt = $_GET['rt'];
  $rw = $_GET['rw'];
  $ejaan = $_GET['ejaan'];
  $data = array();
  $query = "SELECT dpt.id, dpt.nama,  kecamatan.kecamatan, dpt.kelurahan_id, kelurahan.kelurahan,dpt.rw, dpt.rt, dpt.tps
    FROM dpt INNER JOIN kelurahan ON dpt.kelurahan_id=kelurahan.id INNER JOIN kecamatan ON kelurahan.kecamatan_id=kecamatan.id WHERE ";

  if ($ejaan) {
    $query .= " dpt.nama='$nama' ";
  } else {
    $query .= " dpt.nama like '%$nama%' ";
  }

  if ($rt) {
    $query .= " and dpt.rt='$rt' ";
  }

  if ($rt) {
    $query .= " and dpt.rw='$rw' ";
  }

  $query .= " and dpt.kelurahan_id='$kelurahanId' ";
  $query .= " and dpt.sudah='0'";

  // if ($result = mysqli_query($link, "SELECT dpt.id, dpt.nama,  kecamatan.kecamatan, dpt.kelurahan_id, kelurahan.kelurahan,dpt.rw, dpt.rt, dpt.tps
  // FROM dpt INNER JOIN kelurahan ON dpt.kelurahan_id=kelurahan.id INNER JOIN kecamatan ON kelurahan.kecamatan_id=kecamatan.id WHERE dpt.nama='$nama' and dpt.kelurahan_id='$kelurahanId' and dpt.sudah='0'")) {
  if ($result = mysqli_query($link, $query)) {
    while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
      $data[] = $row;
    }
    mysqli_close($link);
    echo json_encode($data);
  }
}


<?php

require_once('../config/connection.php');
global $link;
if (@$_GET['key'] == 'zz2x') {
    $qFindKeluarga = "SELECT id,nama,kk_nik  FROM pendukung WHERE kk_nik is not null";
    echo "<pre>";
    $data=[];

    $qFindKeluarga = mysqli_query($link, $qFindKeluarga);
    while($pend=mysqli_fetch_array($qFindKeluarga)){
      print_r($pend);
      $data[$pend['kk_nik']][]=$pend['nama'];
    }
    print_r($data);
    foreach($data as $kd => $d){
      print_r($d);
      echo $query="UPDATE pendukung SET anggota='".json_encode($d)."' WHERE nik='$kd'";
      mysqli_query($link, $query);
    }
}

echo $query="delete from pendukung where kk_nik is not null";
      mysqli_query($link, $query);

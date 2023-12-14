<?php

require_once('../config/connection.php');
global $link;
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  $sesudah   = json_encode(filter_input_array(INPUT_POST));
  $sebelum = "";
  $tabel = "pendukung";
  $jenis = "c";
  $tabel_id = "0";

  $user_id                     = 1; //id relawan
  $tanggalgabung               = date("Y-m-d"); //generate otomatis date now()
  $ref_id                      = $_POST['relawan_id'];  // isikan 1
  $dpt_id                      = 0; // ambil dari tabel dpt
  $kelurahan_id                = $_POST['kelurahan_id'];;
  $tps                         = 0;      // terbuka
  $jumlahak                    = 0; // isi nol
  $nik                         = $_POST['nik'];       //terbuka
  @$nkk                         = @$_POST['nkk'];       //terbuka
  $nama                        = $_POST['nama'];      // terbuka, default isi dari dari dpt
  $jk                          = ($_POST['jk']);       // terbuka
  $umur                       = $_POST['umur'];       // terbuka
  $pilihanPartai2019                       = $_POST['pilihanPartai2019'];       // terbuka
   $pilihanPartai                       = $_POST['pilihanPartai'];       // terbuka
  $pilihan                       = $_POST['pilihan'];       // terbuka
  $pilihanCapres                       = $_POST['pilihanCapres'];       // terbuka
  $alamat                      = $_POST['alamat'];  // terbuka
  $rw                          = $_POST['rw'];     //terbuka
  $rt                          = $_POST['rt'];     //terbuka
  $hp                          = $_POST['hp'];
  $gps                         = $_POST['gps'];     // generate otomatis
  $lewat                       = 2;    // default 2
  $dibuat                      = date("Y-m-d H:i:s");


  $listPartai2019=['','PKB','GERINDRA','PDIP','GOLKAR','NASDEM','GARUDA','BERKARYA','PKS','PERINDO','PPP','PSI','PAN','HANURA','DEMOKRAT','PBB','PKPI'];
  $listPartai=['','PKB','GERINDRA','PDIP','GOLKAR','NASDEM','BURUH','GELORA','PKS','PKN','HANURA','GARUDA','PAN','PBB','DEMOKRAT','PSI','PERINDO','PPP','UMMAT'];
  $field1= array_search($pilihanPartai2019,$listPartai2019);
   $field2=array_search($pilihanPartai,$listPartai);
  $field3=$pilihan;
  $field4=$pilihanCapres;



$kelurahan=$_POST['kelurahan'];
$cq=mysqli_query($link,"select id from kelurahan where kelurahan ='$kelurahan'");
$cek=$cq->fetch_row();
if(!is_array($cek)){
exit;
}
$kelurahan_id = $cek[0];




  $sqlinsertlog1 = "INSERT into log1 ( `user_id`,`tabel`,`tabel_id`,`jenis`,`sebelum`,`sesudah`,`dibuat`) 
		values( '$user_id','$tabel','$tabel_id','$jenis','$sebelum','$sesudah','$dibuat')";
  $rlog1 = mysqli_query($link, $sqlinsertlog1);


  @$namafile = $_FILES['image']['name'];
  @$ukuran  = $_FILES['image']['size'];
  @$file_tmp = $_FILES['image']['tmp_name'];

  @$fotowajah = $_FILES['fotowajah']['name'];
  @$fotowajahukuran  = $_FILES['fotowajah']['size'];
  @$fotowajahfile_tmp = $_FILES['fotowajah']['tmp_name'];

  $findNik = "SELECT count(*) as r FROM pendukung WHERE nik='$nik'";
  $resultNik = mysqli_query($link, $findNik);
  $data = mysqli_fetch_assoc($resultNik);
  if ($data['r'] > 0) {
    $response["kode"] = "422";
    $response["msg"] = "data nik sudah ada.";
    echo json_encode($response);
  } else {
    move_uploaded_file($fotowajahfile_tmp, '../fotowajah/' . $fotowajah);
    if ($namafile) {
      move_uploaded_file($file_tmp, '../image/' . $namafile);
    }

      $query = "INSERT INTO pendukung (is_kk,user_id, tanggalgabung, ref_id, dpt_id, kelurahan_id, tps, jumlahak, nik,nkk, nama, jk, alamat, rw, rt, 
          hp, gps, dibuat, lewat, fotoktp, fotowajah,field1,field2,field3,field4,umur) VALUES 
('1','$user_id', '$tanggalgabung', '$ref_id','$dpt_id', '$kelurahan_id', '$tps', '$jumlahak', '$nik','$nkk', '$nama', '$jk', '$alamat', '$rw', '$rt', '$hp',
   '$gps', '$dibuat', '$lewat', '$namafile', '$fotowajah','$field1','$field2','$field3','$field4','$umur')";


    $result = mysqli_query($link, $query);

    $kk_id = mysqli_insert_id($link);
    if ($result) {
      $query2 = "UPDATE dpt SET sudah='1' WHERE id= '$dpt_id'";
      mysqli_query($link, $query2);
      $response["kode"] = "200";
      $response["msg"] = "data berhasil dikirim!";
      echo json_encode($response);
    } else {
      $response["kode"] = "400";
      $response["msg"] = "Terjadi kesalahan. data tidak dapat dikirim.";
      echo json_encode($response);
    }
  }
}

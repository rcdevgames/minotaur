<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send push notif</title>
</head>

<body>
    <form action="" method="get">
        <input type="text" name="judul" id="judul" placeholder="judul">
        <input type="text" name="pesan" id="pesan" placeholder="pesan">
        <input type="submit" value="kirim" name="kirim">
    </form>

</body>

</html>

<?php
if (@$_GET['judul']) {

    $appid = "da4cee24-eeda-4fc8-80b3-c099c6f85f35";
    $apikey = "NDhiNGE1MmItMDUxMC00Y2JlLWIyZjEtZDE1ZTEwYzg3YzYw";
    $pesan = @$_GET['pesan'];
    $judul = @$_GET['judul'];
    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://onesignal.com/api/v1/notifications',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => '{
          "app_id": "' . $appid . '",
          "data": {"foo": "bar"},
          "included_segments": ["All"],
          "contents": {"en": "' . $pesan . '"},
          "headings":{"en":"' . $judul . '"}
        }',

        CURLOPT_HTTPHEADER => array(
            'Authorization: Basic ' . $apikey,
            'Content-Type: application/json'
        ),
    ));

    $response = curl_exec($curl);
    print_r($response);
}
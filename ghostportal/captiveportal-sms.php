<?php
header("Content-type: text/html; charset=utf-8");
include ("captiveportal-config.php");


// ---------------------------------------- //

$sorgu    =  mysqli_fetch_array(mysqli_query($baglan,"select * from ghost_settings"));
$expday   =  $sorgu['passwordexptime'];
$ApiUrl   =  $sorgu['apiurl'];
$SmsNo    =  $sorgu['smsno'];
$SmsUser  =  $sorgu['smsuser'];
$SmsPass  =  $sorgu['smspass'];
$SmsText  =  $sorgu['mesaj'];

// ---------------------------------------- //

$Isim  	  =  $_POST["ad"];
$Soyisim  =  $_POST["soyad"];
$Telefon  =  $_POST["telefon"];

//GSM Dogrulamasi bu kisimda (GSM Alan kodlarini kontrol eder.)
$gsmKarakter=strlen($Telefon);
$dogrulanacakTel=$Telefon;
settype($dogrulanacakTel,"integer");
$pattern = '/5[0-6][0-9]\d\d\d\d\d\d\d$/';
$eslesmeKontrol=preg_match($pattern, $dogrulanacakTel);

if ($eslesmeKontrol==0 OR $gsmKarakter!=10) {
	echo "3";
}
else {



// ---------------------------------------- //

date_default_timezone_set('Europe/Istanbul');
$Today 	  = date('j M Y');
$ExpDate  = date('j M Y', strtotime('+'.$expday.' days'));

// --------------- User - Pass - Fonksiyonu --------------->

function randomthing($size)
{
$characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
$str = "";
while(strlen($str) < $size)
{
$str .= substr($characters, (rand() % strlen($characters)), 1);
}
return($str);
}

$RandUser = randomthing(5);
$RandPass = randomthing(5);

//  <--------------------------------------------------------



			mysqli_query($baglan,"INSERT INTO radcheck(username,attribute,op,value,tip,telefon,tcno,adsoyad,tarih,sifre) values('$RandUser','Cleartext-Password', ':=', '$RandPass', '3', '$Telefon', '', '$Isim $Soyisim' , '$Today', '$RandPass')");
			mysqli_query($baglan,"INSERT INTO radcheck(username,attribute,op,value) values('$RandUser', 'Expiration', '=', '$ExpDate')");
			// eger islem basariliysa -->

// --------------- SMS Gönderme --------------->

function sendRequest($site_name,$send_xml,$header_type) {
            //die('SITENAME:'.$site_name.'SEND XML:'.$send_xml.'HEADER TYPE '.var_export($header_type,true));
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL,$site_name);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS,$send_xml);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,0);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
            curl_setopt($ch, CURLOPT_HTTPHEADER,$header_type);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
            curl_setopt($ch, CURLOPT_TIMEOUT, 120);
            $result = curl_exec($ch);
            return $result;
}

$xml = <<<EOS
                    <request>
                            <authentication>
                                    <username>{$SmsUser}</username>
                                    <password>{$SmsPass}</password>
                            </authentication>
                            <order>
                                <sender>{$SmsNo}</sender>
                                <message>
                                    <text>Sayın {$Isim} {$Soyisim} ,
Giriş için gerekli olan bilgiler şöyledir;
Kullanıcı Adınız : {$RandUser}
Şifreniz : {$RandPass}
</text>
                                    <receipents>
                                        <number>{$Telefon}</number>
                                    </receipents>
                                </message>
                            </order>
                    </request>
EOS;
$result = sendRequest($ApiUrl,$xml,array('Content-Type: text/xml'));

$sonuc = '<pre>'.var_export($result,1).'</pre>';

//  <--------------------------------------------------------


preg_match('@<pre>(.*?)</pre>@si',$sonuc,$baslik);

preg_match('#<code>(.*?)</code>#',$baslik[0],$hata);

$hata = $hata[1];

if( ($hata == 111) or ($hata == 200) )
{
mysqli_query($baglan,"INSERT INTO log(ad,soyad,telefon,hata,hatakodu,username,password) values('$Isim', '$Soyisim', '$Telefon', '0', '$hata', '$RandUser', '$RandPass')");

echo "1";

}else{

mysqli_query($baglan,"INSERT INTO log(ad,soyad,telefon,hata,hatakodu,username,password) values('$Isim', '$Soyisim', '$Telefon', '1', '$hata', '$RandUser', '$RandPass')");

echo "0";

}
}
?>

<?php
$conn = ftp_connect("www.compandsave.com");  

ftp_login($conn, "yiyanG1234", "Yiyang!1357"); 

ftp_pasv($conn, true);

ftp_chdir( $conn, "affiliate_datafeed/CJ/");
$pwd= ftp_pwd($conn); 
if(ftp_get($conn, "/home/testing/jing/CJ.csv", "CJ_datafeed.csv", FTP_BINARY)){
	echo "copy CAS file!<br>";}
else {
	echo "no CAS copy!<br>";
}
ftp_close($conn);

// connect  datafeeds.shareasale.com
$conn2 = ftp_connect("datatransfer.cj.com");  
  
// 使用username和password登录  
ftp_login($conn2, "3049559", "6nXCjFxF");  


 
ftp_pasv($conn2, true);
$pwd= ftp_pwd($conn2); 
if (ftp_put($conn2, "CJ_datafeed.csv", "CJ.csv", FTP_BINARY)) {
   echo "successfully uploaded CAS file<br>";
} else {
   echo "There was a problem while uploading CAS file<br>";
}
ftp_close($conn2);


$connCI = ftp_connect("www.comboink.com");  

ftp_login($connCI, "yiyanG1234", "Yiyang!1357"); 

ftp_pasv($connCI, true);

ftp_chdir( $connCI, "affiliate_datafeed/CJ/");
$pwd= ftp_pwd($connCI); 
if(ftp_get($connCI, "/home/testing/jing/CJ_CI.csv", "CJ_datafeed.csv", FTP_BINARY)){
	echo "copy CI file!<br>";}
else {
	echo "no CI copy!<br>";
}
ftp_close($connCI);

// connect  datafeeds.shareasale.com
$connCI2 = ftp_connect("datatransfer.cj.com");  
  
// 使用username和password登录  
ftp_login($connCI2, "3776933", "X46tfg_e");  


 
ftp_pasv($connCI2, true);
$pwd= ftp_pwd($connCI2); 
if (ftp_put($connCI2, "CJ_datafeed.csv", "CJ_CI.csv", FTP_BINARY)) {
   echo "successfully uploaded CI file<br>";
} else {
   echo "There was a problem while uploading CI file<br>";
}
ftp_close($connCI2);
?>
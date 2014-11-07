
 <?php
$conn = ftp_connect("www.compandsave.com");  
ftp_login($conn, "yiyanG1234", "Yiyang!1357"); 
ftp_pasv($conn, true);
ftp_chdir( $conn, "affiliate_datafeed/SAS/");
$pwd= ftp_pwd($conn); 
if(ftp_get($conn, "/home/testing/jing/SAS.csv", "SAS_datafeed.csv", FTP_BINARY)){
	echo "copy CAS file!<br>";}
else {
	echo "no CAS copy!<br>";
}
ftp_close($conn);


// connect  datafeeds.shareasale.com
$conn2 = ftp_connect("datafeeds.shareasale.com");  
ftp_login($conn2, "lubu12", "HLk1vr3c");  
ftp_pasv($conn2, true);
//change chdir  go to /home/youracc/path/to/"/merchantuploads/11293/"
ftp_chdir($conn2, "/merchantuploads/11293/" );
$pwd= ftp_pwd($conn2); 
if (ftp_put($conn2, "SAS_datafeed.csv", "SAS.csv", FTP_BINARY)) {
   echo "successfully uploaded CAS file<br>";
} else {
   echo "There was a problem while uploading CAS file<br>";
}
ftp_close($conn2);




$connCI = ftp_connect("www.comboink.com");  
ftp_login($connCI, "yiyanG1234", "Yiyang!1357"); 
ftp_pasv($connCI, true);
ftp_chdir( $connCI, "affiliate_datafeed/SAS/");
$pwd= ftp_pwd($connCI); 
if(ftp_get($connCI, "/home/testing/jing/SAS_CI.csv", "SAS_datafeed.csv", FTP_BINARY)){
	echo "copy CI file!<br>";}
else {
	echo "no CI copy!<br>";
}
ftp_close($connCI);


// connect  datafeeds.shareasale.com
$connCI2 = ftp_connect("datafeeds.shareasale.com");  
ftp_login($connCI2, "comboink", "BGo8gk8r");  
ftp_pasv($connCI2, true);
//change chdir  go to /home/youracc/path/to/"/merchantuploads/28570/"
ftp_chdir($connCI2, "/merchantuploads/28570/" );
$pwd= ftp_pwd($connCI2); 
if (ftp_put($connCI2, "SAS_datafeed.csv", "SAS_CI.csv", FTP_BINARY)) {
   echo "successfully uploaded CI file<br>";
} else {
   echo "There was a problem while uploading CI file<br>";
}
ftp_close($connCI2);



$connTI = ftp_connect("www.tomatoink.com");  
ftp_login($connTI, "yiyanG1234", "Yiyang!1357"); 
ftp_pasv($connTI, true);
ftp_chdir( $connTI, "affiliate_datafeed/SAS/");
$pwd= ftp_pwd($connTI); 
if(ftp_get($connTI, "/home/testing/jing/SAS_TI.csv", "SAS_datafeed.csv", FTP_BINARY)){
	echo "copy TI file!<br>";}
else {
	echo "no TI copy!<br>";
}
ftp_close($connTI);



// connect  datafeeds.shareasale.com
$connTI2 = ftp_connect("datafeeds.shareasale.com");  
ftp_login($connTI2, "tomatoink", "WHn9ty5c");  
ftp_pasv($connTI2, true);
//change chdir  go to /home/youracc/path/to/"/merchantuploads/40756/"
ftp_chdir($connTI2, "/merchantuploads/40756/" );
$pwd= ftp_pwd($connTI2); 
if (ftp_put($connTI2, "SAS_datafeed.csv", "SAS_TI.csv", FTP_BINARY)) {
   echo "successfully uploaded TI file<br>";
} else {
   echo "There was a problem while uploading TI file<br>";
}
ftp_close($connTI2);



?>
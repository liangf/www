
 <?php
// download server file
// connect and login to FTP server
$ftp_get_server = "www.compandsave.com";
$ftp_get_username = "yiyanG1234";
$ftp_get_userpass = "Yiyang!1357";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./liangf/shopzilla/CompandSave_Feed_Shopzilla.txt";
$local_file = "./CompandSave_Feed_Shopzilla.txt";

$ftp_conn = ftp_connect($ftp_get_server) or die("Could not connect to $ftp_server");
$login = ftp_login($ftp_conn, $ftp_get_username, $ftp_get_userpass);

// download server file
if (ftp_get($ftp_conn, $local_file, $server_file, FTP_ASCII)) {
	echo "Successfully get $local_file from $ftp_get_server.";
}
else {
	echo "Error downloading $server_file.";
}



// upload file to server
// connect and login to FTP server
$ftp_put_server = "ftp.shopzilla.com";
$ftp_put_username = "233322_E0puJJ";
$ftp_put_userpass = "3MmrNp";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./CompandSave_Feed_Shopzilla.txt";
$local_file = "./CompandSave_Feed_Shopzilla.txt";

$ftp_conn = ftp_connect($ftp_put_server) or die("Could not connect to $ftp_server");
$login = ftp_login($ftp_conn, $ftp_put_username, $ftp_put_userpass);

// upload file
if (ftp_put($ftp_conn, $server_file, $local_file, FTP_ASCII)) {
	echo "<br>";
	echo "Successfully uploaded $local_file to $ftp_put_server.";
}
else {
	echo "Error uploading $file.";
}

 
// close connection
ftp_close($ftp_conn);



?>

 <?php
// download server file
// connect and login to FTP server
$ftp_get_server = "www.compandsave.com";
$ftp_get_username = "yiyanG1236";
$ftp_get_userpass = "YiYang!1247";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./liangf/feeds/shopping/CompandSave_Feed_Shopping.txt";
$local_file = "./feeds/CompandSave_Feed_Shopping.txt";

$ftp_conn = ftp_connect($ftp_get_server) or die("Could not connect to $ftp_server");
$login = ftp_login($ftp_conn, $ftp_get_username, $ftp_get_userpass);

// download server file
if (ftp_get($ftp_conn, $local_file, $server_file, FTP_ASCII)) {
	echo "Successfully get $ftp_get_server --> $local_file ";
}
else {
	echo "Error downloading $server_file.";
}



// upload file to server
// connect and login to FTP server
$ftp_put_server = "ftp.ebaycommercenetwork.com";
$ftp_put_username = "m409968";
$ftp_put_userpass = "1fT1OW5n";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./CompandSave_Feed_Shopping.txt";
$local_file = "./feeds/CompandSave_Feed_Shopping.txt";

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
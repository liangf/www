 <?php
set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');
include('Net/SFTP.php'); 
define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);
 
// download server file  -- FTP
// connect and login to FTP server
$ftp_get_server = "www.comboink.com";
$ftp_get_username = "yiyanG1234";
$ftp_get_userpass = "Yiyang!1357";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
//$server_file = "./liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./liangf/feeds/amazon/Comboink_Feed_Amazon.txt";
$local_file = "./feeds/Comboink_Feed_Amazon.txt";

$ftp_conn = ftp_connect($ftp_get_server) or die("Could not connect to $ftp_server");
$login = ftp_login($ftp_conn, $ftp_get_username, $ftp_get_userpass);

// download server file
if (ftp_get($ftp_conn, $local_file, $server_file, FTP_ASCII)) {
	echo "Successfully  $local_file --> $local_file." . "<br>";
}
else {
	echo "Error downloading $server_file.";
}



$sftp_put_server = "productads.amazon-digital-ftp.com";
$sftp_put_username = "M_COMBOINK_157763153";
$sftp_put_userpass = "2AOvz9iUZr";
//$server_file = "./www/ftp/Amazon_datafeed.txt";
$server_file = "./Comboink_Feed_Amazon.txt";
$local_file = "./feeds/Comboink_Feed_Amazon.txt";

$sftp = new Net_SFTP($sftp_put_server);
if (!$sftp->login($sftp_put_username, $sftp_put_userpass)) {
   exit('Login Failed');
}
else echo "SFTP Success login!!!"."<br>";

print_r( $sftp->getSFTPErrors() );
print_r( $sftp->getLog() ); 

if ( $sftp->put($server_file, $local_file, NET_SFTP_LOCAL_FILE) )
	echo "Success upload file." . "<br>";
else echo "Error." . "<br>";

 
// close connection
ftp_close($ftp_conn);



?>
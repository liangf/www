 <?php
// http://phpseclib.sourceforge.net

set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');
include('Net/SFTP.php');
//include('Net/SSH2.php');
define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);

/*
// download server file
// connect and login to FTP server

$ftp_get_server = "www.compandsave.com";
$ftp_get_username = "yiyanG1234";
$ftp_get_userpass = "Yiyang!1357";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./liangf/amazonfeed/noimage.txt";
$local_file = "./noimage.txt";

$ftp_get_server = "www.liangfang.us";
$ftp_get_username = "liangfan";
$ftp_get_userpass = "";
//$server_file = "/v/dc/yy/liangf/amazonfeed/Amazon_datafeed.txt";
$server_file = "./www/ftp/filename.remote";
$local_file = "./filename.remote";

$ftp_conn = ftp_connect($ftp_get_server) or die("Could not connect to $ftp_server");
$login = ftp_login($ftp_conn, $ftp_get_username, $ftp_get_userpass);

// download server file
if (ftp_get($ftp_conn, $local_file, $server_file, FTP_ASCII)) {
	echo "Successfully get $local_file from $ftp_get_server." . "<br>";
}
else {
	echo "Error downloading $server_file." . "<br>";
}
*/



$sftp_put_server = "www.liangfang.us";
$sftp_put_username = "liangfan";
$sftp_put_userpass = "";
$server_file = "./orders.txt";
$local_file = "./orders.txt";

/*
$sftp_put_server = "productads.amazon-digital-ftp.com";
$sftp_put_username = "M_COMPANDSAV_1193533";
$sftp_put_userpass = "uYKr27HovE";
$server_file = "./Amazon_datafeed.txt";
$local_file = "./Amazon_datafeed.txt";

*/
$sftp = new Net_SFTP($sftp_put_server);
if (!$sftp->login($sftp_put_username, $sftp_put_userpass)) {
   exit('Login Failed');
}
else echo "Success login!!!" . "<br>";

print_r( $sftp->getSFTPErrors() );
print_r( $sftp->getLog() ); 
//$sftp->get('./www/ftp/filename.remote', './filename.remote');
if ( $sftp->put($server_file, $local_file, NET_SFTP_LOCAL_FILE) )
	echo "Success upload." . "<br>";
else echo "Error." . "<br>";
?>
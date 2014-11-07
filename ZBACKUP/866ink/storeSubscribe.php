<?php
header('Access-Control-Allow-Origin: http://www.compandsavetest.com');
//header('Access-Control-Allow-Origin: http://casinkadmin.com/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

//require_once 'database.php';

$username = "DBA_dbcomp";
$password = "123456";
$hostname = "866ink.com"; 
$databasename = "dbcompandsave";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
	
	
if( $_POST["emailaddress"] ) {
	$user_email = $_POST["emailaddress"];
	$sql = "INSERT INTO `easter_subscribe` (id, email, time) VALUES(0, '$user_email', now())";
	mysql_query($sql);		
	header('Location: http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-1-thanks.html');
}


//header('Location: http://casinkadmin.com/yy/liangf/compandsave/egg-1-thanks.html');

mysql_close($conn);



?>
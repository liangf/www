<?php
header('Access-Control-Allow-Origin: http://www.liangfang.us/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');


//require_once 'database.php';

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

//$user_name = "liangf";
//$user_email = "mailfangliang@gmail.com";
//$sql = "INSERT INTO easter_fb (id, name, email, time) VALUES(0, '$user_name', '$user_email', now())";
//mysql_query($sql);
 
if( $_POST["uname"] || $_POST["uemail"] || $_POST["uID"]) {
	echo $_POST["uID"];
	//echo "you shared.";
	$user_name = $_POST["uname"];
	$user_email = $_POST["uemail"];
	$user_fbid = $_POST["uID"];
	$sql = "INSERT INTO easter_fb (id, name, email, time, fbID) VALUES(0, '$user_name', '$user_email', now(), '$user_fbid')";
	mysql_query($sql);
	//header('Location: http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-1-thanks.html');
}


mysql_close($conn);
?>
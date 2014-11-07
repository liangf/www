<?php
header('Access-Control-Allow-Origin: http://www.compandsavetest.com');
//header('Access-Control-Allow-Origin: http://casinkadmin.com/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

//require_once 'database.php';

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


if( $_POST["emailaddress"] ) {
	$user_email = $_POST["emailaddress"];
	$user_eggID = $_GET["eggID"];
	//echo $user_eggID;
	$sql = "INSERT INTO `easter_subscribe` (id, email, time, eggID) VALUES(0, '$user_email', now(), '$user_eggID')";
	mysql_query($sql);		
	//header('Location: http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-1-thanks.html');
	//header('Location: http://www.compandsavetest.com/v/dc/J/egg-1-thanks.html');
	//header('Location: http://www.compandsavetest.com/v/dc/J/promotion-april-2014/egg-thanks.html');
	
	//$url = "Location: http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-";
	$url = "Location: http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/egg-";
	$url .= $user_eggID;
	$url .= "-thanks.html";
	header($url);
}


mysql_close($conn);



?>
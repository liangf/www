<?php
header('Access-Control-Allow-Origin: http://www.compandsave.com');
//header('Access-Control-Allow-Origin: https://www.compandsave.com');
//header('Access-Control-Allow-Origin: http://casinkadmin.com/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

//require_once 'database.php';

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

//echo "this is storeForm.";
//echo $_GET["ufirstname"];

if( $_GET["uemail"] ) {
	echo $_GET["uemail"];
	$firstname = $_GET["ufirstname"];
	$lastname = $_GET["ulastname"];
	$address = $_GET["uaddress"];
	$city = $_GET["ucity"];
	$zip = $_GET["uzip"];
	$state = $_GET["ustate"];
	$email = $_GET["uemail"];
	$formID = $_GET["fid"];
	
	
	//echo $user_eggID;
	$sql = "INSERT INTO fatherday_form (id, firstname, lastname, address, city, zip, state, email, time, formID) 
			VALUES(0, '$firstname', '$lastname', '$address', '$city', '$zip', '$state', '$email', now(), '$formID')";
	mysql_query($sql);		

	
}


mysql_close($conn);



?>
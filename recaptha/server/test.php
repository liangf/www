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

echo "this is storeForm.";


if( $_POST["uemail"] ) {
	echo $_POST["uemail"];
	$firstname = $_POST["ufirstname"];
	$lastname = $_POST["ulastname"];
	$address = $_POST["uaddress"];
	$city = $_POST["ucity"];
	$zip = $_POST["uzip"];
	$state = $_POST["ustate"];
	$email = $_POST["uemail"];
	$formID = $_POST["fid"];
	
	
	//echo $user_eggID;
	$sql = "INSERT INTO independence_form (id, firstname, lastname, address, city, zip, state, email, time, formID) 
			VALUES(0, '$firstname', '$lastname', '$address', '$city', '$zip', '$state', '$email', now(), '$formID')";
	mysql_query($sql);		

	
}


mysql_close($conn);



?>
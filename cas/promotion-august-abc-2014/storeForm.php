<?php
header('Access-Control-Allow-Origin: http://www.compandsave.com');
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
	$firstname = $_GET["ufirstname"];
	$lastname = $_GET["ulastname"];
	$address = $_GET["uaddress"];
	$city = $_GET["ucity"];
	$zip = $_GET["uzip"];
	$state = $_GET["ustate"];
	$email = $_GET["uemail"];
	$formID = $_GET["fid"];
	
	
	//echo $user_eggID;
	$sql = "INSERT INTO form_abc(ID, FirstName, LastName, Email, Street, City, State, Zipcode, Time, FormID) 
			VALUES(0, '$firstname', '$lastname', '$email', '$address', '$city', '$state', '$zip', now(), $formID)";
	mysql_query($sql);		

	
}


mysql_close($conn);



?>
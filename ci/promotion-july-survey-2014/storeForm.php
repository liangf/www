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
	$q1 = $_GET["uq1"];
	$product = $_GET["uproduct"];
	$q2 = $_GET["uq2"];
	$q3 = $_GET["uq3"];
	$q4 = $_GET["uq4"];
	$q5 = $_GET["uq5"];
	$firstname = $_GET["ufirstname"];
	$lastname = $_GET["ulastname"];
	$address = $_GET["uaddress"];
	$city = $_GET["ucity"];
	$zip = $_GET["uzip"];
	$state = $_GET["ustate"];
	$state = $_GET["ustate"];
	$country = $_GET["ucountry"];
	$email = $_GET["uemail"];
	$formID = $_GET["fid"];
	
	
	//echo $user_eggID;
	$sql = "INSERT INTO july_survey (ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID) 
			VALUES(0, '$q1', '$product', '$q2', '$q3', '$q4', '$q5', '$firstname', '$lastname', '$email', '$address', '$city', '$state', '$zip', '$country', $formID)";
	mysql_query($sql);		

	
}


mysql_close($conn);



?>
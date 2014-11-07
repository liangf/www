<?php
//header('Access-Control-Allow-Origin: http://www.compandsave.com');
header('Access-Control-Allow-Origin: http://www.casinkadmin.com/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

//require_once 'database.php';

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



if( $_POST["customlab"] ) {
	echo $_POST["customlab"];
	$customlab = $_POST["customlab"];
	$costprice = $_POST["costprice"];
	$shipprice = $_POST["shipprice"];
	//echo $user_eggID;
	$sql = "insert into ebay_activelist (id, customlabel, costprice, shippingcost, time) values(0, '$customlab', '$costprice', '$shipprice', now())";
	mysql_query($sql);		
	
}


mysql_close($conn);



?>
<?php

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


$file = fopen("./clean-upc.csv","w");

$sql = "SELECT upc FROM pricegrabber order by upc";
$result = mysql_query($sql);
$data = array("0");
$oldupc = "";
$newupc = "";
while ($array = mysql_fetch_array($result)) {
	$oldupc = $newupc;
	$newupc = trim($array["upc"], ' ');
	if ($oldupc!=$newupc) {
		$data[0] = $array["upc"];
		fputcsv($file, $data);
	}
}



mysql_close($conn);



?>
<?php
header('Access-Control-Allow-Origin: http://www.compandsave.com');
//header('Access-Control-Allow-Origin: http://casinkadmin.com/');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');


//require_once 'database.php';

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

$file = fopen("../data/easter-fb.csv","w");

//$sql = "SELECT email, time FROM `easter_subscribe` WHERE eggID=1 ORDER BY time AND eggID";
$sql = "SELECT email, link, time, eggID FROM `easter_fb` order by eggID, time";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	echo $array["email"] . " ";
	echo $array["time"] . "<br>";
	fputcsv($file, $array);
}


mysql_close($conn);
?>
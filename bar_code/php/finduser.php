<?php
header('Access-Control-Allow-Origin: http://www.compandsavetest.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
//configuration
$username = "liangf";
$password = "LiAng13579$";
$hostname = "192.168.100.89"; 
$databasename = "liangf";

$scannerID= $_GET['scanner'];

//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password);

mysql_select_db($databasename) or die("can't find dbname");


//create for test
$query = "Select userid From UserInformation Where scannerID='$scannerID'";
$result = mysql_query($query);
while($row = mysql_fetch_array($result)){
	echo $row['userid'];
}
mysql_close($dbhandle);
?>
<?php
header('Access-Control-Allow-Origin: http://www.compandsavetest.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
//configuration
$username = "liangf";
$password = "LiAng13579$";
$hostname = "192.168.100.89"; 
$databasename = "liangf";

$trackingno= $_GET['tracking'];


//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password);

mysql_select_db($databasename) or die("can't find dbname");


//create for test
$query = "Select * From warehouserecords Where trackingno='$trackingno'";
$result = mysql_query($query);
$row = mysql_fetch_row($result);
if($row){
echo "N";
}else{
echo "Y";
}
mysql_close($dbhandle);
?>
<?php
header('Access-Control-Allow-Origin: http://www.compandsavetest.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
//configuration
$username = "liangf";
$password = "LiAng13579$";
$hostname = "192.168.100.89"; 
$databasename = "liangf";

$trackingno= $_POST['tkn'];
$userid= $_POST['userid'];
$time= $_POST['ts'];
$date= $_POST['ds'];
$type= $_POST['shiptype'];


//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password);

mysql_select_db($databasename) or die("can't find dbname");

//create for test
$query = "INSERT INTO warehouserecords VALUES ('$userid', '$trackingno', '', '$date', '$time', '', '', '', '', '', '', '', '$type')";
$result = mysql_query($query);
if($result){
echo "Success insertion";
}else{
echo "fail to insert!";
}
mysql_close($dbhandle);
?>
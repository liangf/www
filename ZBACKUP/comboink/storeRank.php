<?php
header('Access-Control-Allow-Origin: http://www.comboink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
/*
	//$nname = $_POST["uname"];
	//$data = $_POST["utime"];
	$nname = "hao123";
	$data = "00:03.12";
	$times = explode(':', $data);
	$hr = 0;
	$mm = $times[0];
	$secs = $times[1];	
	$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
		echo $hr."<br>";
		echo $mm."<br>";
		echo $secs."<br>";
		echo $tt."<br>";
	$sql = "INSERT INTO easter_score (id, name, totalTime, strTime, hour, minute, second, time) VALUES(0, '$nname', '$tt', '$data', '$hr', '$mm', '$secs', now())";
	mysql_query($sql);
*/

if( $_POST["utime"] ) {
	$nname = $_POST["uname"];
	$data = $_POST["utime"];
	$times = explode(':', $data);
	$hr = 0;
	$mm = $times[0];
	$secs = $times[1];	
	$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
//echo $data;
	$sql = "INSERT INTO easter_score (id, name, totalTime, strTime, hour, minute, second, time) VALUES(0, '$nname', '$tt', '$data', '$hr', '$mm', '$secs', now())";
	mysql_query($sql);


	$output = "";
	$sql = "SELECT * FROM easter_score ORDER BY totalTime LIMIT 10";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		$output .= $array['name'];
		$output .= "#n#";
		$output .= $array['strTime'];
		$output .= "#t#";
	}
    echo $output;
}

mysql_close($conn);
?>
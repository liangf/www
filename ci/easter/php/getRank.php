<?php
header('Access-Control-Allow-Origin: http://www.comboink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


if( $_POST["utime"] ) {
	$data = $_POST["utime"];
	$times = explode(':', $data);
	$hr = 0;
	$mm = $times[0];
	$secs = $times[1];	
	$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
	
	$rank = 0;
	$sql = "SELECT * FROM easter_score ORDER BY totalTime";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		if ($tt<$array['totalTime']) break;
		$rank++;
	}
	echo $rank+1;
	
	//echo "?";
	echo "#r#";
	
	$output = "";
	$sql = "SELECT * FROM easter_score ORDER BY totalTime LIMIT 10";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		$output .= $array['name'];
		//$output .= ",";
		$output .= "#n#";
		$output .= $array['strTime'];
		//$output .= "^";
		$output .= "#t#";
	}
    echo $output;
	
}

mysql_close($conn);

?>
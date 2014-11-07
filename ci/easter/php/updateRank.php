<?php
header('Access-Control-Allow-Origin: http://www.comboink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


	//$times = explode(':', $data);
	//$hr = $times[0];
	//$mm = $times[1];
	//$secs = $times[2];
	//$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
	
	$sql = "SELECT * FROM easter_score";
	$result = mysql_query($sql);
	//echo mysql_num_rows($result);
/*	
		$str_time = "00:00.23";
		$times = explode(':', $str_time);
		$hr = 0;
		$mm = $times[0];
		$secs = $times[1];
		$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
		echo $hr."<br>";
		echo $mm."<br>";
		echo $secs."<br>";
		echo $tt."<br>";
		$sql = "UPDATE easter_score SET totalTime='$tt',hour='$hr',minute='$mm',second='$secs' WHERE id=47";
		mysql_query($sql);
*/	
	
	while($array = mysql_fetch_array($result)) {
		$str_time = $array['strTime'];
		$times = explode(':', $str_time);
		$hr = 0;
		$mm = $times[0];
		$secs = $times[1];
		$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
		$id = $array['id'];
		
		echo $id." "; echo $tt." "; echo $hr." "; echo $mm." "; echo $secs."<br>";

		$sql = "UPDATE easter_score SET totalTime='$tt',hour='$hr',minute='$mm',second='$secs' WHERE id='$id'";
		mysql_query($sql);
	}

	
/*
if( $_POST["utime"] ) {
	$data = $_POST["utime"];
	$times = explode(':', $data);
	$hr = $times[0];
	$mm = $times[1];
	$secs = $times[2];
	$tt = $hr * 60 * 60 * 1000 + $mm * 60 * 1000 + $secs * 1000;
	
	$rank = 0;
	$sql = "SELECT * FROM easter_score ORDER BY totalTime";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		if ($tt<$array['totalTime']) break;
		$rank++;
	}
	echo $rank+1;
	
	echo "?";
	
	$output = "";
	$sql = "SELECT * FROM easter_score ORDER BY totalTime LIMIT 10";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		$output .= $array['name'];
		$output .= ",";
		$output .= $array['strTime'];
		$output .= " ";
	}
    echo $output;
	
}
*/
mysql_close($conn);

?>
<?php
//header('Access-Control-Allow-Origin: http://www.comboink.com');
//header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


if( $_POST["urow"] ) {
	$row = $_POST["urow"];
	//echo $data;

	$output = "";
	$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where customlabel='$row' order by time DESC";
	$result = mysql_query($sql);
	while($array = mysql_fetch_array($result)) {
		$output .= $array['customlabel'];
		$output .= "#n#";
		$output .= $array['costprice'];
		$output .= "#n#";
		$output .= $array['shippingcost'];
		$output .= "#n#";
		$output .= $array['time'];
		$output .= "#t#";
	}
    echo $output;

}

mysql_close($conn);

?>
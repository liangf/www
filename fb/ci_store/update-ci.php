<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

$sql = "delete FROM ci_fbstore";
mysql_query($sql);

?>

<?php
$myfile = fopen("Comboink_Feed_fbstore.txt", "r") or die("Unable to open file!");
// Output one line until end-of-file
while(!feof($myfile)) {
	//echo fgets($myfile) . "<br>";
	$row = fgets($myfile);
	$row = explode('@', $row);
	//echo $row[0] . "<br>";
	$productid = $row[0];
	$shorttitle = mysql_real_escape_string($row[1]);
	$longtitle = mysql_real_escape_string($row[2]);
	$producturl = $row[3];
	$imageurl = $row[4];
	$longtitle2 = str_replace(' ', '', $row[2]);
	$longtitle2 = strtolower($longtitle2);
	$longtitle2 = mysql_real_escape_string($longtitle2);
	$price = $row[5];
	
	$sql = "insert into ci_fbstore (productid, shorttitle, longtitle, producturl, imageurl, longtitle2, price) values('$productid', '$shorttitle', '$longtitle', '$producturl', '$imageurl', '$longtitle2', $price)";
	if( !mysql_query($sql) ) echo $row[0] . "insert db no success. <br>";
}
fclose($myfile);


mysql_close($conn);
?>
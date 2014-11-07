<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

$sql = "delete FROM fbstore";
mysql_query($sql);

?>

<?php
$myfile = fopen("CompandSave_Feed_fbstore.txt", "r") or die("Unable to open file!");
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
	$shorttitle2 = str_replace(' ', '', $row[1]);
	$shorttitle2 = strtolower($shorttitle2);
	$price = $row[5];
	
	$sql = "insert into fbstore (productid, shorttitle, longtitle, producturl, imageurl, shorttitle2, price) values('$productid', '$shorttitle', '$longtitle', '$producturl', '$imageurl', '$shorttitle2', $price)";
	if( !mysql_query($sql) ) echo $row[0] . "insert db no success. <br>";
}
fclose($myfile);


mysql_close($conn);
?>
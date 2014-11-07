<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel";
$result = mysql_query($sql);
$row = mysql_num_rows($result);

$sql2 = "select customlabel, max(time) as maxtime from ebay_activelist group by customlabel order by customlabel";
$result2 = mysql_query($sql2);
$row2 = mysql_num_rows($result2);

echo $row . "<br>";
echo $row2 . "<br>";

$labs2 = array();
while($array = mysql_fetch_array($result2)) {
	$customlabel2 = $array['customlabel'];
	$labs2[$customlabel2] = 1;
}
$old = "old";
$new = "new";
while($array = mysql_fetch_array($result)) {
	$customlabel = $array['customlabel'];
	$old = $new;
	$new = $customlabel;

	//if ($labs2[$customlabel] == 1) echo $customlabel . "<br>";
	if ($old==$new) echo $customlabel . "<br>";
}


mysql_close($conn);			
?>
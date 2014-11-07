<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



//$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel";
$sql = "select customlabel, max(time) as maxtime from ebay_activelist group by customlabel order by customlabel";
$result = mysql_query($sql);
$row = mysql_num_rows($result);
echo $row . "<br>";


$old = "old";
$new = "new";
while($array = mysql_fetch_array($result)) {
	//echo $array['customlabel'] . " ";
	//echo $array['maxtime'] . "<br>";
	$customlabel = $array['customlabel'];
	$old = $new;
	$new = $customlabel;
	$old2 = str_replace(' ', '', $old);
	$old2 = strtolower($old2);
	$new2 = str_replace(' ', '', $new);
	$new2 = strtolower($new2);
	if ($old != $new && $old2==$new2) {
	//if ($old != $new) {
		echo $array['customlabel'] . " ";
		echo $array['maxtime'] . "<br>";	
	}
}

mysql_close($conn);			
?>
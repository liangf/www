<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
?>

<?php

function showMerge() {	
	// Empty the ebay_tmpt table
	$sql = "delete FROM ebay_tmpt";
	mysql_query($sql);

	// insert the distinct data into ebay_tmpt
	// select distinct (customlabel, price) from ebay_trading table
	$tableT = array();
	$sql_t = "SELECT id, customlabel, price, shippingcost, time FROM ebay_trading group by customlabel, price";
	$result = mysql_query($sql_t);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		while($array = mysql_fetch_array($result)) {
			$customlabel2 = trim($array['customlabel']);
			$customlabel2 = str_replace(' ', '', $customlabel2);
			//$customlabel2 = str_replace(' ', '', $array['customlabel']);
			$customlabel2 = strtolower($customlabel2);
			$old_price = $tableT[$customlabel2];
			//$tableT[$customlabel2] = $array['price'];	
			// have the same customlabel, the same price
			if ($tableT[$customlabel2] > 0) {
				$tableT[$customlabel2] = $array['price'];	
				// have the the same price
				if($old_price == $tableT[$customlabel2]) {
					//echo $array['customlabel'] . "<br>";
					continue;
				}
			}
			$customlabel = $array['customlabel'];
			$price = $array['price'];
			$shippingcost = $array['shippingcost'];
			$time = $array['time'];
			// insert the distinct data into ebay_tmpt
			//$sql = "insert into ebay_tmpt (id, customlabel2, customlabel, price, shippingcost, time) values(0, '$customlabel2', '$customlabel', $price, $shippingcost, '$time')";
			$sql = "insert into ebay_tmpt (id, customlabel2, customlabel, price, shippingcost, time) values(0, '$customlabel2', '$customlabel', $price, $shippingcost, now())";
			if( !mysql_query($sql) ) echo "'" .$customlabel ."'" ." added no success. <br>";
		}
	} else { echo "No data in DB.<br>";}

	
	// Empty the ebay_tmpa table
	$sql = "delete FROM ebay_tmpa";
	mysql_query($sql);	
	// insert the distinct data into ebay_tmpa
	// select most recent distinct (customlabel) from ebay_trading table
	$sql_a = "select e2.customlabel, e2.costprice, e2.shippingcost, e2.time from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel";
	$result = mysql_query($sql_a);
	$row = mysql_num_rows($result);	
	// the 1st round, put the same name ('ab cd'=='ab cd'), most recent items into db
	if ($row>=1) {
		while($array = mysql_fetch_array($result)) {
			$customlabel2 = trim($array['customlabel']);
			$customlabel2 = str_replace(' ', '', $customlabel2);
			//$customlabel2 = str_replace(' ', '', $array['customlabel']);
			$customlabel2 = strtolower($customlabel2);
			$customlabel = $array['customlabel'];
			$price = $array['costprice'];
			$shippingcost = $array['shippingcost'];
			$time = $array['time'];
			// insert the distinct data into ebay_tmpa
			$sql = "insert into ebay_tmpa (id, customlabel2, customlabel, costprice, shippingcost, time) values(0, '$customlabel2', '$customlabel', $price, $shippingcost, '$time')";
			if( !mysql_query($sql) ) echo "'" .$customlabel ."'" ." added no success. <br>";			
		}
	} else { echo "No data in DB.<br>";}
	// the 2nd round, put the same name ('abcd'=='ab cd' or 'ab cd'=='ab cd'), most recent items into db
	// delete the same items not max(time)
	$tableA = array();	
	$sql_a = "SELECT id, customlabel2, customlabel, costprice, shippingcost, time FROM ebay_tmpa order by customlabel2, time DESC";
	$result = mysql_query($sql_a);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		while($array = mysql_fetch_array($result)) {
			$customlabel2 = $array['customlabel2'];
			$customlabel = $array['customlabel'];
			if ($tableA[$customlabel2] == 123) {
				$sql = "delete from ebay_tmpa where customlabel='$customlabel'";
				if( !mysql_query($sql) ) echo "'" .$customlabel ."'" ." delete no success. <br>";			
			}
			else $tableA[$customlabel2] = 123;
			
		}
	} else { echo "No data in DB.<br>";}

	
	// Empty the ebay_profit table
	$sql = "delete FROM ebay_profit";
	mysql_query($sql);	
	
	// inner join ebay_tmpa, ebay_tmpt	
	$sql = "SELECT a.customlabel, t.price, a.costprice, a.shippingcost FROM ebay_tmpa as a inner join ebay_tmpt as t on a.customlabel2=t.customlabel2";
	
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		while($array = mysql_fetch_array($result)) {
			$netprofit = $array['price']-$array['costprice']-$array['shippingcost']-$array['price']*0.06-$array['price']*0.05-($array['price']*0.025+0.3);
			$morethan5 = "N";
			if ($netprofit > 5) $morethan5 = "Y";
			
			$customlabel = $array['customlabel'];
			$price = $array['price'];
			$costprice = $array['costprice'];
			$shippingcost = $array['shippingcost'];
			$fvf = $array['price']*0.06;
			$jl5 = $array['price']*0.05;
			$paypalfee = ($array['price']*0.025+0.3);
			//$netprofit = $array['price']-$array['costprice']-$array['shippingcost']-$array['price']*0.06-$array['price']*0.05-($array['price']*0.025+0.3);
			
			// insert the distinct data into ebay_tmpa
			$sql_p = "insert into ebay_profit (id, customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5, time) values(0, '$customlabel', $price, $costprice, $shippingcost, $fvf, $jl5, $paypalfee, $netprofit, '$morethan5', now())";
			if( !mysql_query($sql_p) ) echo "'" .$customlabel ."'" ." added no success. <br>";				
		}
	} else { echo "No data in DB.<br>";}	
}
?>

<?php

// update the input active list and ebay active list
showMerge();


//$today = date("Y-m-d H:i:s"); 
$today = date("Y-m-d"); 
$yesterday0 = mktime(0, 0, 0, date("m"), date("d")-1, date("Y"));
$yesterday0 = date("Y-m-d H:i:s", $yesterday0);
$yesterday1 = mktime(23, 59, 59, date("m"), date("d")-1, date("Y"));
$yesterday1 = date("Y-m-d H:i:s", $yesterday1);
echo $yesterday0 . "<br>";
echo $yesterday1 . "<br>";



//$to = "andrew@compandsave.com";
$to = "liangf@compandsave.com";
$subject = "Ebay Profit";




$message = "";
$message .= "New Added Items\n";

$message .=	str_pad("Custom label", 50, " ") ."\t";
$message .=	str_pad("Cost price", 20, " ") ."\t";
$message .=	str_pad("Shipping cost", 20, " ") ."\t";
//$message .=	"Cost price" ."\t";
//$message .=	"Shipping cost" ."\t";
$message .=	"Time\n";

// get the data from ebay_activelist on yesterday
$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where time between '$yesterday0' and '$yesterday1' order by customlabel";
$result = mysql_query($sql);	
while($array = mysql_fetch_array($result)) {
	$customlabel = $array['customlabel'];
	$sql2 = "SELECT * FROM ebay_activelist where time<'$yesterday0' and customlabel='$customlabel'";
	if ( mysql_num_rows(mysql_query($sql2))<1 ) {
	    $customlabel = str_pad($array['customlabel'], 50, " ");
		$costprice = str_pad($array['costprice'], 20, " ");
		$shippingcost = str_pad($array['shippingcost'], 20, " ");
		
		$message .= $customlabel . "\t";
		$message .= $costprice . "\t";
		$message .= $shippingcost . "\t";
		$message .= $array['time'] . "\n";
	}
}
$message .=	"\n\n";


$message .= "Update existed Items\n";

$message .=	str_pad("Custom label", 50, " ") ."\t";
$message .=	str_pad("Cost price", 20, " ") ."\t";
$message .=	str_pad("Shipping cost", 20, " ") ."\t";
$message .=	"Time\n";
// get the data from ebay_activelist on yesterday
$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where time between '$yesterday0' and '$yesterday1' order by customlabel";
$result = mysql_query($sql);	
while($array = mysql_fetch_array($result)) {
	$customlabel = $array['customlabel'];
	$sql2 = "SELECT * FROM ebay_activelist where time<'$yesterday0' and customlabel='$customlabel'";
	if ( mysql_num_rows(mysql_query($sql2))>0 ) {
	    $customlabel = str_pad($array['customlabel'], 50, " ");
		$costprice = str_pad($array['costprice'], 20, " ");
		$shippingcost = str_pad($array['shippingcost'], 20, " ");
	
		$message .= $customlabel . "\t";
		$message .= $costprice . "\t";
		$message .= $shippingcost . "\t";
		$message .= $array['time'] . "\n";
	}
}
$message .= "\n\n";



$message .= "Less than $5 Profit\n";
$message .= str_pad("Custom label", 50, " ") ."\t";
$message .= str_pad("Price", 20, " ") ."\t";
$message .= str_pad("Cost price", 20, " ") ."\t";
$message .= str_pad("Shipping cost", 20, " ") ."\t";
$message .= str_pad("Ebay FVF", 20, " ") ."\t";
$message .= str_pad("JL 5% commission", 20, " ") ."\t";
$message .= str_pad("Paypal fee", 20, " ") ."\t";
$message .= str_pad("Net Profit", 20, " ") ."\t";
$message .= "More than $5 Profit\n";



$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by netprofit";
$result = mysql_query($sql);	
while($array = mysql_fetch_array($result)) {	
	if ($array['morethan5']=="N") {
	    $customlabel = str_pad($array['customlabel'], 50, " ");
		$price = str_pad($array['price'], 20, " ");
		$costprice = str_pad($array['costprice'], 20, " ");
		$shippingcost = str_pad($array['shippingcost'], 20, " ");
		$fvf = str_pad($array['fvf'], 20, " ");
		$jl5 = str_pad($array['jl5'], 20, " ");
		$paypalfee = str_pad($array['paypalfee'], 20, " ");
		$netprofit = str_pad($array['netprofit'], 20, " ");

		
		$message .= $customlabel . "\t";
		$message .= $price . "\t";
		$message .= $costprice . "\t";
		$message .= $shippingcost . "\t";
		$message .= $fvf . "\t";
		$message .= $jl5 . "\t";
		$message .= $paypalfee . "\t";
		$message .= $netprofit . "\t";
		$message .= $array["morethan5"] . "\n";
	}
}

$message .= "\n\n";



// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
//$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
//$headers .= "Content-type:text;charset=UTF-8" . "\r\n";

// More headers
$headers .= 'From: <ebayprice@compandsave.com>' . "\r\n";
$headers .= 'Cc: liangf@compandsave.com' . "\r\n";

mail($to,$subject,$message,$headers);

mysql_close($conn);
?>
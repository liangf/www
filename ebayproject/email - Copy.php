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
			$customlabel2 = str_replace(' ', '', $array['customlabel']);
			$customlabel2 = strtolower($customlabel2);
			$old_price = $tableT[$customlabel2];
			$tableT[$customlabel2] = $array['price'];	
			// have the same customlabel, the same price
			if ($tableT[$customlabel2] > 0) {	
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
			$sql = "insert into ebay_tmpt (id, customlabel2, customlabel, price, shippingcost, time) values(0, '$customlabel2', '$customlabel', $price, $shippingcost, '$time')";
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
			$customlabel2 = str_replace(' ', '', $array['customlabel']);
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
			if ($tableA[$customlabel2] > 0) {
				$sql = "delete from ebay_tmpa where customlabel='$customlabel'";
				if( !mysql_query($sql) ) echo "'" .$customlabel ."'" ." delete no success. <br>";			
			}
			else $tableA[$customlabel2] = 1;
			
		}
	} else { echo "No data in DB.<br>";}	
}	
?>

<?php
$to = "liangf@compandsave.com";
$subject = "Active List";

$message = "
<html>
<head>
<title>Active List</title>
</head>
<body>
";

$message .= '<h2>New Updated Active List</h2>';
$message .= '<table>';
$message .=	'<tr>';
$message .=	'<td style="width:450px"><b>Custom label</td>';
$message .=	'<td style="width:150px"><b>Cost price</td>';
$message .=	'<td style="width:150px"><b>Shipping cost</td>';
$message .=	'<td style="width:150px"><b>Time</td>';
$message .=	'</tr>';

$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist order by customlabel, time";
$result = mysql_query($sql);	
while($array = mysql_fetch_array($result)) {
	$message .= "<tr>";
	$message .= "<td>" . $array['customlabel'] . "</td>";
	$message .= "<td>" . $array['costprice'] . "</td>";
	$message .= "<td>" . $array['shippingcost'] . "</td>";
	$message .= "<td>" . $array['time'] . "</td>";
	$message .= "</tr>";
}
$message .= "</table>";


showMerge();
$message .= '<h2>Less than $5 Profit</h2>';
$message .= '<table>';
$message .= '<tr>';
$message .= '<td style="width:450px"><b>Custom label</td>';
$message .= '<td style="width:150px"><b>Price</td>';
$message .= '<td style="width:150px"><b>Cost price</td>';
$message .= '<td style="width:150px"><b>Shipping cost</td>';
$message .= '<td style="width:150px"><b>Ebay FVF</td>';
$message .= '<td style="width:150px"><b>JL 5% commission</td>';
$message .= '<td style="width:150px"><b>Paypal fee</td>';
$message .= '<td style="width:150px"><b>Net Profit</td>';
$message .='<td style="width:150px"><b>More than $5 Profit</td>';
$message .= '</tr>';
/*
for ($i=0; $i<1; $i++) {
	$message .= '<tr>';
	$message .= '<td>' . 'customlabel' . '</td>';
	$message .= '<td>' . '21.99' . '</td>';
	$message .= '<td>' . '9.99' . '</td>';
	$message .= '<td>' . '3.99' . '</td>';
	$message .= '<td>' . '1.99' . '</td>';
	$message .= '<td>' . '1.99'. '</td>';
	$message .= '<td>' . '1.99' . '</td>';
	$message .= '<td>' . '5.19' . '</td>';
	$message .= '<td>' . 'Y' . '</td>';
	$message .= '</tr>';
}


	$message .= "<tr>";
	$message .= "<td>" . 'customlabel' . "</td>";
	$message .= "<td>" . '21.99' . "</td>";
	$message .= "<td>" . '9.99' . "</td>";
	$message .= "<td>" . '3.99' . "</td>";
	$message .= "<td>" . '1.99' . "</td>";
	$message .= "<td>" . '1.99' . "</td>";
	$message .= "<td>" . '1.99' . "</td>";
	$message .= "<td>" . '5.19' . "</td>";
	$message .= "<td>" . 'Y' . "</td>";
	$message .= "</tr>";
*/

// inner join ebay_tmpa, ebay_tmpt	
$sql = "SELECT a.customlabel, t.price, a.costprice, a.shippingcost FROM ebay_tmpa as a inner join ebay_tmpt as t on a.customlabel2=t.customlabel2";
$result = mysql_query($sql);	
while($array = mysql_fetch_array($result)) {
	$net_profit = $array['price']-$array['costprice']-$array['shippingcost']-$array['price']*0.06-$array['price']*0.05-($array['price']*0.025+0.3);
	$more_than_5 = "N";
	//$customlabel = $array['customlabel'];
	//$price = $array['price'];
	//$costprice = $array['costprice'];
	//$shippingcost = $array['shippingcost'];
	$customlabel = "customlabel";
	$price = 5.00;	
	$costprice = 2.99;	
	$shippingcost = 3.99;
	$ebay_fvf = $price*0.06;
	$jl_commission = $price*0.05;
	$paypal_fee = ($price*0.025+0.3);
	$net_profit = 0.00;
	
	$price =  '1.11';	
	$costprice = '2.22';	
	$shippingcost = '3.33';
	$ebay_fvf = '4.44';
	$jl_commission = '5.55';
	$paypal_fee = '6.66';
	$net_profit = '7.77';	
	//if ($net_profit > 5) $more_than_5 = "Y";
	$message .= '<tr>';
	$message .= '<td>' . $customlabel . '</td>';
	$message .= '<td>' . $price . '</td>';
	$message .= '<td>' . $costprice . '</td>';
	$message .= '<td>' . $shippingcost . '</td>';
	$message .= '<td>' . $ebay_fvf . '</td>';
	$message .= '<td>' . $jl_commission . '</td>';
	$message .= '<td>' . $paypal_fee . '</td>';
	$message .= '<td>' . $net_profit . '</td>';
	$message .= '<td>' . $more_than_5 . '</td>';
	$message .= '</tr>';			
}

$message .= "</table>";



$message .="
</body>
</html>
";

// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

// More headers
$headers .= 'From: <webmaster@example.com>' . "\r\n";
$headers .= 'Cc: liangf@g.clemson.edu' . "\r\n";

mail($to,$subject,$message,$headers);
?>
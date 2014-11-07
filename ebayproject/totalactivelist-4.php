<?php 
set_time_limit(1500) //increase time-out to 25 mins as downloading and parsing the tree may take a while 
?>




<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
?>


<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<style>
table,th,td
{
border:1px solid black;
border-collapse:collapse;
}

#div-activelist2
{
  position: absolute;
  left: 780px;
  top: 468px
}
</style>
</head>

<body>
	<h2>Add Active List</h2>

	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/totalactivelist.php">
	<table>
		<tr>
			<td style="width:450px"><b>Custom label</td>
			<td style="width:150px"><b>Cost price</td>		
			<td style="width:150px"><b>Shipping cost</td>
			<td></td>
		</tr>
		<tr>
			<td><input type="text" id="customlab" name="customlab" value="custom label" size="68" onfocus="if(this.value=='custom label')this.value='';" onblur="if(this.value=='')this.value='custom label';"></td>
			<td><input type="text" id="costprice" name="costprice" value="cost price" size="18" onfocus="if(this.value=='cost price')this.value='';" onblur="if(this.value=='')this.value='cost price';"></td>		
			<td><input type="text" id="shipprice" name="shipprice" value="shipping cost" size="18" onfocus="if(this.value=='shipping cost')this.value='';" onblur="if(this.value=='')this.value='shipping cost';"></td>
			<td><button>Add</button></td>
		</tr>
	</table>
	</form>
<?php
// submitting the custom lab in the db
if( $_POST["customlab"] ) {
	//echo $_POST["customlab"];
	$customlab = $_POST["customlab"];
	$costprice = $_POST["costprice"];
	$shipprice = $_POST["shipprice"];	

	$sql = "insert into ebay_activelist (id, customlabel, costprice, shippingcost, time) values(0, '$customlab', $costprice, $shipprice, now())";
	if( mysql_query($sql) ) echo "'" .$customlab ."'" ." added! <br>";
	else echo "'" .$customlab ."'" ." added no success. <br>";
	
}
?>
	
	<hr>
	<h2>Search in the DB</h2>
	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/totalactivelist.php">
	<table>
		<tr>
			<td style="width:450px"><input type="text" id="search-customlab" name="scustomlab" value="custom label" size="68" onfocus="if(this.value=='custom label')this.value='';"></td>
			<td style="width:150px"><input type="text" id="search-costprice" name="scostprice" value="cost price" size="18" onfocus="if(this.value=='cost price')this.value='';"></td>		
			<td style="width:150px"><input type="text" id="search-shipprice" name="sshipprice" value="shipping cost" size="18" onfocus="if(this.value=='shipping cost')this.value='';"></td>
			<td><button>Search</button></td>
		</tr>
	</table>	
	</form>
<?php
// searching item from db
if( $_POST["scustomlab"] || $_POST["scostprice"] || $_POST["sshipprice"]) {
	//echo $_POST["scustomlab"] . "<br>";
	//echo $_POST["scostprice"] . "<br>";
	//echo $_POST["sshipprice"] . "<br>";
	$is_input_costprice = -1;
	$is_input_shipprice = -1;
	if ($_POST["scostprice"]!="" && $_POST["scostprice"]!="cost price") $is_input_costprice = 1;
	if ($_POST["sshipprice"]!="" && $_POST["sshipprice"]!="shipping cost") $is_input_shipprice = 1;
	
	
	$customlab = $_POST["scustomlab"];
	echo "You'are searching: <br>";
	echo "custom label: " . $customlab . "<br>";
	$sql = "";
	if ($is_input_costprice>0 && $is_input_shipprice>0) {
		//echo "input both costprice & shipprice . <br>";
		$costprice1 = (float)$_POST["scostprice"] - 0.01;
		$costprice2 = (float)$_POST["scostprice"] + 0.01;
		$shipprice1 = (float)$_POST["sshipprice"] - 0.01;
		$shipprice2 = (float)$_POST["sshipprice"] + 0.01;
		//echo $costprice1 . ", " . $costprice2 . "<br>";
		//echo $shipprice1 . ", " . $shipprice2 . "<br>";
		echo "cost price: " .$_POST["scostprice"] .", " ."shipping cost: " .$_POST["sshipprice"] ."<br>";
		$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where customlabel like '%$customlab%' and (costprice>=$costprice1 and costprice<=$costprice2) and (shippingcost>=$shipprice1 and shippingcost<=$shipprice2)";
	}
	else if ($is_input_costprice>0) {
		//echo "input the costprice. <br>";
		$costprice1 = (float)$_POST["scostprice"] - 0.01;
		$costprice2 = (float)$_POST["scostprice"] + 0.01;
		//echo $costprice1 . ", " . $costprice2 . "<br>";
		echo "cost price: " .$_POST["scostprice"] ."<br>";
		$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where customlabel like '%$customlab%' and (costprice>=$costprice1 and costprice<=$costprice2)";
	}
	else if ($is_input_shipprice>0) {
		//echo "input the shipprice. <br>";
		$shipprice1 = (float)$_POST["sshipprice"] - 0.01;
		$shipprice2 = (float)$_POST["sshipprice"] + 0.01;
		//echo $shipprice1 . ", " . $shipprice2 . "<br>";
		echo "shipping cost: " .$_POST["sshipprice"] ."<br>";
		$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where customlabel like '%$customlab%' and (shippingcost>=$shipprice1 and shippingcost<=$shipprice2)";
	} else {
		$sql = "SELECT customlabel, costprice, shippingcost, time FROM ebay_activelist where customlabel like '%$customlab%'";
	}
	//echo $sql . "<br>";

	$result = mysql_query($sql);
	$row = mysql_num_rows($result);	

	if ($row>0) {
?>	
<table border="1px">
	<tr>
		<td style="width:450px"><b>Custom label</td>
		<td style="width:150px"><b>Cost price</td>
		<td style="width:150px"><b>Shipping cost</td>
		<td style="width:150px"><b>Time</td>
	</tr>
<?php
	while($array = mysql_fetch_array($result)) {
		echo "<tr>";
		echo "<td>" . $array['customlabel'] . "</td>";
		echo "<td>" . $array['costprice'] . "</td>";
		echo "<td>" . $array['shippingcost'] . "</td>";
		echo "<td>" . $array['time'] . "</td>";
		echo "</tr>";
	}
	} else { echo " Not found in db. <br>";}
}
?>
</table>

	<hr>
	<h2>Modify the data</h2>
	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/totalactivelist.php">
	<table>
		<tr>
			<td style="width:450px"><input type="text" id="m-customlab-old" name="mcustomlab_old" value="old custom label" size="68" onfocus="if(this.value=='old custom label')this.value='';"></td>
			<td style="width:450px"><input type="text" id="m-customlab-new" name="mcustomlab_new" value="new custom label" size="68" onfocus="if(this.value=='new custom label')this.value='';"></td>
			<td><button>Modify</button></td>
		</tr>
	</table>	
	</form>	
	
<?php
	if ($_POST["mcustomlab_old"] &&
		$_POST["mcustomlab_new"]) {
		
		$mcustomlab_old = $_POST["mcustomlab_old"];
		$mcustomlab_new = $_POST["mcustomlab_new"];
		$sql_new = "SELECT id, customlabel, costprice, shippingcost, time from ebay_activelist where customlabel='$mcustomlab_new'";
		//$result = mysql_query($sql);
		$row_new = mysql_num_rows(mysql_query($sql_new));
		$sql_old = "SELECT id, customlabel, costprice, shippingcost, time from ebay_activelist where customlabel='$mcustomlab_old'";
		$row_old = mysql_num_rows(mysql_query($sql_old));		
		// new customlab exist in the db
		// old customlab doesn't exist in the db
		if ($row_old<=0) {
			echo "Cannot modify. " . "'" .$mcustomlab_old . "'" ." doesn't exist in the DB.";
		}
		else {
			// update the old --> new
			$sql2 = "SELECT id, customlabel, costprice, shippingcost, time from ebay_activelist where customlabel='$mcustomlab_old'";
			$array = mysql_fetch_array(mysql_query($sql2));
			$old_id = $array['id'];
			$sql3 = "update ebay_activelist set customlabel='$mcustomlab_new' where id=$old_id";
			mysql_query($sql3);
			echo "Modify success! " . "'".$mcustomlab_old . "'" ." --> " . "'" .$mcustomlab_new ."'". "<br>"; 
		}
		
	}
?>	
	
	<hr>	
	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/totalactivelist.php">
	<button id="btn-activelist" name="btnlist" value="list" style="margin:10">Show Active List</button>
	<button id="btn-ebay" name="btnebay" value="ebay" style="margin:10">Show Ebay Active List</button>
	<button id="btn-merge" name="btnmerge" value="merge" style="margin:10">Merge Active List</button>
	<button id="btn-diff" name="btndiff" value="diff" style="margin:10">Difference Active List</button>
	
<?php

if ($_POST["btnlist"] || $_GET["sortname"]=="label_a" || $_GET["sortname"]=="cost_a" || $_GET["sortname"]=="shipping_a") {
	echo "<h2>Active List (if duplicated items, show the most recent added item)</h2>";
	showActiveList();
}
if ($_POST["btnebay"] || $_GET["sortname"]=="label_t" || $_GET["sortname"]=="price_t") {
	echo "<h2>Ebay Active List </h2>";
	showEbay();
}
if ($_POST["btnmerge"]) {
	echo "<h2>Merged Active List </h2>";
	showMerge();
}
if ($_GET["sortname"]=="label_m" || $_GET["sortname"]=="price_m" || $_GET["sortname"]=="cost_m" || $_GET["sortname"]=="shipping_m" || $_GET["sortname"]=="fvf_m" 
	|| $_GET["sortname"]=="jl5_m" ||$_GET["sortname"]=="paypalfee_m"||$_GET["sortname"]=="netprofit_m"||$_GET["sortname"]=="morethan5_m") {
	echo "<h2>Merged Active List </h2>";
	showMergeSort();
}
if ($_POST["btndiff"]) {
	echo "<h2>Difference Active List </h2>";
	diffMerge();
}

function showActiveList() {
	//$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist order by customlabel";
	$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel";

	$sort_img = "./img/s_asc.png";
	if ($_GET["sort"] == "desc") $sort_img = "./img/s_desc.png";
	
	$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_a&sort=desc";
	if ($_GET["sortname"]=="label_a" && $_GET["sort"] == "desc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_a&sort=asc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel DESC";
	}
	if ($_GET["sortname"]=="label_a" && $_GET["sort"] == "asc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_a&sort=desc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.customlabel ASC";
	}
	$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_a&sort=desc";
	if ($_GET["sortname"]=="cost_a" && $_GET["sort"] == "desc") {
		$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_a&sort=asc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.costprice DESC";
	}
	if ($_GET["sortname"]=="cost_a" && $_GET["sort"] == "asc") {
		$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_a&sort=desc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.costprice ASC";
	}
	$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_a&sort=desc";
	if ($_GET["sortname"]=="shipping_a" && $_GET["sort"] == "desc") {
		$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_a&sort=asc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.shippingcost DESC";
	}
	if ($_GET["sortname"]=="shipping_a" && $_GET["sort"] == "asc") {
		$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_a&sort=desc";
		$sql = "select e2.customlabel, e2.costprice, e2.shippingcost from (select customlabel, max(time) as maxtime from ebay_activelist group by customlabel) e1 inner join ebay_activelist as e2 on e1.customlabel=e2.customlabel and e1.maxtime=e2.time order by e2.shippingcost ASC";
	}
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		echo '<div id="div-activelist">';
		echo '<table id="tab-activelist">';
		echo '<tr>';
		echo '<td style="width:450px"><a title="Sort" href='.$href_label.'><b>Custom label<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_cost.'><b>Cost price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_shipping.'><b>Shipping cost<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '</tr>';
		while($array = mysql_fetch_array($result)) {
			echo "<tr>";
			echo "<td>" . $array['customlabel'] . "</td>";
			echo "<td>" . $array['costprice'] . "</td>";
			echo "<td>" . $array['shippingcost'] . "</td>";
			echo "</tr>";
		}
		echo "</table>";
		echo "</div>";
		
		echo '<div id="div-activelist2">';
		echo '<table id="tab-activelist2">';
		//echo '<tr>';
		//echo '<td style="width:450px"><b>Custom label</td>';
		//echo '<td style="width:150px"><b>Cost price</td>';
		//echo '<td style="width:150px"><b>Shipping cost</td>';
		//echo '<td style="width:150px"><b>Time</td>';
		//echo '</tr>';
		echo "</table>";
		echo "</div>";
	} 
	else {
		echo "No data in DB.<br>";
	}
}

function showEbay() {
	$sql = "SELECT customlabel, price, shippingcost FROM ebay_trading order by customlabel";

	
	$sort_img = "./img/s_asc.png";
	if ($_GET["sort"] == "desc") $sort_img = "./img/s_desc.png";
	
	$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_t&sort=desc";
	if ($_GET["sortname"]=="label_t" && $_GET["sort"] == "desc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_t&sort=asc";
		$sql = "SELECT customlabel, price, shippingcost FROM ebay_trading order by customlabel DESC";
	}
	if ($_GET["sortname"]=="label_t" && $_GET["sort"] == "asc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_t&sort=desc";
		$sql = "SELECT customlabel, price, shippingcost FROM ebay_trading order by customlabel ASC";
	}
	$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_t&sort=desc";
	if ($_GET["sortname"]=="price_t" && $_GET["sort"] == "desc") {
		$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_t&sort=asc";
		$sql = "SELECT customlabel, price, shippingcost FROM ebay_trading order by price DESC";
	}
	if ($_GET["sortname"]=="price_t" && $_GET["sort"] == "asc") {
		$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_t&sort=desc";
		$sql = "SELECT customlabel, price, shippingcost FROM ebay_trading order by price ASC";
	}

	
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		echo '<table id="tab-ebay" border="1px">';
		echo '<tr>';
		echo '<td style="width:450px"><a title="Sort" href='.$href_label.'><b>Custom label<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_price.'><b>Cost price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><b>Shipping cost</td>';
		echo '</tr>';
		while($array = mysql_fetch_array($result)) {
			echo "<tr>";
			echo "<td>" . $array['customlabel'] . "</td>";
			echo "<td>" . $array['price'] . "</td>";
			echo "<td>" . $array['shippingcost'] . "</td>";
			echo "</tr>";
		}
		echo "</table>";
	} 
	else {
		echo "No data in DB.<br>";
	}
}

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
	
	// get data from eby_profit Table	
	$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit";

	
	$sort_img = "./img/s_asc.png";
	if ($_GET["sort"] == "desc") $sort_img = "./img/s_desc.png";
	
	$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_m&sort=desc";
	$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_m&sort=desc";
	$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_m&sort=desc";
	$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_m&sort=desc";
	$href_fvf = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=fvf_m&sort=desc";
	$href_jl5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=jl5_m&sort=desc";
	$href_paypalfee = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=paypalfee_m&sort=desc";
	$href_netprofit = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=netprofit_m&sort=desc";
	$href_morethan5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=morethan5_m&sort=desc";

	
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		echo '<table border="1px">';
		echo '<tr>';
		echo '<td style="width:450px"><a title="Sort" href='.$href_label.'><b>Custom label<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_price.'><b>Price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_cost.'><b>Cost price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_shipping.'><b>Shipping cost<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_fvf.'><b>Ebay FVF<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_jl5.'><b>JL 5% commission<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_paypalfee.'><b>Paypal fee<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_netprofit.'><b>Net Profit<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_morethan5.'><b>More than $5 Profit<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '</tr>';
		while($array = mysql_fetch_array($result)) {
			if ($array['morethan5']=="N") echo "<tr bgcolor='#FF0000'>";
			else echo "<tr>";
			echo "<td>" . $array['customlabel'] . "</td>";
			echo "<td>" . $array['price'] . "</td>";
			echo "<td>" . $array['costprice'] . "</td>";
			echo "<td>" . $array['shippingcost'] . "</td>";
			echo "<td>" . $array['fvf'] . "</td>";
			echo "<td>" . $array['jl5'] . "</td>";
			echo "<td>" . $array['paypalfee'] . "</td>";
			echo "<td>" . $array['netprofit'] . "</td>";
			echo "<td>" . $array['morethan5'] . "</td>";
			echo "</tr>";	
		}
		echo "</table>";
	} else { echo "No data in DB.<br>";}		
}

function showMergeSort() {
	// get data from eby_profit Table	
	$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit";

	
	$sort_img = "./img/s_asc.png";
	if ($_GET["sort"] == "desc") $sort_img = "./img/s_desc.png";
	
	$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_m&sort=desc";
	if ($_GET["sortname"]=="label_m" && $_GET["sort"] == "desc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by customlabel DESC";
	}
	if ($_GET["sortname"]=="label_m" && $_GET["sort"] == "asc") {
		$href_label = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=label_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by customlabel ASC";
	}
	$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_m&sort=desc";
	if ($_GET["sortname"]=="price_m" && $_GET["sort"] == "desc") {
		$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by price DESC";
	}
	if ($_GET["sortname"]=="price_m" && $_GET["sort"] == "asc") {
		$href_price = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=price_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by price ASC";
	}	
	$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_m&sort=desc";
	if ($_GET["sortname"]=="cost_m" && $_GET["sort"] == "desc") {
		$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by costprice DESC";
	}
	if ($_GET["sortname"]=="cost_m" && $_GET["sort"] == "asc") {
		$href_cost = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=cost_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by costprice ASC";
	}
	$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_m&sort=desc";
	if ($_GET["sortname"]=="shipping_m" && $_GET["sort"] == "desc") {
		$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by shippingcost DESC";
	}
	if ($_GET["sortname"]=="shipping_m" && $_GET["sort"] == "asc") {
		$href_shipping = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=shipping_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by shippingcost ASC";
	}
	$href_fvf = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=fvf_m&sort=desc";
	if ($_GET["sortname"]=="fvf_m" && $_GET["sort"] == "desc") {
		$href_fvf = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=fvf_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by fvf DESC";
	}
	if ($_GET["sortname"]=="fvf_m" && $_GET["sort"] == "asc") {
		$href_fvf = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=fvf_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by fvf ASC";
	}
	$href_jl5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=jl5_m&sort=desc";
	if ($_GET["sortname"]=="jl5_m" && $_GET["sort"] == "desc") {
		$href_jl5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=jl5_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by jl5 DESC";
	}
	if ($_GET["sortname"]=="jl5_m" && $_GET["sort"] == "asc") {
		$href_jl5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=jl5_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by jl5 ASC";
	}
	$href_paypalfee = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=paypalfee_m&sort=desc";
	if ($_GET["sortname"]=="paypalfee_m" && $_GET["sort"] == "desc") {
		$href_paypalfee = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=paypalfee_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by paypalfee DESC";
	}
	if ($_GET["sortname"]=="paypalfee_m" && $_GET["sort"] == "asc") {
		$href_paypalfee = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=paypalfee_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by paypalfee ASC";
	}
	$href_netprofit = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=netprofit_m&sort=desc";
	if ($_GET["sortname"]=="netprofit_m" && $_GET["sort"] == "desc") {
		$href_netprofit = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=netprofit_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by netprofit DESC";
	}
	if ($_GET["sortname"]=="netprofit_m" && $_GET["sort"] == "asc") {
		$href_netprofit = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=netprofit_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by netprofit ASC";
	}
	$href_morethan5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=morethan5_m&sort=desc";
	if ($_GET["sortname"]=="morethan5_m" && $_GET["sort"] == "desc") {
		$href_morethan5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=morethan5_m&sort=asc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by morethan5 DESC";
	}
	if ($_GET["sortname"]=="morethan5_m" && $_GET["sort"] == "asc") {
		$href_morethan5 = "//www.casinkadmin.com/liang/ebayproject/totalactivelist.php?sortname=morethan5_m&sort=desc";
		$sql = "SELECT customlabel, price, costprice, shippingcost, fvf, jl5, paypalfee, netprofit, morethan5 FROM ebay_profit order by morethan5 ASC";
	}
	
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		echo '<table border="1px">';
		echo '<tr>';
		echo '<td style="width:450px"><a title="Sort" href='.$href_label.'><b>Custom label<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_price.'><b>Price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_cost.'><b>Cost price<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_shipping.'><b>Shipping cost<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_fvf.'><b>Ebay FVF<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_jl5.'><b>JL 5% commission<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_paypalfee.'><b>Paypal fee<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_netprofit.'><b>Net Profit<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '<td style="width:150px"><a title="Sort" href='.$href_morethan5.'><b>More than $5 Profit<img src=' .$sort_img . ' alt="Ascending" title="Ascending" id="s_asc" height="12" width="12"></a></td>';
		echo '</tr>';
		while($array = mysql_fetch_array($result)) {
			if ($array['morethan5']=="N") echo "<tr bgcolor='#FF0000'>";
			else echo "<tr>";
			echo "<td>" . $array['customlabel'] . "</td>";
			echo "<td>" . $array['price'] . "</td>";
			echo "<td>" . $array['costprice'] . "</td>";
			echo "<td>" . $array['shippingcost'] . "</td>";
			echo "<td>" . $array['fvf'] . "</td>";
			echo "<td>" . $array['jl5'] . "</td>";
			echo "<td>" . $array['paypalfee'] . "</td>";
			echo "<td>" . $array['netprofit'] . "</td>";
			echo "<td>" . $array['morethan5'] . "</td>";
			echo "</tr>";			
		}
		echo "</table>";
	} else { echo "No data in DB.<br>";}	
}

function diffMerge() {
	$sql = "SELECT a.customlabel, t.price, a.costprice, a.shippingcost FROM ebay_tmpa as a left JOIN ebay_tmpt as t ON a.customlabel2=t.customlabel2 union SELECT t.customlabel, t.price, a.costprice, a.shippingcost FROM ebay_tmpa as a right JOIN ebay_tmpt as t ON a.customlabel2=t.customlabel2";
	$result = mysql_query($sql);
	$row = mysql_num_rows($result);
	if ($row>=1) {
		echo '<table border="1px">';
		echo '<tr>';
		echo '<td style="width:450px"><b>Custom label</td>';
		echo '<td style="width:150px"><b>Price</td>';
		echo '<td style="width:150px"><b>Cost price</td>';
		echo '<td style="width:150px"><b>Shipping cost</td>';
		echo '</tr>';
		while($array = mysql_fetch_array($result)) {
			//if ($net_profit > 5) $more_than_5 = "Y";
			if ($array['price']=='' || $array['costprice']=='') {
				echo "<tr>";
				echo "<td>" . $array['customlabel'] . "</td>";
				echo "<td>" . $array['price'] . "</td>";
				echo "<td>" . $array['costprice'] . "</td>";
				echo "<td>" . $array['shippingcost'] . "</td>";
				echo "</tr>";
			}
		}
		echo "</table>";
	} else { echo "No data in DB.<br>";}		
}


mysql_close($conn);
?>	
	
	</form>	
</body>
<script>
function initial() {
    var table = document.getElementById("tab-activelist");
    var rows = table.rows; // or table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
		rows[i].style.backgroundColor='#FFFFFF';
	}
}

function deleterow()
{
	document.getElementById("tab-activelist2").deleteRow(0);
}

function insertrow(colum1, colum2, colum3, colum4, n)
{
	var table = document.getElementById("tab-activelist2");
	
	for (var i=0; i<n; i++) {	
		var row = table.insertRow(0);
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		cell1.innerHTML = "no data";
		cell2.innerHTML = "no data";
		cell3.innerHTML = "no data";
		cell4.innerHTML = "no data";
		row.style.visibility = "hidden";
	}
	var row = table.insertRow(n);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	cell1.innerHTML = "Custom label";
	cell2.innerHTML = "Cost price";
	cell3.innerHTML = "Shipping cost";
	cell4.innerHTML = "Time";
	
	var row = table.insertRow(n+1);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	cell1.innerHTML = colum1;
	cell2.innerHTML = colum2;
	cell3.innerHTML = colum3;
	cell4.innerHTML = colum4;
}

function insertrow(data, pos) {
	var div2 = document.getElementById("div-activelist2");
	//div_list2.top = pos.top;
	//alert(pos.top);
	//$('#div-activelist2').top = pos.top;
	div2.style.top = pos.top;
	var table = document.getElementById("tab-activelist2");

	var row = table.insertRow(0);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	cell1.innerHTML = "<b>Custom label";
	cell2.innerHTML = "<b>Cost price";
	cell3.innerHTML = "<b>Shipping cost";
	cell4.innerHTML = "<b>Time";
	
	var items = data.split("#t#");
	for (var i=0; i<items.length-1; i++) {
		var row2 = items[i].split("#n#");
		//alert(row2);
		var customlabel = row2[0];
		var costprice = row2[1];
		var shippingcost = row2[2];
		var time = row2[3];
		
		var row = table.insertRow(i+1);
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		cell1.innerHTML = customlabel;
		cell2.innerHTML = costprice;
		cell3.innerHTML = shippingcost;
		cell4.innerHTML = time;
	}

}

function showDetail() {
    var table = document.getElementById("tab-activelist");
	if (table) {
    var rows = table.rows; // or table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
        rows[i].onclick = (function() {
            var cnt = i; 
			//$('#tab-activelist2').style.display="inline-block";
			//document.getElementById('tab-activelist2').style.display="inline-block";
            return function() {
				var current_pos = $(this).position();
				//alert("Top position: " + current_pos.top + " Left position: " + current_pos.left);
				initial();
				$(this).attr("style","background-color: #FFFF00;");
				var rowCount = document.getElementById('tab-activelist2').rows.length;
				for (var i=0; i<rowCount; i++) deleterow();
				//alert("row"+cnt+" data="+this.cells[0].innerHTML);
				var rowi = this.cells[0].innerHTML;
				//document.getElementById('tab-activelist2').style.display="inline-block";
				jQuery.post("http://www.casinkadmin.com/liang/ebayproject/getRow.php",
					{urow: rowi}, 
					function(data){ 
					insertrow(data, current_pos);
					/*	
						var items = data.split("#t#");
						for (var i=0; i<items.length-1; i++) {
							var row2 = items[i].split("#n#");
							//alert($row2);
							var customlabel = row2[0];
							var costprice = row2[1];
							var shippingcost = row2[2];
							var time = row2[3];
							insertrow(customlabel, costprice, shippingcost, time, cnt);
						}
					*/
					}
				);	

			  //insertrow();
            }    
        })(i);
    }
	}
}

function initial_ebay() {
    var table = document.getElementById("tab-ebay");
	if (table) {
    var rows = table.rows; // or table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
		rows[i].style.backgroundColor='#FFFFFF';
	}
	}
}
function heighlight_ebay() {
    var table = document.getElementById("tab-ebay");
	if (table) {
    var rows = table.rows; // or table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
        rows[i].onclick = (function() {
            return function() {
				initial_ebay();
				$(this).attr("style","background-color: #FFFF00;");
            }    
        })(i);
    }
	}
}

$(document).ready(function(){
	showDetail(); 	
	heighlight_ebay();
});

</script>
</html>
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
</style>
</head>

<body>
	<h2>Add Active List (can overide the same custom label)</h2>

	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/activelist.php">
	<table>
		<tr>
			<td style="width:450px"><b>custom label</td>
			<td style="width:150px"><b>cost price</td>		
			<td style="width:150px"><b>shipping cost</td>
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
	
	$sql = "SELECT * FROM ebay_activelist where customlabel='$customlab'";
	//$result = mysql_query($sql);
	$row = mysql_num_rows(mysql_query($sql));
	if ($row > 0) {
		$sql = "update ebay_activelist set costprice=$costprice, shippingcost=$shipprice, time=now() where customlabel='$customlab'";
		if( mysql_query($sql) ) echo "'" .$customlab ."'" ." updated! <br>";
		else echo "'" .$customlab ."'" ." updated no success. <br>";
	}
	else {
		$sql = "insert into ebay_activelist (id, customlabel, costprice, shippingcost, time) values(0, '$customlab', $costprice, $shipprice, now())";
		if( mysql_query($sql) ) echo "'" .$customlab ."'" ." added! <br>";
		else echo "'" .$customlab ."'" ." added no success. <br>";
	}
}
?>
	
	<hr>
	<h2>Search in the DB</h2>
	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/activelist.php">
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
		$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist where customlabel like '%$customlab%' and (costprice>=$costprice1 and costprice<=$costprice2) and (shippingcost>=$shipprice1 and shippingcost<=$shipprice2)";
	}
	else if ($is_input_costprice>0) {
		//echo "input the costprice. <br>";
		$costprice1 = (float)$_POST["scostprice"] - 0.01;
		$costprice2 = (float)$_POST["scostprice"] + 0.01;
		//echo $costprice1 . ", " . $costprice2 . "<br>";
		echo "cost price: " .$_POST["scostprice"] ."<br>";
		$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist where customlabel like '%$customlab%' and (costprice>=$costprice1 and costprice<=$costprice2)";
	}
	else if ($is_input_shipprice>0) {
		//echo "input the shipprice. <br>";
		$shipprice1 = (float)$_POST["sshipprice"] - 0.01;
		$shipprice2 = (float)$_POST["sshipprice"] + 0.01;
		//echo $shipprice1 . ", " . $shipprice2 . "<br>";
		echo "shipping cost: " .$_POST["sshipprice"] ."<br>";
		$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist where customlabel like '%$customlab%' and (shippingcost>=$shipprice1 and shippingcost<=$shipprice2)";
	} else {
		$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist where customlabel like '%$customlab%'";
	}
	//echo $sql . "<br>";

	$result = mysql_query($sql);
	$row = mysql_num_rows($result);	

	if ($row>0) {
?>	
<table border="1px">
	<tr>
		<td style="width:450px"><b>custom label</td>
		<td style="width:150px"><b>cost price</td>
		<td style="width:150px"><b>shipping cost</td>
	</tr>
<?php
	while($array = mysql_fetch_array($result)) {
		echo "<tr>";
		echo "<td>" . $array['customlabel'] . "</td>";
		echo "<td>" . $array['costprice'] . "</td>";
		echo "<td>" . $array['shippingcost'] . "</td>";
		echo "</tr>";
	}
	} else { echo " Not found in db. <br>";}
}
?>
</table>

	<hr>
	<h2>Modify the data</h2>
	<form method="post" action="http://www.casinkadmin.com/liang/ebayproject/activelist.php">
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
		// new customlab doesn't exist in the db
		// old customlab doesn't exist in the db
		if ($row_new>0) {
			echo "Cannot modify. " . "'" .$mcustomlab_new . "'" ." exist in the DB.";
		}
		else if ($row_old<=0) {
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
	<h2>Latest Active List</h2>
	
<?php
// show the latest data from db
$sql = "SELECT customlabel, costprice, shippingcost FROM ebay_activelist order by customlabel";
$result = mysql_query($sql);
$row = mysql_num_rows($result);
if ($row>=1) {
?>	
<table border="1px">
	<tr>
		<td style="width:450px"><b>custom label</td>
		<td style="width:150px"><b>cost price</td>
		<td style="width:150px"><b>shipping cost</td>
	</tr>
<?php
	while($array = mysql_fetch_array($result)) {
		echo "<tr>";
		echo "<td>" . $array['customlabel'] . "</td>";
		echo "<td>" . $array['costprice'] . "</td>";
		echo "<td>" . $array['shippingcost'] . "</td>";
		echo "</tr>";
	}
?>
</table>
<?php
} else {
	echo "No data in DB.<br>";
}

mysql_close($conn);
?>
</body>
<script>
$(document).ready(function(){

});

</script>
</html>
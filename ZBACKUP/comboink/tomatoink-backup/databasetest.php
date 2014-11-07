<?php
	require_once 'database.php';
?>
<html>
<head>
</head>

<body>


<h1>PHP Exercise -- LiangFang</h1>


<?php
	$username = "DBCOMPANDSAVE";
	$password = "CAS123cas!";
	$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
	$databasename = "DBCOMPANDSAVE";
   
	$db = new Mysql($hostname, $username, $password, $databasename);
	$db->connect();
	$select = $db->select("test", NULL);
    $row = $db->rows($select);
    if($row>=1){
?>
<h2>Show the data from database</h2>
<table border="1px">
    <tr>
        <th>id</th>
        <th>name</th>
    </tr>
<?php
    while($array = $db->myArray($select)){
        echo "<tr>";
        echo "<td>".$array['id']."</td>";
        echo "<td>".$array['name']."</td>";

        echo "</tr>";
    }
?>
</table>
<?php
    }else{
        echo "Cannot find any data!";
    }
      
    $db->dbClose();
?>


</body>

</html>


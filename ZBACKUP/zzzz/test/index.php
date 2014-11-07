<html>

<body>

<h1>It don't works!</h1>

<?php

$connect=mysql_connect("localhost", "liangfan", "fl86727");
if(!$connect) echo "Mysql Connect Error!";
else echo "欢迎访问PHP网站开发教程网-www.leapsoul.cn";
mysql_close();

//phpinfo()
?>

</body>

</html>


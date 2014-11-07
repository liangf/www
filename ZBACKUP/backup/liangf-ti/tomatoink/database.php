<?php
header('Access-Control-Allow-Origin: http://www.tomatoink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
  class Mysql {
	private $host;
	private $username;
	private $password;
	private $database;
	private $conn;

	function __construct($host,$username,$password,$database) {
	  $this->host = $host;
	  $this->username = $username;
      $this->password = $password;
      $this->database = $database;
      //$this->connect();
	}

	function connect() {
	  $this->conn = mysql_connect($this->host,$this->username,$this->password) or die("DB Connnection Error !".mysql_error());
      mysql_select_db($this->database,$this->conn);
      //mysql_query("set names utf8");
	}
         
	function dbClose() {
      mysql_close($this->conn);
	}

	function query($sql) {
      return mysql_query($sql);
	}
        
	function myArray($result) {
      return mysql_fetch_array($result);
	}
        
	function rows($result) {
      return mysql_num_rows($result);
	}
  }
?>  
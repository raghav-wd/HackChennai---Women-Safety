<?php
session_start();
include "dbh.php";

$lat=$_POST["lat"];
$longi=$_POST["longi"];
$uid=$_POST["uid"];

$sql="UPDATE `users` SET lat='$lat',longi='$longi' WHERE uid='$uid'";
mysqli_query($conn,$sql);

echo '{"status":"x"}';
?>
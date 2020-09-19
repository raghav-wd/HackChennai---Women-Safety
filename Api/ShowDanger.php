<?php

include "dbh.php";

$uid=$_POST['uid'];
$dmsg=$_POST['dmsg'];

$sql="UPDATE `users` SET noti=1,dmsg='$dmsg' WHERE uid='$uid'";
mysqli_query($conn,$sql);

echo '{"status":"x"}';
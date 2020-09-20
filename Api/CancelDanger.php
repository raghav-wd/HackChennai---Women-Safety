<?php

include "dbh.php";

$uid=$_POST['uid'];

$sql="UPDATE `users` SET noti=0 WHERE uid='$uid'";
mysqli_query($conn,$sql);

echo '{"status":"x"}';
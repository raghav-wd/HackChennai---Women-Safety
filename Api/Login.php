<?php

include "dbh.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$email=$obj['email'];
$pass=$obj['pass'];

$sql="SELECT * FROM users WHERE email='$email' AND password='$pass'";

$result=mysqli_query($conn,$sql);

header('Content-Type: application/json');
if(mysqli_num_rows($result)>0){
	while($row=mysqli_fetch_assoc($result)){
		echo json_encode($row);
	}
}else{
	//$myobj->uid="-1";
	$str='{"uid":"-1","user":"XXX","email":"XXX@XXX","password":"XXX","lat":"0","longi":"0","place":"","noti":""}';
    echo $str;
}
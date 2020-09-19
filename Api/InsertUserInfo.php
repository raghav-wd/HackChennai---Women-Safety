<?php
session_start();
include "dbh.php";

$name=$_POST["name"];
$email=$_POST["email"];
$pass=$_POST["pass"];


$sql="INSERT INTO users (user,email,password) VALUES ('$name','$email','$pass')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

?>
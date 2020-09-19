<?php

include "dbh.php";

// $lat=$_POST['lat'];
// $longi=$_POST['longi'];
// $dist=$_POST['dist'];

// $lat=37.421998333333335;
// $longi=-122.08400000000002;
// $dist=12327;


// $json = file_get_contents('php://input');
// $obj = json_decode($json,true);

$lat=$_POST['lat'];
$longi=-$_POST['longi'];
$dist=$_POST['dist'];

$c=0;
$flag=0;

$distance="SELECT uid,user,lat,longi,place, 
   111.111 *
    DEGREES(ACOS(LEAST(1.0, COS(RADIANS(lat))
         * COS(RADIANS('$lat'))
         * COS(RADIANS(longi - '$longi'))
         + SIN(RADIANS(lat))
         * SIN(RADIANS('$lat'))))) AS distance_in_km
  FROM users";

$result=mysqli_query($conn,$distance);
header('Content-Type: application/json');
if (mysqli_num_rows($result) > 0) 
{
    while($row = mysqli_fetch_assoc($result)) 
    {
    	if($row['distance_in_km']<$dist){
            $data[$c]=array(
                "uid"=>$row['uid'],
                "user"=>$row['user'],
                "lat"=>$row['lat'],
                "longi"=>$row['longi'],
                "dist"=>$row['distance_in_km']
            );
            $c+=1;
            $flag=1;
    	}
    }
    if($flag==0){
        $obj='{"uid": "-1", "user": "hell", "lat": "0", "longi": "0", "dist": "0"}';
        echo $obj;
    }else{
        echo json_encode($data);
    }
}

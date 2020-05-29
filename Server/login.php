<?php
 
    include("db_admin.php");
    $name = $_POST["name"];
    $password = $_POST["password"];
    if("USER_LOGIN" == $action){
        $db_data = array();
        $sql = "SELECT count(*) FROM $table WHERE name='$name' AND password='$password'";
        $result = $conn->query($sql);
        if($result->num_rows == 1){
            $row = $result->fetch_assoc();
            if($row["count(*)"]==1)
                echo json_encode("Success");
            else
                echo json_encode("Failure");
        }
        $conn->close();
        return;
    }
?>

<?php
    include("dbuser.php");

    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table ( 
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            first_name VARCHAR(30) NOT NULL,
            last_name VARCHAR(30) NOT NULL
            )";
 
        if($conn->query($sql) === TRUE){
            // send back success message
            echo json_encode("Success");
        }else{
            echo json_encode("Failure");
        }
        $conn->close();
        return;
    }
 
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT id, first_name, last_name from $table ORDER BY id ASC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo json_encode("Failure");
        }
        $conn->close();
        return;
    }
 
    if("ADD_USER" == $action){
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name', '$last_name')";
        $result = $conn->query($sql);
        echo json_encode("Success");
        $conn->close();
        return;
    }
 

    if("UPDATE_USER" == $action){
        // App will be posting these values to this server
        $id = (int)$_POST['id'];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = $id";
        if($conn->query($sql) === TRUE){
            echo json_encode("Success");
        }else{
            echo json_encode("Failure");
        }
        $conn->close();
        return;
    }
 

    if('DELETE_USER' == $action){
        $id = (int)$_POST['id'];
        $sql = "DELETE FROM $table WHERE id = $id"; 
        if($conn->query($sql) === TRUE){
            echo json_encode("Success");
        }else{
            echo json_encode("Failure");
        }
        $conn->close();
        return;
    }
 
?>

<?php

$servername = "localhost";
$username = "root";
$password = "S@thya123";
$dbname = "Test";
$table = "user";

// we will get actions from the app to do operations in the database...
$action = $_POST["action"];

// Create Connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check Connection
if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
    return;
}

?>
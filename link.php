<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "employmentDB";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

if(isset($_POST['save'])) {
  $name = $_POST['name'];
  $company = mysqli_real_escape_string($conn, $_POST['company']);
  $email = $_POST['email'];
  $number = $_POST['phone'];
  $type = $_POST['type'];

  $sql = "INSERT INTO `employment` (`name`, `company`, `email`, `number`, `type`)
          VALUES ('$name', '$company', '$email', '$number', '$type')";

  if ($conn->query($sql) === TRUE) {
    echo '<script type="text/javascript"> alert("Data Saved"); 
          location.href="./index.html"</script>';
  } else {
    echo '<script type="text/javascript"> alert("Data Not Saved"); 
          location.href="./index.html"</script>';
  }
} else {
  header("location:./BrainsterLabs.html");
}

// Close connection
$conn->close();
?>

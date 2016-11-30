<?php

require_once("../../../src/framework/Util.php");

$target_dir = Utilities::getPartnerFileRoot();
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = true;
$imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);

// TODO - There is absolutely no security implemented here!! (For pilot)

/*
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        echo "File is an image - " . $check["mime"] . ".";
        $uploadOk = true;
    } else {
        echo "File is not an image.";
        $uploadOk = false;
    }
}

// Check if file already exists
if (file_exists($target_file)) {
    echo "Sorry, file already exists.";
    $uploadOk = false;
}

// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
    echo "Sorry, your file is too large.";
    $uploadOk = false;
}

// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
    echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = false;
}
*/

// Check if $uploadOk is set to 0 by an error
if (!$uploadOk) {
    echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
} else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
}
?> 
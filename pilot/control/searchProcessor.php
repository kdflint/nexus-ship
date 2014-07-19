<?php

include("util/db.php");
include("util/util.php");

$string = $_POST['string'];

header("location:../view/nexus.php?thisPage=directory&newSearch=" . $string);

?>
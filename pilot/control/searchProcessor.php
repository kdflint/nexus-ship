<?php

include("util/db.php");
include("util/util.php");

$string = $_POST['string'];
$filter = "";

if ($_POST['topic'] > 1) {
	$filter = $_POST['topic'];
}

header("location:../view/nexus.php?thisPage=directory&newSearch=" . $string . "&filter=" . $filter);

?>
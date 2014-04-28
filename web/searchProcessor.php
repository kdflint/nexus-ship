<?php

include("util/db.php");
include("util/util.php");

$string = Util::clean($_POST['string']);

header("location:nexus.php?thisPage=directory&newSearch=" . $string);


?>
<?php

include("util/db.php");
include("util/util.php");

$string = $_POST['string'];
$filter = "";

if ($_POST['topic'] > 0) {
	$filter = $_POST['topic'];
}

// TODO: Add actions here

// if action == new search - generate a seperate results file
//      location:../view/nexus.php?thisPage=directory&results=<uuid>
//      page loads with include to results uuid file
//					each result link POSTS an org id via javascripts back to here with action = detail

// if action == detail - generate a detail record
//      location:../view/nexus.php?thisPage=directory&detail=<uuid>
//      page loads with include to detail uuid file
//          Results link is active now, to results=<uuid>
//          Detail link is never active - always a requery to get back there

// if action == message - fire messages to indicated user ids

/*


Sunday

1 - 1. Refactor results as above 

2 - 2. Do above with very basic detail record

2 - 3. Write script to add message names to To field of message box

2 - 4. Add text box to message box, Submit, send messages 

/*

<!DOCTYPE html>
<html>
<head>
<script>
function myFunction()
{
var x=document.getElementById("fname");
x.value=x.value.toUpperCase();
}

function myFunction2(String name)
{
var x=document.getElementById("ToField");
x.value=name;
}
</script>
</head>
<body>

Enter your name: <input type="text" id="fname" onchange="myFunction()">
<p>When you leave the input field, a function is triggered which transforms the input text to upper case.</p>

Enter your name: <input type="checkbox" id="asdf" onchange="myFunction2("Name")">
<p>When you check the box, a function is triggered which transforms the input text to XXX.</p>

</body>
</html>

*/



*/


header("location:../view/nexus.php?thisPage=directory&freeSearch=" . $string . "&filter=" . $filter);

?>
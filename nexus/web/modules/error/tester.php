<?php

// This script will produce errors of varying types
// Include this file at some location to test the outcome of the various errors

// trigger some errors, first define a mixed array with a non-numeric item
//echo "vector a\n";
$a = array(2, 3, "foo", 5.5, 43.3, 21.11);
//print_r($a);

// now generate second array
//echo "----\nvector b - a notice (b = log(PI) * a)\n";
/* Value at position $pos is not a number, using 0 (zero) */
$b = scale_by_log($a, M_PI);
//print_r($b);

// this is trouble, we pass a string instead of an array
//echo "----\nvector c - a warning\n";
/* Incorrect input vector, array of values expected */
$c = scale_by_log("not array", 2.3);
//var_dump($c); // NULL

// this is a critical error, log of zero or negative number is undefined
//echo "----\nvector d - fatal error\n";
/* log(x) for x <= 0 is undefined, you used: scale = $scale" */
$d = scale_by_log($a, -2.5);
//var_dump($d); // Never reached

function scale_by_log($vect, $scale)
{
    if (!is_numeric($scale) || $scale <= 0) {
        trigger_error("log(x) for x <= 0 is undefined, you used: scale = $scale", E_USER_ERROR);
    }

    if (!is_array($vect)) {
        trigger_error("Incorrect input vector, array of values expected", E_USER_WARNING);
        return null;
    }

    $temp = array();
    foreach($vect as $pos => $value) {
        if (!is_numeric($value)) {
            trigger_error("Value at position $pos is not a number, using 0 (zero)", E_USER_NOTICE);
            $value = 0;
        }
        $temp[$pos] = log($scale) * $value;
    }

    return $temp;
}

?>
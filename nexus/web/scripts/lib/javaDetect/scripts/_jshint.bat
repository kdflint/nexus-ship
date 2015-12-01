@echo off 
REM Run jshint on input Javascript file


jshint --verbose --config "%~dp1$.jshintconfig" %1 > "%~dpn1_jshint.js" 2>&1


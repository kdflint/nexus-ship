<?php
header("Content-Type: text/css");
header("Cache-Control: max-age=604800, public");

session_start();

?>

/* CORE LAYOUT                                                                    *
 * http://matthewjamestaylor.com/blog/keeping-footers-at-the-bottom-of-the-page   */

html {
	height: 95%;
}

body { 
	color:#333333;
	font-family:'Oxygen',sans-serif; 
	//text-align:center; 
	background-color: #ffffff;
	height: 100%;
}

.priv-1 {
	display: none;
}

.container {
	/* top level container for all content, left aligned inside a centered body   *
	 * optimized for a tablet -kdf																								*/
	position: relative;
	min-height: 100%;
	width: 900px;
	margin: 0px auto;
	text-align: left;
}

.header {
}

.banner {
	position:absolute;
	width:78%;
	height: 96px;
	padding:0px;
	margin-top:10px;
	border-bottom-right-radius: 6px;
	background: #ffffff; /* Old browsers */
	background: -moz-linear-gradient(top,  #ffffff 45%, #ffffff 70%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(45%,#ffffff), color-stop(70%,#ffffff)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #ffffff 45%,#ffffff 70%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #ffffff 45%,#ffffff 70%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #ffffff 45%,#ffffff 70%); /* IE10+ */
	background: linear-gradient(to bottom,  #ffffff 45%,#ffffff 70%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#ffffff',GradientType=0 ); /* IE6-9 */
}

.banner-image {
	float:left;
	margin-top:10px;
	border-top-left-radius:5px;
	border-bottom-left-radius:5px;
	width: 22px;
	height: 96px;
}

.frame {
	clear: both;
	padding-bottom: 60px;   /* Height of the footer */
	padding-top: 5px;
}

.adv-frame-contents {
	border: 1px solid #004d62 !important;
	width:100%;
	border-radius:10px;
}

.footer {
  position: absolute;
  bottom: 20px;
  height: 60px;
  width: 100%;
  text-align: right;
	font-family: Oswald;
	letter-spacing: 1px;
}

.loginColLeft {
	width:70%;
	float:left;
}

.loginColRight {
	width:30%;
	float:right;
	margin-top: 10px;
}

.frameColLeft {
	width:80%;
	float:left;
}

.frameColRight {
	width:20%;
	float:right;
}

.secondaryControlContainer {
	padding-top: 10px;
	padding-right: 10px;
	position: relative;
	margin-bottom: 22px;
}	

.secondaryControl, .secondaryControlDisabled {
	position: relative;
	float: right;
	margin-left: 20px;
	z-index: 10;
}

.secondaryControlDisabled {
	opacity: .5;
	pointer-events: none;
}


/* patterned from phpBB .dropdownContainer */
.tertiaryControlContainer {
	clear:both;
	float:right;
	font-size: 80%;
	position:relative;
	background: #ffffff;
	border-color: #dae0bc;
	box-shadow: 1px 3px 5px rgba(137, 157, 112, 0.5);
	z-index: 2;
	overflow: hidden;
	overflow-y: auto;
	border: 1px solid transparent;
	border-radius: 5px;
	margin-top: 10px;
	padding: 5px;
	position: relative;
	//min-width: 40px;
	width: 160px;
	max-height: 300px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.controlCol { 
	position:absolute;
	left:0px;
	width:280px;
	height:400px;
	margin-top:10px; 
}

.displayCol { 
	position:absolute;
	left:290px;
	width:630px;
	height:400px;
	margin-top:10px;
	border: 1px solid #A6C3CE !important;
	border-radius:10px;
	overflow:auto; 
}

.displayDetail { 
	font-size:90%;
}

.modal-form {
	position: relative;
	width: 100%;
	height: 380px;
}

.modal-form > fieldset:nth-of-type(1) {
	position: relative;
	width: 380px;
}

.modal-form > fieldset:nth-of-type(2) {
	position: absolute;
	left: 410px;
	width: 390px;
	top: 0px;
}

.modal-form > fieldset:nth-of-type(3) {
	position: absolute;
	bottom: 0px;
	right: 0px;
}

.profileBlock1 {
	position:absolute;
	left:15px;
	width:420px;
	height:400px;
	margin-top: -10px;
}	

.profileBlock2 {
	position:absolute;
	left:460px;
	height:400px;
	margin-top: -10px;
}	

.profileBlock3 {
	position:absolute;
	width:96%;
	top:300px; 
}

.profileBlock4 {
	position: absolute;
	bottom: 20px;
	right: 10px;
}

.profileFormRow {
	margin-top:5px;
	position: relative;
}

.profileCol1 {
	position:absolute;
	left: 15px;
	width: 160px;
}

.profileCol2 {
	position:absolute;
	left: 170px;
}

.messageCol1 {
	position:absolute;
	left: 15px;
	width: 160px;
}

.messageCol2 {
	position:absolute;
	left: 170px;
}

.messageCol3 {
	position:absolute;
	left: 460px;
}

.messageCol4 {
	position:absolute;
	left: 500px;
}

/* TEXT */

.instruction {
	font-size:90%;
}

.confirmation {
	font-size:90%;
	color:#007582;
	width:90%;
}

.required {
	color: #f68620;
	font-weight: bold;
	vertical-align: top;	
}

.product-name {
	font-family:Oswald;
	font-size:230%;
	margin-left: 10px;
	color: #486326;
	opacity: .5;
}

.module-name {
	font-size:170%;
	margin-left: 30px;
	color: #004d62;
	font-weight: bold;
	position: absolute;
	padding-top: 5px;
}


/* LINKS */

a {
	color:#d27b4b;
	text-decoration:none;
}

/* FORMS */

form {
	width:95%;
}

.form-instruction {
	float:right;
	margin-right:25px;
}

.form-input {
	width:95%;
	margin-bottom:20px !important;
}

.form-field {
	margin-top:10px;
	margin-left:15px;
}

/* BUTTONS */

#compose_pm {
	font-size: 80%;
	margin-left: 40px;
	float:left;
}

.pure-button-primary {
	background: rgba(0, 77, 98, 1) !important;
	margin-right: 10px;
}

.pure-button-secondary {
	background: rgba(0, 77, 98, .2)!important;
	margin-right: 10px;
}

.pure-button:hover {
}

.button-schedule,
.button-join {
  color: white;
  border-radius: 6px;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
}

.button-schedule {
	background: rgba(0, 77, 98, 1);
	width: 45%
}

.button-join {
	background: rgba(0, 77, 98, .6);
	width: 45%
}
 		
.button-schedule:hover {
	background: #a6c3ce;
}
   	
.button-join:active {
	background: #a6c3ce;
}

.button-menu,
.button-menu-adv {
  border-radius: 6px;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
  color: #004D62;
  font-size: 110%;
	margin-top: 5px;
	width: 120px;
	padding: .35em;
}

.button-menu-adv {
	width:115px;
}

.button-menu-adv:hover {
	border-right:3px solid #d27b4b;
}

.guest-pass-button,
.show-pass-button {
	font-size:90%;
}

.join_meeting_button {
  background-color: #d27b4b;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  font-weight: bold;
  margin-top: 10px;
  margin-left: 550px !important;
  /*transition: 0.5s;*/
  border-radius: 6px;
  opacity: .9;
  box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
}

.join_meeting_button:hover {
  /*background-color: #f7f8ef;*/
  /*background-color: #d27b4b;*/
  /*color: #d27b4b;*/
  opacity: 1;
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}

/* DATE */

.event, .user {
  width: 110px;
  color: rgba(0, 77, 98, 1);
  text-align: center;
  padding-right:10px;
  border-right:1px solid #a6c3ce;
 }
 
.day, .date, .month, .fname, .lname, .time {
  padding-top: 5px;
}
 
.day, .lname { 
  font-size: 90%;
}
  
.date, .fname { 
  font-size: 150%;
}
  
.fname125 { 
  font-size: 125%;
}
  
.fname110 { 
  font-size: 105%;
  font-weight: bold;
  letter-spacing: .5px;
}
 
.fname90 { 
  font-size: 85%;
  font-weight: bold;
  letter-spacing: .5px;
}

.month, .descr { 
	font-size: 90%;
  }
  
.period {
	font-size: 80%;
	text-align: bottom;
} 
 
#schedule-form-country-button, #schedule-form-countryTimeZones-button {
	vertical-align: middle;
}

.level1-control {
	position: absolute;
	margin-left: 650px;
	padding-top: 20px;
	z-index:10;
}

/* TABLES */

table, .table-div {
    border-collapse: separate !important; /* IE7 and lower */
    border: 1px solid #a6c3ce !important;
    margin-bottom: 5px;
    width: 100%;
    border-radius: 10px;
    -moz-border-radius: 10px;
}

td {
	vertical-align: top;
}

td .techCheckCol2 {
	position: absolute;
	left: 320px;
}

td .techCheckCol3 {
	position: absolute;
	left: 350px;
	width: 270px;
}

.pure-table td:first-child {
	width: 100px;
}

.pure-table td, .td-div {
	border-left: 0px !important;
	padding: 1em !important;
}

/* BLINDS */

.profile_display {
	background: #EDF0DE none repeat scroll 0% 0%;
	padding: 10px;
	height: 315px;
	position: absolute;
	border-radius: 8px;
	margin-left: 10px;
	width: 160px;
	border: 2px solid #a6c3ce;
}
 
/* LIGHTBOXES */

.black_overlay{
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 5000px;
	height: 2000px;
	background-color: black;
	z-index:1001;
	-moz-opacity: 0.8;
	opacity:.80;
	filter: alpha(opacity=80);
}

.white_content {
	display: none;
	position: absolute;
	top:35%;
	left:35%;
	width:450px;
	min-height:230px;
	padding: 10px;
	border: thin solid #bf6030;
	border-radius:15px;
	background-color: white;
	z-index:1002;
	overflow: visible;
	text-align:left;
}

/* TOOLTIPS */

a.tooltip {outline:none; }

a.tooltip span:first-child {
    z-index:20;display:none; padding:14px 20px;
    margin-top:-30px; margin-left:28px;
    width:460px; line-height:16px;  
}

a.tooltip:hover, tooltip-hover {text-decoration:none;}

a.tooltip:hover span:first-child, tooltip-hover {
    display:inline; position:absolute;
    color:#111;
    border:1px solid #DCA; background:#f7f8ef;
}
    
.callout {
	z-index:20;position:absolute;top:30px;border:0;left:-12px;
}
    
/* CSS3 extras */
a.tooltip span:first-child
{
    border-radius:4px;
    box-shadow: 5px 5px 8px #CCC;
}


/* SCHEDULE PICKER */

.ui-front {
	z-index: 10001;
}


/* OR separator on login */

.or-separator {
    text-align: center;
    width: 330px;
    margin-bottom: 10px;
    background-image: url(../image/or-separator-line.png);
    background-repeat: no-repeat;
    background-position: center center;
}

.or-separator .or-separator-label {
    display: inline-block;
    padding: 4px;
    border: 2px solid #ccc;
    border-radius: 50%;
}

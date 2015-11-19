var errorBackground = "rgba(247,248,239,0.6) url('') no-repeat right top";

var techCheckSummaryHtml = "";

function flashInstalled() {
	return FlashDetect.installed;
}

function flashVersionCheck() {
	if (flashInstalled()) {
		return FlashDetect.versionAtLeast(11,2);
	} else {
		return false;
	}
}

function setTechCheckSummaryHtml() {
  if (!flashInstalled()) {	
		techCheckSummaryHtml = "<span class='fa fa-check-square-o' style='margin-right:10px;'></span>Your system is not compatible to participate in this meeting.</span><span style='margin-left:10px;' class='fa fa-info-circle' >";
  } else if (!flashVersionCheck()) {
		techCheckSummaryHtml = "<span class='fa fa-check-square-o' style='margin-right:10px;'></span>Your system is not compatible to participate in this meeting.</span><span style='margin-left:10px;' class='fa fa-info-circle' >";  	
	} else {
		techCheckSummaryHtml = "<span class='fa fa-check-square-o' style='margin-right:10px;'></span>Your system is compatible to participate in this meeting.</span><span style='margin-left:10px;' class='fa fa-info-circle' >";
	}
}

function getTechCheckSummaryHtml() {
	return techCheckSummaryHtml;
}

function formSubmit(formId) {
 		document.forms[formId].submit();
}



function isValidEmail(email) {
    var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
        return false;
    }
    return true;
}

function isSafeCharacterSet(set) {	
	if(set.indexOf('<') > -1 ||
		 set.indexOf('>') > -1 ||
		 set.indexOf('%') > -1 ||
		 set.indexOf('*') > -1 ||
		 set.indexOf('&') > -1 ||
		 set.indexOf('=') > -1 ||
		 set.indexOf('\/') > -1 ||
		 set.indexOf('\\') > -1 ||
		 set.indexOf('!') > -1) {
  	return false;
	}
	return true;
}

function toggleRememberCheckbox() {
	var loginRemember = document.getElementById("login-remember");
	var curState = loginRemember.checked;
	if(curState) {
		loginRemember.checked = false;
		document.getElementById("fakeCheckBox").className = "fa fa-square-o";
		document.getElementById("fakeCheckBox").style = "color:#004d62;padding-right:5px;"
	} else {
		loginRemember.checked = true;
		document.getElementById("fakeCheckBox").className = "fa fa-check-square-o";
		document.getElementById("fakeCheckBox").style = "color:#004d62;padding-right:4px;"
 	}
}

// TODO - combine these
function toggleAdminCheckbox() {
	var adminValue = document.getElementById("new-user-admin");
	var curState = adminValue.checked;
	if(curState) {
		adminValue.checked = false;
		document.getElementById("fakeCheckBox2").className = "fa fa-square-o";
		document.getElementById("fakeCheckBox2").style = "color:#004d62;padding-right:5px;"
	} else {
		adminValue.checked = true;
		document.getElementById("fakeCheckBox2").className = "fa fa-check-square-o";
		document.getElementById("fakeCheckBox2").style = "color:#004d62;padding-right:4px;"
 	}
}
    	
function toggleFormDisplay(formId) {
	var showForm = document.getElementById(formId);
	document.getElementById("login-form").style.display='none';
	document.getElementById("recover-username-form").style.display='none';
	document.getElementById("recover-password-form").style.display='none';
	showForm.style.display='block';
	document.getElementById("login-user-message").innerHTML = "";
}			

function recordActivity() {
	if(activityFlag) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	}
  	}
		xmlhttp.open("GET","src/framework/sessionManager.php");
		xmlhttp.send();  					
	}
	activityFlag = 0;
}

function toggleFrameDisplay(frameId) {
	var showFrame = document.getElementById(frameId);
	var showButton = document.getElementById('menu-' + frameId);
	document.getElementById("reserveList").style.display='none';
	document.getElementById("userList").style.display='none';
	document.getElementById("fatalError").style.display='none';
	document.getElementById("menu-userList").style.backgroundColor='rgba(210, 123, 75, 1)';
	document.getElementById("menu-reserveList").style.backgroundColor='rgba(210, 123, 75, 1)';
	showFrame.style.display='block';
	showButton.style.backgroundColor='rgba(137, 157, 112, 1)';
}

function getLocalTz() {
	// https://bitbucket.org/pellepim/jstimezonedetect
	var tz = jstz.determine();
	return tz.name();
}

function showTimeZoneDisplay(displayId) {
	var showDisplay = document.getElementById(displayId);
	document.getElementById("tz-static").style.display='none';
	document.getElementById("tz-select").style.display='none';	 
	showDisplay.style.display='block';
	if (displayId == 'tz-select') {
		document.getElementById("local-tzFormChange").value = "true";
		document.getElementById("schedule-form-country").selectedIndex = "0";
		$( "#schedule-form-country" ).selectmenu( "refresh" );
		displayTimeZones();
	} else {
		document.getElementById("local-tzFormChange").value = "false";
	}
}

function setTimeZoneDisplay(zone) {
  document.getElementById("local-tzDisplay").innerHTML = zone;
  document.getElementById("local-tzFormField").value = zone;
  showTimeZoneDisplay("tz-static");
}	

function displayTimeZones() {
	var timeZone = document.getElementById("schedule-form-countryTimeZones");
	var countryCode = document.getElementById("schedule-form-country").value;
	// TODO - this line clears previous selections - how does it work?
	for (a in timeZone.options) { timeZone.options.remove(0); }
  var countryTimeZones = timeZoneData[countryCode];
  var option = document.createElement("option");
  option.text = "Time Zone";
  option.selected = true;
  timeZone.add(option);
  if (countryTimeZones === undefined) {
  	// leave the time zone options list unpopulated
  	$( "#schedule-form-countryTimeZones" ).selectmenu( "refresh" );
  } else if (countryTimeZones.length == 1) {
  	// update display and form to show this one time zone option
  	setTimeZoneDisplay(Object.getOwnPropertyNames(countryTimeZones[0]));
  } else {
  	// add the time zone options to the time zone options list
  	for (var i=0; i<countryTimeZones.length; i++) {
	  	var option = document.createElement("option");
  		option.text = Object.getOwnPropertyNames(countryTimeZones[i]);
  		timeZone.add(option);
		}
    $( "#schedule-form-countryTimeZones" ).selectmenu( "refresh" );
  }
}

function isValidEmail(email) {
    var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
        return false;
    }
    return true;
}

function toggleTooltip(tip) {
	var curState = document.getElementById(tip).className;
	if (curState == "tooltip-hover") {
		document.getElementById(tip).className = "";
	} else {
		document.getElementById(tip).className = "tooltip-hover";
	}
}


// TODO - refactor these front validations scripts - way too redundant!

function loginValidateAndSubmit() {
		
	pass = true;
	var loginForm = document.forms["login-form"];
	var submitButton = document.getElementById("login-form-submit");
	
  var usernameField = loginForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
  if (username == null || username == "") {
    setFieldErrorStyles(usernameField, "Username is required.");
    pass = false;
  }
  
  var passwordField = loginForm["password"];
  var password = passwordField.value;
  setFieldPassStyles(passwordField, "");
  if (password == null || password == "") {
    setFieldErrorStyles(passwordField, "Password is required.");
    pass = false;
  }

 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		loginForm.submit();
 	}
}

function demoValidateAndSubmit() {
	
	pass = true;
	var loginForm = document.forms["login-form"];
	var submitButton = document.getElementById("login-form-submit");
	
  var usernameField = loginForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
  if (username == null || username == "") {
    setFieldErrorStyles(usernameField, "Name is required.");
    pass = false;
  }
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		loginForm.submit();
 	}
}

function usernameValidateAndSubmit() {
		
	pass = true;
	var usernameForm = document.forms["recover-username-form"];
	var submitButton = document.getElementById("username-form-submit");
	
  var emailField = usernameForm["email"];
  var email = emailField.value;
  setFieldPassStyles(emailField, "Email");
	pass = validateEmail(emailField);
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		usernameForm.submit();
 	}
}
 	
function passwordValidateAndSubmit() {
		
	pass = true;
	var passwordForm = document.forms["recover-password-form"];
	var submitButton = document.getElementById("password-form-submit");
	
  var usernameField = passwordForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
  if (username == null || username == "") {
    setFieldErrorStyles(usernameField, "Username is required.");
    pass = false;
  }
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		passwordForm.submit();
 	}

}

function inviteValidateAndSubmit() {

	pass = true;
	var inviteForm = document.forms["invite-form"];
	var submitButton = document.getElementById("invite-form-submit");
	
	var emailField = inviteForm["email"];
	setFieldPassStyles(emailField, "Email");
	pass = validateEmail(emailField);

 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.style.opacity = ".6";
 		inviteForm.submit();
 	}
}

function enrollValidateAndSubmit() {

	pass = true;
	var enrollForm = document.forms["enroll-form"];
	var submitButton = document.getElementById("enroll-form-submit");
  var re = /[0-9]/;
  var re2 = /\s/;

	var emailField = enrollForm["email"];
	setFieldPassStyles(emailField, "");
  if (!isValidEmail(emailField.value)) {
  	setFieldErrorStyles(emailField, "Valid email is required.");
  	emailField.value = "";
  	pass = false;
  }

  var usernameField = enrollForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
  if (username == null || username == "" || username.length < 7 || username.length > 25 || re2.test(username)) {
    setFieldErrorStyles(usernameField, "Valid username is required.");
    usernameField.value = "";
    pass = false;
  }		
	
  var passwordField = enrollForm["password1"];
  var password = passwordField.value;
  setFieldPassStyles(passwordField, "");
  if (password == null || password == "" || password.length < 7 || password.length > 25 || !re.test(password)) {
    setFieldErrorStyles(passwordField, "Valid password is required.");
    passwordField.value = "";
    pass = false;
  }
  
  var passwordField2 = enrollForm["password2"];
  var password2 = passwordField2.value;
  setFieldPassStyles(passwordField2, "");
  if (password2 == null || password2 == "" || password != password2) {
    setFieldErrorStyles(passwordField2, "Matching confirmation password is required.");
    passwordField2.value = "";
    pass = false;
  }	
  
  var fnameField = enrollForm["fname"];
  var fname = fnameField.value;
  setFieldPassStyles(fnameField, "");
  if (fname == null || fname == "" || fname.length > 25) {
    setFieldErrorStyles(fnameField, "Valid first name is required.");
    pass = false;
  }	
  	
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment";
 		submitButton.style.opacity = ".6";
 		enrollForm.submit();
 	}

}

function validateEmail(emailField) {
	var email = emailField.value;
	if (email == null || email == "") {
    setFieldErrorStyles(emailField, "Email is required.");
    return false;
  } else if (!isValidEmail(email)) {
    setFieldErrorStyles(emailField, "Valid email is required.");
    emailField.value = "";
  	return false;
  }
  return true;
}

function resetProfileForm() {
	var profileForm = document.forms['profile-form'];
	profileForm.reset();
	setFieldPassStyles(profileForm["password1"], "");
	setFieldPassStyles(profileForm["password2"], "");
	setFieldPassStyles(profileForm["fname"], "");
	setFieldPassStyles(profileForm["lname"], "");
	setFieldPassStyles(profileForm["email"], "");
}
		
function resetScheduleForm() {
	document.getElementById('schedule_control').click();
	var scheduleForm = document.forms['schedule-form'];
	scheduleForm.reset();
	setFieldPassStyles(scheduleForm['meeting-name'], "Purpose");
	setFieldPassStyles(scheduleForm['meeting-date'], "Date");
	setFieldPassStyles(document.getElementById("schedule-form-time-button"), "Time");
	setFieldPassStyles(document.getElementById("schedule-form-duration-button"), "Duration");
	setFieldPassStyles(document.getElementById("schedule-form-type-button"), "Meeting Type");
	$( "#schedule-form-time" ).selectmenu( "refresh" );
	$( "#schedule-form-duration" ).selectmenu( "refresh" );
	$( "#schedule-form-type" ).selectmenu( "refresh" );
	showTimeZoneDisplay("tz-static");
}

function resetNowForm() {
	document.getElementById('join_control').click();
	var nowForm = document.forms['now-form'];
	nowForm.reset();
	setFieldPassStyles(nowForm['meeting-name'], "Purpose");
	setFieldPassStyles(document.getElementById("now-form-duration-button"), "Duration");
	setFieldPassStyles(document.getElementById("now-form-type-button"), "Meeting Type");
	$( "#now-form-duration" ).selectmenu( "refresh" );
	$( "#now-form-type" ).selectmenu( "refresh" );
}

function resetInviteForm() {
	document.getElementById('add_user_control').click();
	var inviteForm = document.forms['invite-form'];
 	if (inviteForm["new-user-admin"].checked) {
 		toggleAdminCheckbox();
 	}
	inviteForm.reset();
	setFieldPassStyles(inviteForm['email'], "Email");
}

function profileValidateAndSubmit() {
	
	pass = true;
	var profileForm = document.forms['profile-form'];
	var submitButton = document.getElementById('profile-form-submit');
	
  var password1Field = profileForm["password1"];
  var password1 = password1Field.value;
  setFieldPassStyles(password1Field, "");
  
  var password2Field = profileForm["password2"];
  var password2 = password2Field.value;
  setFieldPassStyles(password2Field, "");
  
  if (password1 == null || password1 == "") {
  	// don't run any more password validations
  } else {
  	if (password1.length < 7 || password1.length > 25) {
  		setFieldErrorStyles(password1Field, "7-25 characters please");
  		password1Field.value = "";
   	 	pass = false;
   	}
    if (pass && (password2 == null || password2 == "")) {
    	setFieldErrorStyles(password2Field, "Please confirm your new password.");
    	pass = false;
  	}
  	if (pass && (password1 !== password2)) {
  		setFieldErrorStyles(password2Field, "Your passwords do not match.");
  		password2Field.value = "";
    	pass = false;
  	}
  }
   
  var fnameField = profileForm["fname"];
  var fname = fnameField.value;
  setFieldPassStyles(fnameField, "First Name");
  if (fname == null || fname == "") {
    setFieldErrorStyles(fnameField, "First name is required.");
    pass = false;
  }	  
  
  var emailField = profileForm["email"];
  var email = emailField.value;
  setFieldPassStyles(emailField, "Email");
	if (!validateEmail(emailField)) {
		pass = false;
	}
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		profileForm.submit();
 	}
}

function getMaxDaysForMonth(month) {
	switch(month) {
    case 4:
    case 6:
    case 9:
    case 11:
        return 30;
        break;
    default:
        return 31;
	} 
}

function getMaxDaysForFebruary(year) {
	switch(year%4) {
    case 0:
        return 29;
        break;
    default:
        return 28;
	} 
}
	
function eventValidateAndSubmit(thisForm) {
	pass = true;
	var eventForm = document.forms[thisForm];
	var submitButton = document.getElementById(thisForm + "-submit");	
	 
 	var timeField = eventForm['meeting-time'];
  var time = timeField.value;
	setFieldPassStyles(document.getElementById(thisForm + "-time-button"), "Time");
  if (time == null || time == "" || time == "Time") {
   	setFieldErrorStyles(document.getElementById(thisForm + "-time-button"), "Time");
    pass = false;
  }
   
	var dateField = eventForm['meeting-date'];
  var date = dateField.value;
  var re = /\d{2}\/\d{2}\/\d{4}/;
  var parts = new Array();
	setFieldPassStyles(dateField, "Date");
  if (date == null || date == "") {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  	dateField.value = "";
    pass = false;
	} else if (date == "today") { 
		// All is good - do nothing
	} else if (re.test(date)) {
  	 parts = date.split("/");
  	 var year = parseInt(parts[2], 10);
  	 var month = parseInt(parts[0], 10);
  	 var day = parseInt(parts[1], 10);
  	 if (
  	 			1 <= month && month <= 12 &&
  	 			1 <= day && day <= 31 &&
  	 			2000 <= year && year <= 2100
  	 ) {
  	 	if (day > getMaxDaysForMonth(month)) {
  	 		// too many days for the month
		 		setFieldErrorStyles(dateField, "mm/dd/yyyy");
  			dateField.value = "";
    		pass = false;  	
  	 	} else if (month == 2 && day > getMaxDaysForFebruary(year)) {
  	 		// too many days for Feb
		 		setFieldErrorStyles(dateField, "mm/dd/yyyy");
  			dateField.value = "";
    		pass = false;  
    	} else {
  	 		// All is good - do nothing
  	 	}
   	} else {
		 	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  		dateField.value = "";
    	pass = false;  		
  	} 
  } else {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  	dateField.value = "";
   	pass = false;
  }
  
  if (Boolean(pass)) {
  	// if all date/time formatting passes, check that this valid date is not in the past
    var nowEpoch = Date.now();
    var reserveEpoch = Date.parse(parts[2] + "-" + parts[0] + "-" + parts[1] + "T" + time);
    if (nowEpoch > reserveEpoch) {
    	alert("Your meeting time is in the past.");
  		setFieldErrorStyles(dateField, "mm/dd/yyyy");
   		setFieldErrorStyles(document.getElementById(thisForm + "-time-button"), "Time");
   		pass = false;
		}
  }
  
 	var nameField = eventForm['meeting-name'];
  var name = nameField.value;
	setFieldPassStyles(nameField, "Purpose");
  if (name == null || name == "" || name.length > 50) {
  	setFieldErrorStyles(nameField, "Meeting purpose is required");
    pass = false;
  }

  var durationField = eventForm['meeting-duration'];
  var duration = durationField.value;
	setFieldPassStyles(document.getElementById(thisForm + "-duration-button"), "Duration");
  if (duration == null || duration == "" || duration == "Duration") {
  	setFieldErrorStyles(document.getElementById(thisForm + "-duration-button"), "Duration");
    pass = false;
  }
  
	if (eventForm['meeting-type'] !== undefined) {
  	var typeField = eventForm['meeting-type'];
  	var typeValue = typeField.value;
  	setFieldPassStyles(document.getElementById(thisForm + "-type-button"), "Meeting Type");
  	if (typeValue == null || typeValue == "" || typeValue == "Meeting Type") {
	  	setFieldErrorStyles(document.getElementById(thisForm + "-type-button"), "Meeting Type");
    	pass = false;
  	}
  }
  
	var tzChangeValue = eventForm['tzone-change'].value;
	if (tzChangeValue == "true") {
		setFieldErrorStyles(document.getElementById(thisForm + "-country-button"), "Country");
		setFieldErrorStyles(document.getElementById(thisForm + "-countryTimeZones-button"), "Time Zone");
		showTimeZoneDisplay('tz-select');
		pass = false;
	}
 
	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.style.opacity = ".6";
 		eventForm.submit();
 	}
}

function setFieldPassStyles(formField, placeholder) {
	formField.style.backgroundColor = "white";
	formField.placeholder = placeholder;
	formField.style.borderColor = "#cccccc";
  formField.style.borderWidth = "1px";
}

function setFieldErrorStyles(formField, placeholder) {
  formField.placeholder = placeholder;
  formField.style.background = errorBackground;
  formField.style.borderColor = "#f68620";
  formField.style.borderWidth = "2px";
}	

var errorBackground = "rgba(247,248,239,0.6) url('') no-repeat right top";

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

function getXmlHttpRequest() {
	var xmlhttp;
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
  	xmlhttp = new XMLHttpRequest();
  } else { // code for IE6, IE5
  	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  return xmlhttp;
}

function setPublicSession(oid, fname, mid, relativePath) {
	var xmlhttp = getXmlHttpRequest();
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status != 200) { return true; }
		} else {
			return false;
		}
	};
	xmlhttp.open("GET", relativePath + "plugin/setPublicSession.php?oid=" + oid + "&timezone=" + getLocalTz() + "&fname=" + fname + "&uuid=" + mid);
	xmlhttp.send();
}

function setPublicSession2(oid, fname, relativePath) {
	var xmlhttp = getXmlHttpRequest();
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status != 200) { return true; }
		} else {
			return false;
		}
	};
	xmlhttp.open("GET", relativePath + "plugin/setPublicSession.php?oid=" + oid + "&timezone=" + getLocalTz() + "&fname=" + fname);
	xmlhttp.send();
}

function toggleFileClear() {
	var fieldValue = document.getElementById('fileToUpload').value;
	var fileClear = document.getElementById('fileClearControl');
	if (fieldValue) {
		fileClear.style.display = 'inline';
	} else {
		fileClear.style.display = 'none';
	}
}

function clearFileInput(ctrl) {
  try {
    ctrl.value = null;
  } catch(ex) { }
  if (ctrl.value) {
    ctrl.parentNode.replaceChild(ctrl.cloneNode(true), ctrl);
  }
  toggleFileClear();
}

function toggleRememberCheckbox() {
	var loginRemember = document.getElementById("login-remember");
	var curState = loginRemember.checked;
	if(curState) {
		loginRemember.checked = false;
		document.getElementById("fakeCheckBox").className = "fa fa-square-o";
		document.getElementById("fakeCheckBox").style = "color:#004d62;padding-right:5px;";
	} else {
		loginRemember.checked = true;
		document.getElementById("fakeCheckBox").className = "fa fa-check-square-o";
		document.getElementById("fakeCheckBox").style = "color:#004d62;padding-right:4px;";
 	}
}

// TODO - combine these
function toggleAdminCheckbox() {
	var adminValue = document.getElementById("new-user-admin");
	var curState = adminValue.checked;
	if(curState) {
		adminValue.checked = false;
		document.getElementById("fakeCheckBox2").className = "fa fa-square-o";
		document.getElementById("fakeCheckBox2").style = "color:#004d62;padding-right:5px;";
	} else {
		adminValue.checked = true;
		document.getElementById("fakeCheckBox2").className = "fa fa-check-square-o";
		document.getElementById("fakeCheckBox2").style = "color:#004d62;padding-right:4px;";
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
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	}
  	};
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
	  	var optionNew = document.createElement("option");
  		optionNew.text = Object.getOwnPropertyNames(countryTimeZones[i]);
  		timeZone.add(optionNew);
		}
    $( "#schedule-form-countryTimeZones" ).selectmenu( "refresh" );
  }
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

function guestValidateAndSubmit(oid, mid) {
	
	pass = true;
	var joinForm = document.forms["public-join-form"];
	
  var usernameField = joinForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
  if (username == null || username == "") {
    setFieldErrorStyles(usernameField, "Name is required.");
    pass = false;
  }
  
	var emailField = joinForm["email"];
	setFieldPassStyles(emailField, "");
  if (!isValidEmail(emailField.value)) {
  	setFieldErrorStyles(emailField, "Valid email is required.");
  	emailField.value = "";
  	pass = false;
  }
	
 	if (Boolean(pass)) {	
 		setPublicSession(oid, username, mid, '');
 		document.getElementById('public-meeting-join').click();
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
	setFieldPassStyles(scheduleForm['meeting-name'], "Meeting Name");
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
	setFieldPassStyles(nowForm['meeting-name'], "Meeting Name");
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
	var dateField = eventForm['meeting-date'];
	var date = dateField.value;
	var timeFieldEnd;
  var timeEnd;
	var dateFieldEnd;
	var dateEnd;  
	
	var isTimeEnd = (eventForm['meeting-time-end'] !== undefined ? true : false);
	var isDateEnd = (eventForm['meeting-date-end'] !== undefined ? true : false);
  
  setFieldPassStyles(dateField, "Start Date");
	if (validateDateFormat(dateField)) {
		if (!validateTimeFuture(dateField, time)) {
			pass = false;
		}
	} else {
		pass = false;
	}
	
	setFieldPassStyles(document.getElementById(thisForm + "-time-button"), "Start Time");
	if (time == null || time == "" || time.indexOf("Time") > -1) {
   	setFieldErrorStyles(document.getElementById(thisForm + "-time-button"), "Start Time");
    pass = false;
  }
 
	if (Boolean(isDateEnd)) {
		dateFieldEnd = eventForm['meeting-date-end'];
  	setFieldPassStyles(dateFieldEnd, "End Date");
  	if (validateDateFormat(dateFieldEnd)) {
			if (!validateTimeFuture(dateFieldEnd, timeEnd)) {
				pass = false;
			}	
		} else {
			pass = false;
		}  
	}

	if (Boolean(isTimeEnd)) {
		timeFieldEnd = eventForm['meeting-time-end'];
  	timeEnd = timeFieldEnd.value;
		setFieldPassStyles(document.getElementById(thisForm + "-time-end-button"), "Time End");
  	if (timeEnd == null || timeEnd == "" || timeEnd == "End Time") {
	   	setFieldErrorStyles(document.getElementById(thisForm + "-time-end-button"), "End Time");
    	pass = false;
  	}
	}

  var durationField = eventForm['meeting-duration'];
	if (Boolean(pass) && Boolean(isDateEnd) && Boolean(isTimeEnd)) {
		if (!validateEndTimeGreater(dateField, time, eventForm['meeting-date-end'], eventForm['meeting-time-end'].value)) {
			pass = false;
		} else {
  		var firstEpoch = Date.parse(createTimeStampString(date, time));
  		var secondEpoch = Date.parse(createTimeStampString(eventForm['meeting-date-end'].value, eventForm['meeting-time-end'].value));
 			var epochDiff = secondEpoch - firstEpoch;
 			if (epochDiff/1000 > 86400) {
 				alert("A meeting cannot be longer than 24 hours");
 				setFieldErrorStyles(setFieldErrorStyles(eventForm['meeting-date-end'], "mm/dd/yyyy"));
 				pass = false;
 			} else {
 				durationField.value = millisecondsToHms(epochDiff);
 			}
		}
	}
	
  var duration = durationField.value;
	setFieldPassStyles(document.getElementById(thisForm + "-duration-button"), "Duration");
  if (duration == null || duration == "" || duration == "Duration") {
 		setFieldErrorStyles(document.getElementById(thisForm + "-duration-button"), "Duration");
   	pass = false;
 	} else if (!validateTimeFormat(duration)) {
 		alert("Bad duration: " + duration);
 		pass = false;
	}
	  
 	var nameField = eventForm['meeting-name'];
  var name = nameField.value;
	setFieldPassStyles(nameField, "Meeting Name");
  if (name == null || name == "" || name.length > 50) {
  	setFieldErrorStyles(nameField, "Meeting name is required");
    pass = false;
  }

	var tzChangeValue = eventForm['tzone-change'].value;
	if (tzChangeValue == "true") {
		setFieldErrorStyles(document.getElementById(thisForm + "-country-button"), "Country");
		setFieldErrorStyles(document.getElementById(thisForm + "-countryTimeZones-button"), "Time Zone");
		showTimeZoneDisplay('tz-select');
		pass = false;
	}

	if (eventForm['meeting-descr'] !== undefined) {
 		var descrField = eventForm['meeting-descr'];
  	var descr = descrField.value;
		setFieldPassStyles(descrField, "Description");
  	if (descr == null || descr == "" || descr.length > 1500) {
	  	setFieldErrorStyles(descrField, "Meeting description is required");
    	pass = false;		
    }
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
  
  var forApproval = false;
  var contact = "";
  if (eventForm['meeting-contact'] !== undefined) {
  	forApproval = true;
  	var contactField = eventForm['meeting-contact'];
  	contact = contactField.value;
  	setFieldPassStyles(contactField, "Contact Email");
  	if (!isValidEmail(contact)) {
  		setFieldErrorStyles(contactField, "Valid email is required.");
  		contactField.value = "";
  		pass = false;
  	}  	
  }
  
	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.style.opacity = ".6";
 		eventForm.submit();
 	}
}

function setFieldPassStyles(formField, placeholder) {
	if (formField) {
		formField.style.backgroundColor = "white";
		formField.placeholder = placeholder;
		formField.style.borderColor = "#cccccc";
  	formField.style.borderWidth = "1px";
  }
}

function setFieldErrorStyles(formField, placeholder) {
  formField.placeholder = placeholder;
  formField.style.background = errorBackground;
  formField.style.borderColor = "#f68620";
  formField.style.borderWidth = "2px";
}	

function validateDateFormat(dateField) {
	var date = dateField.value;
	var re = /\d{2}\/\d{2}\/\d{4}/;
  var parts = new Array();
  if (date == null || date == "") {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  	dateField.value = "";
    return false;
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
    		return false;  	
  	 	} else if (month == 2 && day > getMaxDaysForFebruary(year)) {
  	 		// too many days for Feb
		 		setFieldErrorStyles(dateField, "mm/dd/yyyy");
  			dateField.value = "";
    		return false;  
    	} else {
  	 		// All is good - do nothing
  	 	}
   	} else {
		 	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  		dateField.value = "";
    	return false;  		
  	} 
  } else {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  	dateField.value = "";
   	return false;
  }
  return true;
}

function validateTimeFuture(dateField, time) {
  var nowEpoch = Date.now();
  var reserveEpoch = Date.parse(createTimeStampString(dateField.value, time));
  if (nowEpoch > reserveEpoch) {
  	alert("Your meeting time is in the past.");
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
  	return false;
	}
	return true;
}

function validateEndTimeGreater(dateField1, time1, dateField2, time2) {
	var date1 = dateField1.value;
  var firstEpoch = Date.parse(createTimeStampString(date1, time1));

	var date2 = dateField2.value;
  var secondEpoch = Date.parse(createTimeStampString(date2, time2));

  if (firstEpoch > secondEpoch) {
  	alert("Your meeting ends before it starts.");
  	setFieldErrorStyles(dateField2, "mm/dd/yyyy");
  	return false;
	}
	return true;
}

function createTimeStampString(date, time) {
	var parts = new Array();
  parts = date.split("/");
  return (parts[2] + "-" + parts[0] + "-" + parts[1] + "T" + time);
}

function millisecondsToHms(ms) {
	ms = Number(ms);
	var d = ms/1000;
	var h = Math.floor(d / 3600);
	var m = Math.floor(d % 3600 / 60);
	//var s = Math.floor(d % 3600 % 60);
	var s = "00";
	return ((h > 0 ? h + ":" : "00:") + (m > 0 ? (h > 0 && m < 10 ? "0" : "") + m + ":" : "00:") + s); 
}

function validateTimeFormat(t) {
	// TODO - complete this
	return true;
}

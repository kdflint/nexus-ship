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
}

function setTimeZoneDisplay(zone) {
  document.getElementById("local-tzDisplay").innerHTML = zone;
  document.getElementById("local-tzFormField").value = zone;
  showTimeZoneDisplay("tz-static");
}	

function displayTimeZones() {
	var timeZone = document.getElementById("countryTimeZones");
	var countryCode = document.getElementById("country").value;
	// TODO - this line clears previous selections - how does it work?
	for (a in timeZone.options) { timeZone.options.remove(0); }
  var countryTimeZones = timeZoneData[countryCode];
  if (countryTimeZones.length == 1) {
  	setTimeZoneDisplay(Object.getOwnPropertyNames(countryTimeZones[0]));
  } else {
		var option = document.createElement("option");
  	option.text = "Time Zone";
  	option.selected = true;
  	timeZone.add(option);
  	for (var i=0; i<countryTimeZones.length; i++) {
	  	var option = document.createElement("option");
  		option.text = Object.getOwnPropertyNames(countryTimeZones[i]);
  		timeZone.add(option);
		}
    $( "#countryTimeZones" ).selectmenu( "refresh" );
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
	
  var fnameField = inviteForm["fname"];
  var fname = fnameField.value;
  setFieldPassStyles(fnameField, "First Name");
  if (fname == null || fname == "") {
    setFieldErrorStyles(fnameField, "First name is required.");
    pass = false;
  }	
	
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

function passwordValidateAndSubmit2(formId) {
	
	pass = true;
	var passwordForm = document.forms[formId];
	var submitButton = document.getElementById(formId + "-submit");
	
  var password1Field = passwordForm["password1"];
  var password1 = password1Field.value;
  password1Field.style.backgroundColor = "white";
  password1Field.placeholder = "";
  if (password1 == null || password1 == "" || password1.length < 7 || password1.length > 25) {
    password1Field.placeholder = "7-25 characters please";
    password1Field.style.background = errorBackground;
    passwordField.style.borderColor = "#f68620";
    passwordField.style.borderWidth = "2px";
    pass = false;
  }
  
  var password2Field = passwordForm["password2"];
  var password2 = password2Field.value;
  password2Field.style.backgroundColor = "white";
  password2Field.placeholder = "";
  if (pass && (password2 == null || password2 == "")) {
    password2Field.placeholder = "Please confirm your new password.";
    password2Field.style.background = errorBackground;
    password2Field.style.borderColor = "#f68620";
    password2Field.style.borderWidth = "2px";
    pass = false;
  }
  if (pass && (password1 !== password2)) {
    password2Field.placeholder = "Your passwords do not match.";
    password2Field.style.background = errorBackground;
    password2Field.style.borderColor = "#f68620";
    password2Field.style.borderWidth = "2px";
    pass = false;
  }
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		passwordForm.submit();
 	}
}
 	
function eventValidateAndSubmit() {
	pass = true;
	var eventForm = document.forms["schedule-form"];
	var submitButton = document.getElementById("schedule-form-submit");
	
	var nameField = eventForm['meeting-name'];
  var name = nameField.value;
	setFieldPassStyles(nameField, "Purpose");
  if (name == null || name == "" || name.length > 50) {
  	setFieldErrorStyles(nameField, "Meeting purpose is required");
    pass = false;
  }
  
	var dateField = eventForm['meeting-date'];
  var date = dateField.value;
  var patt = new RegExp(/\d{2}\/\d{2}\/\d{4}/);  
	setFieldPassStyles(dateField, "Date");
  if (date == null || date == "") {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
    pass = false;
  } else if (patt.test(date)) {
  	 var parts = date.split("/");
  	 // TODO - this does not match valid date to month, so, 04/31/2000 will pass through
  	 if (
  	 			1 <= parseInt(parts[0], 10) && parseInt(parts[0], 10) <= 12 &&
  	 			1 <= parseInt(parts[1], 10) && parseInt(parts[1], 10) <= 31 &&
  	 			2000 <= parseInt(parts[2], 10) && parseInt(parts[2], 10) <= 2100
  	 ) {
  	} else {
  		setFieldErrorStyles(dateField, "mm/dd/yyyy");
    	pass = false;  		
  	}
  }
  
 	var timeField = eventForm['meeting-time'];
  var time = timeField.value;
	setFieldPassStyles(document.getElementById("basicExample-button"), "Time");
  if (time == null || time == "" || time == "Time") {
   	setFieldErrorStyles(document.getElementById("basicExample-button"), "Time");
    pass = false;
  }
  
  var durationField = eventForm['meeting-duration'];
  var duration = durationField.value;
	setFieldPassStyles(document.getElementById("duration-button"), "Duration");
  if (duration == null || duration == "" || duration == "Duration") {
  	setFieldErrorStyles(document.getElementById("duration-button"), "Duration");
    pass = false;
  }
  
  // TODO - validate timezone?
 
	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.style.opacity = ".6";
 		eventForm.submit();
 	}
}

function setFieldPassStyles(formField, placeholder) {
	formField.style.backgroundColor = "white";
	formField.placeholder = placeholder;
  formField.style.borderWidth = "0px";
}

function setFieldErrorStyles(formField, placeholder) {
  formField.placeholder = placeholder;
  formField.style.background = errorBackground;
  formField.style.borderColor = "#f68620";
  formField.style.borderWidth = "2px";
}	

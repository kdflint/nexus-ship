var errorBackground = "rgba(247,248,239,0.6) url('') no-repeat right top";

function displayLocalTz() {
	// https://bitbucket.org/pellepim/jstimezonedetect
	var tz = jstz.determine();
  document.getElementById("local-tzDisplay").innerHTML = tz.name();
  document.getElementById("local-tzFormField").innerHTML = tz.name();
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
	} else {
		loginRemember.checked = true;
 	}
}
    	
function toggleFormDisplay(formId) {
	var showForm = document.getElementById(formId);
	document.getElementById("login-form").style.display='none';
	document.getElementById("recover-username-form").style.display='none';
	document.getElementById("recover-password-form").style.display='none';
	showForm.style.display='block';
	document.getElementById("login-user-message").innerHTML = "";
}			function recordActivity() {
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

// TODO - refactor these front validations scripts - way too redundant!

function loginValidateAndSubmit() {
		
	pass = true;
	var loginForm = document.forms["login-form"];
	var submitButton = document.getElementById("login-form-submit");
	
  var usernameField = loginForm["uid"];
  var username = usernameField.value;
  usernameField.style.backgroundColor = "white";
  usernameField.placeholder = "";
  if (username == null || username == "") {
    usernameField.placeholder = "Username name is required.";
    usernameField.style.background = errorBackground;
    usernameField.style.borderColor = "#f68620";
   	usernameField.style.borderWidth = "2px";
    pass = false;
  }
  
  var passwordField = loginForm["password"];
  var password = passwordField.value;
  passwordField.style.backgroundColor = "white";
  passwordField.placeholder = "";
  if (password == null || password == "") {
    passwordField.placeholder = "Password is required.";
    passwordField.style.background = errorBackground;
    passwordField.style.borderColor = "#f68620";
    passwordField.style.borderWidth = "2px";
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
  emailField.style.backgroundColor = "white";
  emailField.placeholder = "Email";
  if (email == null || email == "") {
    emailField.placeholder = "Email is required.";
    emailField.style.background = errorBackground;
    emailField.style.borderColor = "#f68620";
    emailField.style.borderWidth = "2px";
    pass = false;
  } else if (!isValidEmail(email)) {
    emailField.placeholder = "Valid email is required.";
    emailField.style.background = errorBackground;
    emailField.style.borderColor = "#f68620";
    emailField.style.borderWidth = "2px";
    emailField.value = "";
  	pass = false;
  }
  
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
  usernameField.style.backgroundColor = "white";
  usernameField.placeholder = "";
  if (username == null || username == "") {
    usernameField.placeholder = "Username name is required.";
    usernameField.style.background = errorBackground;
    usernameField.style.borderColor = "#f68620";
    usernameField.style.borderWidth = "2px";
    pass = false;
  }
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		passwordForm.submit();
 	}

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
  if (name == null || name == "") {
  	setFieldErrorStyles(nameField, "Meeting purpose is required");
    pass = false;
  }

	var dateField = eventForm['meeting-date'];
  var date = dateField.value;
  var patt = new RegExp(/\d{2}\/\d{2}\/\d{4}/);  
	setFieldPassStyles(dateField, "Date");
  if (date == null || date == "" || !patt.test(date)) {
  	setFieldErrorStyles(dateField, "mm/dd/yyyy");
    pass = false;
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
 
	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
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

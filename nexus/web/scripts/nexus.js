var errorBackground = "rgba(230,179,76,0.3) url('') no-repeat right top";

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
}

function toggleFrameDisplay(frameId) {
	var showFrame = document.getElementById(frameId);
	document.getElementById("reserveList").style.display='none';
	document.getElementById("userList").style.display='none';
	showFrame.style.display='block';
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
    pass = false;
  }
  
  var passwordField = loginForm["password"];
  var password = passwordField.value;
  passwordField.style.backgroundColor = "white";
  passwordField.placeholder = "";
  if (password == null || password == "") {
    passwordField.placeholder = "Password is required.";
    passwordField.style.background = errorBackground;
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
    pass = false;
  } else if (!isValidEmail(email)) {
    emailField.placeholder = "Valid email is required.";
    emailField.style.background = errorBackground;
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
    pass = false;
  }
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		passwordForm.submit();
 	}

}
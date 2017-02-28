var errorBackground = "rgba(247,248,239,0.6) url('') no-repeat right top";

var currentEvents;
var geoDataOrgSearch;

var MEETING_INFO_NEXT_REFRESH = "60000";
var NEXT_MEETING_START;
var IS_NOW = true;
var IS_TIMER_INIT = false;
var ACTIVITY_FLAG = 1;
var DEFAULT_FORUM;
var HTTP_WEB_PATH;
var HTTP_FORUM_PATH;
var FORUM_SESSION_REFRESH_COUNTER = 0;
var DEFAULT_INBOX_FOCUS = "/ucp.php?i=pm&folder=inbox";
var INBOX_FOCUS = "";
//var RECIPIENT_LIST = [];


/*
Would like to avoid initializing these and force the including php page to do so, but that might break something right now. 
So, we've got redundand code for the moment
See login.php:142
*/
var USERNAME_REQUIRED = "Username is required";
var PASSWORD_REQUIRED = "Password is required";
var EMAIL_REQUIRED = "Valid email is required";

function formSubmit(formId) {
 		document.forms[formId].submit();
}

function countdownTimer() {
	var timerDisplay = document.getElementById("countdown");
	NEXT_MEETING_START--;
	if (timerDisplay) {
		timerDisplay.innerHTML = secondsToFriendlyTime(NEXT_MEETING_START);
	}
}

/**
 * @param {string} filename The name of the file WITHOUT ending
 */
function playSound(filename){   
   document.getElementById("notification").innerHTML='<audio autoplay="autoplay"><source src="audio/' + filename + '.mp3" type="audio/mpeg" /><source src="audio/' + filename + '.ogg" type="audio/ogg" /><embed hidden="true" autostart="true" loop="false" src="audio/' + filename +'.mp3" /></audio>';
}

function truncateString(str, length, ending) { 
		// Truncate a string at the last space before the length designate
		var lastSpace, firstCut, secondCut;
		var splitChar = " "; 
    if (length == null) {  
      length = 50;  
    }  
    if (ending == null) {  
      ending = '...';  
    }  
    if (str.length > length) {  
      firstCut = str.substring(0, length);
      lastSpace = firstCut.lastIndexOf(splitChar);
      if (lastSpace > 0) {
      	lastCut = firstCut.substring(0, lastSpace) + ending;
      } else {
      	lastCut = firstCut + ending;
      }
    } else {  
      lastCut = str;  
    }  
    return lastCut;
};  

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

function resetSessionLanguage(lang) {
	if (lang != 'xx') {
		var x = document.getElementById("fname");
		var xmlhttp = getXmlHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) { 
					location.reload(true); 
				} else {
					return false;
					
				}
			}
		};
		xmlhttp.open("GET", "src/framework/setSessionLanguage.php?language=" + lang);
		xmlhttp.send();
	}
}	

function setSessionTimezone(relativePath) {
	var xmlhttp = getXmlHttpRequest();
	var tz = getLocalTz();
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) { 
				return true; 
			} else {
				return false;
			}
		}
	};
	xmlhttp.open("GET", relativePath + "plugin/setSessionTimezone.php?timezone=" + tz, false);
	xmlhttp.send();
}

function setPublicSession(oid, fname, mid, relativePath) {
	var xmlhttp = getXmlHttpRequest();
	var returnStatus;
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status != 200) { 
				returnStatus = false;
			} else {
			 	returnStatus = true;
			}
		}
	};
	xmlhttp.open("GET", relativePath + "plugin/setPublicSession.php?oid=" + oid + "&timezone=" + getLocalTz() + "&fname=" + fname + "&uuid=" + mid, false);
	xmlhttp.send();
	return returnStatus;
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

function disableTestMessageLink(linkId) {
   var link=document.getElementById(linkId);
   link.style.color="#899d70";
   link.setAttribute("href", "#");
   link.innerHTML = 'To test, save your changes';
}

function post(uiContext, to, p) {
  var myForm = document.createElement("form");
  myForm.method="post" ;
  myForm.action = to ;
  for (var k in p) {
    var myInput = document.createElement("input") ;
    myInput.setAttribute("name", k) ;
    myInput.setAttribute("value", p[k]);
    myForm.appendChild(myInput) ;
  }
  document.body.appendChild(myForm) ;
  myForm.submit() ;
  document.body.removeChild(myForm) ;
	disableTestMessageLink(uiContext);
	document.getElementById(uiContext).innerHTML = "A test message has been sent!";

}

function fillRecipients() {
	var recipientlist = [];
	var names = document.forms['member-directory-form'].elements['names[]'];
	for (var i=0; i<names.length; i++) {
		console;log("hi");
		if (names[i].checked) {
			var keyval = names[i].value.split("::");
			if (keyval.length == 2) {
				var dto = new Object();	
				dto.username = keyval[0];
				dto.fullname = keyval[1];	
				recipientlist.push(dto);	
	  	}
	  }
	}
	document.getElementById("recipient-dto").innerHTML = JSON.stringify(recipientlist);
	console.log(JSON.stringify(recipientlist));
}

function goToInboxCompose() {
	//fillRecipients();
	document.getElementById("inbox-mode").innerHTML = "compose";
	$( "#adv-menu-inbox" ).click();	
}

function checkAll(formname) {
	var curState = document.forms['member-directory-form']['togglestate'].value;
  var checkboxes = document.forms[formname].elements['names[]']; 
  var indicator = document.getElementById("mark_all");
  if (curState == "0") {
  	for (var i=0; i<checkboxes.length; i++)  {
	    if (checkboxes[i].type == 'checkbox')   { checkboxes[i].checked = true; }	
    }
    document.forms['member-directory-form']['togglestate'].value = "1";
    indicator.innerHTML = "Unselect all";
  } else if (curState == "1") {
  	for (var i=0; i<checkboxes.length; i++)  {
	    if (checkboxes[i].type == 'checkbox')   { checkboxes[i].checked = false; }
	  }	
   	document.forms['member-directory-form']['togglestate'].value = "0";
   	indicator.innerHTML = "Select all";
	}
}	

function showAdvProfile(username) {
	var iframeSrc = HTTP_FORUM_PATH  + "/memberlist.php?mode=viewprofile&un=" + username;
  var iframe = document.getElementById("adv-profile-frame");
  iframe.src = iframeSrc;
  window.location.assign(HTTP_WEB_PATH + "/nexus.php#openProfile");
}

function toggleRecurFormElements(override) {
	var curValue = document.getElementById('repeat-check').checked;
	var repeatBlock = document.getElementById("repeat-block");
  var locationBlock = document.getElementById("location-block");
  var repeatSpan = document.getElementById("repeat-span");
  var repeatEdit = document.getElementById('repeat-edit');
  var submitButton = document.getElementById("schedule-form-submit");
  if(!curValue) {
 		repeatBlock.style.display = "none";
		locationBlock.style.display = "block";
		repeatSpan.style.visibility = "hidden";
		repeatEdit.style.visibility = "hidden";
 		submitButton.style.visibility = "visible";
 	} else if (Boolean(override)) {
 		repeatBlock.style.display = "none";
		locationBlock.style.display = "block";
		repeatSpan.style.visibility = "visible";
		repeatEdit.style.visibility = "visible";
 		submitButton.style.visibility = "visible";
 	} else {
  	repeatBlock.style.display = "block";
  	locationBlock.style.display = "none";
  	updateRepeatDescr(document.getElementById('repeat-interval'));
  	updateRepeatFreq(document.getElementById('repeat-freq'));
  	repeatSpan.style.visibility = "visible";
  	repeatEdit.style.visibility = "hidden";
 		submitButton.style.visibility = "hidden";
 	}
}

function updateRepeatDescr(element) {
	var labels = [];
	var x = parseInt(element.value);
	labels[0] = "days";
	labels[1] = "days";
	labels[2] = "weeks";
	labels[3] = "daily";
	labels[4] = "weekdays";
	labels[5] = "weekly";
	
	document.getElementById("repeat-descr").innerHTML = labels[x+3];
	
	var unitlabels = document.getElementsByClassName("repeat-unit");
	for (var i = 0; i < unitlabels.length; i += 1) {
	  unitlabels[i].innerHTML = labels[x];
	}

}

function updateRepeatFreq(element) {
	document.getElementById("repeat-quantity").innerHTML = element.value;
}

function toggleFileClear() {
	var fieldValue = document.getElementById('fileToUpload').value;
	var fileClear = document.getElementById('fileClearControl');
	if (fieldValue) {
		fileClear.style.display = 'inline';
		document.getElementById("attachment-label").innerHTML = "<b>Attach a file</b> (optional)";
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

function htmlFormatParagraphs(rawText) {
	var replaced = rawText.replace(new RegExp( '~', 'g' ), '</p><p>');
	return replaced;
}

function htmlFormatAnchors(rawText) {
	var re = new RegExp('(https?:\/\/)(.*?)(\\s|$|<)', 'gm');
	var replaced = rawText.replace(re, '<a href="$1$2" target="_blank">$1$2</a>$3');
	return replaced;
}

function htmlFormatEmail(rawText) {
	var re = new   RegExp("([\\w\\d\\.\\?\\/\\-!#$%&'*+=^`{|}~]+)@([\\w\\d\\-\\.]+?)\\.(\\S+?)(<|\\s|$)", 'gm');
	var replaced = rawText.replace(re, '<a href="mailto:$1@$2.$3">$1@$2.$3</a>$4');
	return replaced;
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

function toggleTertiary(menu) {
	var tertiaryContainer = document.getElementById(menu);
	var curState = tertiaryContainer.style.display;
	tertiaryContainer.style.display = "none";
	if (curState === "none") {
		tertiaryContainer.style.display = "block";
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
	var userListButton = document.getElementById("menu-userList");
	var reserveListButton = document.getElementById("menu-reserveList");
	var showButton = document.getElementById('menu-' + frameId);
	var walkMeAnchor = document.getElementById('walkme-' + frameId);
	
	/* set all to default */
	document.getElementById("reserveList").style.display='none';
	document.getElementById("userList").style.display='none';
	document.getElementById("walkme-userList").style.display='none';
	document.getElementById("walkme-reserveList").style.display='none';
	document.getElementById("fatalError").style.display='none';
	userListButton.style.backgroundColor='rgba(210, 123, 75, 1)';
	userListButton.className = "pure-button button-menu";
	reserveListButton.style.backgroundColor='rgba(210, 123, 75, 1)';
	reserveListButton.className = "pure-button button-menu";
	
	/* alter the chosen */
	showFrame.style.display='block';
	showButton.style.backgroundColor='rgba(137, 157, 112, 1)';
	showButton.className = "pure-button button-menu active";
	walkMeAnchor.style.display='block';
}

function toggleAdvFrameDisplay(menuItem) {
	var menuItems = document.getElementById("advMenu").children;
	var showButton = document.getElementById(menuItem.id);
  for (var i=0; i<menuItems.length; i++) {
		menuItems[i].style.backgroundColor='#dae0bc';
	}
	showButton.style.backgroundColor='rgba(137, 157, 112, 1)';
	loadAdvPage(menuItem.id);
}

function checkGoodForumSession(thisFrame) {
	if (thisFrame.src.includes(HTTP_FORUM_PATH)) {
 		var content = thisFrame.contentWindow || thisFrame.contentDocument;
 		if (content.document && content.document.getElementById('wrap')) { 
			var rawFrameHtml = content.document.getElementById('wrap').innerHTML;
			// TODO - pick more foolproof string
   		if (rawFrameHtml.includes("Password:")) {
   			thisFrame.src = HTTP_WEB_PATH + "/loading_placeholder.html";
   			console.log("Forum session expired. Attempting refresh.");
   			// TODO - catch the return value on this method?
				if (FORUM_SESSION_REFRESH_COUNTER < 2) {
   				refreshForumSession();
   				console.log("Return on attempt " + FORUM_SESSION_REFRESH_COUNTER);
   				FORUM_SESSION_REFRESH_COUNTER++;
					document.getElementById('adv-menu-forum').click();
				} else {
					thisFrame.src = HTTP_WEB_PATH + "/service_unavailable.html";
				}
   		} else {
   			console.log("Forum session valid.");
   			FORUM_SESSION_REFRESH_COUNTER = 0;
   		}
   	}
	}
}

function loadAdvPage(resource) {
	var frameDisplay = document.getElementById("adv_frame_display");
	frameDisplay.style.display = "none";

	var divDisplay = document.getElementById("adv_div_display");
	divDisplay.style.display = "none";
	var divDisplays = divDisplay.getElementsByClassName('div-display');
	for (var i = 0; i < divDisplays.length; i += 1) {
	  divDisplays[i].style.display = "none";
	}
	var frameId = "adv-frame";
	
		switch(resource) {
			case "adv-menu-inbox":
				var iframeSrc = HTTP_FORUM_PATH  + INBOX_FOCUS; //"/ucp.php?i=pm&folder=inbox";
    		var iframe = document.getElementById(frameId);
    		iframe.src = iframeSrc;
    		frameDisplay.style.display ="block";
    		INBOX_FOCUS = DEFAULT_INBOX_FOCUS;
    		break;    		
    	case "adv-menu-forum":
    		var iframeSrc = HTTP_FORUM_PATH  + "/viewforum.php?f=" + DEFAULT_FORUM;
    		var iframe = document.getElementById(frameId);
    		iframe.src = iframeSrc;
    		frameDisplay.style.display ="block";
    		break;
    	case "adv-menu-event":
    		document.getElementById("event_display").style.display ="block";
    		divDisplay.style.display ="block";
    		break;
    	case "adv-menu-network":
    		document.getElementById("network_display").style.display ="block";
    		divDisplay.style.display ="block";
    		break;
    	case "adv-menu-profile":
    		document.getElementById("profile_display").style.display ="block";
    		divDisplay.style.display ="block";
    		break;
    	default:
       	document.getElementById(frameId).src = HTTP_WEB_PATH + "/production_placeholder.html";
       	frameDisplay.style.display ="block";
        break;
		} 
}

function refreshForumSession() {
	var xmlhttp = getXmlHttpRequest();
	xmlhttp.onreadystatechange=function() {
		console.log(xmlhttp.readyState);
  	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { return true;  }
 	}
 	console.log("refreshing forum");
	xmlhttp.open("GET","src/framework/sessionManager.php?forum=1", false); // synchronous call
	xmlhttp.send();  					
}

function usernameValidCheck(input) {
	var xmlhttp = getXmlHttpRequest();
	var status;
	xmlhttp.onreadystatechange=function() {
  	if (xmlhttp.readyState == 4) {
  		if (xmlhttp.status == 200) { 
  			console.log(xmlhttp.responseText);
  			jsonObj = JSON.parse(xmlhttp.responseText);	
  			status = jsonObj['username-status'];
  		} else {
  			status = "undefined";
  		}
 		}
 	}
	xmlhttp.open("GET","src/framework/usernameLookup.php?username=" + input , false); // synchronous call
	xmlhttp.send();
	console.log(status);
	return status;  					
}


function myHTMLInclude() {
  var z, i, a, file, xhttp;
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
    if (z[i].getAttribute("w3-include-html")) {
      a = z[i].cloneNode(false);
      file = z[i].getAttribute("w3-include-html");
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
          a.removeAttribute("w3-include-html");
          a.innerHTML = xhttp.responseText;
          z[i].parentNode.replaceChild(a, z[i]);
          myHTMLInclude();
        }
      }      
      xhttp.open("GET", file, true);
      xhttp.send();
      return;
    }
  }
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

// LEFT OFF - create data file with states identifed to countries, like time zone one
function displayStates() {
	var state = document.getElementById("organization-form-countryStates");
	var countryCode = document.getElementById("organization-form-country").value;
	// TODO - this line clears previous selections - how does it work?
	for (a in state.options) { state.options.remove(0); }
  var countryStates = stateData[countryCode];
  var option = document.createElement("option");
  option.text = "State";
  option.selected = true;
  state.add(option);
  if (countryStates === undefined) {
  	// leave the options list unpopulated
  	$( "#organization-form-countryStates" ).selectmenu( "refresh" );
  //} else if (countryStates.length == 1) {
  	// update display and form to show this one option
  	//setStateDisplay(Object.getOwnPropertyNames(countryStates[0]));
  } else {
  	// add the state options to the state options list
  	for (var i=0; i<countryStates.length; i++) {
	  	var optionNew = document.createElement("option");
  		optionNew.text = countryStates[i];
  		state.add(optionNew);
		}
    $( "#organization-form-countryStates" ).selectmenu( "refresh" );
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

function showDirectoryDetail(orgId) {
	document.getElementById("show-directoryResults").style.display='none';
	document.getElementById("show-directoryDetail").style.display='block';	
	var secondaryFilterIcon = document.getElementById("secondary-network-filter");
	if (secondaryFilterIcon) {
		secondaryFilterIcon.className = "secondaryControlDisabled";
	}
	var secondaryOrgEditIcon = document.getElementById("secondary-network-edit");
	if (secondaryOrgEditIcon) {
		secondaryOrgEditIcon.style.display = "block";
	}
	getDirectoryDetail(orgId);
}	
			
function showDirectoryResults() {
	document.getElementById("show-directoryResults").style.display='block';
	document.getElementById("show-directoryDetail").style.display='none';	
	var secondaryFilterIcon = document.getElementById("secondary-network-filter");
	if (secondaryFilterIcon) {
		secondaryFilterIcon.className = "secondaryControl";
	}
	var secondaryOrgEditIcon = document.getElementById("secondary-network-edit");
	if (secondaryOrgEditIcon) {
		secondaryOrgEditIcon.style.display = "none";
	}

}
					
function showDirectoryMap() {
	document.getElementById("directoryMapContainer").style.opacity=1;
	document.getElementById("directoryMapContainer").style.filter='alpha(opacity=100)'
	document.getElementById("directoryMapContainer").style.zIndex=10;
	document.getElementById("directoryTable").style.display='none';
	document.getElementById("directory_control").className='fa fa-list fa-' + getDirectoryIconSize();
	document.getElementById("map_control").onclick=function(){showDirectoryList();};
}

function getDirectoryIconSize() {
	return "lg";
}
			
function showDirectoryList() {
	document.getElementById("directoryMapContainer").style.opacity=0;
	document.getElementById("directoryMapContainer").style.filter='alpha(opacity=0)'
	document.getElementById("directoryMapContainer").style.zIndex=-1;
	document.getElementById("directoryTable").style.display='block';
	document.getElementById("directory_control").className='fa fa-globe fa-' + getDirectoryIconSize();
	document.getElementById("map_control").onclick=function(){showDirectoryMap();};
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
    setFieldErrorStyles(usernameField, USERNAME_REQUIRED);
    pass = false;
  }
  
  var passwordField = loginForm["password"];
  var password = passwordField.value;
  setFieldPassStyles(passwordField, "");
  if (password == null || password == "") {
    setFieldErrorStyles(passwordField, PASSWORD_REQUIRED);
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
  	setFieldErrorStyles(emailField, EMAIL_REQUIRED);
  	emailField.value = "";
  	pass = false;
  }
	
 	if (Boolean(pass)) {	
 		if (setPublicSession(oid, username, mid, '')) {
 			document.getElementById('public-meeting-join').click();
 		} else {
 			usernameField.value = emailField.value = null;
 			setFieldErrorStyles(usernameField, "Our bad, something goofed :(");
 			setFieldErrorStyles(emailField, "Please try again.");
 		}
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
    setFieldErrorStyles(usernameField, USERNAME_REQUIRED);
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
  	setFieldErrorStyles(emailField, EMAIL_REQUIRED);
  	emailField.value = "";
  	pass = false;
  }

  var usernameField = enrollForm["uid"];
  var username = usernameField.value;
  setFieldPassStyles(usernameField, "");
	var result = usernameValidCheck(username);
	switch(result) {
		case "invalid":
		case "undefined":
    	setFieldErrorStyles(usernameField, "Valid username is required.");
    	usernameField.value = "";
    	pass = false;		
    	break;
    case "dupe":
    	setFieldErrorStyles(usernameField, "This username is already taken: " + username);
    	usernameField.value = "";
    	pass = false;		
    	break;  
    default:
    	break  
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
    setFieldErrorStyles(emailField, EMAIL_REQUIRED);
    emailField.value = "";
  	return false;
  }
  return true;
}

function validatePhone(phone) {
	return /^[0-9()-. ]+$/.test(phone);
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
	var formControl = document.getElementById('schedule_control');
	if (formControl) {
		formControl.click();
	}
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

function resetEventForm() {
	var scheduleForm = document.forms['schedule-form'];
	resetScheduleForm();
	// overrides
	setFieldPassStyles(scheduleForm['meeting-date'], "Start Date");
	setFieldPassStyles(document.getElementById("schedule-form-time-button"), "Start Time");
	setFieldPassStyles(document.getElementById("schedule-form-time-end-button"), "End Time");
	// additional fields
	setFieldPassStyles(scheduleForm['meeting-url'], "Web Link (http://)");
	setFieldPassStyles(scheduleForm['meeting-descr'], "Description");
	setFieldPassStyles(scheduleForm['meeting-registr'], "Registration Information");
	setFieldPassStyles(scheduleForm['registration-url'], "Registration Link (http://)");
	setFieldPassStyles(scheduleForm['meeting-loc'], "Location");
	setFieldPassStyles(scheduleForm['meeting-date-end'], "End Date");
	clearFileInput(document.getElementById('fileToUpload'));
	document.getElementById('schedule-form-submit').innerHTML = "Add";
	scheduleForm['meeting-descr'].innerHTML = "";
	scheduleForm['meeting-registr'].innerHTML = "";
	scheduleForm['meeting-uuid'].value = "";
	// TODO - timezone value is not resetting - why? Also affects NWM (that is, form cancel does not reset tx value/display)
	return true;
}

function resetDirectoryForm() {
	return true;
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
  if (fname == null || fname == "" || fname.length < 1) {
    setFieldErrorStyles(fnameField, "First name is required.");
    pass = false;
  }

  var emailField = profileForm["email"];
  var email = emailField.value;
  setFieldPassStyles(emailField, "Email");
	if (!validateEmail(emailField)) {
		pass = false;
	}
	
	if (profileForm["sms"] !== undefined) {
  	var smsField = profileForm["sms"];
  	var sms = smsField.value;
  	setFieldPassStyles(smsField, "");
		if (sms != null && sms.length > 0 && !validatePhone(sms)) {
			smsField.value = "";
			setFieldErrorStyles(smsField, "Please enter a valid cell number.");
			pass = false;
		}		
	}
	
	if (profileForm["phone"] !== undefined) {
  	var phoneField = profileForm["phone"];
  	var phone = phoneField.value;
  	setFieldPassStyles(phoneField, "");
 		if (phone != null && phone.length > 0 && !validatePhone(phone)) {
 			phoneField.value = "";
			setFieldErrorStyles(phoneField, "Please enter a valid phone number.");
			pass = false;
		}		
	}
  
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		profileForm.submit();
 	}
}

function organizationBasicValidateAndSubmit(thisForm) {
	
	var organizationBasicForm = document.forms[thisForm];
	var submitButton = document.getElementById(thisForm + "-submit");
	var pass = true;	
	
	var nameField = organizationBasicForm['org-name'];
	var urlField = organizationBasicForm['org-url'];
	var contactNameField  = organizationBasicForm['org-contact-name'];
	var contactTitleField = organizationBasicForm['org-contact-title'];
	var contactEmailField = organizationBasicForm['org-contact-email'];
	var contactPhoneField = organizationBasicForm['org-contact-phone'];
	var streetField = organizationBasicForm['org-street'];
	var cityField = organizationBasicForm['org-city'];
	var countryField = document.getElementById("organization-form-country");
	var stateField = document.getElementById("organization-form-countryStates");

  var name = nameField.value;
	setFieldPassStyles(nameField, "Organization Name");
  if (isEmptyOrLong(name, 100)) {
  	setFieldErrorStyles(nameField, "Organization name is required");
    pass = false;
  }
  
  // TODO - validate url, also in event form
  var url = urlField.value;
	setFieldPassStyles(urlField, "Organization Web Site (http://)");
  if (isEmptyOrLong(url, 100)) {
  	setFieldErrorStyles(urlField, "Organization web site is required");
    pass = false;
  }  
  
  var email = contactEmailField.value;
	setFieldPassStyles(contactEmailField, "Email");
  if (!isValidEmail(email)) {
  	setFieldErrorStyles(contactEmailField, EMAIL_REQUIRED);
  	contactEmailField.value = "";
  	pass = false;
  }
  
	var street = streetField.value;
	setFieldPassStyles(streetField, "Street Address");
	if (isEmptyOrLong(street, 50)) {
		setFieldErrorStyles(streetField, "Street address is required");
		streetField.value = "";
		pass = false;
	}
	
	var city = cityField.value;
	setFieldPassStyles(cityField, "City");
	if (isEmptyOrLong(city, 50)) {
		setFieldErrorStyles(cityField, "City is required");
		cityField.value = "";
		pass = false;
	}

	var country = countryField.value;
	setFieldPassStyles(document.getElementById("organization-form-country-button", "Country"))
	if (country === "AA") {
		setFieldErrorStyles(document.getElementById("organization-form-country-button", "Country"));
		pass = false;
	}

	// TODO - not all countries have states so must revise when we open up country list. Also, could be province.
	// http://www.columbia.edu/~fdc/postal/
	var state = stateField.value;
	setFieldPassStyles(document.getElementById("organization-form-countryStates-button", "States"));
	if (state === "State") {
		setFieldErrorStyles(document.getElementById("organization-form-countryStates-button", "States"));
		pass = false;
	}
	
 	if (Boolean(pass)) {
 		submitButton.disabled = true;  
 		submitButton.innerHTML = "One Moment"; 
 		submitButton.style.opacity = ".6";
 		organizationBasicForm.submit();
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

function switchToOrganizationView() {
	document.getElementById('member_view_control').style.display = "block";
	document.getElementById('directory_view_control').style.display = "none";
	document.getElementById('map_control').style.display = "block";
	document.getElementById('compose_pm').style.display = "none";
	document.getElementById("organizational_directory").style.display = "block";
	document.getElementById("member_directory").style.display = "none";
	var addNewOrg = document.getElementById('add_new_org');
	var addNewMember = document.getElementById('add_new_member');
	if (addNewOrg && addNewMember) {
		addNewOrg.style.display = "block";
		addNewMember.style.display = "none";
	}
}
	
function switchToMemberView() {
	document.getElementById('member_view_control').style.display = "none";
	document.getElementById('directory_view_control').style.display = "block";
	document.getElementById('map_control').style.display = "none";
	document.getElementById('compose_pm').style.display = "block";
	document.getElementById("organizational_directory").style.display = "none";
	document.getElementById("member_directory").style.display = "block";
	var addNewOrg = document.getElementById('add_new_org');
	var addNewMember = document.getElementById('add_new_member');
	if (addNewOrg && addNewMember) {
		addNewOrg.style.display = "none";
		addNewMember.style.display = "block";
	}
}

function populateEventForm(i) {
	/* currentEvents is a global, initialized in the ajax processing */
	var eventForm = document.forms['schedule-form'];	
  if (currentEvents[i].purpose) { eventForm['meeting-name'].value = currentEvents[i].purpose; }
	if (currentEvents[i].url) { eventForm['meeting-url'].value = currentEvents[i].url; }
	if (currentEvents[i].descr) { 
		var descrString = currentEvents[i].descr.replace(new RegExp( '~', 'g' ), '\r\n');
		eventForm['meeting-descr'].innerHTML = descrString;
		eventForm['meeting-descr'].value = descrString;
	}
	if (currentEvents[i].registration) { 
		eventForm['meeting-registr'].innerHTML = currentEvents[i].registration; 
		eventForm['meeting-registr'].value = currentEvents[i].registration;
	}
	if (currentEvents[i].regr_url) { eventForm['registration-url'].value = currentEvents[i].regr_url; }
	if (currentEvents[i].location) { eventForm['meeting-loc'].value = currentEvents[i].location; }
	if (currentEvents[i].tz_extract_name) { eventForm['tzone-name'].value = currentEvents[i].tz_extract_name; }
	if (currentEvents[i].uuid) { eventForm['old-meeting-uuid'].value = currentEvents[i].uuid; }	
	if (currentEvents[i].contact) { eventForm['meeting-contact'].value = currentEvents[i].contact; }
	if (currentEvents[i].group_assoc) { eventForm['orig-group-assoc'].value = currentEvents[i].group_assoc; }
	if (currentEvents[i].recur) { 
		var intervals = {daily:"0", weekly:"2", weekdays:"1"}; 
		var pattern = currentEvents[i].recur_pattern;
		eventForm['repeat-check'].checked = true; 
		eventForm['repeat-interval'].value = intervals[pattern];
		eventForm['repeat-freq'].value = currentEvents[i].recur_num;
		updateRepeatDescr(eventForm['repeat-interval']);
		updateRepeatFreq(eventForm['repeat-freq']);
		document.getElementById("repeat-span").style.visibility = "visible";
		document.getElementById('repeat-edit').style.visibility = "visible";
	}
		
	if (currentEvents[i].fileext) {
		// TODO - put the whole file path into db
		eventForm['old-file-ext'].value = currentEvents[i].fileext;
		document.getElementById("attachment-label").innerHTML = 
		"<b>Attached file: </b> <a href='http://northbridgetech.org/apps/nexus/partner/file/event-" + currentEvents[i].uuid + "." + currentEvents[i].fileext + "' target='_blank'>View</a>";
	}

	var startTime = currentEvents[i].hour_24 + ":" + currentEvents[i].minute + ":00";
	var startOptions = eventForm['meeting-time'];
	var startTimeIndex = "0";

	for (m = 0; m < startOptions.length; m++) {
		if (startOptions.options[m].value == startTime) { 
			startTimeIndex = startOptions.options[m].index; 
			break;
    }
    //txt = txt + "\n" + startOptions.options[m].text + " has index: " + startOptions.options[m].index + " and value: " + startOptions[m].value;
  }
	startOptions.selectedIndex = startTimeIndex;
	$( "#schedule-form-time" ).selectmenu( "refresh" );
		
	var endTime = currentEvents[i].hour_end_24 + ":" + currentEvents[i].minute_end + ":00";
	var endOptions = eventForm['meeting-time-end'];
	var endTimeIndex = "0";
	for (m = 0; m < endOptions.length; m++) {
		if (endOptions.options[m].value == endTime) { 
			endTimeIndex = endOptions.options[m].index; 
			break;
    }
  }
	endOptions.selectedIndex = endTimeIndex;  
	$( "#schedule-form-time-end" ).selectmenu( "refresh" );
		
	var startDate = 
		(currentEvents[i].month_num.length < 2 ? "0" : "") +
		currentEvents[i].month_num + 
		"/" + 
		(currentEvents[i].date.length < 2 ? "0" : "") +
		currentEvents[i].date + 
		"/" + 
		currentEvents[i].year;
	var endDate = 
		(currentEvents[i].month_num_end.length < 2 ? "0" : "") +
		currentEvents[i].month_num_end + 
		"/" + 
		(currentEvents[i].date_end.length < 2 ? "0" : "") +
		currentEvents[i].date_end + 
		"/" + 
		currentEvents[i].year_end;
	eventForm['meeting-date'].value = startDate;
	eventForm['meeting-date-end'].value = endDate;
	//document.getElementById('schedule-form-submit').innerHTML = "Update";
	document.getElementById('schedule-form-submit').innerHTML = "Approve";
	document.getElementById('schedule-form-submit').disabled = false;
	eventForm['meeting-uuid'].value = currentEvents[i].uuid;

	return true;
}
	
function eventValidateAndSubmit(thisForm) {

	pass = true;
	var eventForm = document.forms[thisForm];
	var submitButton = document.getElementById(thisForm + "-submit");	
	var timeZoneOffset = timeZoneOffsets[eventForm['tzone-name'].value];

  var time = eventForm['meeting-time'].value;
	var dateField = eventForm['meeting-date'];
	var date = dateField.value;
	
  var timeEnd;
	var dateFieldEnd;
	var dateEnd;  
	
	var isTimeEnd = (eventForm['meeting-time-end'] !== undefined ? true : false);
	var isDateEnd = (eventForm['meeting-date-end'] !== undefined ? true : false);
  
  setFieldPassStyles(dateField, "Start Date");
	if (validateDateFormat(dateField)) {
		if (!validateTimeFuture(dateField, time, timeZoneOffset)) {
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
  		if (Boolean(isTimeEnd)) {
  			timeEnd = eventForm['meeting-time-end'].value;
				setFieldPassStyles(document.getElementById(thisForm + "-time-end-button"), "End Time");
				if (timeEnd == null || timeEnd == "" || timeEnd == "End Time" || !validateTimeFuture(dateFieldEnd, timeEnd, timeZoneOffset)) {
					setFieldErrorStyles(document.getElementById(thisForm + "-time-end-button"), "End Time");
					pass = false;
				}	
  		}
		} else {
			if (Boolean(isTimeEnd)) {
				timeEnd = eventForm['meeting-time-end'].value;
				setFieldPassStyles(document.getElementById(thisForm + "-time-end-button"), "End Time");
				if (timeEnd == null || timeEnd == "" || timeEnd == "End Time") {
					setFieldErrorStyles(document.getElementById(thisForm + "-time-end-button"), "End Time");
				}	
			}				
			setFieldErrorStyles(eventForm['meeting-date-end'], "mm/dd/yyyy");
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
  
	if (eventForm['repeat-check'] !== undefined) {
		if (eventForm['repeat-check'].checked) {
			// TODO - validate repeat-freq and repeat-interval
  		var eventEndEpoch = Date.parse(createTimeStampString(eventForm['meeting-date-end'].value, eventForm['meeting-time-end'].value));
  		var numRealDaysToPass = getDaysPassing(eventForm['repeat-freq'].value, eventForm['repeat-interval'].value, eventForm['meeting-date-end'].value);
  		var epochSpan = numRealDaysToPass*24*60*60*1000;
  		eventForm['meeting-recur-duration'].value = millisecondsToFormat("#MM#/#DD#/#YYYY# #hh#:#mm#:#ss#", eventEndEpoch+epochSpan);
		} else {
			eventForm['meeting-recur-duration'].value = 0;
		}
	}
	
 	var nameField = eventForm['meeting-name'];
  var name = nameField.value;
	setFieldPassStyles(nameField, "Meeting Name");
  if (name == null || name == "" || name.length > 100) {
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
 
	if (eventForm['meeting-type'] !== undefined) {
  	var typeField = eventForm['meeting-type'];
  	var typeValue = typeField.value;
  	setFieldPassStyles(document.getElementById(thisForm + "-type-button"), "Meeting Type");
  	if (typeValue == null || typeValue == "" || typeValue == "Meeting Type") {
	  	setFieldErrorStyles(document.getElementById(thisForm + "-type-button"), "Meeting Type");
    	pass = false;
  	}
  }
  
	// Find a better way to do this. Why am I doing this? It's a hidden field...
  var forApproval = false;
  var contact = "";
  if (eventForm['meeting-contact'] !== undefined && eventForm['meeting-contact'].value.length > 0) {
  	forApproval = true;
  	var contactField = eventForm['meeting-contact'];
  	contact = contactField.value;
  	setFieldPassStyles(contactField, "Contact Email");
  	if (!isValidEmail(contact)) {
  		setFieldErrorStyles(contactField, EMAIL_REQUIRED);
  		contactField.value = "";
  		pass = false;
  	}  	
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

function isEmptyOrLong(value, maxLength) {
	if (value == null || value == "" || value.length > maxLength) {
		return true;
	}
	return false;
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

function validateTimeFuture(dateField, time, zoneOffset) {
  var nowEpoch = Date.now();
  var reserveEpoch = Date.parse(createTimeStampString(dateField.value, time + zoneOffset));
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

// LEFT OFF writing this method
function secondsToFriendlyTime(s) {
	var sNum = Number(s);
	var sign = "";
	if (sNum < 0) {
		sNum = Math.abs(sNum);
		sign = "-";
	}
	var dayEquiv = 24*60*60;
	var hourEquiv = 60*60;
	if (sNum < hourEquiv*6) {
		// less than six hours in future
		var h = Math.floor(sNum / hourEquiv);
		var m = Math.floor(sNum % hourEquiv / 60);
		var s = Math.floor(sNum % hourEquiv % 60);
		return (sign + (h > 0 ? h + ":" : "00:") + (m > 0 ? (h > 0 && m < 10 ? "0" : "") + m + ":" : "00:") + (s > 0 ? (m > 0 && s < 10 ? "0" : "") + s + "" : "00"));
	} else if (sNum < dayEquiv) {
		// between 6 and 24 hours in future
		var h = Math.floor(sNum/hourEquiv);
		return (sign + h + " hours");;
	} else {
		// greater than 24 hours in future
		var d = Math.floor(sNum/dayEquiv);
		return (sign + d + " days"); 
	}
}

function validateTimeFormat(t) {
	// TODO - complete this
	return true;
}

function getDaysPassing(num, freq, start) {
	var curDate = new Date(start);
	// Note: Subtract 1 from each calculation to remove the first event date from the days passed calculation
	switch(parseInt(freq)) {
		case 0:
			return parseInt(num) - 1;
		case 2:
			return parseInt(num * 7) - 1;
		case 1:
			var loopCount = 0;
			var weekdayCount = 0;
  	  while (weekdayCount < num) {
        curDate.setDate(curDate.getDate() + 1);
        var dayOfWeek = curDate.getDay();
        if ((dayOfWeek > 0) && (dayOfWeek < 6)) {
           weekdayCount++;
         }
        loopCount++;
    	}
    	return loopCount - 1;
	}
	return 1;
}

function millisecondsToFormat(formatString, ms){
	var thisDate = new Date(ms);
  var YYYY,YY,MMMM,MMM,MM,M,DDDD,DDD,DD,D,hhhh,hhh,hh,h,mm,m,ss,s,ampm,AMPM,dMod,th;
  YY = ((YYYY=thisDate.getFullYear())+"").slice(-2);
  MM = (M=thisDate.getMonth()+1)<10?('0'+M):M;
  MMM = (MMMM=["January","February","March","April","May","June","July","August","September","October","November","December"][M-1]).substring(0,3);
  DD = (D=thisDate.getDate())<10?('0'+D):D;
  DDD = (DDDD=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][thisDate.getDay()]).substring(0,3);
  th=(D>=10&&D<=20)?'th':((dMod=D%10)==1)?'st':(dMod==2)?'nd':(dMod==3)?'rd':'th';
  formatString = formatString.replace("#YYYY#",YYYY).replace("#YY#",YY).replace("#MMMM#",MMMM).replace("#MMM#",MMM).replace("#MM#",MM).replace("#M#",M).replace("#DDDD#",DDDD).replace("#DDD#",DDD).replace("#DD#",DD).replace("#D#",D).replace("#th#",th);
  h=(hhh=thisDate.getHours());
  if (h==0) h=24;
  if (h>12) h-=12;
  hh = h<10?('0'+h):h;
  hhhh = hhh<10?('0'+hhh):hhh;
  AMPM=(ampm=hhh<12?'am':'pm').toUpperCase();
  mm=(m=thisDate.getMinutes())<10?('0'+m):m;
  ss=(s=thisDate.getSeconds())<10?('0'+s):s;
  return formatString.replace("#hhhh#",hhhh).replace("#hhh#",hhh).replace("#hh#",hh).replace("#h#",h).replace("#mm#",mm).replace("#m#",m).replace("#ss#",ss).replace("#s#",s).replace("#ampm#",ampm).replace("#AMPM#",AMPM);
};
window.addEventListener("load", populateWebMeetUrls);
var domain = "northbridgetech.org";
var path = "/apps";

function populateWebMeetUrls(){
  var desktopUrl = "https://northbridgetech.org/apps/nexus/";
  
  chrome.management.get(chrome.runtime.id, function(extnInfo){
	var extnInstallType = extnInfo.installType;
	if(extnInstallType === "development"){
		path = "/dev";
	}
  });
  
	chrome.cookies.getAll({"domain":domain, "path":path}, function(cookies){
    var channelItems = document.getElementById("channel_list");
    var cookieVals;

    cookies.forEach(function(value, index, array) {
      if (cookies[index].name == 'remembered_groups') {
        cookieVals = cookies[index].value.split('%2C');
        //cookieVals = "12345678%2Ccfa975fd%2Cuserdemo".split('%2C');
      }
    });

    cookieVals.forEach(function(value, index, array) {
      var link = document.createElement("a");
      link.setAttribute("href", desktopUrl + "web/login.php?oid=" + value);
      link.setAttribute("class", "list-group-item list-group-item-action");
      link.setAttribute("target", "_blank");
      link.innerHTML = value; 
      channelItems.appendChild(link);
    });

  });
}

function getCookies(cname, cookies) {
  var name = cname + "=";
  //alert("+>" + document.cookie);
  var decodedCookie = decodeURIComponent(cookies);
  var ca = decodedCookie.split(';');
  for(var i = 0; i <ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}
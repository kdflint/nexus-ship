window.addEventListener("load", populateWebMeetUrls);

function populateWebMeetUrls(){
  //var cookieVal;
  chrome.cookies.getAll({"url":"https://northbridgetech.org/apps/nexus/web/login.php"}, function(cookies){

    var channelItems = document.getElementById("channel_list");
    var cookieVals;

    cookies.forEach(function(value, index, array) {
      if (cookies[index].name == 'remembered_oids') {
        cookieVals = cookies[index].value.split('%2C');
        //cookieVals = "12345678%2Ccfa975fd%2Cuserdemo".split('%2C');
      }
    });

    cookieVals.forEach(function(value, index, array) {
      var link = document.createElement("a");
      link.setAttribute("href", "https://northbridgetech.org/dev/nexus/web/login.php?oid=" + value);
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
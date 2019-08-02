window.addEventListener("load", populateWebMeetUrls);
function populateWebMeetUrls(){

    //document.cookie="12345678%2Ccfa975fd%2Cuserdemo";
    //var cookieVal = document.cookie;
    var cookieVal = getCookie('remembered_oids');
 
    //var rrItems = document.getElementById("rritemslist");
    var channelItems = document.getElementById("channel_list");

    if (cookieVal) {

    var cookieVal_array = cookieVal.split('%2C');
    
        for(var i=0; i<cookieVal_array.length;i++){
            var opt = cookieVal_array[i];
            //var el = document.createElement("option");
            //el.textContent = opt;
            //el.value = opt;
            //rrItems.appendChild(el);

            // https://stackoverflow.com/questions/16503879/chrome-extension-how-to-open-a-link-in-new-tab
            var link = document.createElement("a");
            link.setAttribute("href", "https://northbridgetech.org/dev/nexus/web/login.php?oid=" + opt);
            link.setAttribute("class", "list-group-item list-group-item-action");
            link.setAttribute("target", "_blank");
            link.innerHTML = opt;
            channelItems.appendChild(link);
        }
    }
}

// TODO - this method works in a standard web page.
// Make it work with the chrome API.
function getCookie(cname) {
    var name = cname + "=";
    alert("+>" + document.cookie);
    var decodedCookie = decodeURIComponent(document.cookie);
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

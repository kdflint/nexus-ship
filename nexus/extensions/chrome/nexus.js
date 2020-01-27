var background = chrome.extension.getBackgroundPage(); 
var anchorStash = new Array();
var isAuthenticated = false;

window.addEventListener("load", createAlarm);
window.addEventListener("load", populateWebMeetUrls);

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    // TODO - remove link when meeting is no longer in the list
    if (request.msg == "join_meeting") {
      background.console.log("Got message to join meeting.");
      populateJoinMeetingUrl(request.data);
    }
    if (request.msg == "clear_meetings") {
      background.console.log("Got message to clear meetings.");
    }
  }
);

function createAlarm() {
  chrome.alarms.create('meeting-poll', {
    when: 0, periodInMinutes: 1});
}

function populateJoinMeetingUrl(data) {
  if (isAuthenticated) {
    // If we haven't already set a Join badge
    if (!document.getElementById(data.uuid) && data.purpose != "Demo Meeting") {
      var a = document.getElementById(data.group_name);
      if (a) {
        // LEFT OFF - is this right? Hmmm, must reset the href on this anchor and remove the span element
        anchorStash.push(a);
        a.href = "https://northbridgetech.org" + background.urlPath + "/nexus/web/modules/meeting/control/joinMeetingProcessor.php?id=" + data.uuid + "&type=" + data.type;
        a.innerHTML = data.group_name + 
        "<span class='badge badge-primary badge-pill'>Join</span>"; 
      }
    }
  }
}

function populateWebMeetUrls() {

  var desktopUrl = "https://" + background.domain + background.urlPath + "/nexus/web/login.php";
  
  var cookieParms = {"domain":background.domain, "path":background.cookiePath};
  chrome.cookies.getAll(cookieParms, function(cookies){
    background.console.log("Cookie list: " + JSON.stringify(cookies));

    var channelItems = document.getElementById("channel_list");
    var channelLabel = document.getElementById("channel_label");
    var groups;
    var orgs;

    cookies.forEach(function(value, index, array) {
      background.console.log(value);
      if (cookies[index].name === 'remembered_groups') {
        var dec = decodeURI(cookies[index].value).replace(/%3A/g,":").replace(/\+/g, " ").replace(/%2C/g, ",");
        try {
          groups = JSON.parse(dec);
        } catch {}
      }
      if (cookies[index].name === 'remembered_orgs') {
        var dec = decodeURI(cookies[index].value).replace(/%3A/g,":").replace(/\+/g, " ").replace(/%2C/g, ",");
        try {
          orgs = JSON.parse(dec);
        } catch {}
      }
    });

    if (orgs && orgs.length > 0) {
      if (orgs.length == 1) {
        orgs.forEach(function(value, index, array) {
          if (value['uid'] != 'userdemo') {
            channelLabel.innerHTML = "My Channels";
            channelItems.appendChild(configureChannelLink(value['name'], desktopUrl + "?oid=" + value['uid'], value['name']));
          } else {
            channelItems.appendChild(configureChannelLink('Nexus Web Meet Demonstration', desktopUrl + "?oid=userdemo"), 'userdemo');
          }
        });
      } else {
        orgs.forEach(function(value, index, array) {
          if (value['uid'] != 'userdemo') {
            channelLabel.innerHTML = "My Channels";
            channelItems.appendChild(configureChannelLink(value['name'], desktopUrl + "?oid=" + value['uid'], value['name']));
          }
        });
      }
    } else {
      channelItems.appendChild(configureChannelLink('Nexus Web Meet Demonstration', desktopUrl + "?oid=userdemo"), 'userdemo');
    }

  });

  cookieParms =  {"domain":background.domain, "path":"/"};
  chrome.cookies.getAll(cookieParms, function(cookies) {
    background.console.log("Checking for authenticated session... ");
    cookies.forEach(function(value, index, array) {
      if (cookies[index].name === 'REMEMBERME') {
        isAuthenticated = true;
      }
    });
    background.console.log(isAuthenticated);
  });

}

function configureChannelLink(label, url, id) {
  var a = document.createElement("a");
  a.setAttribute("id", id);
  a.setAttribute("href", url);
  a.setAttribute("class", "list-group-item d-flex justify-content-between align-items-center list-group-item-action");
  a.setAttribute("target", "_blank");
  a.innerHTML = label; 
  return a;
}
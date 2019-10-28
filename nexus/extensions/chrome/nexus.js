window.addEventListener("load", createAlarm);
window.addEventListener("load", populateWebMeetUrls);

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    // TODO - remove link when meeting is no longer in the list
    populateJoinMeetingUrl(request.data);
  }
);

function createAlarm() {
  chrome.alarms.create('meeting-poll', {
    when: 0, periodInMinutes: 1});
}

function populateJoinMeetingUrl(data) {
  if (!document.getElementById(data.uuid) && data.purpose != "Demo Meeting") {
    var linkDiv = document.getElementById("running_meeting_list");
    var p = document.createElement("p");
    var a = document.createElement("a");
    // TODO - make link url dynamic to environment
    a.setAttribute("href", "https://northbridgetech.org/apps/nexus/web/modules/meeting/control/joinMeetingProcessor.php?id=" + data.uuid + "&type=" + data.type);
    a.setAttribute("target", "_blank");
    a.setAttribute("id", data.uuid);
    a.innerHTML = data.purpose; 
    p.appendChild(a);
    linkDiv.appendChild(p);
  }
}

function populateWebMeetUrls(){
  // TODO - make link url dynamic to environment
  var desktopUrl = "https://northbridgetech.org/apps/nexus/";
  chrome.cookies.getAll({"url":desktopUrl}, function(cookies){

    var channelItems = document.getElementById("channel_list");
    var groups;
    var orgs;

    cookies.forEach(function(value, index, array) {
      if (cookies[index].name == 'remembered_groups') {
        var dec = decodeURI(cookies[index].value).replace(/%3A/g,":").replace(/\+/g, " ").replace(/%2C/g, ",");
        try {
          groups = JSON.parse(dec);
        } catch {}
      }
      if (cookies[index].name == 'remembered_orgs') {
        var dec = decodeURI(cookies[index].value).replace(/%3A/g,":").replace(/\+/g, " ").replace(/%2C/g, ",");
        try {
          orgs = JSON.parse(dec);
        } catch {}
      }
    });

    if (orgs && orgs.length > 0) {
      orgs.forEach(function(value, index, array) {
        if (value['uid'] != 'userdemo') {
          var a = document.createElement("a");
          channelItems.appendChild(configureChannelLink(a, value['name'], desktopUrl + "web/login.php?oid=" + value['uid']));
        }
      });
    } else {
      var a = document.createElement("a");
      channelItems.appendChild(configureChannelLink(a, 'Demo Channel', desktopUrl + "web/login.php?oid=userdemo"));      
    }

  });
}

function configureChannelLink(a, label, url) {
  a.setAttribute("href", url);
  a.setAttribute("class", "list-group-item list-group-item-action");
  a.setAttribute("target", "_blank");
  a.innerHTML = label; 
  return a;
}
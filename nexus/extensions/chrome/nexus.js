window.addEventListener("load", createAlarm);
window.addEventListener("load", populateWebMeetUrls);

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    // TODO - remove link when meeting is no longer in the list
    if (request.msg == "join_meeting") {
      populateJoinMeetingUrl(request.data);
    }
    if (request.msg == "clear_meetings") {
      console.log("hi!");
    }
  }
);

var anchorStash = new Array();

function createAlarm() {
  chrome.alarms.create('meeting-poll', {
    when: 0, periodInMinutes: 1});
}





function populateJoinMeetingUrl(data) {
  // when do we set a element id = data.uuid. Is below a mistake?
  if (!document.getElementById(data.uuid) && data.purpose != "Demo Meeting") {
    var a = document.getElementById(data.group_name);
    if (a) {
      // LEFT OFF - is this right? Hmmm, must reset the href on this anchor and remove the span element
      anchorStash.push(a);
      a.href = "https://northbridgetech.org/apps/nexus/web/modules/meeting/control/joinMeetingProcessor.php?id=" + data.uuid + "&type=" + data.type;
      a.innerHTML = data.group_name + 
      "<span class='badge badge-primary badge-pill'>Join</span>"; 
    }
  }
}

function populateWebMeetUrls() {

  var domain = "northbridgetech.org";
  var path = "/apps";

  chrome.management.get(chrome.runtime.id, function(extnInfo) {
    var extnInstallType = extnInfo.installType;
    if(extnInstallType === "development"){
      path = "/dev";
    }
  });
  
  var desktopUrl = "https://" + domain + path + "/nexus/web/login.php";

  chrome.cookies.getAll({"domain":domain, "path":path}, function(cookies){

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
          channelItems.appendChild(configureChannelLink(value['name'], desktopUrl + "?oid=" + value['uid'], value['name']));
        }
      });
    } else {
      channelItems.appendChild(configureChannelLink('Demo Channel', desktopUrl + "?oid=userdemo"), 'userdemo');
    }

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
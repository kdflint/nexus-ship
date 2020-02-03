var domain = "northbridgetech.org";
var cookiePath = "/prod";
var urlPath = "/apps";

chrome.management.get(chrome.runtime.id, function(extnInfo) {
  var extnInstallType = extnInfo.installType;
  console.log("Install mode: " + extnInstallType);
  if(extnInstallType == "development"){
    cookiePath = "/dev";
    urlpath = "/dev";
  }
});

chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab)
{
    console.log(tab);
    var action_url = "https://northbridgetech.org" + urlPath + "/nexus/web/login.php";
    chrome.tabs.create({url: action_url});
}

chrome.alarms.onAlarm.addListener(function(alarm) {
  // TODO - api should not respond if auth token is not set
  if (alarm.name === "meeting-poll") {
    console.log("Check for running meeting...", alarm);
    let xhr = new XMLHttpRequest;
    let apiUrl = 'https://northbridgetech.org' + urlPath + '/nexus/web/api/getRunningMeetings.php';
    console.log(apiUrl);
    xhr.open('GET', apiUrl, true)
    xhr.onload = function() {
      if (this.status === 200) {
        console.log("got a response of 200: " + this.responseText);
        if (this.responseText.length > 0 && this.responseText.indexOf('unauthenticated') < 0  && this.responseText.indexOf('none') < 0) {
          var payload = JSON.parse(this.responseText);
          payload.forEach(function(value, index, array) {
            chrome.runtime.sendMessage({
              msg: "join_meeting", 
              data: {
                  uuid: value.uuid,
                  type: value.mtype,
                  purpose: value.purpose,
                  group_name: value.group_name
              }
            });
          });
        } else {
          // TODO - this isn't right but on the right track
          chrome.runtime.sendMessage({
            msg: "clear_meetings"
          });
        }
      }
    }
    xhr.send();
  }
});


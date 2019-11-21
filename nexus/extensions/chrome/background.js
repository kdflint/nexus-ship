chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab)
{
    console.log(tab);
    var action_url = "https://northbridgetech.org/apps/nexus/web/login.php";
    chrome.tabs.create({url: action_url});
}

chrome.alarms.onAlarm.addListener(function(alarm) {
  if (alarm.name === "meeting-poll") {
    console.log("Check for running meeting...", alarm);
    let xhr = new XMLHttpRequest;
    // TODO - make api url dynamic on environment
    xhr.open('GET', 'https://northbridgetech.org/apps/nexus/web/api/getRunningMeetings.php', true)
    xhr.onload = function() {
      if (this.status === 200) {
        if (this.responseText.length > 0 && this.responseText.indexOf('unauthenticated') < 0) {
        //if (false) {
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
          chrome.runtime.sendMessage({
            msg: "clear_meetings"
          });
        }
      }
    }
    xhr.send();
  }
});

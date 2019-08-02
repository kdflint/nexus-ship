chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab){
    console.log(tab);
    var action_url = "https://northbridgetech.org/apps/nexus/web/login.php";
    chrome.tabs.create({url: action_url});
}

function createAlarm() {
    chrome.alarms.create("1min", {
      delayInMinutes: 0.1, periodInMinutes: 0.1});
  }


chrome.alarms.onAlarm.addListener(function(alarm) {
  //if (alarm.name === "1min") {
  //  alert("alarm bells");
  //}
});
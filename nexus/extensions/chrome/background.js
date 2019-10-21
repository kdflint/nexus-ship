chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab)
{
    console.log(tab);
    var action_url = "https://northbridgetech.org/apps/nexus/web/login.php";
    chrome.tabs.create({url: action_url});
}

chrome.alarms.onAlarm.addListener(function(alarm) 
{
  if (alarm.name === "meetingPoll") {
    console.log("Check for running meeting...", alarm);
  }
});

chrome.runtime.onMessage.addListener(gotMessage);

function gotMessage(request, sender, sendResponse){
  console.log(sender);
  /*
  chrome.cookies.getAll({"url":"https://northbridgetech.org/apps/nexus/web/login.php"}, function(cookies){
    //sendResponse({cookiesList: cookies});
    alert(JSON.stringify({cookiesList: cookies}));
  });
  */
}


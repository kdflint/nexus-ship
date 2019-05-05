chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab){
    console.log(tab);
    var action_url = "https://northbridgetech.org/apps/nexus/web/login.php";
    chrome.tabs.create({url: action_url});
}
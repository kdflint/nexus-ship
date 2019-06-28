window.addEventListener("load", populateWebMeetUrls);
function populateWebMeetUrls(){
    document.cookie="12345678%2Ccfa975fd%2Cuserdemo";
    var cookieVal = document.cookie;
    console.log(cookieVal);

    var rrItems = document.getElementById("rritemslist");

    var cookieVal_array = cookieVal.split('%2C');
    for(var i=0; i<cookieVal_array.length;i++){
        var opt = cookieVal_array[i];
        var el = document.createElement("option");

        el.textContent = opt;
        el.value = opt;

        rrItems.appendChild(el);
    }
}
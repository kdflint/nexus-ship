function toggleDisplay(elementId) {
  hideAll();
  showSelected(elementId);
} 

function toggleDisplay2(elementId) {
  hideAll2();
  showSelected(elementId);
} 

function showSelected(elementId) {
	var textElement = document.getElementById(elementId);
  textElement.style.display = 'block';
}

function hideAll() {
  document.getElementById('detail').style.display = 'none';
  document.getElementById('browse').style.display = 'none';
  document.getElementById('default').style.display = 'none';
  document.getElementById('reply').style.display = 'none';
}

function hideAll2() {
  document.getElementById('reply').style.display = 'none';
}

function popup(mylink, windowname) {
	if (! window.focus) return true;
	var href;
	if (typeof(mylink) == 'string') {
   	href=mylink;
   } else {
   	href=mylink.href;
   }
	window.open(href, windowname, 'width=600,height=400,scrollbars=yes');
	return false;
}

/*
Written by Matthew Harvey (matt AT unlikelywords DOT com)
(http://www.unlikelywords.com/html-morsels/)
Distributed under the Creative Commons 
"Attribution-NonCommercial-ShareAlike 2.0" License
(http://creativecommons.org/licenses/by-nc-sa/2.0/)
*/
function drawPercentBar(width, percent, color, background) { 
  var pixels = width * (percent / 100); 
  if (!background) { background = "none"; }

  document.write("<div style=\"position: relative; line-height: 1em; background-color: " 
                 + background + "; border: 1px solid black; width: " 
                 + width + "px\">"); 
  document.write("<div style=\"height: 1.5em; width: " + pixels + "px; background-color: "
                 + color + ";\"></div>"); 
  document.write("<div style=\"position: absolute; text-align: center; padding-top: .25em; width: " 
                 + width + "px; top: 0; left: 0\">" + percent + "%</div>"); 

  document.write("</div>"); 
} 

function currentTime() {
	var currentTime = new Date()
	var month = currentTime.getMonth()+1
	var date = currentTime.getDate()
	var hours = currentTime.getHours()
	var minutes = currentTime.getMinutes()

	if (minutes < 10) {
		minutes = "0" + minutes
	}
	
	var suffix = "AM";
	if (hours >= 12) {
		suffix = "PM";
		hours = hours - 12;
	}
	if (hours == 0) {
		hours = 12;
	}
	document.write("<b>" + month + "/" + date + "</b>")
}

function post(to, p) {
  var myForm = document.createElement("form");
  myForm.method="post" ;
  myForm.action = to ;
  for (var k in p) {
    var myInput = document.createElement("input") ;
    myInput.setAttribute("name", k) ;
    myInput.setAttribute("value", p[k]);
    myForm.appendChild(myInput) ;
  }
  document.body.appendChild(myForm) ;
  myForm.submit() ;
  document.body.removeChild(myForm) ;
}

function test() {
		alert("test from script.js");
}

function displayTeamProfile() {
	document.getElementById("demo").innerHTML=Date();
}

function toggle(showHideDiv, switchImgTag) {
 	var ele = document.getElementById(showHideDiv);
   var imageEle = document.getElementById(switchImgTag);
   if(ele.style.display == "block") {
   	ele.style.display = "none";
		imageEle.innerHTML = '<img style="margin:5px;" src="images/plus.png" height="15" width="15" />';
   }
   else {
    ele.style.display = "block";
     imageEle.innerHTML = '<img style="margin:5px;" src="images/minus.png" height="15" width="15" />';
   }
}

function toggleChat(showHideDiv) {
 	var ele = document.getElementById(showHideDiv);
  if(ele.style.display == "block") {
   	ele.style.display = "none";
   }
   else {
    ele.style.display = "block";
   }
}

function initialize() {
	var myLatlng1 = new google.maps.LatLng(41.779732, -87.64583);
	var myLatlng2 = new google.maps.LatLng(41.708770, -87.74680);
  var mapOptions = {
    center: myLatlng1,
    zoom: 11
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
  
  var marker1 = new google.maps.Marker({
    position: myLatlng1,
    map: map,
    title: 'Englewood Community Health Services'
  });
  
  var marker2 = new google.maps.Marker({
    position: myLatlng2,
    map: map,
    title: 'Oak Lawn Neighborhoods for Peace'
  });
}

function initialize1() {
	var myLatlng1 = new google.maps.LatLng(41.779732, -87.64583);
	var myLatlng2 = new google.maps.LatLng(41.708770, -87.74680);
  var mapOptions = {
    center: myLatlng1,
    zoom: 11
  };
  var map = new google.maps.Map(document.getElementById("map-canvas1"),
      mapOptions);
  
  var marker1 = new google.maps.Marker({
    position: myLatlng1,
    map: map,
    title: 'Englewood Community Health Services'
  });
  
  var marker2 = new google.maps.Marker({
    position: myLatlng2,
    map: map,
    title: 'Oak Lawn Neighborhoods for Peace'
  });
}

function initialize2() {
	var myLatlng1 = new google.maps.LatLng(42.0194, -87.6715);
  var mapOptions = {
    center: myLatlng1,
    zoom: 12
  };
  var map = new google.maps.Map(document.getElementById("map-canvas2"),
      mapOptions);
  
  var marker1 = new google.maps.Marker({
    position: myLatlng1,
    map: map,
    title: 'Howard Street Connections'
  });  
}

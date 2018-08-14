// startsWith function not implemented in IE. This will supply a body to the function when browser does not.
// http://stackoverflow.com/questions/30867172/code-not-running-in-ie-11-works-fine-in-chrome

if (!String.prototype.startsWith) {
  String.prototype.startsWith = function(searchString, position) {
    position = position || 0;
    return this.indexOf(searchString, position) === position;
  };
}

function sizeAvatar(containerId, imgClass) {
	// The avatar image display resolution will automatically adjust by means of style sheet to a max-height of 90 with width proportional
	// If the adjusted resolution yields a width of > 90, this function will re-adjust to make max-width = 90 and height proportional
	if (document.getElementById(containerId)) {
		var img = document.getElementById(containerId).getElementsByClassName(imgClass)[0];
		if (img) {
			var height = parseInt(img.height);
			var width = parseInt(img.width);
			if (width > 90) {
				var heightCalc = (90/width) * height;
				img.style.width = "90px";
				img.style.height =  heightCalc + "px";
			}
		}
	}
}

// startsWith function not implemented in IE. This will supply a body to the function when browser does not.
// http://stackoverflow.com/questions/30867172/code-not-running-in-ie-11-works-fine-in-chrome

if (!String.prototype.startsWith) {
  String.prototype.startsWith = function(searchString, position) {
    position = position || 0;
    return this.indexOf(searchString, position) === position;
  };
}

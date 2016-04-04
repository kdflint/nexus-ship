/*

                detectJava_28.js v0.5.4
                By Eric Gerds   http://www.pinlady.net/PluginDetect/



 USAGE:
  1) This script works together with the PluginDetect script and with VerifyApplet.js.
     VerifyApplet.js is optional.
     When you download/generate the PluginDetect script, make sure that the
     "Java" checkbox is selected.
     See http://www.pinlady.net/PluginDetect/download/
     
  2) Insert the PluginDetect script and VerifyApplet.js into the <head> or <body> of your web page.

  3) Insert the output <div> into the <body> of your HTML page. This <div> will receive the
     plugin detection results:
        <div id="javaresult"></div>

  4) If you wish to specify the plugindetect <div>, then insert it into the <body>,
     anywhere BEFORE the plugin detection begins.
     This <div> temporarily holds any plugin object that is inserted into the web page,
     but only when needed for detection.
     For example:
        <div id="plugindetect" style="right:0px; top:0px; position:absolute;"></div>
     This step is optional, as PluginDetect will create and insert the <div> automatically
     when needed.

  5) Insert this script AFTER the PluginDetect script, AFTER the output <div>,
     and AFTER the plugindetect <div> (assuming you specifed the plugindetect <div>).

  6) Get a copy of the "getJavaInfo.jar" jarfile. The jarfile is needed for Java detection.
     Adjust the value of the "jarfile" variable (given in the code below) to reflect the 
     jarfile name and path.

     Examples...

     If your web page is at      http://www.mysite.com/webpage.htm
     and you have the jarfile at http://www.mysite.com/getJavaInfo.jar
     then jarfile = "getJavaInfo.jar"  (relative path, relative to the web page)

     If your web page is at       http://www.mysite.com/webpage.htm
     and you have the jarfile at  http://www.mysite.com/stuff/getJavaInfo.jar
     then jarfile = "stuff/getJavaInfo.jar"   (relative path, relative to the web page)
     or   jarfile = "/stuff/getJavaInfo.jar"  (absolute path)

  7) Feel free to change this script, remove comments, etc... to fit your own needs.


*/


(function(){

var $ = PluginDetect,

 minVersion = "1,7,0,65",      // minimum version of Java we are trying to detect

// The path of the jarfile can be relative or absolute.
// Only the very first Java PluginDetect command that is executed
// needs to have the jarfile input argument. You do not have to specify this input arg in
// any subsequent Java PluginDetect commands.
 jarfile = "../files/getJavaInfo.jar",

// If the verifyTags input argument is not specified or is null, then PluginDetect assumes
// a default value. Only the very first Java PluginDetect command that is executed
// would need to have the verifyTags input argument, if at all. You do not have to specify
// this input arg in any subsequent Java PluginDetect commands.
 verifyTags = [2.8,2.8,2.8],

 // Detection results are placed in <div> with this id.
 outputID = "javaresult";


// -----------------------------------------------------


// output <div>.
var out = document.getElementById(outputID);


// Add text to output node
var docWrite = function(text){
     if (out){
        if (text){
          text = text.replace(/&nbsp;/g,"\u00a0");
          out.appendChild(document.createTextNode(text));
        }
        out.appendChild(document.createElement("br"));
     }
};  // end of function




// This event handler writes the detection results to the web page
function displayResults($){

  // Display the highest installed Java version.
  if ($.getVersion) docWrite("Highest Installed Java Version: " + $.getVersion("Java"));


  // Test whether Java is installed or not.
  //
  // Note that $.isMinVersion("Java") is equivalent to $.isMinVersion("Java", "0").
  if ($.isMinVersion)
  {
  
    docWrite("Java (using <applet> and/or <object> tag) installed & enabled: " +
      ($.isMinVersion("Java") >= 0 ? "true" : "false"));
      

    // Check if some minimum Java version is installed
    var JavaStatus = $.isMinVersion("Java", minVersion);

    if (JavaStatus == 1)
      docWrite("Java " + minVersion + 
      " or higher (using <applet> and/or <object> tag) is installed & enabled.")

    else if (JavaStatus === 0) docWrite("Java installed & enabled but version is unknown")

    else if (JavaStatus == -0.1) docWrite("Java installed & enabled but version is < " + minVersion)

    else if (JavaStatus == -0.2) docWrite("Java installed but not enabled")

    // if this function is called by $.onDetectionDone(), then detection has completed,
    // and so -.5/+.5 would not occur.
    else if (JavaStatus == -0.5 || JavaStatus == 0.5)
      docWrite("Java detection: not completed yet, requires NOTF detection.")

    else if (JavaStatus == -1) docWrite("Java not installed / not enabled")
    
    else if (JavaStatus == -3) docWrite("Error...bad input argument to PluginDetect method");

  }


  // Get extra info on the Java plugin.
  var INFO = $.getInfo ? $.getInfo("Java") : null;
  if (INFO)
  {

     // INFO.getDeploymentToolkitObj is usually not needed
     // docWrite("getDeploymentToolkitObj( ): " + INFO.getDeploymentToolkitObj( ) );

     if (INFO.OTF===0) docWrite("Java detection: completed ON THE FLY (OTF)")
     else if (INFO.OTF==2) docWrite("Java detection: completed NOT ON THE FLY (NOTF)")
     
     // if this function is called by $.onDetectionDone(), then detection has completed,
     // and so this last 'else' would not occur.
     else if (INFO.OTF==1) docWrite("Java detection: not completed yet, requires NOTF detection.");

     docWrite("Next-Generation Java Plugin2 installed & enabled: " +
       (INFO.isPlugin2==1 ? "true": (INFO.isPlugin2==-1 ? "false" : "unknown"))
       );

     // INFO.All_versions array lists ALL Java versions found from all sources
     if (INFO.All_versions.length>1)
        docWrite("Multiple Java versions detected: " + INFO.All_versions.join(" & "));

     if (INFO.vendor) docWrite("Java vendor: " + INFO.vendor);

     // Data from navigator.plugins array
     if (INFO.name) docWrite("Java plugin name: " + INFO.name);
     if (INFO.description) docWrite("Java plugin description: " + INFO.description);


     if ($.isNum(INFO.objectTag))
       docWrite("Java (using HTML5 compatible <object> tag) installed & enabled: " + (INFO.objectTag>=0?"true":"false") +
         (INFO.objectTag===0 ? "  [but Javascript/Java bridge was not verified for this tag]" : "")
       );
     if ($.isNum(INFO.appletTag))
       docWrite("Java (using <applet> tag) installed & enabled: " + (INFO.appletTag>=0?"true":"false") +
         (INFO.appletTag===0 ? "  [but Javascript/Java bridge was not verified for this tag]" : "")
       );
     // For IE, you can also use the
     //  <object> tag with classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
     // to display a Java applet.
     if ($.browser.isIE && $.isNum(INFO.objectTagActiveX))
       docWrite("Java (using <object> tag with Oracle Java ActiveX classid) installed & enabled: " + (INFO.objectTagActiveX>=0?"true":"false") +
         (INFO.objectTagActiveX===0 ? "  [but Javascript/Java bridge was not verified for this tag]" : "")
       );

  }


  docWrite("");
  docWrite("navigator.javaEnabled( ): " +
     (navigator.javaEnabled() ? "true" : "false [this may prevent Java from running in your browser]")
  );

  if ($.browser.isIE)
  {
     docWrite("ActiveX enabled / ActiveX scripting enabled: " +
       ($.browser.ActiveXEnabled ? "true" : "false [this may prevent Java from running in Internet Explorer]")
     );
     docWrite("ActiveX Filtering enabled: " + 
       ($.browser.ActiveXFilteringEnabled ? "true [this may prevent Java from running in Internet Explorer]" : "false")
     );
  }

  docWrite("");
  docWrite("Java applets are queried to get the Java version, using verifyTags=[" +
           verifyTags + "].");


  // show Java runtime properties
  if ($.JAVA) $.JAVA.showProperties(
      {title:"<br/>The Java/Javascript bridge in your browser is working.<br/><br/>" +
       "The following additional Java runtime properties are revealed by querying our Java applet...<br/>",
       preName:"java.lang.System.getProperty(\"", postName:"\"): ", preValue:"", postValue:"<br/>"},
      outputID
     );


}  // end of displayResults()




// Start Java plugin detection, using the jarfile if needed.
// When Java detection has been completed, then call displayResults().
$.onDetectionDone("Java", displayResults, jarfile, verifyTags);



})();   // end of anonymous function


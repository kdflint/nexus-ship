/*

  execVerifyApplet.js v0.1
  By Eric Gerds
  

  This script requires PluginDetect and VerifyApplet.js to run.

*/


(function($){

  // Show Java applets
  // result1 = output node id
  // getJavaInfo.jar = Java applet path/name
  $.JAVA.showAllApplets("result1", "getJavaInfo.jar");

  // Verify applet methods
  // result2 = output node id
  $.JAVA.verifyAppletMethods('result2');
  
  // show Java runtime properties
  // result3 = output node id
  $.JAVA.showProperties(
    {title:"<br/><br/>The following additional Java runtime properties are revealed by querying the applet...<br/>",
       preName:"applet.getProp(\"", postName:"\"): ", preValue:"", postValue:"<br/>"},
       "result3");

})(PluginDetect);
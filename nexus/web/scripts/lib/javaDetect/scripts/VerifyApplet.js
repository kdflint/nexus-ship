/*

  VerifyApplet.js v1.4
  By Eric Gerds

  Public methods:
    showAllApplets() - Show Java applets using different HTML tags
    verifyAppletMethods() - Verify that Java applet methods are working
    showProperties() - Show Java runtime properties

  Requirements:
    Requires the PluginDetect Library to work.
    Place VerifyApplet.js script immediately AFTER the PluginDetect script.

*/


(function($){

var dbug = 0;

$.JAVA = {

// HTML object for a running Java applet with a working Java/Javascript bridge
HTML_:null,

// HTML objects for Java applets. One for each HTML tag.
HTML:[null, null, null, null, null],



// [private]
// Add text to output node
docWrite: function(out, text, bold, noLF){
     var b;
     if (out){
        if (text){
          text = text.replace(/&nbsp;/g,"\u00a0");
          text = document.createTextNode(text);

          if (bold){
            b = document.createElement("b");
            b.appendChild(text);
            text = b;
          }

          out.appendChild(text);
        }

        if (!noLF) out.appendChild(document.createElement("br"));
     }
},  // end of docWrite()


// [private]
createTagLabel:function(app){

  var label = "";

  if (app && app.tagName && app.outerHTML)
  {
     if (app.tagName=="applet") label = "<applet> tag";
     
     else if (app.tagName=="embed") label = "<embed> tag";

     else{  // <object> tag
        if ((/clsid\s*:/i).test(app.outerHTML))
           label = "<object> tag with Oracle ActiveX classid (Internet Explorer only)";
        else label = "HTML5 compatible <object> tag";
     }

     app.label = label;
  }

}, // end of createTagLabel()



// [private]
// Insert Java applet
// @out = output node
// @N = applet number/type, 0 - 4
// @label
showApplet: function(out, N){

 if (!out) return;

 var JAVA=this, DOM = $.DOM, tmp,

     wrapperDiv = document.createElement("div"),
     appAndBgDiv = document.createElement("div"), // appDiv + bgDiv
     appDiv = document.createElement("div"), // contains applet
     bgDiv = document.createElement("div"),  // contains background for applet
     msgDiv = document.createElement("div"), // contains message for applet

     altHTML = "",
     wrapperWidth="990px",

     // These widths are numbers. We do NOT include "px" here.
     // HTML5 standards say that width/height attributes for <object>/<embed> tags 
     // are in units of pixels.
     // ie. width="100" height="100"
     //
     // Note: applet.insertJavaTag() requires numbers (assumed units of pizels).
     // For DOM.setStyle() we simply add in the "px" as needed.
     appWidth="350", appHeight="80",

     msgWidth="595px", msgHeight="",
     applet=$.Plugins.java.applet,

     defaultStyle = [
                "backgroundColor", "transparent",
                "backgroundImage","none",
                "outlineStyle","none",
                "borderStyle","none",
                "padding","0px",
                "margin","0px",
                "visibility","visible",
                "verticalAlign", "baseline",
                "display", "block",
                "fontSize", "15px",
                "lineHeight", "15px"
     ],


     wrapperDivStyle = defaultStyle.concat([
             //   "border", "solid green 1px",      // *
                "position", "relative",
                "width", wrapperWidth
     ]),

     appAndBgDivStyle = defaultStyle.concat([
                "position", "relative",
                "border","solid black 1px",
                "marginLeft","10px",
                "marginTop", "10px",
                "width", appWidth+"px",
                "height", appHeight+"px",
                "styleFloat", "left",  // float style for IE
                "cssFloat", "left"     // float style for non-IE
             ]),

     appDivStyle = defaultStyle.concat([
                "position", "relative",
                "zIndex", "2",
                "width", appWidth+"px",
                "height", appHeight+"px"
             ]),
             
     bgDivStyle = defaultStyle.concat([
                "backgroundColor","#8888AA",
                "position", "absolute",
                "left","0px",
                "top","0px",
                "zIndex", "1",
                "width", appWidth+"px",
                "height", appHeight+"px",
                "textAlign", "center"
        ]),

     msgDivStyle = defaultStyle.concat([
              //  "border", "solid red 1px",        // *
                "position", "relative",
                "marginLeft","20px",
                "marginTop", "10px",
                "width", msgWidth,
                "height", msgHeight,
                "styleFloat", "left",  // float style for IE
                "cssFloat", "left"     // float style for non-IE
             ]);


    DOM.setStyle(wrapperDiv, wrapperDivStyle);
    DOM.setStyle(appAndBgDiv, appAndBgDivStyle);
    DOM.setStyle(appDiv, appDivStyle);
    DOM.setStyle(bgDiv, bgDivStyle);
    DOM.setStyle(msgDiv, msgDivStyle);

    appAndBgDiv.appendChild(appDiv);
    appAndBgDiv.appendChild(bgDiv);
    
    wrapperDiv.appendChild(appAndBgDiv);
    wrapperDiv.appendChild(msgDiv);

    // Clear the floats
    tmp = document.createElement("br");
    DOM.setStyle(tmp, ["clear","both"]);
    wrapperDiv.appendChild(tmp);

    out.appendChild(wrapperDiv);


    // ** For reliability reasons, we make sure that appDiv is in the DOM
    // BEFORE we insert the Java tag into appDiv.
    var app1 = applet.insertJavaTag(N, appDiv, altHTML, appWidth, appHeight);
    if (!app1 || !app1.tagName){
       out.removeChild(wrapperDiv);
       return;
    }
    JAVA.createTagLabel(app1);

    // div text
    bgDiv.innerHTML = "<br/><br/><b>Java applet is not running</b>";
    if ($.isString(app1.outerHTML))
    {
      tmp = app1.outerHTML.replace(/\s*>/g,">").replace(/</g, "&lt;").replace(/>/g, "&gt;");
      tmp = tmp.replace(/style\s*=\s*['"][^'"]*['"]/, "");
      tmp = tmp.replace(/&lt;\s*param/g, "<br/>&lt;param");
      
      msgDiv.innerHTML = "<b>Java applet using " +
        app1.label.replace(/</g, "&lt;").replace(/>/g, "&gt;") + "</b><br/>" + tmp;
    }

    // N = 0,1,2,3,4
    JAVA.HTML[N] = app1;

    JAVA.docWrite(out, "");


},  // end of showApplet()


// [public]
// Show Java applets using different HTML tags.
showAllApplets: function(outputID, jarfile){
  
  var JAVA=this, tmp, x,
    // output <div>. Detection results are placed in this <div>.
    out=document.getElementById(outputID);


  // Initialize $.Plugins.java{} so that
  // we can use $.Plugins.java.applet.insertJavaTag().
  // We specify [0,0,0] because we do not care about the detection result here.
  if ($.getVersion) tmp=$.getVersion("Java", jarfile, [0,0,0])
  else tmp = $.isMinVersion("Java", 0, jarfile, [0,0,0]);

  for (x=0;x<5;x++){
     JAVA.showApplet(out, x);
  }

},  // end of showAllApplets()


// List of Java applet methods
//
// Note: isActive() has been defined for all applets sice JDK 1.0
// We did not explicitly define this method, it is automatically just created.
methods:{
  // methods with no input args
  noArg: ["isActive", "getVersion", "getVendor", "getAppVersion"],

  // methods with one input arg
  oneArg: ["getProp", "statusbar"],
  
  // sample input arg for each item in oneArg[]
  arg: ["java.version", " "]
},

// [private]
// test Java/Javascript bridge for HTML.obj() or applet
// return 1 if active/working.
testBridge:function(pre, post, out, HTML){
  
  var JAVA=this, y, str="", result=0, tmp,

     obj = HTML ? HTML.obj() : null,
     readyState = HTML ? HTML.readyState() : null;

  // For older IE, the readyState property exists for applets.
  // We make sure that readyState==4 before querying the applet.
  // We do this because in some rare cases with old Java/IE,
  // the browser can crash/hang when you query the applet for readyState != 4. 
  // To avoid this, we wait for readyState==4.
  // Newer Java/IE do not have this issue.
  if (obj && (!$.isNum(readyState) || readyState==4))
  {
     // check methods that work without input arg
     for (y=0;y<JAVA.methods.noArg.length;y++)
     {
         try{
            tmp = obj[JAVA.methods.noArg[y]]();
            result=1;
            str += (str ? ", " : "") + JAVA.methods.noArg[y] + "( )";
            if (!dbug) return 1;
         }catch(e){}
     } // y loop

     // check methods that work with input arg
     for (y=0;y<JAVA.methods.oneArg.length;y++)
     {
          try{
             tmp = obj[JAVA.methods.oneArg[y]](JAVA.methods.arg[y]);
             result=1;
             str += (str ? ", " : "") + JAVA.methods.oneArg[y] + "( )";
             if (!dbug) return 1;
          }catch(e){}
     } // y loop

  }

  if (dbug && str) JAVA.docWrite(out, pre + str + post, "bold");


  return result;

}, // testBridge()


// [private]
// Try to find an applet that is working.
// Store result in JAVA.HTML_.
updateHTML:function(out){

  var JAVA=this, x,
     HTML = JAVA.HTML.concat($.Plugins.java.applet.HTML);

  if (!JAVA.HTML_)
  {
     for (x=0;x<HTML.length;x++)
     {
        if (HTML[x])
        {
           if (JAVA.testBridge("[ * Applet methods working for HTML[" + x + "] " +
              "(<" + HTML[x].tagName + "> tag): ", " ]", out, HTML[x]))
           {
              JAVA.HTML_ = HTML[x];    // Java/Javascript bridge works for this applet
              
              if (!dbug) return;
           }

        }

     } // x loop


  }

}, // end of updateHTML()


hasRun:0,

// [public]
// Verify that Java applet methods are working.
verifyAppletMethods: function(outputID){
  
  var JAVA=this;
  
  // create event handler
  if (!JAVA.verifyAppletMethods_handler)
    JAVA.verifyAppletMethods_handler = $.ev.handler(JAVA.verifyAppletMethods_hndlr, $, JAVA, outputID);

  JAVA.verifyAppletMethods_handler();

}, // end of verifyAppletMethods()


// [private]
// Event Handler
verifyAppletMethods_hndlr: function($, JAVA, outputID){

  var out = document.getElementById(outputID), y,

    R = "", tmp,

    // count is the # of applet methods that are working.
    // maxcount are the total number of applet methods in the applet.
    count=0, maxcount=6;


  var tmpDiv = document.createElement("div");

  // find a working applet
  JAVA.updateHTML(tmpDiv);


  for (y=0;y<JAVA.methods.noArg.length;y++)
  {
       R = "applet." + JAVA.methods.noArg[y] + "( ): ";
       try{
          tmp = JAVA.HTML_.obj()[JAVA.methods.noArg[y]]();
          R += ($.isDefined(tmp) ? tmp : "ok"); // If no return value, then just show "ok"
          count++;
       }catch(e){R += "method is not working";}

       JAVA.docWrite(tmpDiv, R);
  } // y loop


  for (y=0;y<JAVA.methods.oneArg.length;y++)
  {
       R = "applet." + JAVA.methods.oneArg[y] + "(\"" + JAVA.methods.arg[y] + "\"): ";
       try{
          tmp = JAVA.HTML_.obj()[JAVA.methods.oneArg[y]](JAVA.methods.arg[y]);
          R += ($.isDefined(tmp) ? tmp : "ok"); // If no return value, then just show "ok"
          count++;
       }catch(e){R += "method is not working";}

       JAVA.docWrite(tmpDiv, R);
  } // y loop


  JAVA.docWrite(tmpDiv, "");


  if (JAVA.HTML_)
  {
    JAVA.docWrite(tmpDiv, "Java appears to be installed and enabled in your browser.");
    JAVA.docWrite(tmpDiv, "The Javascript/Java bridge appears to be working also.");
    JAVA.docWrite(tmpDiv, "");

    if (count<maxcount)
    {
      JAVA.docWrite(tmpDiv, "ERROR: one or more methods in your Java applet are not working.", "bold");
      JAVA.docWrite(tmpDiv, "Do not use this buggy applet with " + $.name + ".");
    }
    else
    {
       JAVA.docWrite(tmpDiv, "YOUR JAVA APPLET WORKS!!!", "bold");
       JAVA.docWrite(tmpDiv, "All methods in your Java applet are working properly.");
       JAVA.docWrite(tmpDiv, "You may use this applet with the " + $.name + " Library to do Java detection.");
    }

  }else{
       JAVA.docWrite(tmpDiv, "ERROR: none of the methods in your Java applet appear to be working.", "bold");
       JAVA.docWrite(tmpDiv, "Make sure that Java is installed and enabled, and then try again.");
       JAVA.docWrite(tmpDiv, "");
  }




  // JAVA.hasRun && JAVA.HTML_  -> replace innerHTML
  // JAVA.hasRun && !JAVA.HTML_ -> do nothing
  // !JAVA.hasRun -> add to innerHTML
  if (JAVA.hasRun && !JAVA.HTML_){}
  else{
     if (JAVA.hasRun && JAVA.HTML_) out.innerHTML = "";
     out.appendChild(tmpDiv);
  }



  // If the Java plugin is not active, then we run this routine again.
  // We do this in case the user needs to "click to activate" the plugin.
  // At that point, we automatically run the tests again.
  JAVA.hasRun = 1;
  if (JAVA.shouldContinue(2))
    $.ev.setTimeout(JAVA.verifyAppletMethods_handler, JAVA.intervalLength);


},  // end of verifyAppletMethods_hndlr()


// [public]
// Show Java runtime properties
showProperties:function(str, outputID){

  var JAVA=this;

  // create event handler
  if (!JAVA.showProperties_handler)
    JAVA.showProperties_handler = $.ev.handler(JAVA.showProperties_hndlr, $, JAVA, str, outputID);

  JAVA.showProperties_handler();

}, // end of showProperties()


// [private]
// Event Handler
showProperties_hndlr:function($, JAVA, str, outputID){

   // set output <div>
   var out = document.getElementById(outputID);

   // find a working applet
   JAVA.updateHTML(out);

   if (JAVA.HTML_) JAVA.showProperties_System(JAVA.HTML_.obj(), str, outputID);

   else if (JAVA.shouldContinue(1))
     $.ev.setTimeout(JAVA.showProperties_handler, JAVA.intervalLength);

}, // end of showProperties_hndlr()



// [private]
// Display Java runtime properties by querying the Java applet
//   via java.lang.System.getProperties("property name")
// Output is sent to DOM node given by @outputID.
//
// @AppletObj == Java applet object
showProperties_System: function(AppletObj, str, outputID){

  str.title = str.title || "";
  str.preName = str.preName || "";     // string to display before propertyName
  str.postName = str.postName || "";   // string to display after propertyName
  str.preValue = str.preValue || "";   // string to display before value
  str.postValue = str.postValue || ""; // string to display after value

  var JAVA=this, result="", value, x,
      out = document.getElementById(outputID), PropName =
          ["java.class.path", "java.class.version",
           "java.compiler", "java.home", "java.io.tmpdir",
           "java.version", "java.vendor", "java.vendor.url",
           "java.vm.name", "java.vm.vendor", "java.vm.version",
           "java.vm.specification.name", "java.vm.specification.vendor", "java.vm.specification.version",
           "java.runtime.name", "java.runtime.version",
           "java.specification.name", "java.specification.vendor", "java.specification.version",
           "path.separator", "line.separator", "file.separator",
           "file.encoding", "file.encoding.pkg",
           "user.dir", "user.home", "user.name",
           "os.version", "os.name", "os.arch"];

  // Query instantiated Java applet to get Java runtime info
  if (AppletObj && out)
  {
          for (x=0;x<PropName.length;x++)
          {
             value="";
             // AppletObj.getProp(PropName[x]) == java.lang.System.getProperty(PropName[x])
             try{value = AppletObj.getProp(PropName[x]) + "";}
             catch(e){}

             if (value){
               value = value.replace("\r", "\\r").replace("\n", "\\n");

               result += str.preName + PropName[x] + str.postName + 
                 str.preValue + value + str.postValue;
             }
          } // x loop

          if (result) out.innerHTML += str.title + result + "<br/>";

  }
  
  JAVA.showProperties_bridge(outputID);

}, // end of showProperties_System()


// [private]
// Test the Java/Javascript bridge for all JAVA HTML tags given by JAVA.HTML{}
// Show the results.
showProperties_bridge:function(outputID){
  
  var JAVA=this, x, bridge, HTML, out=document.getElementById(outputID);
  
  if (out)
  {
     for (x=0;x<JAVA.HTML.length;x++)
     {
         HTML = JAVA.HTML[x];
         if (HTML && HTML.label){
             JAVA.docWrite(out, "Java/Javascript bridge for " + HTML.label + ": ", 0, "noLF");
             bridge = JAVA.testBridge("", "", 0, HTML);
             JAVA.docWrite(out, (bridge ? "ok" : "NOT ok"), (bridge ? 0 : "bold"));
         }
     }
  }

}, // end of showProperties_bridge()


intervalLength:1500, // in units of ms
count:{},
countMax: 99,

// Return 1 if we should continue calling setTimeout()
// Return 0 otherwise
// @id is an id to identify the calling routine
shouldContinue:function(id){

  var JAVA=this, x,
    HTML = JAVA.HTML.concat($.Plugins.java.applet.HTML);

  // if JAVA.HTML_ exists, then an applet with a working bridge has been found, so
  //   no need to continue the setTimeout() loop.
  // If $.ev does not exist, then we are unable to call $.ev.handler, which is needed
  // to continue the setTimeout() loop.
  if (!$.isDefined(id) || JAVA.HTML_ || !$.ev){
    return 0;
  }

  id = "a" + id;
  if ($.isNum(JAVA.count[id])) JAVA.count[id]++;
  else JAVA.count[id]=0;

  // if window.onload has fired and there are no items in HTML[] and count>N,
  // then return 0
  if ($.win && $.win.loaded && JAVA.count[id]>JAVA.countMax){
     for (x=0;x<HTML.length;x++){
        if (HTML[x]) return 1;
     }
     return 0; // if there are no HTML objects at all, then we do NOT continue
  }

  return 1;


}, // end of shouldContinue()


z:0

} // end of $.Java{}



})(PluginDetect);


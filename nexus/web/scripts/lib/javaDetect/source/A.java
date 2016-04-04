/*
   
 Java source code for getJavaInfo.jar applet
 v 5.2
 http://www.pinlady.net/PluginDetect/
 By Eric Gerds

 --------------------------

 It is recommended that you customize this source code to reduce the chances of an antiVirus
 scanner from falsely identifying your getJavaInfo.jar as malware.

 How you customize this Java source file is up to you, but I have found that even making a small
 customization (ie. changing just a single byte) is often enough to change a 
 false positive AntiVirus detection to a negative detection. Just make sure that you do 
 not change any of the method names that are already in use, since PluginDetect requires 
 them to remain the same.


 Some of the ways you can customize the source code in this file are shown below with 
 a few examples.


 Custom Example 1: you can change the returned string result of getAppVersion().
 This will have no effect on PluginDetect functionality. Just customize the string
 to contain whatever you like.
    public String getAppVersion()
       {
          return "999";         // version of this applet
       }

 Custom Example 2: returned string result of getAppVersion()...
     public String getAppVersion()
       {
          return "blablabla007";   // version of this applet
       }

 Custom Example 3: You can also add one or more randomly named methods to this applet...
     public String randomUniqueMethodName()
       {
         return "qq";
       }

 Custom Example 4: You might also try changing the ORDER of the methods. This will
 not change the functionality, but it will change the binary signature that an AntiVirus
 scanner sees.


*/


import java.applet.*;
import java.awt.*;

public class A extends Applet
{

    public void init()
    {
       // Give the user a visual confirmation that Java is running.
       // Because Label will give text that is Black (or sometimes White), we
       // choose a Red background.
       this.setBackground(Color.red);

       this.add(new Label("Java version: " + getVersion() + ",  vendor: " + getVendor()));
    }


    public String getAppVersion()
    {
       return "5.2";     // version of this applet.
                         // The user should change this string to some random
                         // set of characters to customize the applet.
                         // Ex.  
                         //  return "5.1 customVersion1";
                         //  return "5.1 customVersion2";
                         //  return "5.1 Eric's custom version";
                         //  etc...
                         //
                         // Customizing just this one line of code should be enough to
                         // create a unique hash value for the applet, and hence reduce
                         // the chances of an antiVirus scanner from falsely detecting
                         // this applet as a virus.

    }

    public String getProp(String S)
    {
       String o="";
       try{
           if (S instanceof String) o=System.getProperty(S);
       }
       catch(Exception e){};
       return o;
    }

    public String getVersion()
    {
       return getProp("java.version");
    }

    public String getVendor()
    {
       return getProp("java.vendor");
    }


/*  Set the browser window status bar from within this applet.

    We would like to prevent the window status bar from showing the "Applet A started"
    message when detecting Java. This message only occurs in some browsers, not all.
    We can solve this problem using the showStatus("") method from within the Java applet.

    - Is the showStatus method compatible with Java 1.3?

    - Even when you cannot set window.status from Javascript, it is still possible
     in some browsers for the applet to affect the status bar. Hence it is probably best
     to set the status bar from within the applet using showStatus().

    - Note, some browsers show the word "Done" in the status bar after the page has fully
    loaded (ie. window.onload has fired). We want to avoid overwriting the 'Done'.

*/
    public void statusbar(String S)
    {
       try{
           if (S instanceof String) showStatus(S);
       }
       catch(Exception e){};
    }


}   // end of class A



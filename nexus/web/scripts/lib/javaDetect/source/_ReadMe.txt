This folder contains the Java source code for the getJavaInfo.jar applet.
The source code allows you to create your own customized getJavaInfo.jar.

The getJavaInfo.jar applet and the PluginDetect.js script together allow you to perform Java
detection in web browsers. PLUGINDETECT WILL USUALLY TRY TO AVOID USING THE APPLET, HOWEVER,
TO SPEED UP JAVA PLUGIN DETECTION AND TO PREVENT CERTAIN SECURITY POPUP MESSAGES FROM OCCURRING.
The applet will only be used when absolutely necessary (or if specifically requested,
via the verifyTagsArray[] input argument to PluginDetect).



RECOMMENDATION TO ALL USERS:

You may want to consider converting the getJavaInfo.jar applet into a SIGNED applet. This will
remove certain Java security restrictions that could block the applet from running
when a user's Java is outdated. Instructions on converting the applet into a signed applet
are not included here, as this is beyond the scope of this discussion. (BTW, the security
certificate needed for a signed applet can be rather expensive).

I also recommend that you customize the Java source file "A.java", and then compile it
to create YOUR OWN CUSTOMIZED getJavaInfo.jar file. This customized getJavaInfo.jar should
then be used with the PluginDetect script to do Java detection on your website.
I do NOT recommend that you use the getJavaInfo.jar that you downloaded from my website.

Why do I say this? Because there are malware authors out there who are bundling the
PluginDetect script and the getJavaInfo.jar (from my website) into their own
malware. These malware packages basically use PluginDetect/getJavaInfo.jar to detect 
the Java version in user's browsers. When the malware detects a vulnerable Java version,
it executes a specially crafted Java applet to compromise the user's computer. 
When such malware packages are presented to the AntiVirus company, they MIGHT falsely conclude
that PluginDetect/getJavaInfo.jar are malware, simply because they are contained within
the malware package. 

But I say again, PluginDetect and getJavaInfo.jar themselves are NOT malware.
The simple act of detecting the Java version in a user's browser is not and should not be
considered malicious.

I believe that when you create your own customized getJavaInfo.jar, you will decrease the
odds of your .jar being recognized as malware by an AntiVirus scanner, since it will now have a
UNIQUE binary signature that is different from the binary signature of the
getJavaInfo.jar file contained in any potential malware package. (Note: the fact
that PluginDetect tries to avoid using the applet during detection, will also reduce the chances
of the applet being falsely recognized as malware.)


To create your own customized getJavaInfo.jar, simply follow the instructions below.



--------------------------------------------------------------------------------
Instructions on how to create a customized "getJavaInfo.jar" (on Windows)

1) Install a JDK (Java Development Kit) onto your PC. I get my JDKs from Oracle.
This JDK will be used to create your Java applet. 

You also will need the "rt.jar" file from Sun Java 1.2.2_017.
This rt.jar file contains all of the compiled class files for Java Runtime Environment 1.2.2_017.
We use this old rt.jar file to insure that your getJavaInfo.jar applet will be compatible
with Java 1.2.2 and higher.

2) Modify the "A.java" source code file (in this folder). Instructions on how to modify the A.java
source code are found in the A.java file itself.

2) Edit the "compile.bat" file (in this folder) so that the paths to the
 JDK (Java Development Kit) and to rt.jar are correct.

3) Using your mouse, drag the "A.java" source code file onto the "compile.bat" program.
 The program will compile the "A.java" source code into "A.class", and then compresses
 that to create your customized "getJavaInfo.jar" applet.

4) Open the "VerifyApplet.htm" web page (in this folder) in your browser. This web page will
check all the methods for the customized getJavaInfo.jar applet to make sure everything is ok.
(Note: VerifyApplet.htm and your customized getJavaInfo.jar applet should be in the same folder,
in order for the VerifyApplet.htm web page to work properly.)

5) If the custom getJavaInfo.jar checks out ok, then replace any instances of 
getJavaInfo.jar you downloaded from my website with your own customized getJavaInfo.jar.

6) You are now free to use your custom getJavaInfo.jar with the PluginDetect script to do 
Java detection on your own website.




------------------------------------------------------------------------------------------------
You may ignore everything below this line :-)
------------------------------------------------------------------------------------------------
Strategies we use to minimize the size of the getJavaInfo.jar file:

2) For some reason, having the batch program change its current directory to the folder 
with the A.class file reduces the size of the .jar. As opposed to not changing
the directory and using full paths.

3) By using shorter class names in the .java source code, we get a smaller .jar file size.

4) We simplify the code as much as possible.

5) It is possible to use 3rd party .jar compression tools, but for reliability reasons
we avoid this.

-------------------------------------------------------------------------------------------------



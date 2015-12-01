There are several Java detection examples in this folder...


Example1:
A Java detector that can perform both OTF and NOTF detection. It uses the jarfile when necessary.
Detection is initiated before the browser window has loaded.

Example1_verified:
This is exactly the same as Example1, except that we selected the "Verify jarfile [path/]name"
option when generating the PluginDetect script for Java detection.
This option verifies that the Java detection code specifies the jarfile with the correct
name and path.

Example2:
A Java detector that can perform both OTF and NOTF detection. It uses the jarfile when necessary.
Detection is initiated AFTER the browser window has loaded.

Example3 + Example4:
A Java detector that can perform both OTF and NOTF detection. It forces Java to start up 
and use the getJavaInfo.jar applet to do Java plugin detection. This particular Java detector is
the slowest of all the detectors because it can take a relatively long time for Java to start up.

Example5:
This example is the same as Example1, except that it only reveals the bare essentials on
the Java plugin.






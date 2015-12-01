@echo off 


REM Modify the paths for JDKjavac, JDKjar, and bootclasspath as needed.
REM We use quotes here because the paths may contain spaces.
REM
REM Note: we use rt.jar from Java 1.2.2_017 so that the java applet will be compatible with Java 1.2.2 and higher. 
REM Java 1.2.2_017 does not actually even have to be installed. You only just need that one file rt.jar.
REM

SET JDKjavac="C:\Program Files\Java\jdk1.7.0_67\bin\javac"
SET JDKjar="C:\Program Files\Java\jdk1.7.0_67\bin\jar"
SET bootclasspath="C:\Program Files\Java\jdk1.2.2\jre\lib\rt.jar"


REM Even though we will be running the java compiler from a newer JAVA SDK, we would still like the
REM compiled applet to run on OLDER Java versions.
REM Thus we need to specify targetversion and sourceversion.
REM We choose targetversion of 1.1, because the last Microsoft Java version was 1.1.x.y, and we would like
REM the applet to be compatible with that.
REM We choose sourceversion of 1.2 because our rt.jar comes from Java 1.2.2_017.
 
SET targetversion=1.1
SET sourceversion=1.2




REM Users should not modify anything below this line
REM **************************************************************************************************************************

SET source=A.java
SET manifest=manifest.mf
SET class=A.class
SET jar=getJavaInfo.jar


echo ****************************************************************************
echo *
echo * compile v0.1.4
echo * by Eric Gerds  http://www.pinlady.net/PluginDetect/
echo *
echo * This is an MS-DOS batch program that will compile your Java source 
echo * code "%source%" into an applet named "%jar%"...
echo *
echo * Instructions:
echo * 1) Make sure that you have a JDK (Java Development Kit) installed 
echo *    when using this batch program. 
echo *    Also have the "rt.jar" file from Java 1.2.2 installed, so your applet
echo *    will be compatible with older Java runtimes.
echo * 2) You will have to edit this batch program so that the paths
echo *    to JDK javac, JDK jar, and bootclasspath are correct.
echo *
echo * Current Path to JDK javac : 
echo *        %JDKjavac%
echo * Current Path to JDK jar : 
echo *        %JDKjar%
echo * Current bootclasspath :
echo *        %bootclasspath%
echo *
echo * 3) Customize/edit the Java applet source file "%source%" as needed.
echo * 4) Drag and drop the file "%source%" onto this batch program to create
echo *    your applet "%jar%".
echo * 5) Open the VerifyApplet.htm web page in your browser to verify the
echo *    functionality of your newly created applet "%jar%".
echo *
echo ****************************************************************************
echo.
echo.


if "%~1"=="" ( 
  echo.
  echo ERROR: No input file was specified.
  echo To use this program, just drag and drop the source file "%source%"
  echo onto this batch program.
  echo.
  echo.
  pause
  exit
)

if not "%~nx1"=="%source%" ( 
  echo ERROR: Input source file should be named "%source%",
  echo not "%~nx1"
  echo.
  echo.
  pause
  exit
)


REM We do this check because we delete the "%class%" file at some point.
REM We make sure to avoid accidentally deleting any important files.
if not "%class%"=="A.class" ( 
  echo ERROR: "class" variable must be set to "A.class",
  echo not "%class%"
  echo.
  echo.
  pause
  exit
)


REM Change directories. For some reason,
REM this helps to make the final .jar file a bit smaller.
cd "%~dp1"

REM Compile input .java file to .class file.
REM
REM We need to specify target and source for OLDER Java versions when using
REM a newer Java SDK so that our compiled applets are compatible with older versions
REM of Java.

echo Compiling "%source%" to "%class%"
%JDKjavac% -target %targetversion% -source %sourceversion% -bootclasspath %bootclasspath% -extdirs "" "%source%"
echo.
echo.

REM Convert .class file to .jar file.
REM
REM The -m option allows us to add custom headers to the manifest.

echo Converting "%class%" to "%jar%"
%JDKjar% -cvfm "%jar%" "%manifest%" "%class%"
echo.
echo.

echo Deleting "%class%" file
del "%class%"
echo.
echo.

echo DONE
echo.
echo.
pause





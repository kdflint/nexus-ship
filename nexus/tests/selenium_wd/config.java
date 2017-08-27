package DevNexus;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;

public class config 
{
	
	 	public static WebDriver driver;
	 	public static StringBuffer verificationErrors = new StringBuffer();
	  
	 	//Path of property file in local - Need to be replaced 
	 	static File property_file = new File("C:\\Users\\Arvind\\Desktop\\hema practie selenium\\datafile.properties");
	  
	 	static FileInputStream fileInput = null;
	 	static Properties prop = new Properties();
	 	
	 	@BeforeSuite(alwaysRun = true)
		  public void setUp() throws Exception
		  {
		      try{
		    	  fileInput = new FileInputStream(property_file);
			  	}catch(FileNotFoundException e){
			  		e.printStackTrace();
			  	}
			  try{
				  prop.load(fileInput);
			  }
			  catch(IOException e){
				  e.printStackTrace();
			  }
			  System.setProperty("webdriver.chrome.driver",prop.getProperty("chromedriver"));
			  driver=new ChromeDriver();
			  driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
			  driver.manage().window().maximize();
		      driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		  }
	 	
	 	@AfterSuite
	 	public void closeBrowser() {
	 		driver.quit();
	 	}
}

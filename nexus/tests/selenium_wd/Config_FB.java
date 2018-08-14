package facebook_login;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
	
public class Config_FB 
        {
	
	        
        	public static WebDriver driver;
		 	public static StringBuffer verificationErrors = new StringBuffer();
		 	
		 	
		 	//Path of property file in local - Need to be replaced 
		 	static File property_file = new File("C:\\Users\\Arvind\\Desktop\\hema practie selenium\\Story 1 - FB login\\datafile_FB.properties");
		  
		 	static FileInputStream fileInput = null;
		 	static Properties prop = new Properties();
		 	
		 	@BeforeSuite(alwaysRun = true)
			  public void setUp() throws Exception
			  {
			      try
			      {
			    	  fileInput = new FileInputStream(property_file);
				  }
			      catch(FileNotFoundException e)
			      {
				  		e.printStackTrace();
				  }
				  try
				  {
					  prop.load(fileInput);
				  }
				  catch(IOException e)
				  {
					  e.printStackTrace();
				  }
				  
				  ChromeOptions options = new ChromeOptions();
				  options.addArguments("--disable-notifications");
				  
				  
				  System.setProperty("webdriver.chrome.driver",prop.getProperty("chromedriver"));
				  driver=new ChromeDriver(options);
				  
				 
			  }
		 	
		 	
		 	@AfterSuite
		 	public void closeBrowser() 
		 	{
		 		driver.quit();
		 	}
	

}

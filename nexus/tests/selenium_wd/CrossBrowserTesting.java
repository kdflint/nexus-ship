package DevNexus;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

public class CrossBrowserTesting
{
	WebDriver driver;
	
	@Test
	 
	@Parameters("Browser")
	public  void test1(String browser)
	{
	 
	if(browser.equalsIgnoreCase("FF"))
	 {
		System.setProperty("webdriver.firefox.marionette", "C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\geckodriver.exe");
	    driver=new FirefoxDriver();
	 
	  }
	else if(browser.equalsIgnoreCase("chrome"))
	  {
	 
		System.setProperty("webdriver.chrome.driver","C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\chromedriver.exe");
		
		 driver=new ChromeDriver();
	 
      }
	else if(browser.equalsIgnoreCase("IE"))
	  {
	 
	    System.setProperty("webdriver.ie.driver", "C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\IEDriverServer.exe");
	 
	     driver=new InternetExplorerDriver();
	  }
	    driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
	    driver.manage().window().maximize();
	    driver.findElement(By.name("uid")).sendKeys("name ");
	    driver.findElement(By.name("password")).sendKeys("pass ");  
	    driver.findElement(By.id("login-form-submit")).click();
	    driver.close();
	
	}
}
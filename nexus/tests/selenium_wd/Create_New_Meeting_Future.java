package DevNexus;
import static org.testng.Assert.fail;

import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class Create_New_Meeting_Future extends config 
{
		@Test
		public void Test4() throws InterruptedException
		{
		    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("username"));
		    driver.findElement(By.name("password")).sendKeys(prop.getProperty("password"));  
		    driver.findElement(By.id("login-form-submit")).click();

		    //Creating a New Meeting
		    driver.findElement(By.xpath(".//*[@id='schedule_control']/span[1]")).click();
		    driver.findElement(By.xpath(" .//*[@id='schedule-form']/fieldset/div[1]/input")).sendKeys("New Meeting Demo");
		    driver.findElement(By.linkText("Change")).click();

		    //selecting country
		    driver.findElement(By.cssSelector("#schedule-form-country-button > span.ui-selectmenu-text")).click();
		    driver.findElement(By.id("ui-id-246")).click();
		  
		     //selecting timezone 
		    driver.findElement(By.cssSelector("#schedule-form-countryTimeZones-button > span.ui-selectmenu-text")).click();
		    driver.findElement(By.id("ui-id-260")).click();
		    
		     //selecting date and time
		    driver.findElement(By.id("datepicker")).click();
		    driver.findElement(By.linkText("27")).click();
		    driver.findElement(By.cssSelector("#schedule-form-time-button > span.ui-selectmenu-text")).click();
		    driver.findElement(By.id("ui-id-269")).click();
		    
		     //selecting duration
		    driver.findElement(By.cssSelector("#schedule-form-duration-button > span.ui-selectmenu-text")).click();
		    driver.findElement(By.id("ui-id-317")).click();
		    
		    //selecting type of meeting type and clicking on reserve button
		    driver.findElement(By.cssSelector("#schedule-form-type-button > span.ui-selectmenu-text")).click();
		    driver.findElement(By.id("ui-id-328")).click();
		    driver.findElement(By.id("schedule-form-submit")).click();
		    driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
		         	 	   
		    Thread.sleep(3000);
		  
		}

		@AfterClass(alwaysRun = true)
		  public void tearDown() throws Exception
	    {
		    String verificationErrorString = verificationErrors.toString();
		    if (!"".equals(verificationErrorString))
		    {
		      fail(verificationErrorString);
		    }
		}
}

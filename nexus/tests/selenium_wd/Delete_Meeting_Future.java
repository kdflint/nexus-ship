package DevNexus;
import static org.testng.Assert.assertEquals;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.testng.annotations.Test;
public class Delete_Meeting_Future extends config
{
		
			@Test
			public void Test1() throws InterruptedException
			{
			
		    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("username"));
		    driver.findElement(By.name("password")).sendKeys(prop.getProperty("password"));  
		    driver.findElement(By.id("login-form-submit")).click();
		   
		    
		    driver.findElement(By.cssSelector("#reservationRow1 > #futureEventDetail > div.meeting > span.descr > p > a")).click();
		    Thread.sleep(3000);
		    assertEquals(closeAlertAndGetItsText(), "Please confirm this delete.");
		    Thread.sleep(3000);
		    driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
		    }
		   
			private String closeAlertAndGetItsText()
			{
			    boolean acceptNextAlert = true;
				try 
				{
			      Alert alert = driver.switchTo().alert();
			      String alertText = alert.getText();
			      if (acceptNextAlert) 
			      {
			        alert.accept();
			      } 
			      else
			      {
			        alert.dismiss();
			      }
			      return alertText;
			      } 
				   finally
				   {
			         acceptNextAlert = true;
			        } 
				}
}
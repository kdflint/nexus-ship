package DevNexus;
import static org.testng.Assert.fail;

import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class NewEnrollment extends config
{

	  @Test
	  public void testNewEnroll() throws Exception
	  {
	    
	    driver.findElement(By.name("uid")).clear();
	    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("username"));
	    
	    driver.findElement(By.name("password")).clear();
	    driver.findElement(By.name("password")).sendKeys(prop.getProperty("password"));
	    
	    driver.findElement(By.id("login-form-submit")).click();
	    driver.findElement(By.id("menu-userList")).click();
	    
	    driver.findElement(By.id("add_user_control_icon")).click();
	    
	    driver.findElement(By.name("fname")).sendKeys(prop.getProperty("fname"));
	    
	    driver.findElement(By.id("fakeCheckBox2")).click();
	    
	    driver.findElement(By.name("email")).clear();
	    driver.findElement(By.name("email")).sendKeys(prop.getProperty("email"));
	    
	    driver.findElement(By.id("invite-form-submit")).click();
	    Thread.sleep(5000);  
	    driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
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



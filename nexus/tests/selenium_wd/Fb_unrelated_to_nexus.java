package facebook_login;

import static org.testng.Assert.fail;
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class Fb_unrelated_to_nexus extends Config_FB
{

	   @Test
	   public void testFbUnrelatedToNexus() throws Exception
	   {
		driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
	    driver.findElement(By.linkText("Sign In with Facebook")).click();
	    driver.findElement(By.id("email")).clear();
	    driver.findElement(By.id("email")).sendKeys(prop.getProperty("email1"));
	    driver.findElement(By.id("pass")).clear();
	    driver.findElement(By.id("pass")).sendKeys(prop.getProperty("password1"));
	    driver.findElement(By.id("loginbutton")).click();
	    
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

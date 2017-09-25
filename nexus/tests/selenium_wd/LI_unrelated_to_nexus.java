package LinkedIn_Login;

import static org.testng.Assert.fail;
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class LI_unrelated_to_nexus extends Config_LI
{

	   @Test
	   public void testFbUnrelatedToNexus() throws Exception
	   {
		driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		driver.findElement(By.linkText("Sign In with LinkedIn")).click();
		driver.findElement(By.id("session_key-oauthAuthorizeForm")).clear();
		driver.findElement(By.id("session_key-oauthAuthorizeForm")).sendKeys(prop.getProperty("email1"));
		driver.findElement(By.id("session_password-oauthAuthorizeForm")).clear();
		driver.findElement(By.id("session_password-oauthAuthorizeForm")).sendKeys(prop.getProperty("password1"));
		driver.findElement(By.name("authorize")).click();
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
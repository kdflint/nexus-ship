package LinkedIn_Login;

import static org.testng.Assert.fail;
import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class GoodLogin_LI extends Config_LI
{
	 @Test
		  public void testGoodLoginFB() throws Exception 
		  {
			driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
			driver.manage().window().maximize();
		    driver.findElement(By.linkText("Sign In with LinkedIn")).click();
		    driver.findElement(By.id("session_key-oauthAuthorizeForm")).clear();
		    driver.findElement(By.id("session_key-oauthAuthorizeForm")).sendKeys(prop.getProperty("email"));
		    driver.findElement(By.id("session_password-oauthAuthorizeForm")).clear();
		    driver.findElement(By.id("session_password-oauthAuthorizeForm")).sendKeys(prop.getProperty("password"));
		    driver.findElement(By.name("authorize")).click();
		    driver.findElement(By.xpath("//a[3]/span")).click();
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

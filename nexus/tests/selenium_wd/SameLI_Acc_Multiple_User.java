package LinkedIn_Login;

import static org.testng.Assert.fail;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

public class SameLI_Acc_Multiple_User extends Config_LI
{
	  @Test
	  public void testMultipleUserFB() throws Exception 
	  {
	    driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
	    driver.manage().window().maximize();
	    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
	    driver.findElement(By.name("uid")).clear();
	    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("user1"));
	    driver.findElement(By.name("password")).clear();
	    driver.findElement(By.name("password")).sendKeys(prop.getProperty("p1"));
	    driver.findElement(By.id("login-form-submit")).click();
	    driver.findElement(By.xpath("//a[3]/span")).click();
	    driver.findElement(By.name("uid")).clear();
	    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("user2"));
	    driver.findElement(By.name("password")).clear();
	    driver.findElement(By.name("password")).sendKeys(prop.getProperty("p2"));
	    driver.findElement(By.id("login-form-submit")).click();
	    driver.findElement(By.xpath("//a[3]/span")).click();
	    
	    driver.findElement(By.linkText("Sign In with LinkedIn")).click();
	    driver.findElement(By.id("session_key-oauthAuthorizeForm")).clear();
	    driver.findElement(By.id("session_key-oauthAuthorizeForm")).sendKeys(prop.getProperty("email2"));
	    driver.findElement(By.id("session_password-oauthAuthorizeForm")).clear();
	    driver.findElement(By.id("session_password-oauthAuthorizeForm")).sendKeys(prop.getProperty("pass2"));
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

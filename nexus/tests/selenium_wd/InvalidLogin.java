package DevNexus;
import org.openqa.selenium.By;
import org.testng.annotations.Test;

public class InvalidLogin extends config 
{
	
			@Test
			public void Test() throws InterruptedException
			{
				driver.findElement(By.name("uid")).sendKeys(prop.getProperty("invalidUserName"));
				driver.findElement(By.name("password")).sendKeys(prop.getProperty("invalidPassword"));
				driver.findElement(By.id("login-form-submit")).click();
				Thread.sleep(3000);
			}
}





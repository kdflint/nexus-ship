package DevNexus;
import org.openqa.selenium.By;
import org.testng.annotations.Test;
public class goodlogin extends config
{
	
		@Test
		public void Test1() throws InterruptedException
		{
		    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("username"));
		    driver.findElement(By.name("password")).sendKeys(prop.getProperty("password"));  
		    driver.findElement(By.id("login-form-submit")).click();
		    Thread.sleep(3000);
		}
}

package DevNexus;
import org.openqa.selenium.By;
import org.testng.annotations.Test;
public class LogoutChck extends config 
{
		@Test
		public void Test2() throws InterruptedException
		{
			driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
			Thread.sleep(3000);
		}
}



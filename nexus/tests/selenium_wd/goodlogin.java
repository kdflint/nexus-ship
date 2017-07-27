package DevNexus;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
public class goodlogin
{
	
		@Test
		public void Test1() throws InterruptedException
		{
		System.setProperty("webdriver.chrome.driver","C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\chromedriver.exe");
		WebDriver driver=new ChromeDriver();
	    driver.get("https://northbridgetech.org/dev/nexus/web/login.php");
	    driver.manage().window().maximize();
	    driver.findElement(By.name("uid")).sendKeys("Hemalatha");
	    driver.findElement(By.name("password")).sendKeys("hemalatha2414");  
	    driver.findElement(By.id("login-form-submit")).click();
	    File src= ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
	    try {
	         FileUtils.copyFile(src, new File("C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\screenshot\\Test4.png"));
	    }
	     catch (IOException e)
	     {
	      System.out.println(e.getMessage());
	      
	      }
	    driver.close();
}
}

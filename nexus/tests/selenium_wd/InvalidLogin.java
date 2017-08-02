package DevNexus;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;

public class InvalidLogin 
{
	
			@Test
			public void Test2() throws InterruptedException
			{
			System.setProperty("webdriver.chrome.driver","C:\\Users\\Arvind\\Desktop\\hema practie selenium\\jar file folder\\chromedriver.exe");
			WebDriver driver1=new ChromeDriver();
		    driver1.get("https://northbridgetech.org/dev/nexus/web/nexus.php");
		    driver1.manage().window().maximize();
		   
		    driver1.findElement(By.name("uid")).sendKeys("abcd");
		    driver1.findElement(By.name("password")).sendKeys("abcd");
		    driver1.findElement(By.id("login-form-submit")).click();
		    	    
		    Thread.sleep(5000);
		    driver1.close();
		}
		}





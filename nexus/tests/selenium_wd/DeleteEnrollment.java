package DevNexus;

import org.openqa.selenium.By;
import org.testng.annotations.Test;

public class DeleteEnrollment extends config 
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
	    driver.findElement(By.cssSelector("#userRow1 > span.td-div > div.meeting > p > a > span.fa.fa-trash-o")).click();
	    driver.switchTo().alert().accept();
	    driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
	  }

}

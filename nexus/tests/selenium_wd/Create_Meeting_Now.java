package DevNexus;

import static org.testng.Assert.fail;

import org.openqa.selenium.By;
import org.testng.annotations.AfterClass;
import org.testng.annotations.Test;

	
	public class Create_Meeting_Now extends config 
	{
			@Test
			public void Test6() throws InterruptedException
			{
	 
		    driver.findElement(By.name("uid")).sendKeys(prop.getProperty("username"));
		    driver.findElement(By.name("password")).sendKeys(prop.getProperty("password"));  
		    driver.findElement(By.id("login-form-submit")).click();
		    Thread.sleep(3000);
	 	    //driver.findElement(By.xpath(".//*[@id='join_control']/span")).click();
	 	    driver.findElement(By.cssSelector(".fa.fa-circle-o-notch.fa-2x")).click();
	 	   
	       
	        driver.findElement(By.name("meeting-name")).sendKeys("latest");
	        driver.findElement(By.cssSelector("span.ui-icon.ui-icon-triangle-1-s")).click();
	        driver.findElement(By.id("ui-id-3")).click();
	        driver.findElement(By.cssSelector("#now-form-duration-button > span.ui-selectmenu-text")).click();
	        driver.findElement(By.id("ui-id-8")).click();
	        driver.findElement(By.id("now-form-submit")).click();
	        Thread.sleep(10000);
	        
	        //Deleting the created meeting
	       driver.findElement(By.cssSelector(".fa.fa-trash-o")).click();
	       Thread.sleep(3000);
	       driver.switchTo().alert().accept();
	                
		    driver.findElement(By.xpath("html/body/div[1]/div[1]/span[2]/a[3]/span")).click();
	       }

	      

		@AfterClass(alwaysRun = true)
	      public void tearDown() throws Exception 
	      {
	         driver.close();
	         String verificationErrorString = verificationErrors.toString();
	         if (!"".equals(verificationErrorString))
	         {
	           fail(verificationErrorString);
	         }
	      }
	}



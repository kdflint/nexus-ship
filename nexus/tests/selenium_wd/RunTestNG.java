import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;

import org.testng.TestNG;

/* Main Class to run test suites from command line*/
public class RunTestNG {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		TestNG test_runner = new TestNG();
		List<String> testsuiteFiles = new ArrayList<String>();
		
		testsuiteFiles.add("./TestSuite1.xml");
		testsuiteFiles.add("./TestSuite2_FBlogin.xml");
		
		test_runner.setTestSuites(testsuiteFiles);
		
		test_runner.run();
	}
}

package LinkedIn_Login;

import java.util.ArrayList;
import java.util.List;

import org.testng.TestNG;

public class RunTestNGLinkedIn {

	public static void main(String[] args) {
				
		TestNG test_runner = new TestNG();
		List<String> testsuiteFiles = new ArrayList<String>();
		
		testsuiteFiles.add("./TestSuite_LI.xml");
				
		test_runner.setTestSuites(testsuiteFiles);
		test_runner.run();
	}
}

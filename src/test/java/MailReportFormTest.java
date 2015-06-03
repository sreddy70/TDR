package test;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.csc.dpull.bean.*;

public class MailReportFormTest {

	MailReportForm _frm;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		 _frm = new MailReportForm();
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testEmailID() {
		String emailId = "sreddy@csc.com"; 
		_frm.setEmailID(emailId);
		assertSame(emailId, _frm.getEmailID());
	}

	@Test
	public void testSubject() {
		String sub = "Mail Subject";
		_frm.setSubject(sub);
		assertNotNull(_frm.getSubject());
	}

}

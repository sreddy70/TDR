package com.csc.dpull.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.MailReportForm;
import com.csc.dpull.util.DatabaseUtility;


public class MailReportAction extends Action {
	

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		boolean result=true;
		MailReportForm formBean=(MailReportForm) form;
		DatabaseUtility dbUtil=new DatabaseUtility();
		
		
		String enteredEmail=formBean.getEmailID();
		String subject=formBean.getSubject();
		String mailBody=formBean.getMailBody();		
		String filePath=formBean.getFileAttachment();
		
		try{
		
		dbUtil.mailAttachment(enteredEmail,subject,mailBody,filePath);
		
	    request.setAttribute("msg"," <font size=\"2px\"> Attachment has been mailed to you on \"<font color=\"gray\" >"+enteredEmail+"</font>\".</font>");
			return mapping.findForward("success");
		}
		catch (Exception e) {
			System.out.println("Exception caught - Class:ForgotPwdAction - Method :execute - Exception: "+e );
			request.setAttribute("msg"," Please enter correct Details");
			return mapping.findForward("failure");
			}
		}

	
	
	
	
	
	
	
}

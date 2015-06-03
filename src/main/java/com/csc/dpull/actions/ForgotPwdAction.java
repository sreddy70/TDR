package com.csc.dpull.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.ForgotPwdForm;
import com.csc.dpull.util.DatabaseUtility;


public class ForgotPwdAction extends Action {
	

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		DatabaseUtility dbUtil=new DatabaseUtility();
		
		ForgotPwdForm forgotPwdForm=(ForgotPwdForm) form;
		String enteredEmail=forgotPwdForm.getEmailId();
		String result="";
		try{
		String empId=forgotPwdForm.getEmpId();
		int enteredEmpId=Integer.parseInt(empId);
		String enteredDoj=forgotPwdForm.getDoj();
		 enteredEmail=forgotPwdForm.getEmailId();
		
		result= dbUtil.forgotPwdCheck(enteredEmpId, enteredDoj);
		}
		catch (Exception e) {
			System.out.println("Exception caught - Class:ForgotPwdAction - Method :execute - Exception: "+e );
			request.setAttribute("msg"," Please enter correct Employee Id & Date of Joining.");
			return mapping.findForward("failure");
		}
		if(!result.equals("")){	
			dbUtil.sendEmail("Login Password", result, enteredEmail);
			request.setAttribute("msg"," <font style=\"font-weight: bold;\">Password has been mailed to you on \"<font color=\"gray\" style=\"font-weight: bold;\">"+enteredEmail+"</font>\".</font>");
			return mapping.findForward("success");
			
		}
		else{
			request.setAttribute("msg"," Please enter correct Employee Id & Date of Joining.");
			return mapping.findForward("failure");
			}	
		
	
		}

	
	
	
	
}

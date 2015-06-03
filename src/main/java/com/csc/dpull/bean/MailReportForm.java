package com.csc.dpull.bean;

import org.apache.struts.action.ActionForm;

public class MailReportForm extends ActionForm{
	
	
	private static final long serialVersionUID = 1L;
	
	private String emailID;
	private String subject;
	private String mailBody;	
	private String fileAttachment;
	
	public String getEmailID() {
		return emailID;
	}
	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMailBody() {
		return mailBody;
	}
	public void setMailBody(String mailBody) {
		this.mailBody = mailBody;
	}
	
	public String getFileAttachment() {
		return fileAttachment;
	}
	public void setFileAttachment(String fileAttachment) {
		this.fileAttachment = fileAttachment;
	}
	
}

package com.csc.dpull.bean;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class ETLProcessForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String database;
	private String serverName;
	private String userid;
	private String password;
	private String FTPuserid;
	private String FTPpassword;
	private ArrayList<NameValueBean> dbList;
	
	
	public String getDatabase() {
		return database;
	}
	public void setDatabase(String database) {
		this.database = database;
	}
	public String getServerName() {
		return serverName;
	}
	public void setServerName(String serverName) {
		this.serverName = serverName;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public ArrayList<NameValueBean> getDbList() {
		return dbList;
	}
	public void setDbList(ArrayList<NameValueBean> dbList) {
		this.dbList = dbList;
	}
	public String getFTPuserid() {
		return FTPuserid;
	}
	public void setFTPuserid(String puserid) {
		FTPuserid = puserid;
	}
	public String getFTPpassword() {
		return FTPpassword;
	}
	public void setFTPpassword(String ppassword) {
		FTPpassword = ppassword;
	}
	
}

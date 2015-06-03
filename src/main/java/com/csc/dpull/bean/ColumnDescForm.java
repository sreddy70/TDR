package com.csc.dpull.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts.action.ActionForm;

public class ColumnDescForm extends ActionForm{
	
	private String dbName = "" ;
	private String tblName = "";
	private ArrayList<NameValueBean> dbList;
	private ArrayList<NameValueBean> tblList;
	private Map<String, String> colDetails;
	private String youSelectedDbName = "" ;
	private String youSelectedTblName = "";
	
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	public String getTblName() {
		return tblName;
	}
	public void setTblName(String tblName) {
		this.tblName = tblName;
	}
	public ArrayList<NameValueBean> getDbList() {
		return dbList;
	}
	public void setDbList(ArrayList<NameValueBean> dbList) {
		this.dbList = dbList;
	}
	public ArrayList<NameValueBean> getTblList() {
		return tblList;
	}
	public void setTblList(ArrayList<NameValueBean> tblList) {
		this.tblList = tblList;
	}
	public Map<String, String> getColDetails() {
		return colDetails;
	}
	public void setColDetails(Map<String, String> colDetails) {
		this.colDetails = colDetails;
	}
	public String getYouSelectedDbName() {
		return youSelectedDbName;
	}
	public void setYouSelectedDbName(String youSelectedDbName) {
		this.youSelectedDbName = youSelectedDbName;
	}
	public String getYouSelectedTblName() {
		return youSelectedTblName;
	}
	public void setYouSelectedTblName(String youSelectedTblName) {
		this.youSelectedTblName = youSelectedTblName;
	}
	public void resetAll(){
		setDbName("");
		setTblName("");
		setYouSelectedDbName("");
		setYouSelectedTblName("");
		setColDetails(new HashMap<String, String>());
		setDbList(new ArrayList<NameValueBean>());
		setTblList(new ArrayList<NameValueBean>());
	}
}

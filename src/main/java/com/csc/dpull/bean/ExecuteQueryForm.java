package com.csc.dpull.bean;

import org.apache.struts.action.ActionForm;

public class ExecuteQueryForm extends ActionForm{
	
	private String query = "" ;
	private String fromTable = "";
	private String queryNmbr = "";
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getFromTable() {
		return fromTable;
	}
	public void setFromTable(String fromTable) {
		this.fromTable = fromTable;
	}
	public String getQueryNmbr() {
		return queryNmbr;
	}
	public void setQueryNmbr(String queryNmbr) {
		this.queryNmbr = queryNmbr;
	}
	
}

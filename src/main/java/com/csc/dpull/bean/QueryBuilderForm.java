package com.csc.dpull.bean;

import org.apache.struts.action.ActionForm;

public class QueryBuilderForm extends ActionForm{

	private String query = "" ;
	private String fromtable = "";
	private String fromDatabase ="";

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getFromtable() {
		return fromtable;
	}

	public void setFromtable(String fromtable) {
		this.fromtable = fromtable;
	}

	public String getFromDatabase() {
		return fromDatabase;
	}

	public void setFromDatabase(String fromDatabase) {
		this.fromDatabase = fromDatabase;
	}
	
}

package com.csc.dpull.bean;

import org.apache.struts.action.ActionForm;

public class LockRecordsForm extends ActionForm{
	
	private String updateQuery;
	private String operation;

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getUpdateQuery() {
		return updateQuery;
	}

	public void setUpdateQuery(String updateQuery) {
		this.updateQuery = updateQuery;
	}

}

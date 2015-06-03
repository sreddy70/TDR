package com.csc.dpull.bean;

import org.apache.struts.action.ActionForm;

public class WhereClauseForm extends ActionForm{
	
	private static final long serialVersionUID = 1L;
	
	private String leftParenthesis;
	private String colList1;
	private String operator;
	private String colOrExp;
	private String expValue;
	private String colList2;
	private String rightParenthesis;
	private String whereClause;
	
	private String andOrVal;
	private String leftParVal;
	private String colList1Val;
	private String operatorVal;
	private String expOrSelectVal;
	private String expVal;
	private String colList2Val;
	private String rightParVal;
	
	public String getAndOrVal() {
		return andOrVal;
	}
	public void setAndOrVal(String andOrVal) {
		this.andOrVal = andOrVal;
	}
	public String getLeftParVal() {
		return leftParVal;
	}
	public void setLeftParVal(String leftParVal) {
		this.leftParVal = leftParVal;
	}
	public String getColList1Val() {
		return colList1Val;
	}
	public void setColList1Val(String colList1Val) {
		this.colList1Val = colList1Val;
	}
	public String getOperatorVal() {
		return operatorVal;
	}
	public void setOperatorVal(String operatorVal) {
		this.operatorVal = operatorVal;
	}
	public String getExpOrSelectVal() {
		return expOrSelectVal;
	}
	public void setExpOrSelectVal(String expOrSelectVal) {
		this.expOrSelectVal = expOrSelectVal;
	}
	public String getExpVal() {
		return expVal;
	}
	public void setExpVal(String expVal) {
		this.expVal = expVal;
	}
	public String getColList2Val() {
		return colList2Val;
	}
	public void setColList2Val(String colList2Val) {
		this.colList2Val = colList2Val;
	}
	public String getRightParVal() {
		return rightParVal;
	}
	public void setRightParVal(String rightParVal) {
		this.rightParVal = rightParVal;
	}
	public String getWhereClause() {
		return whereClause;
	}
	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}
	public String getLeftParenthesis() {
		return leftParenthesis;
	}
	public void setLeftParenthesis(String leftParenthesis) {
		this.leftParenthesis = leftParenthesis;
	}
	public String getColList1() {
		return colList1;
	}
	public void setColList1(String colList1) {
		this.colList1 = colList1;
	}	
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getExpValue() {
		return expValue;
	}
	public void setExpValue(String expValue) {
		this.expValue = expValue;
	}
	public String getColList2() {
		return colList2;
	}
	public void setColList2(String colList2) {
		this.colList2 = colList2;
	}
	public String getRightParenthesis() {
		return rightParenthesis;
	}
	public void setRightParenthesis(String rightParenthesis) {
		this.rightParenthesis = rightParenthesis;
	}
	public String getColOrExp() {
		return colOrExp;
	}
	public void setColOrExp(String colOrExp) {
		this.colOrExp = colOrExp;
	}
	

	
}

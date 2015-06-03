package com.csc.dpull.bean;

public class TableColumnListInfo {
	
	private String DB_NAME;
	private String TABLE_NAME;
	private String COLUMN_NAME;
	private String DATA_TYPE;
	
	public String getTABLE_NAME() {
		return TABLE_NAME;
	}
	public void setTABLE_NAME(String tABLENAME) {
		TABLE_NAME = tABLENAME;
	}
	public String getCOLUMN_NAME() {
		return COLUMN_NAME;
	}
	public void setCOLUMN_NAME(String cOLUMNNAME) {
		COLUMN_NAME = cOLUMNNAME;
	}
	public String getDATA_TYPE() {
		return DATA_TYPE;
	}
	public void setDATA_TYPE(String dATATYPE) {
		DATA_TYPE = dATATYPE;
	}
	public String getDB_NAME() {
		return DB_NAME;
	}
	public void setDB_NAME(String db_name) {
		DB_NAME = db_name;
	}
	

}

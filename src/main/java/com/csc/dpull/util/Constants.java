package com.csc.dpull.util;

import java.util.ArrayList;
import java.util.Arrays;

public interface Constants {
	
	public static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	public static final String DB_SERVER = "jdbc:mysql://localhost:3306/";
	public static final String DB_USERID = "root";
	public static final String DB_PASSWORD = "xyz" ;
	public static final String TDR_string = "Test Data Repository" ;
	public static final String DB_NAME = "tdr_db";
	public static final String DB_INFORMATION_SCHEMA = "information_schema";
	public static final String DB_MYSQL = "mysql";
	//maximum number of queries to be shown on query history page
	public static final String MAX_QUERIES_SAVED = "10";
	//name of databases to hide
	public static final ArrayList<String> dbsToHide =  new ArrayList<String>(Arrays.asList("information_schema", "mysql"));
	//name of tables to hide
	public static final ArrayList<String> tablesToHide =  new ArrayList<String>(Arrays.asList("column_details", "csc_dashboard_user","query_info","mainframe_info"));

}

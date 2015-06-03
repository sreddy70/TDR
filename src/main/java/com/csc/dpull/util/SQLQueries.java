package com.csc.dpull.util;

public class SQLQueries implements Constants{
	public static final String DASHBOARD_USERS = "select user_id,user_name,profile,access_role_id from "+Constants.DB_NAME+".CSC_DASHBOARD_USER where USER_id =? and PASSWORD =? ";
	
	public static final String table_details = "show columns from table_name";
	public static final String table_column_details = "SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME ,DATA_TYPE FROM "+Constants.DB_INFORMATION_SCHEMA+".COLUMNS";	
	
	public static final String table_column_count = "SELECT count(*) FROM "+Constants.DB_INFORMATION_SCHEMA+".COLUMNS order by 1";
	
	public static final String database_list = "show databases";
	public static final String table_list = "show tables from ?";

	public static final String forgotPwdCheckQuery = "select password from "+Constants.DB_NAME+".csc_dashboard_user where user_id=? and DOJ=? ";
	public static final String fetchColDetails= "select column_name, column_desc from "+Constants.DB_NAME+".column_details where table_name=? and database_name=?";

	// query to fetch relationship for a database	
	public static final String fetchTableRelations= "SELECT COLUMN_NAME AS CHILD_COLUMN ,TABLE_NAME AS CHILD_TABLE,REFERENCED_COLUMN_NAME AS PARENT_COLUMN,	REFERENCED_TABLE_NAME AS PARENT_TABLE FROM "+Constants.DB_INFORMATION_SCHEMA+".KEY_COLUMN_USAGE	WHERE TABLE_SCHEMA = ? and REFERENCED_COLUMN_NAME is not null";
	
	//queries to save and retrieve the latest queries fired by a particular user
	public static final String CREATE_QUERY_INFO_TABLE = "CREATE TABLE IF NOT EXISTS "+Constants.DB_NAME+".query_info(" +
		"`user_name` VARCHAR(50) NOT NULL ," +
		"`query_string` VARCHAR(2000) DEFAULT NULL," +
		"`from_tables` VARCHAR(1000) DEFAULT NULL," +
		"`from_database` VARCHAR(200) DEFAULT NULL," +
		"`query_date` DATETIME  DEFAULT NULL)";

	//public static final String QUERY_COUNT = "SELECT count(*) from query_info where user_name=?";

	public static final String INSERT_QUERY_INFO = "INSERT INTO "+Constants.DB_NAME+".query_info " +
		"(user_name, query_string, from_tables, from_database, query_date)" +
		" VALUES (?,?,?,?,?)";
	public static final String QUERY_INFO = "SELECT * " +
		"FROM "+Constants.DB_NAME+".query_info " +
		"WHERE user_name=? " +
		"ORDER BY query_date DESC " +
		"LIMIT "+Integer.valueOf(Constants.MAX_QUERIES_SAVED);
	//  DCSAC_D081110.TXT
	
	public static final String CREATE_MAINFRAME_INFO_TABLE="CREATE TABLE IF NOT EXISTS "+Constants.DB_NAME+".mainframe_info ("+
		"`sr_no` int(10) unsigned NOT NULL AUTO_INCREMENT,"+
		"`batch_date` date NOT NULL,"+
		"PRIMARY KEY (`sr_no`))";
	public static final String COUNT_TODAYS_ETL_PROCESS="SELECT count(*) FROM "+Constants.DB_NAME+".mainframe_info where batch_date=?";
	public static final String INSERT_MAINFRAME_INFO="insert into "+Constants.DB_NAME+".mainframe_info (batch_date) values(?)";
	
	public static final String deleteTable1="DELETE from cards.dctac_account";
	public static final String deleteTable2="DELETE from cards.dctax_acct_fee_dtl";
	public static final String deleteTable3="DELETE from cards.dctay_txn_fee_dtl";
	public static final String deleteTable4="DELETE from cards.dctek_extrnl_acct";
	public static final String deleteTable5="DELETE from cards.dctex_expn_fle";
	public static final String deleteTable6="DELETE from cards.dctgn_xchg_genrfin";
	public static final String deleteTable7="DELETE from cards.dctix_xchg_visafin";
	public static final String deleteTable8="DELETE from cards.dctjo_post_action";
	public static final String deleteTable9="DELETE from cards.dctlp_lsxpl";
	public static final String deleteTable10="DELETE from cards.dctlr_alerts";
	public static final String deleteTable11="DELETE from cards.dctls_lst_stln_icd";
	public static final String deleteTable12="DELETE from cards.dctly_lyl_tot";
	public static final String deleteTable13="DELETE from cards.dctmp_xchg_mci_fin";
	public static final String deleteTable14="DELETE from cards.dctpl_plastic";
	
	
	
//	public static final String loadTable1="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSAC.TXT\" INTO TABLE cards.dctac_account FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable2="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSAX.TXT\" INTO TABLE cards.dctax_acct_fee_dtl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable3="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSAY.TXT\" INTO TABLE cards.dctay_txn_fee_dtl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable4="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSEK.TXT\" INTO TABLE cards.dctek_extrnl_acct FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable5="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSEX.TXT\" INTO TABLE cards.dctex_expn_fle FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable6="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSGN.TXT\" INTO TABLE cards.dctgn_xchg_genrfin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable7="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSIX.TXT\" INTO TABLE cards.dctix_xchg_visafin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable8="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSJO.TXT\" INTO TABLE cards.dctjo_post_action FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable9="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSLP.TXT\" INTO TABLE cards.dctlp_lsxpl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable10="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSLR.TXT\" INTO TABLE cards.dctlr_alerts FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable11="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSLS.TXT\" INTO TABLE cards.dctls_lst_stln_icd FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable12="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSLY.TXT\" INTO TABLE cards.dctly_lyl_tot FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable13="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSMP.TXT\" INTO TABLE cards.dctmp_xchg_mci_fin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
//	public static final String loadTable14="LOAD DATA INFILE \"D:\\\\TDR_TableScripts\\\\DCSPL.TXT\" INTO TABLE cards.dctpl_plastic FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	
	public static final String loadTable1="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSAC.TXT\" INTO TABLE cards.dctac_account FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable2="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSAX.TXT\" INTO TABLE cards.dctax_acct_fee_dtl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable3="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSAY.TXT\" INTO TABLE cards.dctay_txn_fee_dtl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable4="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSEK.TXT\" INTO TABLE cards.dctek_extrnl_acct FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable5="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSEX.TXT\" INTO TABLE cards.dctex_expn_fle FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable6="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSGN.TXT\" INTO TABLE cards.dctgn_xchg_genrfin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable7="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSIX.TXT\" INTO TABLE cards.dctix_xchg_visafin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable8="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSJO.TXT\" INTO TABLE cards.dctjo_post_action FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable9="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSLP.TXT\" INTO TABLE cards.dctlp_lsxpl FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable10="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSLR.TXT\" INTO TABLE cards.dctlr_alerts FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable11="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSLS.TXT\" INTO TABLE cards.dctls_lst_stln_icd FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable12="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSLY.TXT\" INTO TABLE cards.dctly_lyl_tot FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable13="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSMP.TXT\" INTO TABLE cards.dctmp_xchg_mci_fin FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";
	public static final String loadTable14="LOAD DATA INFILE \"C:\\\\FTP\\\\cards\\\\DCSPL.TXT\" INTO TABLE cards.dctpl_plastic FIELDS TERMINATED BY \"#\" ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n'";

}

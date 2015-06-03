package com.csc.dpull.util;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.activation.*;

import org.apache.commons.net.ftp.FTPClient;



import com.csc.dpull.bean.QueryBuilderForm;
import com.csc.dpull.bean.TableColumnListInfo;






/**
 * 
 * @author ak185109
 */
public class DatabaseUtility {

	/** Creates a new instance of DatabaseUtility */
	public DatabaseUtility() {
	}

	public ArrayList<String> getuserInfo(String user_name, String password)
			throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String logininfo="loginFailure";
		String loggedUser="";
		ArrayList<String> alist=new ArrayList<String>();

		try {
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.DASHBOARD_USERS);
			ps.setString(1, user_name);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
			 loggedUser=rs.getString("user_name");
				logininfo = "loginSuccess";
			}
			
			System.out.println("-logged user-"+loggedUser);
			alist.add(loggedUser);
			alist.add(logininfo);
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return alist;
	}
	
	public static ArrayList<String> getTableList(String database_name)
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<String> tablelist = null;
		
		try {
			tablelist = new ArrayList<String>();
			con = DBUtil.getConnection();
			
			ps = con.prepareStatement("show tables from "+database_name);
			//ps.setString(1, database_name);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				tablelist.add(rs.getString(1));
			}
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return tablelist;
	}			
	
	public static TableColumnListInfo[] getTableColumnList()
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		TableColumnListInfo tcinfo[] = null;
		try {
			
			tcinfo  = new TableColumnListInfo[getColumnCount()];
			
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.table_column_details);
			//ps.setString(1, schema_name);
			
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {

				tcinfo[i] = new TableColumnListInfo();
				tcinfo[i].setDB_NAME(rs.getString("TABLE_SCHEMA"));
				tcinfo[i].setTABLE_NAME(rs.getString("TABLE_NAME"));
				tcinfo[i].setCOLUMN_NAME(rs.getString("COLUMN_NAME"));
				tcinfo[i].setDATA_TYPE(rs.getString("DATA_TYPE"));
					
				i++;
			}
			
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return tcinfo;
	}
	
	public static int getColumnCount()
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.table_column_count);
			//ps.setString(1, schema_name);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return count;
	}	
	
	public static ArrayList<String> getDatabaseList()
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<String> tablelist = null;
		
		try {
			tablelist = new ArrayList<String>();
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.database_list);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				tablelist.add(rs.getString(1));
			}
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return tablelist;
	}


	// Fetching Column details
	public static Map<String, String> fetchColDetails(String dbName, String tblName)
			throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map<String,String> map=new HashMap<String, String>();
		try {
			con = DBUtil.getConnection();
			
			ps = con.prepareStatement(SQLQueries.fetchColDetails);
			ps.setString(1, tblName);
			ps.setString(2, dbName);
			rs = ps.executeQuery();
		
			while(rs.next()) {
				//map.put(column_name, column_desc);
				map.put(rs.getString("column_name"), rs.getString("column_desc"));
			}
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return map;
	}
	

	public void updateLockRecords(String strUpdateQuery, String dbName) throws Exception {
		Connection con = null;
		Statement ps = null;
		String[] queries = null;
		queries = strUpdateQuery.split(";");
		try {
			con = DBUtil.getDbSpecificConnection(dbName);
			ps = con.createStatement();			
			for(int i=0;i<queries.length;i++){
				ps.addBatch(queries[i]);
			}
			
			ps.executeBatch();
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
				throw e;
			}
		}
		
	}
	
	public static ArrayList<String> getPrimaryKeyList(String table_name, String database_name)
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<String> tablecolumnlist = new ArrayList<String>();
		
		try {
			
			String[] splittable_name = splitstr(table_name, ",");
			
			String table_names = "";
			for (int i = 0; i < splittable_name.length; i++) {
				table_names = table_names + "'" + splittable_name[i].trim() + "',";
			}
			
			table_names = table_names.substring(0,table_names.length()-1);
			System.out.println("table names in DAO = "+table_names);
			
			con = DBUtil.getDbSpecificConnection(database_name);
			ps = con.prepareStatement("select table_name, column_name from INFORMATION_SCHEMA.COLUMNS where column_key = 'PRI' and table_name in ("+table_names+") order by 1");
			
			rs = ps.executeQuery();

			while (rs.next()) 
			{
				tablecolumnlist.add(rs.getString(1)+"."+rs.getString(2));
			}
			ps.close();
		} catch (Exception ex) 
		{
			ex.printStackTrace();
			throw ex;
		} 
		finally 
		{
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		System.out.println("returnning primary columns "+tablecolumnlist);
		return tablecolumnlist;
	}	
	
	public static String[] splitstr(String inpstr, String sep) {
		if (inpstr != null) {
			StringTokenizer str = new StringTokenizer(inpstr, sep);
			int count = str.countTokens();
			String arr_str[] = new String[count];
			for (int i = 0; i < count; i++) {
				arr_str[i] = str.nextToken(sep);
			}
			return arr_str;
		} else
			return null;
	}



	public String forgotPwdCheck(int empId, String doj){
		System.out.println("---forgotPwdCheck---");
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String result="";
		try{
			con=DBUtil.getConnection();
			ps=con.prepareStatement(SQLQueries.forgotPwdCheckQuery);
			ps.setInt(1, empId);
			ps.setString(2, doj);	
			System.out.println(ps.toString());
			rs=ps.executeQuery();
			/*rs.next();
			System.out.println("checking rs2-"+rs.getInt("count")); 
			
			if(rs.getInt("count")>0){
				 
				result=true;
			}
			*/
			if(rs.next())
			{
				System.out.println("password = "+rs.getString("password"));
				result= rs.getString("password");
			}
			else
			{
				System.out.println("---returning false from chng pwd ---");
				result="";
			}
			ps.close();
			con.close();
			rs.close();	
			
		}
		catch(Exception e){
			System.out.println("--Class: DatabaseUtility, Method:forgetPwdCheck, Exception caught:  "+e); 
			
		}		
		return result;

}


/**
	 * Send a single email.
	 */
	static ResourceBundle resBundle = ResourceBundle.getBundle("MQMonitor",Locale.US);
	public void sendEmail(String aSubject, String aBody,String mailTo) throws IOException {
		
		System.out.println("EmailPasswordAction--"+aSubject+aBody+mailTo); 
		
		String host = resBundle.getString("mail.host"); // "172.25.8.10";
		//String[] strArrTo = resBundle.getString("mail.to").trim().split(";"); // "hsachdeva2@csc.com";
		String from = resBundle.getString("mail.from").trim(); // "hsachdeva2@csc.com";

		Properties props = System.getProperties();
		props.put("mail.host", (host.trim()).toString());
		//props.put("mail.transport.protocol",resBundle.getString("mail.port").trim() );
		System.out.println(props.get("mail.host").toString()); 
		//System.out.println(props.get("mail.transport.protocol").toString());
		Session session = Session.getDefaultInstance(props, null);
			//strArrTo = strArrTo[iUrlToBeMonitored].split(",");
		Message msg = new MimeMessage(session);
		//for (int i = 0; i < strArrTo.length; i++) {	
			try {				
				String to = mailTo;
				msg.setFrom(new InternetAddress(from));
				InternetAddress[] address = { new InternetAddress(to.trim()) };
				msg.setRecipients(Message.RecipientType.TO, address);
				msg.setSubject(aSubject);
				msg.setText("Your login password to DPull is " + aBody + ".");
				msg.setSentDate(new Date());
				Transport.send(msg);
	
			} catch (MessagingException ex) {
				System.err.println("ERROR WHILE SENDING EMAIL. " + ex);
			}			
		}

	
	
	/**
	 * Send an attachment through  email. By Harsh
	 */
	public boolean mailAttachment(String emailId, String subject, String body, String filePath){
		//System.out.println(" class DatabaseUtility --Method mailAttachment--");
		String mailSubject=subject;
		String mailBody=body;
		String mailTo= emailId;
		String fileAttachment=filePath;
	
		
		String host = resBundle.getString("mail.host"); // "172.25.8.10";
		//String[] strArrTo = resBundle.getString("mail.to").trim().split(";"); // "hsachdeva2@csc.com";
		String from = resBundle.getString("mail.from").trim(); // "hsachdeva2@csc.com";

		  // Get system properties
			Properties props = System.getProperties();
			
		  // Setup mail server
			props.put("mail.host", (host.trim()).toString());
			//System.out.println(props.get("mail.host").toString());
			
		 // Get session	
			Session session = Session.getDefaultInstance(props, null);
		  
		// Define message
			Message msg = new MimeMessage(session);
			try {		
				String to = mailTo;
				msg.setFrom(new InternetAddress(from));
				InternetAddress[] address = { new InternetAddress(to.trim()) };
				msg.setRecipients(Message.RecipientType.TO, address);
				msg.setSubject(mailSubject);
				//msg.setText(mailBody);
				msg.setSentDate(new Date());
				//System.out.println("---2222----");
				 MimeBodyPart messageBodyPart =new MimeBodyPart();
				 messageBodyPart.setText(mailBody);
				 Multipart multipart = new MimeMultipart();
				 multipart.addBodyPart(messageBodyPart);
				 messageBodyPart = new MimeBodyPart();
				 DataSource source = new FileDataSource(fileAttachment);
				 //System.out.println("---3333----");
				 messageBodyPart.setDataHandler(new DataHandler(source));
				 messageBodyPart.setFileName(fileAttachment);
				 multipart.addBodyPart(messageBodyPart);
				 msg.setContent(multipart);
				// System.out.println("---4444----");
				 Transport.send( msg );
				 System.out.println("after sending msg" ); 
				 
			} catch (MessagingException ex) {
				System.err.println("ERROR WHILE SENDING EMAIL. " + ex);
			}
			return true;	
	}

	public static ArrayList<ArrayList<String>> fetchTableRelations(String databaseName) throws Exception{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ArrayList<String>> array2D = new ArrayList<ArrayList<String>>(); 
		
		
		try{
			con=DBUtil.getConnection();
		    ps = con.prepareStatement(SQLQueries.fetchTableRelations);
		    ps.setString(1, databaseName);
		    rs=ps.executeQuery();
		    while(rs.next()){
		   // System.out.println(rs.getString("CHILD_COLUMN")+"-"+rs.getString("CHILD_TABLE")+"-"+rs.getString("PARENT_COLUMN")+"-"+rs.getString("PARENT_TABLE"));
		    	ArrayList<String> array1D= new ArrayList<String>();
			    array1D.add(rs.getString("PARENT_TABLE"));
			    array1D.add(rs.getString("PARENT_COLUMN"));
			    array1D.add(rs.getString("CHILD_TABLE"));
			    array1D.add(rs.getString("CHILD_COLUMN"));
			    array2D.add(array1D);
		    }
		    
		    //System.out.println("2D array list size--"+array2D.size());
		}
		catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return array2D;
		
	}
	
	public static void saveQueryInfo(String userName, String tableName, String dbName, String query)
	throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.CREATE_QUERY_INFO_TABLE);
			ps.executeUpdate();
			ps.close();
			
//			ps = con.prepareStatement(SQLQueries.QUERY_COUNT);
//			ps.setString(1, userName);
//			rs = ps.executeQuery();
//			if (rs.next()) {
//				count = rs.getInt(1);
//			}
//			ps.close();
//			System.out.println("count - inside saveQueryInfo"+count);
//			int allowedQueryNum= Integer.valueOf(Constants.MAX_QUERIES_SAVED);
//			if (count == allowedQueryNum || count >allowedQueryNum)
//			{
//				for(int i=count; i>allowedQueryNum-1; i--)
//				{
//					ps = con.prepareStatement(SQLQueries.delete_row);
//					ps.executeUpdate();
//					ps.close();
//				}
//				//remove rows for the number of times (n-5+1)
//			}
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String queryDate = sdf.format(date);
			System.out.println("queryDate - inside saveQueryInfo"+queryDate);
			ps = con.prepareStatement(SQLQueries.INSERT_QUERY_INFO);
			ps.setString(1, userName);
			
			ps.setString(2, query);
			ps.setString(3, tableName);
			ps.setString(4, dbName);
			ps.setString(5, queryDate);
			ps.executeUpdate();
			ps.close();
			
			
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		//return count;
	}	
	
	public static Map<String, ArrayList<String>> retrieveQueryHistory(String userName)
	throws Exception
	{

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		Map<String, ArrayList<String>> queryinfo = new HashMap<String, ArrayList<String>>();
		try {
			
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.QUERY_INFO);
			ps.setString(1, userName);
			try
			{
				rs = ps.executeQuery();
				int i = 0;
				while (rs.next()) {
					ArrayList<String> rowInfo = new ArrayList<String>();
					rowInfo.add(rs.getString(1));
					rowInfo.add(rs.getString(2));
					rowInfo.add(rs.getString(3));
					rowInfo.add(rs.getString(4));
					rowInfo.add(rs.getString(5));
					queryinfo.put(String.valueOf(i+1), rowInfo);	
					i++;
				}
			}
			catch(SQLException sqlEx)
			{
				//sql exception is thrown if there is error in executing a query.
				//it may arise in case table from where query info is fetched is not available.
				System.out.println("Sql exception caught");
			}
			System.out.println("retrieved query is empty = "+queryinfo.isEmpty());
			ps.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		return queryinfo;
	
		
	}
		
	public static String countETLRuns(){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String result = "0";
		try {
			
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.CREATE_MAINFRAME_INFO_TABLE);
			ps.executeUpdate();
			ps.close();
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String queryDate = sdf.format(date);
			ps = con.prepareStatement(SQLQueries.COUNT_TODAYS_ETL_PROCESS);
			ps.setString(1, queryDate);
			rs = ps.executeQuery();
			if (rs.next()) {
				 result=rs.getString(1);
			}
			ps.close();
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return result;
		
	}
	
	public static void insertMainframeInfo(){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String queryDate = sdf.format(date);
			con = DBUtil.getConnection();
			ps = con.prepareStatement(SQLQueries.INSERT_MAINFRAME_INFO);
			ps.setString(1, queryDate);
			ps.executeUpdate();
			ps.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public boolean ETLProcess(Map<String, String> mapOfSpecs, File file){
		try{
		BufferedReader input1 =  new BufferedReader(new FileReader(file));
		String line1 = null;
		while (( line1 = input1.readLine()) != null){
			System.out.println(line1);
		}
		}catch(Exception ex){}
		//System.out.println("--ETL Process-1-----"); 
	     String serverName =mapOfSpecs.get("Server")  ; 
	     String userName =mapOfSpecs.get("UserId") ; 
	     String password =mapOfSpecs.get("Password") ; 
//		String serverName ="20.17.189.77"  ; 
//	     String userName ="Y00021" ; //AWT
//	     String password ="myname12" ; 
	     String result="";
	     
	  
	     System.out.println(serverName+"--"+userName+"--"+password);
	     FTPClient ftp = new FTPClient() ; 
	     //Connect to the server 
	     try { 
	          ftp.connect (serverName) ; 
	          String replyText =ftp.getReplyString()  ; 
	          System.out.println ("-1-"+replyText) ; 
	     } 
	     catch (Exception  e)  {
	               e.printStackTrace () ; 
	     } 
	     
	     //Login to the server 
	     try { 
	               ftp.login (userName, password) ; 
	               String replyText = ftp.getReplyString() ; 
	               System.out.println ("-2-"+replyText); 
	     } catch (Exception e) { 
	               e.printStackTrace(); 
	     } 
	     
	     //Tell server that the file will have JCL records 
	     try { 
	               ftp.site ("filetype=jes") ; 
	               String replyText = ftp.getReplyString() ; 
	               System.out.println ("-3-"+replyText) ; 
	     } 
	     catch 	(Exception e) { 
	               e.printStackTrace() ; 
	     } 
	     //Submit the job from the text file.Use \\ to avoid using escape notation 
	     try { 
	               //FileInputStream inputStream = new FileInputStream ("D:\\DPULLJCL.txt") ;
	    	 	   FileInputStream inputStream = new FileInputStream (file) ;
	               ftp.storeFile (serverName,inputStream);
	               result = ftp.getReplyString();
	             //  result=   "Transfer completed successfully";
	               
	               System.out.println ("-4-"+result) ; 
	     } 
	     catch	(Exception e) { 
	               e.printStackTrace() ; 
	     } 
	     //Quit the server 
	     try { 
	                 ftp.quit() ; 
	     } 
	     catch 	(Exception e) { 
	                e.printStackTrace() ; 
	     }
	    
	     //result=   "Transfer completed successfully";
	     if(result.contains("Transfer complete")){
	    	 System.out.println("returning true");
	    	 return true;
	    	 }
	     
	     else{
	    	 System.out.println("returning false");
	    	 return false;
	    	 }
	 }
	
	
	public boolean LoadDB(String DbName,String ScriptFilePath, String tableName) throws Exception{
		System.out.println("--Dao: method Load DB--");
		
		Connection con=null;
		//PreparedStatement ps=null;
		Statement ps = null;
		Statement ps1 = null;
		ResultSet rs=null;
		
		try {
		
		con=DBUtil.getConnection();
		
		ps = con.createStatement();
		ps.addBatch(SQLQueries.deleteTable1);
		ps.addBatch(SQLQueries.deleteTable2);
		ps.addBatch(SQLQueries.deleteTable3);
		ps.addBatch(SQLQueries.deleteTable4);
		ps.addBatch(SQLQueries.deleteTable5);
		ps.addBatch(SQLQueries.deleteTable6);
		ps.addBatch(SQLQueries.deleteTable7);
		ps.addBatch(SQLQueries.deleteTable8);
		ps.addBatch(SQLQueries.deleteTable9);
		ps.addBatch(SQLQueries.deleteTable10);
		ps.addBatch(SQLQueries.deleteTable11);
		ps.addBatch(SQLQueries.deleteTable12);
		ps.addBatch(SQLQueries.deleteTable13);
		ps.addBatch(SQLQueries.deleteTable14);
		ps.executeBatch();
		ps1 = con.createStatement();
		ps1.addBatch(SQLQueries.loadTable1);
		ps1.addBatch(SQLQueries.loadTable2);
		ps1.addBatch(SQLQueries.loadTable3);
		ps1.addBatch(SQLQueries.loadTable4);
		ps1.addBatch(SQLQueries.loadTable5);
		ps1.addBatch(SQLQueries.loadTable6);
		ps1.addBatch(SQLQueries.loadTable7);
		ps1.addBatch(SQLQueries.loadTable8);
		ps1.addBatch(SQLQueries.loadTable9);
		ps1.addBatch(SQLQueries.loadTable10);
		ps1.addBatch(SQLQueries.loadTable11);
		ps1.addBatch(SQLQueries.loadTable12);
		ps1.addBatch(SQLQueries.loadTable13);
		ps1.addBatch(SQLQueries.loadTable14);
		ps1.executeBatch();
		//ps=con.prepareStatement(SQLQueries.loadTable1);
	
	//	ps=con.prepareCall(SQLQueries.loadTable2);
		//rs=ps.executeQuery();
		return true;
		}
		
		catch(Exception e){		
			
			System.out.println("-Exception caught: Class DatabaseUtility : Method:LoadDB--"+e); 
			e.printStackTrace();
			return false;
		}finally {
			try {
				if (con != null)
					con.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				throw e;
			}
		}
		
		
	}
	
}

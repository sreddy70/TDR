package com.csc.dpull.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil implements Constants{
	 
    public static Connection getConnection() throws SQLException {
        Connection connection=null;
        try{
            if(connection== null) {                            
			 
            	String DB_Driver = Constants.DB_DRIVER;
           	    String DB_Server = Constants.DB_SERVER+Constants.DB_MYSQL;
            	String DB_USERID = Constants.DB_USERID;
                String DB_PASSWORD = Constants.DB_PASSWORD ;                                
                                 
                Class.forName(DB_Driver).newInstance();
               
                connection = DriverManager.getConnection(DB_Server, DB_USERID, DB_PASSWORD);   
            }
            return connection;
        } catch(SQLException e){
            throw new SQLException(e.toString());
        } catch(Exception e){
            throw new SQLException(e.toString());
        }
    }
    
    public static Connection getDbSpecificConnection(String db_Name) throws SQLException {
        Connection connection=null;
        try{
            if(connection== null) {                            
			 
            	String DB_Driver = Constants.DB_DRIVER;
           	    String DB_Server = Constants.DB_SERVER+db_Name;;
            	String DB_USERID = Constants.DB_USERID;
                String DB_PASSWORD = Constants.DB_PASSWORD ;     
                                 
                Class.forName(DB_Driver).newInstance();
               
                connection = DriverManager.getConnection(DB_Server, DB_USERID, DB_PASSWORD);   
            }
            return connection;
        } catch(SQLException e){
            throw new SQLException(e.toString());
        } catch(Exception e){
            throw new SQLException(e.toString());
        }
    }
    
    public static InputStream getPropertyAsStream( String propName ) throws IOException {
        Integer dummy = new Integer(0);
        StringBuffer sb = new StringBuffer(30);
        sb.append( "/properties/" );
        sb.append( propName );
        
        InputStream is = null;
        is = dummy.getClass().getResourceAsStream(sb.toString() );
        if(is==null) {
            is = dummy.getClass().getResourceAsStream( propName );
        }
       
        if(is==null){
            is = DBUtil.class.getResourceAsStream("/" + propName );
        }
        return is;
    }
    
    
}
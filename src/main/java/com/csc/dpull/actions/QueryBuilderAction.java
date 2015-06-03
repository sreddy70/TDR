package com.csc.dpull.actions;

import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.QueryBuilderForm;
import com.csc.dpull.util.DatabaseUtility;


public class QueryBuilderAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		QueryBuilderForm qbeform = (QueryBuilderForm)form;
		String query=qbeform.getQuery();
		
		int whereIndex=0;
		int fromIndex=0;
		String upperCaseQuery = query.toUpperCase();
		if (upperCaseQuery.contains("FROM")){
		fromIndex=upperCaseQuery.indexOf("FROM");
		}
		else{
			request.getSession().setAttribute("fromDatabase","");
			request.getSession().setAttribute("fromtable", "");
			return mapping.findForward("queryFailure");
		}
		
		if (upperCaseQuery.contains("WHERE")){
		whereIndex=upperCaseQuery.indexOf("WHERE");	
		}	
		else if (!upperCaseQuery.contains("WHERE") && upperCaseQuery.contains("GROUP BY")){
			whereIndex=upperCaseQuery.indexOf("GROUP BY");
		}
		else if (!upperCaseQuery.contains("WHERE") && !upperCaseQuery.contains("GROUP BY") && upperCaseQuery.contains("ORDER BY")){
			whereIndex=upperCaseQuery.indexOf("ORDER BY");
		}
		else if (!upperCaseQuery.contains("WHERE") && !upperCaseQuery.contains("GROUP BY") && !upperCaseQuery.contains("ORDER BY")){
			whereIndex=upperCaseQuery.length();
		}
		
		//System.out.println("fromIndex-"+fromIndex);
		//System.out.println("whereIndex-"+whereIndex);	
		
		String tableNames = query.substring(fromIndex+4, whereIndex);
		StringTokenizer st = new StringTokenizer(tableNames,",");
		String tableList="";
		String tables="";
		String tableName="";
		String dbName="";
		String dbaseName="";
		
		while (st.hasMoreTokens()) {	
			
			tables=st.nextToken().trim();
			if(tables.contains(".")){				
				tableName=tables.substring(tables.indexOf(".")+1, tables.length());
				 tableList+=tableName;
				 if(st.hasMoreTokens())
				 tableList+=",";  
				dbName=tables.substring(0, tables.indexOf("."));
			}
			else{
				System.out.println("error : database name not there"); 
				tableList+=tables;
				 if(st.hasMoreTokens())
				tableList+=",";  
				}                   
			}
		
		if (tableList.equals("") || tableList==null){
			tableList+="abc,def";  
		}
		
		request.getSession().setAttribute("queryString", qbeform.getQuery());
		
		//request.getSession().setAttribute("fromtable", qbeform.getFromtable());
		request.getSession().setAttribute("fromtable", tableList);
	//	request.setAttribute("queryString", qbeform.getQuery());
		
		request.setAttribute("queryString", qbeform.getQuery());
		request.setAttribute("fromtable",tableList);
		
		if (qbeform.getFromDatabase()!=null && !qbeform.getFromDatabase().equals("")){
			dbaseName=qbeform.getFromDatabase();
			request.getSession().setAttribute("fromDatabase",dbaseName );
			request.setAttribute("fromDatabase",dbaseName);
		}
		else if ( (qbeform.getFromDatabase()==null || qbeform.getFromDatabase().equals(""))&&(dbName==null || dbName.equals(""))){
			request.getSession().setAttribute("fromDatabase","");
		}
		else{ 
			dbaseName=dbName;
		request.getSession().setAttribute("fromDatabase",dbaseName);
			request.setAttribute("fromDatabase",dbaseName);
		}
		saveQueryInTable( request.getSession().getAttribute("userid").toString(),tableList,dbaseName,query);
		return mapping.findForward("querySuccess");
	}
	
	public void saveQueryInTable(String userName, String tableName, String dbName, String query)
	{
		try
		{
			DatabaseUtility.saveQueryInfo(userName, tableName, dbName, query);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
}

package com.csc.dpull.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReportGeneration
 */
public class ReportGeneration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportGeneration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder strDate = new StringBuilder();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
		response.setContentType("application/vnd.ms-excel");
		
		String fileName = "report_"+request.getSession().getAttribute("userid")+"_"+sdf.format(date);
		
		response.setHeader("Content-Disposition", "attachment; filename="+fileName+".xls");
	    PrintWriter out = response.getWriter();
	    try
	    {
	    	ArrayList<ArrayList<String>> resultSet =  (ArrayList<ArrayList<String>>) request.getSession().getAttribute("ResultSet");
	    	//System.out.println("excel resultSet = "+resultSet);
	    	if(resultSet!=null)
	    	{
	    		StringBuffer content = new StringBuffer();
	    		int countLock = 0;
	    		int countLockedBy = 0;
	    		int counLockCols = 0;
	    		for (int i=0;i<resultSet.size();i++)
	    		{
	    			String lockInfo ="";
	    			String lockedByInfo ="";
	    			counLockCols = countLock + countLockedBy;
	    			ArrayList<String> rowInfo = resultSet.get(i);
	    			if(i==0)
	    				content.append("<tr style=\"font-weight: bold;\">");
	    			else
	    				content.append("<tr>");
	    			for (int j=0; j<rowInfo.size(); j++)
	    			{
	    				if(rowInfo.get(j).equals("update_flag"))
	    				{
	    					if(i==0 && countLock==0)
	    					{
	    						content.append("<td>");
	    						content.append("Lock");
	    						content.append("</td>");
	    					}
	    					countLock++;
	    				}
	    				else if(rowInfo.get(j).equals("Locked_By"))
	    				{
	    					if(i==0 && countLockedBy==0)
	    					{
	    						content.append("<td>");
	    						content.append("Locked By");
	    						content.append("</td>");
	    					}
	    					countLockedBy++;
	    				}
	    				else if(i>0 && j>rowInfo.size()-countLock-countLockedBy-1)//7-4-1=2
	    				{
	    					if((counLockCols)%2==0)
	    					{
	    						lockInfo = lockInfo.equals("1")?"1":rowInfo.get(j);
	    						counLockCols--;
	    						if(counLockCols==1)
	    						{
	    							content.append("<td>");
	    							content.append(lockInfo.equals("1")?"Yes":"No");
	    							content.append("</td>");
	    						}
	    						if(rowInfo.get(j).equals("0"))
	    						{
		    						counLockCols--;
		    						j++;
	    						}
	    						else
	    						{
	    							lockedByInfo = lockedByInfo+","+rowInfo.get(j+1);
		    						counLockCols--;
		    						j++;
	    						}
	    						if(counLockCols==0)
	    						{
	    							content.append("<td>");
	    							content.append(lockedByInfo.substring(lockedByInfo.indexOf(",")+1));
	    							content.append("</td>");
	    						}
	    					}
	    				}
	    				else
	    				{
	    					content.append("<td>");
	    					content.append(rowInfo.get(j));
	    					content.append("</td>");
	    				}
	    			}
	    			content.append("</tr>");
	    		}
	    		StringBuffer contentforExcel = new StringBuffer();
		    	contentforExcel.append("<table border=1>");
		    	contentforExcel.append(content.toString());
		    	contentforExcel.append("</table>");
		    	out.write(contentforExcel.toString());
	    	}
	    	out.close();
	    }
	    catch(Exception ex)
	    {
	    	System.out.println("exception caught....");
	    	ex.printStackTrace();
	    }
	}
}

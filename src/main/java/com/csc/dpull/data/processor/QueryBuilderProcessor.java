package com.csc.dpull.data.processor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import com.csc.dpull.util.*;

public class QueryBuilderProcessor implements Constants {

	
	public static Map gettableXMLList(){ 
	Map map = new HashMap();
		
		StringBuffer xmllist = new StringBuffer();
		ArrayList<String> databaselist = null;
		ArrayList<String> tablelist = null;
		try 
		{
			databaselist = DatabaseUtility.getDatabaseList();
			ArrayList<String> dbListToRefresh = new ArrayList<String>();
			xmllist.append("<?xml version=\\\'1.0\\\' encoding=\\\'iso-8859-1\\\'?>");
			xmllist.append("<tree id=\\\"0\\\">");			
			xmllist.append("<item text=\\\" "+Constants.TDR_string+" \\\" id=\\\""+Constants.TDR_string+"\\\" call=\\\"1\\\" select=\\\"1\\\">");
			for (int i = 0; i < databaselist.size(); i++) {
				if(!(Constants.dbsToHide.contains(databaselist.get(i))))
				{
					dbListToRefresh.add(databaselist.get(i));
					tablelist = DatabaseUtility.getTableList(databaselist.get(i));
				
					xmllist.append("<item text=\\\"" + databaselist.get(i) +"\\\" id=\\\"" + databaselist.get(i) +"\\\" >");
					
					for (int j = 0; j < tablelist.size(); j++) {
						if(!(Constants.tablesToHide.contains(tablelist.get(j))))
						{
							xmllist.append("<item text=\\\"");
							xmllist.append(tablelist.get(j));
							xmllist.append("\\\" id=\\\"");
							xmllist.append(tablelist.get(j));
							xmllist.append("\\\" />");
						}
					}				
					xmllist.append("</item>");		
				}
			}
			xmllist.append("</item>");		
			xmllist.append("</tree>");
			map.put("xmllist", xmllist.toString());
			map.put("databaselist", dbListToRefresh);
			System.out.println("in dao--"+map.get("xmllist"));
			System.out.println("in dao--"+map.get("databaselist"));
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return map;
	}
	
}

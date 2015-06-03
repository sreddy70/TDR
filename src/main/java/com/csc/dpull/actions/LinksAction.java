package com.csc.dpull.actions;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.ColumnDescForm;
import com.csc.dpull.bean.ETLProcessForm;
import com.csc.dpull.bean.ForgotPwdForm;
import com.csc.dpull.bean.NameValueBean;
import com.csc.dpull.data.processor.QueryBuilderProcessor;
import com.csc.dpull.util.Constants;
import com.csc.dpull.util.DatabaseUtility;

public class LinksAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {	
		String requesttype = request.getParameter("actionType");
		if (requesttype.equals("showColDescription")){
			
			ColumnDescForm columnDescForm=(ColumnDescForm) form;
			//remove call to resestAll() method if it's not needed to refresh the page on tab click
			columnDescForm.resetAll();
			ArrayList<String> dbList = DatabaseUtility.getDatabaseList();
			ArrayList<NameValueBean> arrayOfDbs = new ArrayList<NameValueBean>();
			if(dbList!=null)
			{
				for(int i=0; i<dbList.size();i++)
				{
					if(!Constants.dbsToHide.contains(dbList.get(i)))
					{
						NameValueBean nvBean = new NameValueBean();
						nvBean.setName(dbList.get(i));
						nvBean.setValue(dbList.get(i));
						arrayOfDbs.add(nvBean);
					}
				}
			}
			columnDescForm.setDbList(arrayOfDbs);
			return mapping.findForward("showColDescPage");
		}
		else if (requesttype.equals("forgotPwd")){
			return mapping.findForward("FwdPwdLink");
		}
		else if (requesttype.equals("queryHistory")){
			Map<String, ArrayList<String>> queryInfoMap =  DatabaseUtility.retrieveQueryHistory(request.getSession().getAttribute("userid").toString());
			request.setAttribute("queryInfo", queryInfoMap);
			return mapping.findForward("queryHistoryPage");
		}
		else if (requesttype.equals("queryBuilderPage")){
			
			Map  map= new HashMap();
			map	= QueryBuilderProcessor.gettableXMLList();
			String xmllist =(String) map.get("xmllist");
			request.setAttribute("tablelist", xmllist);				
			request.setAttribute("tablecolumnlist", DatabaseUtility.getTableColumnList());			
//			map=databaseUtility.fetchColDetails();
//			request.getSession().setAttribute("colDetails", map);
			
			return mapping.findForward("success");
		}
		else if(requesttype.equalsIgnoreCase("startETL"))
		{
			ETLProcessForm etlProcessForm = (ETLProcessForm) form; 
			ArrayList<String> dbList = DatabaseUtility.getDatabaseList();
			ArrayList<NameValueBean> arrayOfDbs = new ArrayList<NameValueBean>();
			if(dbList!=null)
			{
				for(int i=0; i<dbList.size();i++)
				{
					if(!Constants.dbsToHide.contains(dbList.get(i)))
					{
						NameValueBean nvBean = new NameValueBean();
						nvBean.setName(dbList.get(i));
						nvBean.setValue(dbList.get(i));
						arrayOfDbs.add(nvBean);
					}
				}
			}
			etlProcessForm.setDbList(arrayOfDbs);
			return mapping.findForward("querySuccess");
		}
		else
		return null; 
	}
	
}

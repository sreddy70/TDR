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
import com.csc.dpull.bean.NameValueBean;
import com.csc.dpull.util.Constants;
import com.csc.dpull.util.DatabaseUtility;

public class ColumnDescAction  extends Action{
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {	
		String requesttype = request.getParameter("actionType");
		ColumnDescForm colDescForm = (ColumnDescForm) form;
		if (requesttype.equals("tables")){
			ArrayList<String> tblList = DatabaseUtility.getTableList(colDescForm.getDbName());
			ArrayList<NameValueBean> arrayOfTables = new ArrayList<NameValueBean>();
			if(tblList!=null)
			{
				for(int i=0; i<tblList.size();i++)
				{
					if(!Constants.tablesToHide.contains(tblList.get(i)))
					{
						NameValueBean nvBean = new NameValueBean();
						nvBean.setName(tblList.get(i));
						nvBean.setValue(tblList.get(i));
						arrayOfTables.add(nvBean);
					}
				}
			}
			colDescForm.setTblList(arrayOfTables);
			return mapping.findForward("showColDescPage");
		}
		else if (requesttype.equals("columns")){
			Map<String, String> colDetails = DatabaseUtility.fetchColDetails(colDescForm.getDbName(), colDescForm.getTblName());
			colDescForm.setColDetails(colDetails);
			colDescForm.setYouSelectedDbName(colDescForm.getDbName());
			colDescForm.setYouSelectedTblName(colDescForm.getTblName());
			return mapping.findForward("showColDescPage");
		}
		else
			return null; 
			
	}
}

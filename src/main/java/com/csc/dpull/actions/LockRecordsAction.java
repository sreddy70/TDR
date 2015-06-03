package com.csc.dpull.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.LockRecordsForm;
import com.csc.dpull.util.DatabaseUtility;



public class LockRecordsAction extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try{
		String dbName = request.getSession().getAttribute("fromDatabase").toString();
		DatabaseUtility DBUtility = new DatabaseUtility();
		LockRecordsForm lock=(LockRecordsForm)form;
		String strUpdateQuery = lock.getUpdateQuery();	
		
		DBUtility.updateLockRecords(strUpdateQuery,dbName);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return mapping.findForward("lockSuccess");
	}

}

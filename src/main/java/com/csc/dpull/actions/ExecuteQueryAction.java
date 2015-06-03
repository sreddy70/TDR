package com.csc.dpull.actions;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.ExecuteQueryForm;
import com.csc.dpull.bean.QueryBuilderForm;

public class ExecuteQueryAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, ArrayList<String>> queryDetails=(Map<String, ArrayList<String>>)request.getSession().getAttribute("queryInfo");
		ExecuteQueryForm exQueryForm = (ExecuteQueryForm)form;
		String queryNum = exQueryForm.getQueryNmbr();
		request.getSession().setAttribute("queryString", ((ArrayList<String>) queryDetails.get(queryNum)).get(1).toString());
		request.setAttribute("queryString", ((ArrayList<String>) queryDetails.get(queryNum)).get(1).toString());
		request.getSession().setAttribute("fromtable", ((ArrayList<String>) queryDetails.get(queryNum)).get(2).toString());
		request.getSession().setAttribute("fromDatabase", ((ArrayList<String>) queryDetails.get(queryNum)).get(3).toString());
		return mapping.findForward("querySuccess");
	}
}

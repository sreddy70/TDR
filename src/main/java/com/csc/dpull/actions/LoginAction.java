package com.csc.dpull.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.LoginForm;
import com.csc.dpull.data.processor.QueryBuilderProcessor;
import com.csc.dpull.util.DBUtil;
import com.csc.dpull.util.DatabaseUtility;


public class LoginAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	//Map<String, ArrayList<String>> map= new HashMap<String, ArrayList<String>>();
	Map map1 = new HashMap();
		
		LoginForm login=(LoginForm)form;
		String userid = login.getUserId();
		String password = login.getPassword();
	//	request.getSession().setAttribute("userid", userid);
		ArrayList<String> alist = validate(userid,password);
		String loggedUser = alist.get(0);
		request.getSession().setAttribute("userid", loggedUser);
		
		String result=alist.get(1);
		if(result != null && result.equals("loginSuccess")){
			
			 map1= QueryBuilderProcessor.gettableXMLList();
			 String xmllist=(String) map1.get("xmllist");
			request.setAttribute("tablelist", xmllist);
			request.setAttribute("tablecolumnlist", DatabaseUtility.getTableColumnList());
			//ArrayList<String> dblist= (ArrayList<String>) map1.get("databaselist");
			//request.getSession().setAttribute("dblist", dblist);
			
		}
		else if(result != null && result.equals("loginFailure")){
			request.setAttribute("errorMsg", " <font style=\"font-weight: bold;\">Invalid UserId and Password</font>");
		
		}

		return mapping.findForward(result);
	
	}

	private ArrayList<String> validate(String userid, String password) throws Exception {
		DatabaseUtility DBUtility = new DatabaseUtility();
		ArrayList<String> alist = DBUtility.getuserInfo(userid, password);
		
		return alist;
	}
}

package com.csc.dpull.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.WhereClauseForm;

public class WhereClauseAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String result ="";
		try {


			WhereClauseForm formBean = (WhereClauseForm) form;
			
			//for first row
			 result = " where"+ formBean.getLeftParenthesis()+""+formBean.getColList1()+" "+formBean.getOperator()+" ";
			 if(formBean.getColOrExp().equals("Table Column"))
			 {
				 result = result + formBean.getColList2();
			 }
			 else
			 {
				 result = result + formBean.getExpValue();
			 }
			 result = result + ""+ formBean.getRightParenthesis();
			 
			//request.setAttribute("whereClause", result);
			
			//other than first row
			String[] andOrArray=formBean.getAndOrVal().split(",");
			String[] leftParArray=formBean.getLeftParVal().split(",");
			String[] col1Array=formBean.getColList1Val().split(",");
			String[] operatorArray=formBean.getOperatorVal().split(",");
			String[] selectArray=formBean.getExpOrSelectVal().split(",");
			String[] expValArray=formBean.getExpVal().split(",");
			String[] col2Array=formBean.getColList2Val().split(",");
			String[] rightParArray=formBean.getRightParVal().split(",");
			
			int noOfRows=andOrArray.length;
			for(int i=0;i<noOfRows; i++){
				result=result.concat(" ").concat(andOrArray[i])
								.concat(" ").concat(leftParArray[i])
									.concat(" ").concat(col1Array[i])
										.concat(" ").concat(operatorArray[i])
											.concat(" ");
										
				if(selectArray[i].equals("Table Column"))
				{
					result = result.concat(col2Array[i]);
				}
				 else
				{
					result = result.concat(expValArray[i]);
				}
				
				result = result.concat(rightParArray[i]);	
			}
			formBean.setWhereClause(result.trim());

		} catch (Exception e) {
			System.out.println("-WhereClauseAction Exception==" + e);
			e.printStackTrace();
			request.setAttribute("errorMsg"," Please enter the correct values.");
			return mapping.findForward("failure");
		}
	
		return mapping.findForward("Success");
	}

}

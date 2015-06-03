package com.csc.dpull.actions;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.Writer;
import java.net.InetAddress;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.csc.dpull.bean.ETLProcessForm;
import com.csc.dpull.util.DatabaseUtility;

public class ETLProcessAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		boolean result=false;
		String requesttype = request.getParameter("actionType");
		ETLProcessForm formBean = (ETLProcessForm) form;
		DatabaseUtility dbtil = new DatabaseUtility();
		
		if(requesttype.equals("etlProcess")){		
		
			Map<String, String> mapOfSpecs = new HashMap<String, String>();
			mapOfSpecs.put("Database", formBean.getDatabase());
			mapOfSpecs.put("Server", formBean.getServerName());
			mapOfSpecs.put("UserId", formBean.getUserid());
			mapOfSpecs.put("Password", formBean.getPassword());
			mapOfSpecs.put("FTPUserId", formBean.getFTPuserid());
			mapOfSpecs.put("FTPPassword", formBean.getFTPpassword());
			
			String countETL = DatabaseUtility.countETLRuns();
			DatabaseUtility.insertMainframeInfo();
			
			File jclFile = getFile(countETL, mapOfSpecs);
			result = dbtil.ETLProcess(mapOfSpecs, jclFile);
			System.out.println("getting response==="+result);
			//result = true;
			if (result) {
				request.setAttribute("msg"," <font color=\"red\" size=\"2\" style=\"font-family: sans-serif; font-weight: bold\">Request has been sent to Mainframe. Job Execution has been started. </br> Reception of Batch files will take some time . After receiving Batch files click refresh Database button to Reload the database.</font>");
			}
			else if(!result){
				request.setAttribute("msg","<font color=\"red\" size=\"2\" style=\"font-family: sans-serif; font-weight: bold\">Some Problem occured while sending your request to Mainframe Server.</font>");
			}
		}
		if(requesttype.equals("LoadDB")){
			try{
				boolean result1=false;
			result1=dbtil.LoadDB("","","");
			if(result1){
			request.setAttribute("msg"," <font color=\"red\" size=\"2\" style=\"font-family: sans-serif; font-weight: bold\">Database has been refreshed successfully.</font>");
			}
			if(!result1){
				request.setAttribute("msg","<font color=\"red\" size=\"2\" style=\"font-family: sans-serif; font-weight: bold\">Some Problem occured while refreshing the database.</font>");
			}
			}
			catch(Exception e){
				request.setAttribute("msg"," <font color=\"red\" size=\"2\" style=\"font-family: sans-serif; font-weight: bold\">Problem occured in refreshing the database. Please check Mainframe Script content.</font>");
				System.out.println("--Exception caught : class ETLProcessAction : Method execute"+e); 
				
			}
			
		}
		return mapping.findForward("success");
	}

	public File getFile(String countETL, Map<String, String> mapOfSpecs)
	{

		Writer writer = null; 
		File resultFile =null;
		try{
			InetAddress clientIp = InetAddress.getLocalHost();
			resultFile = new File("write.txt");
			writer = new BufferedWriter(new FileWriter(resultFile)); 
			
			//File jclFile = new File("D:\\TDR_TableScripts\\DPULLJCL.txt");
			File jclFile =  new File(getServlet().getServletContext().getRealPath("")+"/jcl/DPULLJCL.txt");
			System.out.println("file exists: " + jclFile.exists());
			BufferedReader input =  new BufferedReader(new FileReader(jclFile));
			
			StringBuilder strDate = new StringBuilder();
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yy");
			
			strDate.append("D");
			strDate.append(sdf.format(date).replaceAll("-", ""));
			if(!countETL.equals("0"))
				strDate.append((char)(64+Integer.valueOf(countETL)));
			String line = null;
			while (( line = input.readLine()) != null){
				if(line.contains("$DbName"))
					line = line.replace("$DbName", "ADADPULL");
				if(line.contains("$Date"))
					line = line.replace("$Date", strDate.toString());
				if(line.contains("$IPAddress"))
					line = line.replace("$IPAddress", clientIp.getHostAddress());
				if(line.contains("$FTPUserId"))
					line = line.replace("$FTPUserId", mapOfSpecs.get("FTPUserId"));
				if(line.contains("$FTPPassword"))
					line = line.replace("$FTPPassword", mapOfSpecs.get("FTPPassword"));
				
				writer.append(line);
				writer.append("\n");
			}
			writer.close();
		}
		catch(Exception ex)
		{
			System.out.println("excepetion name = "+ex.getMessage());
		}
		return resultFile;
	}
	
	

}

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.ArrayList"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>DPull</title>
	<link rel='STYLESHEET' type='text/css' href='./common/style.css'>
	
	<script type="text/javascript">
	function submitForm(){
		//alert(document.forms[0].action);
			document.forms[0].submit();
			//alert("-2-");
	}

	function reloadDB(){
		//alert("reloadDB");
		document.forms[0].action="/Tdr/reloadDB.do?actionType=LoadDB";    
		//alert(document.forms[0].action);
	    document.forms[0].submit(); 
	  //  alert("reloadDB submit");  
		
}


	
<%
//ArrayList<String> dblist=(ArrayList<String>)request.getSession().getAttribute("dblist");
//ArrayList<String> dblist= new ArrayList<String>();
//System.out.println("--on etl jsp--"+dblist.size());

String msg=(String)request.getAttribute("msg");
System.out.println("--on etl jsp--"+msg);
String printMsg="";
%>

	</script>
	
	
</head>

<body>
<html:form action="/etlProcess.do?actionType=etlProcess"  styleId="etlForm"  >
<table cellspacing="0" cellpadding="0" class="sample_header" border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
	<tr valign="middle">
		<!-- COMPONENT ICON -->
		<td width="40" align="center"><img src="./common/dhtmlxtree_icon.gif" border="0"></td>
		<!-- COMPONENT NAME -->
		<td width="205" align="left"><b>DPull</b></td>
		<!-- SAMPLE TITLE -->
		<td>
			<table cellpadding=0 cellspacing=0>
				<tr height="30">
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="queryBuilderPage?actionType=queryBuilderPage">Query Builder</html:link></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/showColDesc.do?actionType=showColDescription">Column Details</html:link></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/queryHistory.do?actionType=queryHistory" >Search History</html:link></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#FFFFFF', startColorstr='#DDDDDD', gradientType='0');" class="tab_selected"><b>Refresh Database</b></td>
				</tr>
			</table>
		</td>
		<!-- CLOSE BUTTON -->
		<td width="250"><div align="left"><b>Welcome <%=request.getSession().getAttribute("userid") %></b></div></td>
		<td width="80" align="center"><a href="index.jsp" class="logout"><b>Logout</b></a></td>
	</tr>
</table>
<table border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" width="1112" height="620" border="0">
	<tr>
		<td align="" valign="top">
			<br><br>
	  <table cellpadding="0" cellspacing="0" width="35%" border="0" align="center" >  
        <tr>
				<td><font size = 2 color="#000000" style="font-family: sans-serif;">Select Database</font></td>
				<td> 
                    <html:select styleId="dbSelectId" property="database" name="ETLProcessForm">
                    	<html:option value="0">Select database</html:option>
                    	<html:optionsCollection name="ETLProcessForm" property="dbList" label="name" value="value" />
                    </html:select>							
				</td>
		</tr>
		 <tr><td colspan="2">&nbsp;</td>	</tr>	
		 
		 <tr>
				<td><font size = 2 color="#000000" style="font-family: sans-serif;">Server Name</font></td>
				<td> 
				 <html:text name="ETLProcessForm" property="serverName" size="20" maxlength="20"/>
				</td>
		</tr>	
		 <tr><td colspan="2">&nbsp;</td>	</tr>	
		<tr>
				<td><font size = 2 color="#000000" style="font-family: sans-serif;">User ID</font></td>
				<td> 
				 <html:text name="ETLProcessForm" property="userid" size="20" maxlength="20"/>
				</td>
		</tr>	  
	    <tr><td colspan="2">&nbsp;</td>	</tr>	
		
		<tr>
			<td><font size = 2 color="#000000" style="font-family: sans-serif;">Password</font></td>
			<td><html:password name ="ETLProcessForm"  property="password" size="20"  /></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td>	</tr>	
		
		<tr>
			<td><font size = 2 color="#000000" style="font-family: sans-serif;">FTP User ID</font></td>
			<td><html:text name ="ETLProcessForm"  property="FTPuserid" size="20"  /></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td>	</tr>	
		
		<tr>
			<td><font size = 2 color="#000000" style="font-family: sans-serif;">FTP Password</font></td>
			<td><html:password name ="ETLProcessForm"  property="FTPpassword" size="20"  /></td>
		</tr>
		
		    <tr><td colspan="2">&nbsp;</td>	</tr>
		    <tr><td colspan="2">&nbsp;</td>	</tr>
		    <tr><td colspan="2">&nbsp;</td>	</tr>
		
		<tr>
			<td><input style="width:10 " type="Button" value="Extract Data"  onclick="submitForm();"></td>
			<td><input style="" type="Button" value="Refresh/Reload Database"  onclick="reloadDB();"></td>
							
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>	
	    
	   <tr height=""><td colspan="2" >
	 
	    <%=printMsg%>
	   </td>	
	   </tr>
		
   </table>     
   </td>
	</tr>	
	 <%if(msg!=null && !msg.equals("")){ 
		   printMsg=msg; }
		  %>
	<tr height="250px" align="center">
	<td valign="top"><%=printMsg%></td>
	</tr>
	
	
</table>
 </html:form>
 </body>
</html>

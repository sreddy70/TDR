<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>

<%
		String path = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
%>


<html>
<head>
	<title>DPull - Forgot Password</title>
	<link rel='STYLESHEET' type='text/css' href='<%=path%>common/style.css'>
	<LINK href="css/IEWin.css" type=text/css rel=stylesheet>
<script type="text/javascript">
<%
// System.out.println("-Harsh msg-"+request.getAttribute("msg"));
String msg=(String)request.getAttribute("msg");
String printMsg="";
%>


function onSubmit(){
	
	if(document.getElementById('empId').value=="")
	{
		alert("Please Enter Employee Id.");
		//document.getElementById('USER').focus();
		return false;
	}	
	
	 if(document.getElementById('doj').value=="")
	{
		alert("Please Enter Date of Joining.");
		//document.getElementById('PASSWORD').focus();
		return false;
	}	

	 if(document.getElementById('emailId').value=="")
	{
		alert("Please Enter Email Id.");
		//document.getElementById('PASSWORD').focus();
		return false;
	}
	else{
		document.fgtPwdForm.submit();
		}
}
</script>
</head>
<body>
<html:form action="/getPwd.do">
	
	<table  cellspacing="0" cellpadding="0" class="sample_header" border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
	<tr valign="middle">
		<!-- COMPONENT ICON -->
		<td width="40" align="center"><img src="<%=path%>common/dhtmlxtree_icon.gif" border="0"></td>
		<!-- COMPONENT NAME -->
		<td width="205" align="left"><b>DPull</b></td>
		<!-- SAMPLE TITLE -->
		<td align="center">&nbsp;<b>I Forgot My Password</b></td>
		<!-- CLOSE BUTTON -->
		<td width="250">&nbsp;</td>
		<td width="80" align="center"><a href="index.jsp"><font color="blue" style="font-weight: bold;">Back</font></a></td>
	</tr>
	
</table>	 

<table style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" width="1112" height="620">
	<tr>
		<td valign="top">	

	<table width="100%" border="0" style="border: 0px solid; border-color: #999999;">
	<tr><td></td></tr><tr><td></td></tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
		<br>				
		<br>
		<tr>
			<td>
			<table align="center">
				<tr><td colspan="2" height="50"></td></tr>
				<tr align="left">
					<th colspan="2">Please Enter the following Details :</th>
				</tr>
				<tr><td colspan="2" height="10"></td></tr>
				<tr>
					<td>Employee Id</td>
					<td><html:text
						property="empId" value=""></html:text></td>
				</tr>
				<tr>
					<td>Date of Joining</td>
					<td><html:text
						property="doj" value=""></html:text>&nbsp;&nbsp;(Ex: yyyy-mm-dd)</td>
				</tr>
				<tr>
					<td>Email Id</td>
					<td><html:text
						property="emailId" value=""></html:text>&nbsp;&nbsp;(Ex: abc@csc.com)</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><html:submit
						onclick="return onSubmit();"></html:submit>
					<html:reset></html:reset>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				
				<tr><td height="75"></td></tr>
				
				<tr>
					<%
						if(msg !=null){
						printMsg=msg;
						System.out.println("printMsg-"+printMsg);
						}
					%>
					<td colspan="2"><font color="red"><%=printMsg%></font></td>
				</tr>
			</table>
			</td>
		</tr>
		

	</table>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td></td></tr>
				<tr><td></td></tr><tr><td></td></tr>
				<tr><td></td></tr>
		<tr>
			<td colspan=4 align="center">
			<hr width="90%" color="#616D7E" align="center">
			<span class="copyr" >&#169; Copyright 2010 CSC. All Rights Reserved. <A class="more" HREF="#">Legal/Data Privacy Statement</A>.</span>
			</td>
		</tr>
	</table>
		</td>
	</tr>
</table>
</html:form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>
<html>
<head>
	<title>Mail Report</title>
	<link rel='STYLESHEET' type='text/css' href='./common/style.css'>

<script type="text/javascript">
<%

String path = request.getScheme() + "://"
		+ request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath()
		+ "/";
		
		
		String msg=(String)request.getAttribute("msg");
		String printMsg="";
	
%>

function onSubmit(){
	if(document.getElementById('emailID').value=="")
	{
		alert("Please Enter Email Id.");
		//document.getElementById('USER').focus();
		return false;
	}	
	
	 if(document.getElementById('subject').value=="")
	{
		alert("Please Enter Mail Subject.");
		//document.getElementById('PASSWORD').focus();
		return false;
	}	

	 if(document.getElementById('fileAttachment').value=="")
	{
		alert("Please select the File ");
		//document.getElementById('PASSWORD').focus();
		return false;
	}
	else{
	document.mailReportForm.submit();
	}
}

function closeWindow()
{
	window.close();
}

</script>
</head>


<body>
<html:form styleId="mailReportForm" action="/mailFile.do">
<table width="1115" height="10" cellspacing="0" cellpadding="0" class="sample_header" border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
	<tr valign="middle">
		<!-- COMPONENT ICON -->
		<td width="40" align="center"><img src="<%=path%>common/dhtmlxtree_icon.gif" border="0"></td>
		<!-- COMPONENT NAME -->
		<td width="205" align="left"><b>DPull</b></td>
		<!-- SAMPLE TITLE -->
		<td align="center">&nbsp;<b>Mail Report</b></td>
		<!-- CLOSE BUTTON -->
		<td width="250">&nbsp;</td>
		<td width="80" align="center"><a href="javascript: void(0);" class="logout" onclick="closeWindow()"><b>Close</b></a></td>
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
					<td>Email Id</td>
					<td><html:text
						property="emailID" value=""></html:text>&nbsp;&nbsp;(Ex: abc@csc.com)</td>
				</tr>
				<tr>
					<td>Mail Subject</td>
					<td><html:text
						property="subject" value=""></html:text></td>
				</tr>
				<tr>
					<td>Mail Content/Body</td>
					<td><html:textarea property="mailBody" value="" cols="20" rows="5"></html:textarea></td>
				</tr>
				<tr><td></td></tr>
				<tr>
				<td>Attach File</td>
					<td colspan="2"><input type="file" name="fileAttachment" id="fileAttachment">		</td>
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
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="button" onclick="onSubmit()" value="Mail Report">
					<html:reset></html:reset>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr><td></td></tr>
				<tr><td></td></tr>
				<tr>
					<td colspan="2">
					<%
						if(msg !=null){
						printMsg=msg;
						System.out.println("printMsg-"+printMsg);
						}
					%>
					<font color="red"><%=printMsg%></font>
					</td>
				</tr>
				
				<tr><td height="40"></td></tr>
				
				
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
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td></td></tr>
				<tr><td></td></tr><tr><td></td></tr>
				<tr><td></td></tr>
		<tr>
			<td colspan=4 align="center">
			<hr width="90%" color="#616D7E" align="center">
			<span class="copyr" >&#169; Copyright 2010 CSC. All Rights Reserved. <A class="more" HREF="#">Legal/Data Privacy Statement</A></span>
			</td>
		</tr>
	</table>
		</td>
	</tr>
</table>

</html:form>
</body>
</html>

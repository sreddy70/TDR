<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
<script type="text/javascript" src="common/jquery-1.4.2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#DataAcqDesc").mouseover(function(){
	    $("#DataAcqDesc").addClass("backgroundChange");
	  });
	$("#DataAcqDesc").mouseout(function(){
	    $("#DataAcqDesc").removeClass("backgroundChange");
	  });

	$("#TestDataDesc").mouseover(function(){
	    $("#TestDataDesc").addClass("backgroundChange");
	  });
	$("#TestDataDesc").mouseout(function(){
	    $("#TestDataDesc").removeClass("backgroundChange");
	  });  

	
	$("#EmpoweringDesc").mouseover(function(){
	    $("#EmpoweringDesc").addClass("backgroundChange");
	  });
	$("#EmpoweringDesc").mouseout(function(){
	    $("#EmpoweringDesc").removeClass("backgroundChange");
	  });

	$("#RedDependDesc").mouseover(function(){
	    $("#RedDependDesc").addClass("backgroundChange");
	  });
	$("#RedDependDesc").mouseout(function(){
	    $("#RedDependDesc").removeClass("backgroundChange");
	  });

	$('#headerTable').click(function() {
		  $('#headerTable').animate({
		    opacity: 0.80
		    }, 'slow', function() {
		    	 $('#headerTable').animate({
		 		    opacity: 1.00
		 		    }, 'slow', function() {
			 		    document.getElementById('headerTable').click(); });
		  });
		});	   
	});



<%
String msg=(String)request.getAttribute("errorMsg");
System.out.println("on login jsp"+msg);
String printMsg="";	
%>
</script>

<style>
.backgroundChange{
background:navy;
font-size: 2px;
border:2px solid;
border-color:#999999;
color: white;
font-weight:lighter;


}

</style>
<LINK href="css/IEWin.css" type=text/css rel=stylesheet>


  <title>DPull - Login</title>
<SCRIPT LANGUAGE="JavaScript">

<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Expires","0"); 
response.setDateHeader("Expires",-1); 
%>



function resetCredFields()
{
	document.getElementById('PASSWORD').value = "";
	document.getElementById('headerTable').click();	
}

function submitForm()
{
    	if(document.getElementById('USER').value=="")
    	{
    		alert("User Name is mandatory field.");
    		document.getElementById('USER').focus();
    		return false;
    	}	
    	if(document.getElementById('PASSWORD').value=="")
    	{
    		alert("Password is mandatory field.");
    		document.getElementById('PASSWORD').focus();
    		return false;
    	}	

}
function forgottonPassword()
{
	alert('ForGotton');
}

function modifyProfile()
{
	alert('Modify');	   
	document.Login.submit();
}

function FormKeyPressed()
{
	if (navigator.appName == "Netscape")
	{
		return true;
	} else {
		
		if (13 == event.keyCode)
		{
			//submitForm();
			event.returnValue = false;
		} else {
			event.returnValue = true;
		}
	}
	return true;
}
</SCRIPT>
		
	</head>

<BODY bgColor="#FFFFFF" onload="resetCredFields()" topMargin="6px" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="headerTable">
		<tr>
			<br>
			<td width="5%">&nbsp;</td>
			 <!-- <td width="7%" valign="top">
		        <img src="images/logo2008.gif" height="35px" width="90px" border="0">
   		     </td>   		
			<td width="83%"><img src="images/Header_bgChange_4.JPG" border="0"></td>
			 -->
			 <td width="25%">
			 <img src="images/FileTransfer.jpg" border="0" height="100px" width="300px" vspace="0"></img>
			 </td>
			 <td width="65%" bgcolor="#1F497D">
				<table width="100%" cellpadding="0" cellspacing="0" >
				<tr>
					<td style="color:#FFFFFF;font-size:28px;font-family: sans-serif;padding-left:30px;">
					DPull - Acquire and Reserve Test Data
					</td>
				</tr>
				</table>
			 </td>
			 
			<td width="5%">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" height="60px;">&nbsp;</td>
		</tr>
		<!-- <tr>
			<td width="100%" colspan="2" align="left">
			     <div align='left'><img src="images/DPull.jpg" height="100" width="220" border="0"></div>
			</td>
		</tr>
		 -->
	</table>	<!-- clone starts from here -->  	  
<html:form   action="/login.do">

<center>

<!-- outer table with border -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<!--  <td width="70%">&nbsp;&nbsp;&nbsp;<img src="images/DPULL_New .JPG"   border="0">
	</td>
	 -->
	 <td width="5%">
	 &nbsp;
	 </td>
	 <td width="60%">
	 <table width="100%" border="0" height="250px;">
		 <tr bgcolor="#1F497D">
			 <td style="color:#FFFFFF;font-size:18px;font-family: sans-serif;" align="center">
			 <b>Welcome to DPull</b>
			 </td>
		 </tr>
		 <tr>
			 <td style="font-size:14px;font-family: sans-serif;">
			 &nbsp;
			<!--  <b>DPull Test Data Repository Application helps in :-</b>  -->
			 </td>
		 </tr>
		 <tr>
			 <td style="font-family: sans-serif;font-size:13px">
			 <table width="100%">
			 	<tr>
			 		<td width="5%">
			 		<img src="images/files.jpg" height="40px;" width="40px;"></img>
			 		</td>
			 		<td width="95%">
			 		<div id="DataAcqDesc" style="font-family: sans-serif; font-size:13px"><b>Data acquisition from files or databases required for the successful execution of test cases by business analysts/testers.</b></div>
			 		</td>
			 	</tr>
			 </table>
			 </td>
		 </tr>
		 <tr>
			 <td style="font-family: sans-serif;font-size:13px">
			 <table width="100%">
			 <tr>
				 <td width="5%">
				 <img src="images/graphs.gif" height="40px;" width="40px;"></img>
				 </td>
				 <td width="95%">
				 <div id="TestDataDesc" style="font-family: sans-serif; font-size:13px"><b>Test data identification from Production/Test environment by providing the criteria thereby reducing lot of manual effort.</b></div>
				 </td>
			 </tr>
			 </table>	
			 </td>
		 </tr>
		 <tr>
			 <td style="font-family: sans-serif;font-size:13px">
			 <table width="100%">
				 <tr>
					<td width="5%">			
					<img src="images/development1.png" height="40px;" width="40px;"></img>	 
					</td>
					<td width="95%">
					 <div id="RedDependDesc" style="font-family: sans-serif;font-size:13px"><b>Reducing dependency on development team for test data.</b></div>
					</td>
				 </tr>
			 </table>
			 </td>
		 </tr>
		 <tr>
			 <td style="font-family: sans-serif;font-size:13px">
			 <table>
			 	<tr>
			 		<td width="5%">
			 		<img src="images/Empower.bmp" height="40px;" width="40px;"></img>
			 		</td>
			 		<td width="95%">
			 		<div id="EmpoweringDesc" style="font-family: sans-serif;font-size:13px"><b>Empowering the business analysts/testers to reserve the test data to prevent any other user from using the same test data.</b></div>
			 		</td>
			 	</tr>
			 </table>
			 </td>
		 </tr>
		 
	 </table>
	 </td>	
	 <td width="5%">
	 &nbsp;
	 </td>
	 <td width="25%" align="left">
		<table width="100%" border="0" style="border:2px solid;border-color:#999999;">
			<tr>
				<td>
					<span class="headline3" style="height:250px;background:#F9F9F9">
					<br>
					<font color="#202020" style="font-family: sans-serif;margin-left: 30px"><b>Please Log In</b></font>
					<br><br>
					<table  cellpadding="0" cellspacing="0" width="100%" border="0">
							<tr>
							<td width="60%"><SPAN class=headline2d><font size = 2 color="#000000" style="font-family: sans-serif;margin-left:30px">User ID</font></span></td>
							<td width="40%"></td>
							</tr>
							<tr>
								<td colspan="2" valign="top">&nbsp;<html:text  name="LoginForm"  property="userId" size="30" styleId="USER" style="margin-left: 25px" /></td>
								</tr>
								<tr>
								<td width="60%"><br><SPAN class=headline2d><font size = 2 color="#000000" style="font-family: sans-serif;margin-left:30px">Password</font></span><br></td>
								<td width="40%"></td>
								</tr>
								<tr>
								<td colspan="2" valign="top">&nbsp;<html:password styleId="PASSWORD" name="LoginForm"  property="password" size="30"  style="margin-left: 25px" /><br><br></td>
								</tr>
								<tr>
								<td></td>
								<td></td>
								</tr>
								<tr>
								<td></td>
								<td></td>
								</tr>
								<tr>
								<td>
								&nbsp;<input style="margin-left:23px" type="image" value="Log In" src="images/login_dk_mouse_over.gif" width="88" height="28"  name="submit" title="Click to Logon" onclick="return submitForm();">
								</td>
								
							<td >
								
								</td>
								
								<!-- 
								<td width="100%" valign="bottom" align="center">
								<table height="28px;" border="0">
									<tr height="28px;">
									
									<td width="70%" bgcolor="#FFFFFF" height="28px;" align="left">
									<input type="image" value="Log In" src="images/login_dk_mouse_over.gif" width="88" height="28"  name="submit" title="Click to Logon" onclick="return submitForm();">
									</td>
									<td width="30%" height="28px;">
									</td>
									
									</tr>
									<tr height="28px;">
									
									<td width="70%" bgcolor="#FFFFFF" height="28px;" align="left" nowrap="nowrap">
									<font size="1"><a href="">Forgot Password</a></font>
									</td>
									<td width="30%" height="28px;">
									</td>
									
									</tr>
								</table>
							</td>  
							-->
								</tr>
								
								<%
								if(msg !=null){
								printMsg=msg;
								System.out.println("printMsg-"+printMsg);
								}
								%>
								<tr>
								<td colspan="2"><font color="red" size="2" style="font-family: sans-serif;margin-left:30px;"><%=printMsg%></font>
								</td>
								</tr>
								<tr> <td></td> </tr>
								
								<tr>
								<td nowrap="nowrap">							
								<font size="2" style="font-family: sans-serif;margin-left:30px">

								<html:link action="forgotPwdLink?actionType=forgotPwd" >Forgot Password</html:link>
								</font>
  
								</td>
								<td>
								&nbsp;
								</td>
								</tr>
					

				</table>
				
				
				
				 </span>
				
				 </td> 
				 </tr>
				 </table>
				 </td>
				 
				 <td width="5%">
				 &nbsp;
				 </td>
</tr>
  
  
  <tr> 
    <td>
	  <!-- Login table -->
     
    </td>
  </tr>
</table>
</center></html:form>	

<script language="javascript">
  document.getElementById("USER").focus();
</script><!-- clone ends here -->
<br><br><br>
<hr width="90%" color="#616D7E" align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td colspan=4 align="center">
<span class="copyr" >&#169; Copyright 2010 CSC. All Rights Reserved. <A class="more" HREF="#">Legal/Data Privacy Statement</A>.</span>
</td></tr>
</table>
</body>
</html>
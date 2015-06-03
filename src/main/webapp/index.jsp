<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %> 


<html>
<head>
<script LANGUAGE="JavaScript">
<%request.getSession().invalidate();
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Expires","0"); 
response.setDateHeader("Expires",-1); 
%>
window.onunload = unloadPage;
function unloadPage()
{
document.FrmLog.action="SN_LogoutDisp.jsp";
document.FrmLog.submit();
var colList1 = document.getElementById("colList1");
colList1.appendChild("");
}
</script>
</head>
<body>
	<jsp:forward page="login.jsp" />
	
</body>
</html>
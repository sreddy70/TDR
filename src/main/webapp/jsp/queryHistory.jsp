<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>

<%@page import="java.util.ListIterator"%><html>


<head>
	<title>DPull</title>
	<link rel='STYLESHEET' type='text/css' href='./common/style.css'>
</head>

<%
	Map queryDetails=(Map)request.getAttribute("queryInfo");
	request.getSession().setAttribute("queryInfo",queryDetails);
%>
<script type="text/javascript">

	function validateRadioChecked(radioObj) {
		if(!radioObj)
			return "";
		var radioLength = radioObj.length;
		if(radioLength == undefined)
			if(radioObj.checked)
			{
				document.getElementById('selectedQueryNum').value = radioObj.value;
				return true;
			}
			else
			{
				alert('Please select a query to see results');
				return false;
			}
		for(var i = 0; i < radioLength; i++) {
			if(radioObj[i].checked) {
				document.getElementById('selectedQueryNum').value = radioObj[i].value;
				return true;
			}
		}
		alert('Please select a query to see results');
		return false;
	}


	</script>
	
<html:form styleId="queryHistoryForm" action="/executeQuery.do" target="resultPage">
<body>

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
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/showColDesc.do?actionType=showColDescription" >Column Details</html:link></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#FFFFFF', startColorstr='#DDDDDD', gradientType='0');" class="tab_selected"><b>Search History</b></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/refreshDatabase.do?actionType=startETL">Refresh Database</html:link></td>
				</tr>
			</table>
		</td>
		<!-- CLOSE BUTTON -->
		<td width="250"><div align="left"><b>Welcome <%=request.getSession().getAttribute("userid") %></b></div></td>
		<td width="80" align="center"><a href="index.jsp" class="logout"><b>Logout</b></a></td>
	</tr>
</table>
<html:hidden styleId="fromTable" name="ExecuteQueryForm" property="fromTable" ></html:hidden>
<html:hidden styleId="selectedQuery" name="ExecuteQueryForm" property="query" ></html:hidden>
<html:hidden styleId="selectedQueryNum" name="ExecuteQueryForm" property="queryNmbr" ></html:hidden>
<table style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" width="1112" height="620">
	<tr>
		<td align="center" valign="top">
			</br></br>


		<%
		if(queryDetails.isEmpty())
		{%>
			<b>Previous searches not available.</b>
		<%}
		else
		{
			%>

			<table border="1" cellspacing="0" cellpadding="3">	
				<tr>
					<th width="5%">&nbsp;</th>
					<th>Showing last 10 queries with latest at the top</th>
				</tr>

			<%
			//map is formed in reverse order.. in orderto display last item must be shown first
			for(int i=0; i<queryDetails.size();i++)
			{
				String serialNum = String.valueOf(i+1);
				String query = ((ArrayList) queryDetails.get(serialNum)).get(1).toString();
			%>
				<tr>
					<td width="5%"><input type="radio" name="queryRadio" value="<%=serialNum%>"></td>
					<td align="left"><%=query%></td>
				</tr>
			<%
			}
			%>
			</table>
			<br><br><br>
			<INPUT type="submit" value="Show Results" onclick="return validateRadioChecked((document.forms['queryHistoryForm'].elements['queryRadio']))" />
		<%
		}%>
		</td>
	</tr>
</table>	
</body>
</html:form>
</html>

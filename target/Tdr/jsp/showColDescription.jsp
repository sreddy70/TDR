<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.csc.dpull.util.Constants"%>
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean"%>

<%@page import="java.util.HashMap"%><html>

<%
	String path = request.getScheme() + "://"
	+ request.getServerName() + ":"
	+ request.getServerPort() + request.getContextPath()
	+ "/";
	//ArrayList<String> dbList = (ArrayList<String>)request.getAttribute("dbList");
//	System.out.println("dbList list "+dbList);
	//Map colDetails=(Map)request.getSession().getAttribute("colDetails");
	Map colDetails=  new HashMap();
%>

<head>
	<title>DPull</title>
	<link rel='STYLESHEET' type='text/css' href='./common/style.css'>
	
	<script type="text/javascript">
	function showTables(sel){ 
		   if(sel.options.selectedIndex == 0){
		     // alert('Please choose a database'); 
		   } 
		   else{ 
			   document.colDescForm.action='<%=path%>showColumns.do?actionType=tables';
			   document.forms["colDescForm"].submit();
		   } 
		} 
	function fetchColumns()
	{
		// check that database and table is selected from the drop down
		if(document.getElementById("dbSelectId").options.selectedIndex=='0')
		{
			alert('Please select a database');
			return false;
		}
		else if(document.getElementById("tblSelectId").options.selectedIndex=='0')
		{
			alert('Please select a table');
			return false;
		}
		else
		{
			return true;
		}
		
	}
	
	</script>
</head>

<html:form  styleId="colDescForm"  action="/showColumns.do?actionType=columns" >
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
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#FFFFFF', startColorstr='#DDDDDD', gradientType='0');" class="tab_selected"><b>Column Details</b></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/queryHistory.do?actionType=queryHistory" >Search History</html:link></td>
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
<table style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" width="1112" height="620" border="0">
	<tr>
		<td align="center" valign="top">
			<br><br>
			<label  class="infoMessage" > Please select database and table to get column description</label>
			<br><br>
			<table border="0" cellspacing="0" cellpadding="3" width="500">	
				<tr>
					<td>
						<html:select styleId="dbSelectId" property="dbName" name="ColumnDescForm" onchange="showTables(this)">
							<html:option value="0">Select database</html:option> 
							<html:optionsCollection name="ColumnDescForm" property="dbList" 
								label="name" value="value" />
						</html:select>
					</td>
					<td>
						<html:select styleId="tblSelectId" property="tblName" name="ColumnDescForm" >
							<html:option value="0">Select table</html:option> 
							<logic:notEmpty name="ColumnDescForm" property="tblList">
								<html:optionsCollection name="ColumnDescForm" property="tblList" 
									label="name" value="value" />
							</logic:notEmpty>
						</html:select>
					</td>
					<td>
						<input type="submit" value="Fetch Columns" onclick="return fetchColumns()">
					</td>
				</tr>
			</table>
			<br><br>
			<table border="0" width="300">
				<tr>
					<logic:notEmpty name="ColumnDescForm" property="youSelectedDbName">
					<logic:notEmpty name="ColumnDescForm" property="youSelectedTblName">
						<td>
							<label style="font-weight: bold">Schema: </label>
							<bean:write name="ColumnDescForm" property="youSelectedDbName"/>
						</td>
						<td>
							<label style="font-weight: bold">Table: </label>
							<bean:write name="ColumnDescForm" property="youSelectedTblName"/>
						</td>
					</logic:notEmpty>
					</logic:notEmpty>
				</tr>
			</table>
			<br>
			<table border="1" cellspacing="0" cellpadding="3" width="500">	
				<logic:notEmpty name="ColumnDescForm" property="colDetails">
					<tr><th>Column Name</th>
						<th>Column Description</th>
					</tr>
					<logic:iterate id="colId" name="ColumnDescForm" property="colDetails">
					<tr>
						<td><bean:write name="colId" property="key"/></td>
						<td><bean:write name="colId" property="value"/></td>
					</tr>
					</logic:iterate>
				</logic:notEmpty>
				<logic:notEmpty name="ColumnDescForm" property="dbName">
				<logic:notEqual value="0" name="ColumnDescForm" property="tblName">
				<logic:empty name="ColumnDescForm" property="colDetails">
					<tr>
						<td style="font-weight: bold">
							No column details available for the selected table
						</td>
					</tr>
				</logic:empty>
				</logic:notEqual>
				</logic:notEmpty>
			</table>
		</td>
	</tr>
</table>
</body>
</html:form>
</html>

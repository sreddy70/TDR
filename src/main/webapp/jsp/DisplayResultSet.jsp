<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ page 
	import = "com.csc.dpull.util.*"
	import = "java.io.*"
	import = "java.lang.*"
	import = "java.sql.*"
	import="java.text.*"
	import = "javax.swing.*"
	import="java.util.*"
%>
<%
String msg="";
String printMsg="";	

	
%>
<%
	String query = "";
		String userid = (String) request.getSession().getAttribute(
				"userid");
		Connection con = null;
		Statement st = null;
		PreparedStatement pstmt_get_Sequence = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		con = DBUtil.getDbSpecificConnection(session.getAttribute("fromDatabase").toString());
		st = con.createStatement();
		HashSet<String> pricolumnset = new HashSet<String>();
		//Map<String, ArrayList<String>> reArrangedPricolumnset = new HashMap<String, ArrayList<String>>();
%>
<%!public int nullIntconv(String str) {
		int conv = 0;
		if (str == null) {
			str = "0";
		} else if ((str.trim()).equals("null")) {
			str = "0";
		} else if (str.equals("")) {
			str = "0";
		}
		try {
			conv = Integer.parseInt(str);
		} catch (Exception e) {
		}
		return conv;
	}%>
<%!public ArrayList<ArrayList<String>> convertResultSetToArrayList(ResultSet rs) {
	
	ArrayList<ArrayList<String>> results = new ArrayList<ArrayList<String>>();
	try
	{
		ResultSetMetaData resultSetMetaData =rs.getMetaData();
    	int numColumns = resultSetMetaData.getColumnCount();
    	ArrayList<String> rowInfo =new ArrayList<String>();
    	for (int i=1; i<(numColumns+1); i++)
    	{
        	String columnName = resultSetMetaData.getColumnName(i);
    		rowInfo.add(i-1,columnName);
    	}
    	results.add(rowInfo);
    	while (rs.next()) {
    		rowInfo =new ArrayList<String>();
    		for (int l = 1; l < numColumns + 1; l++) {
    			String columnName = resultSetMetaData.getColumnName(l);
    			rowInfo.add(l-1,rs.getObject(l)!=null?rs.getObject(l).toString():"");
    		}
    		results.add(rowInfo);
    	}
    	//System.out.println("array of arrays = ="+results);
	}
	catch(Exception ex)
	{
		System.out.println("Exception in convertResultSetToArrayList mthd in DisplayResultSet.js");
		ex.printStackTrace();
	}
	return results;
}%>
<%
try{
	ResultSet rsPagination = null;
		ResultSet rsRowCnt = null;
		String path = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
		PreparedStatement psPagination = null;
		PreparedStatement psRowCnt = null;

		int iShowRows = 20; // Number of records show on per page
		int iTotalSearchRecords = 10; // Number of pages index shown

		int iTotalRows = nullIntconv(request.getParameter("iTotalRows"));
		int iTotalPages = nullIntconv(request
				.getParameter("iTotalPages"));
		int iPageNo = nullIntconv(request.getParameter("iPageNo"));
		int cPageNo = nullIntconv(request.getParameter("cPageNo"));

		int iStartResultNo = 0;
		int iEndResultNo = 0;

		if (iPageNo == 0) {
			iPageNo = 0;
		} else {
			iPageNo = Math.abs((iPageNo - 1) * iShowRows);
		}

		String queryString = session.getAttribute("queryString").toString();
		//queryString = queryString.toUpperCase();
		String upperCaseQuery = queryString.toUpperCase();
	
		String columnexist = queryString.substring(0, upperCaseQuery
				.indexOf("FROM"));
		boolean aggAvailable = false;
		if(columnexist.indexOf("SUM(")==-1 && columnexist.indexOf("MIN(")==-1 && columnexist.indexOf("MAX(")==-1 && columnexist.indexOf("COUNT(")==-1 && columnexist.indexOf("AVG(")==-1)
		{	
			aggAvailable = false;
		}
		else
		{
			aggAvailable = true;
		}
		String[] splittable_name = DatabaseUtility.splitstr(session
				.getAttribute("fromtable").toString(), ",");
		if(!aggAvailable){
		ArrayList<String> pricolumnlist = DatabaseUtility
				.getPrimaryKeyList(session.getAttribute("fromtable").toString(), 
									session.getAttribute("fromDatabase").toString());
		String pricolumnstring = "";
		for (int i = 0; i < pricolumnlist.size(); i++) {
			if (columnexist.indexOf(pricolumnlist.get(i)) == -1) {
				pricolumnstring = pricolumnstring + ""
						+ pricolumnlist.get(i) + ",";
			}
			pricolumnset.add(pricolumnlist.get(i));
		}
		for (int i = 0; i < splittable_name.length; i++) {
			pricolumnstring = pricolumnstring
					+ splittable_name[i].trim() + ".update_flag" + ",";
			pricolumnstring = pricolumnstring
					+ splittable_name[i].trim() + ".locked_by" + ",";
		}

		pricolumnstring = pricolumnstring.substring(0, pricolumnstring
				.length() - 1);


		queryString = queryString.substring(0, upperCaseQuery
				.indexOf("FROM"))
				+ ","
				+ pricolumnstring
				+ " "
				+ queryString.substring(upperCaseQuery.indexOf("FROM"),
						queryString.length());
		
		//System.out.println("queryString======>" + queryString);
		}
		String sqlPagination = queryString + " limit " +iPageNo + "," + iShowRows
				+ "";
		System.out.println("sql query to get result set======>" + sqlPagination);
		//String sqlPagination = request.getAttribute("queryString")+"";
try{
		psPagination = con.prepareStatement(sqlPagination);
		rsPagination = psPagination.executeQuery();

		//// this will count total number of rows
		//String sqlRowCnt="SELECT FOUND_ROWS() as cnt";
		String sqlRowCnt = session.getAttribute("queryString") + "";
			
		if(!aggAvailable){
		String lockedFlagCols = "";
		for (int i = 0; i < splittable_name.length; i++) {
			lockedFlagCols = lockedFlagCols
					+ splittable_name[i].trim() + ".update_flag" + ",";
			lockedFlagCols = lockedFlagCols
					+ splittable_name[i].trim() + ".Locked_By" + ",";
		}
		sqlRowCnt = sqlRowCnt.substring(0, sqlRowCnt.toUpperCase()
				.indexOf("FROM"))
				+ ","
				+ lockedFlagCols.substring(0, lockedFlagCols.lastIndexOf(","))
				+ " "
				+ sqlRowCnt.substring(sqlRowCnt.toUpperCase().indexOf("FROM"),
						sqlRowCnt.length());
		}
		System.out.println("sql query for row count======>" + sqlRowCnt);
		psRowCnt = con.prepareStatement(sqlRowCnt);
		rsRowCnt = psRowCnt.executeQuery();
		
		//ResultSet resultSet = rsRowCnt;
		request.getSession().setAttribute("ResultSet",convertResultSetToArrayList(rsRowCnt));
		rsRowCnt.last();
		iTotalRows = rsRowCnt.getRow();
		/*  if(rsRowCnt.next())
		   {
		      iTotalRows=rsRowCnt.getInt("number");
		      System.out.println("iTotalRows="+iTotalRows);
		   }*/
}
catch (Exception ex)
{
	System.out.println("Exception while getting data from database-----"+ex.getMessage());
	msg=ex.getMessage();
	ex.printStackTrace();
}
%>

<%@page import="java.util.Map.Entry"%><html>
<head>
	<title>DPull - Results</title>
	<link rel='STYLESHEET' type='text/css' href='<%=path%>common/style.css'>
	<link rel="STYLESHEET" type="text/css" href="<%=path%>codebase/dhtmlxtree.css">

<script>


<%
String path1 = request.getScheme() + "://"+ request.getServerName() + ":"+ request.getServerPort() + request.getContextPath()+ "/";
%>

function validateRecordCeck(checkboxname){

var allElements = document.getElementsByName(checkboxname);
var bit = 0;
for (var i=0; i < allElements.length; i++) {
    if(allElements[i].disabled==false && allElements[i].checked==true){
        bit=1;   		
	}	
}
if(bit==0) {
	alert('Please select atleast one row');
	return false;
	}
else
	return true;
	
}

function generateLockingQuery(checkboxname,operation){	

var finalUpdateQuery="";
var finalUpdateCHKUCHK="";
var update_flag=0;
var locked_by='';
if(operation=="lock")
{
	update_flag=1;
	locked_by= '<%=session.getAttribute("userid")%>';
}
var allElements = document.getElementsByName(checkboxname);
for (var i=0; i < allElements.length; i++) {
    var updateQueryCHK="";
    var updateQueryUCHK="";

    if(!allElements[i].disabled){
    if(allElements[i].checked==true){  
		var arrTables = allElements[i].value.split('-TABLE-');
		//forming update query for one checkbox 
		for(var j=0;j<arrTables.length;j++){			
			var arrTableName=arrTables[j].split('.');
			var arrWhereClauses = arrTables[j].split(',');
			var tableName=arrTableName[0];
			var whereClause = "";
			//for forming where clause in update query
			for(var k=0;k<arrWhereClauses.length;k++){
					if(whereClause!="")
						whereClause = whereClause + " AND "+arrWhereClauses[k];
					else
						whereClause = arrWhereClauses[k];		
			}			
			if(updateQueryCHK!="")
			{
				updateQueryCHK = updateQueryCHK+";"+" UPDATE "+tableName+" SET UPDATE_FLAG = '"+update_flag+"', LOCKED_BY = '"+ locked_by +"' WHERE "+whereClause;
			}
			else
			{
				updateQueryCHK = "UPDATE "+tableName+" SET UPDATE_FLAG = '"+update_flag+"', LOCKED_BY = '"+ locked_by +"' WHERE "+whereClause;
			}			
		}	
	}	

    if(updateQueryCHK!="" && finalUpdateQuery!="")
    	finalUpdateQuery=finalUpdateQuery+";"+updateQueryCHK; 
    else   
    	finalUpdateQuery=finalUpdateQuery+updateQueryCHK; 
}  
}
document.getElementById('queryField').value=finalUpdateQuery;
var toSubmit =validateRecordCeck(checkboxname);
	if(toSubmit)
	{
		document.getElementById("hiddenInputId").value ='';
		document.displayForm.action='<%=path%>lockRecods.do';
		document.forms["displayForm"].submit(); 
	}	
}


function generateReport()
{
	document.displayForm.method='post';
	document.displayForm.action='<%=path%>ReportGeneration';
	document.forms["displayForm"].submit(); 

}

function closeWindow()
{
	window.close();
}

function changeScreenSize(w,h)
{       
	window.resizeTo( w,h );   
	window.focus();
}

function mailReport()
{
	//alert("mailReport");
	//document.displayForm.method='get';
	document.forms[0].action="<%=path%>jsp/mailAttachment.jsp";
	//alert(document.forms[0].action);
	document.forms[0].submit(); 
	//window.event.valueOf().toString()

}



</script>
</head>
<html:form styleId="displayForm"  action="/lockRecods.do">
<body onload="changeScreenSize(920,620)">
<table cellspacing="0" cellpadding="0" width="100%" border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
	<tr valign="middle">
		<!-- COMPONENT ICON -->
		<td width="40" align="center"><img src="<%=path %>common/dhtmlxtree_icon.gif" border="0"></td>
		<!-- COMPONENT NAME -->
		<td width="205" align="left"><b>DPull</b></td>
		<!-- SAMPLE TITLE -->
		<td>&nbsp;</td>
		<!-- CLOSE BUTTON -->
		<td width="250">&nbsp;</td>
		<td align="right" style="padding-right: 25px;"><a href="javascript: void(0);" class="logout" onclick="closeWindow()"><b>Close</b></a></td>
	</tr>
</table>


<table style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" width="100%" height="620">
	<tr>
		<td align="center" valign="top">
		<br><br>
		<label style="font-weight: bold;">Query:</label>
		<%=session.getAttribute("queryString").toString()%>
		<br><br>
	<INPUT type="button" value="Lock Record" onclick="return generateLockingQuery('chkbox','lock')" />
	<INPUT type="button" value="Unlock Record" onclick="return generateLockingQuery('chkbox','unlock')" />
	<INPUT type="button" value="Save Test Data" onclick="generateReport();" />
	<INPUT type="button" value="Mail Report" onclick="mailReport();" />
		
			</br></br>		<%
						if(msg !=null && !msg.equalsIgnoreCase("") ){
						printMsg="Error Occured :  "+msg;
						}
					%>
					<font color="red" style="font-weight: bold" id="errorId"> <%=printMsg%></font>	

<input type="hidden" name="iPageNo" value="<%=iPageNo%>">
<input type="hidden" name="cPageNo" value="<%=cPageNo%>">
<input type="hidden" name="iShowRows" value="<%=iShowRows%>">
<html:hidden name="LockRecordsForm"  property="updateQuery"  styleId="queryField" />
<table id="resultTblId"  width="95%" border="1" cellpadding="1" cellspacing="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0'); background-color: #FFFFFF">
<tr>
<%
	ResultSetMetaData rsMetaData = rsPagination!=null? rsPagination.getMetaData():null;
			int numberOfColumns = rsMetaData!=null? rsMetaData.getColumnCount(): 0;
			int w = 0;
			// get the column names; column indexes start from 1
			for (int i = 1; i < numberOfColumns + 1; i++) {
				String columnName = rsMetaData.getColumnName(i);
				// Get the name of the column's table name

				String tableName = rsMetaData.getTableName(i);
				if (pricolumnset.contains(tableName + "." + columnName) && columnexist.indexOf(tableName + "." + columnName)== -1 ) {
					w++;
				} else {
					w = 0;
				}
				if (w == 0) {
					if (!columnName.equals("update_flag") && !columnName.equals("locked_by")) {
						
%>
    <td style="font-size:12px;background:#1F497D;font-size:14px;color:#FFFFFF;padding:5px;"><b><%=columnName%></b></td>
    <%
    	}
    				}
    			}
    %>
    
    <%if(!aggAvailable){ %>  
<td style="font-size:12px;background:#1F497D;font-size:14px;color:#FFFFFF;padding:5px;" width="30"><b>Lock</b></td>
<td style="font-size:12px;background:#1F497D;font-size:14px;color:#FFFFFF;padding:5px;" width="30"><b>Locked_By</b></td>
<%} %>
</tr>
<%
try{
	if(rsPagination!=null){
	while (rsPagination.next()) {
%>
    <tr >
	<%
		ResultSetMetaData rsMetaData1 = rsPagination
							.getMetaData();
					int numberOfColumns1 = rsMetaData1.getColumnCount();
					String lockstring = "";
					String oldtable = "";
					String newtable = "";
					int q = 0;
					int checkedflag = 0;
					int checkedflagInfo = 0;
					int lockflagInfo = 0;
					String lockedBy = "";
					for (int i = 0; i < splittable_name.length; i++) {
						
						if (!aggAvailable && rsPagination.getObject(splittable_name[i]
								+ ".update_flag") != null
								&& rsPagination.getObject(
										splittable_name[i] + ".update_flag")
										.toString().equals("1")) 
						{
							checkedflagInfo = 1;
							//System.out.println(splittable_name[i]+ ".update_flag found true");
							if (rsPagination.getObject(splittable_name[i]+".locked_by") != null)
									
							{
								lockedBy = lockedBy + rsPagination.getObject(splittable_name[i]+".locked_by") + ",";
							}
							
						}
					}
					//remove last comma from lockedBy
					lockedBy =lockedBy.length()>0? lockedBy.substring(0,lockedBy.lastIndexOf(",")):"";
					for (int j =0; j<lockedBy.split(",").length;j++)
					{
						if(lockedBy.split(",")[j].equals(userid))
						{
							lockflagInfo = 0;
						}
						else
						{
							lockflagInfo = 1;
							break;
						}
					}
					Map<String, ArrayList<String>> lockingMap = new HashMap<String, ArrayList<String>>();
					for (int l = 1; l < numberOfColumns1+1; l++) {
						String columnName1 = rsMetaData.getColumnName(l);
						String tablename = rsMetaData1.getTableName(l);
						oldtable = newtable;
						if (pricolumnset.contains(tablename + "."
								+ columnName1)) {
							Iterator itr = pricolumnset.iterator();
							while(itr.hasNext())
							{
								String tblCol = itr.next().toString();
								String[] tblAndCol = tblCol.split("\\.");
								if(tablename.equals(tblAndCol[0]) && columnName1.equals(tblAndCol[1]) )
								{
									if(lockingMap.containsKey(tblAndCol[0]))
									{
										ArrayList<String> existingTblCols = lockingMap.get(tblAndCol[0]);
										existingTblCols.add(columnName1+"='"+rsPagination.getObject(columnName1).toString()+"'");
										lockingMap.put(tblAndCol[0],existingTblCols);
									}
									else 
									{
										ArrayList<String> nonEistingTblCol =	new ArrayList<String>();
										nonEistingTblCol.add(columnName1+"='"+rsPagination.getObject(columnName1).toString()+"'");
										lockingMap.put(tblAndCol[0],nonEistingTblCol);
									}
								}
							}
							if(columnexist.indexOf(tablename + "." + columnName1)==-1)
							{
								q++;
							}
							else
							{
								q = 0;
							}
						} else if (columnName1.equals("update_flag")
								|| columnName1.equals("locked_by")) {

							q++;
						} else {

							q = 0;
						}
						
	%>      
      <%
            	if (q == 0) {
            		if (!aggAvailable && rsPagination.getObject(tablename
							+ ".update_flag") != null
							&& rsPagination.getObject(
									tablename + ".update_flag")
									.toString().equals("1")) {
						checkedflag = 1;
						
            %>
<!--    	<td style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#BDEDFF', startColorstr='#FFFFFF', gradientType='0');border:solid;border-width:1 px;border-color:#AFC7C7;background: #D1DCEC;font-size:12px;">   -->
					 <%
                  	if (lockflagInfo >= 1) {
               	   %>
           			 <td style="background:#DFF3FA;font-size:12px;color:#1F497D; padding-left: 3px">&nbsp;
    						<%=(rsPagination.getObject(columnName1) != null) ? rsPagination.getObject(columnName1): ""%>
					</td> 
					<%
     				} else {
    				 %>
      				<td style="background:#BDEDFF;font-size:12px;color:#1F497D; padding-left: 3px">&nbsp;
    						<%=(rsPagination.getObject(columnName1) != null) ? rsPagination.getObject(columnName1): ""%>
					</td>
					<% } %> 
      <%
        	} else {
        %>
    	 <td class="whiteFont" style="background:#FFFFFF;font-size:12px; padding-left: 3px">&nbsp;<%=(rsPagination
															.getObject(columnName1) != null) ? rsPagination
													.getObject(columnName1)
													: ""%></td> 
      <%
       	}
       %>
      
      <%
            	}
            %>
      <%
     
      	} //end of for loop
      	
					Iterator itrLockKeys =  lockingMap.keySet().iterator();
      				while(itrLockKeys.hasNext())
      				{
      					lockstring = lockstring + " -TABLE- ";
      					String tblName = itrLockKeys.next().toString();
      					ArrayList<String> colDetails = lockingMap.get(tblName);
      					for(int y =0; y<colDetails.size();y++)
      					{
      						lockstring = lockstring
							+ tblName
							+ "."
							+ colDetails.get(y)
							+ ",";
      					}
      					//remove last comma
      					//lockedBy.length()>0? lockedBy.substring(0,lockedBy.lastIndexOf(",")):"";
      					lockstring = lockstring.length()>0?lockstring.substring(0,lockstring.lastIndexOf(",")):lockstring;
      				}
      				// remove first -Table-
      				lockstring = lockstring.length()>0?lockstring.substring(lockstring.indexOf(" -TABLE- ")+9,lockstring.length()).trim():lockstring;
      %>
      
      <%if(!aggAvailable){
            	if (checkedflagInfo >= 1) {
            %>
      
      
      <% 
                  	if (lockflagInfo >= 1) {
                  %>
     	<td align="center" style="background:#DFF3FA;font-size:12px;color:#1F497D; padding-left: 2px">&nbsp;<INPUT type="checkbox" name="chkbox" disabled="disabled" checked="checked" value="<%=lockstring.substring(0, lockstring
												.length() )%>"/></td>
		<td class="whiteFont" style="background:#DFF3FA;font-size:12px; padding-center: 3px">&nbsp;
   			  <%=lockedBy%> 
   		</td>
     <%
     	} else {
     %>
     	<td align="center" style="background:#BDEDFF;font-size:12px;color:#1F497D; padding-left: 2px">&nbsp;<INPUT type="checkbox" name="chkbox" checked="checked" value="<%=lockstring.substring(0, lockstring
												.length() )%>"/></td>
		<td class="whiteFont" style="background:#BDEDFF;font-size:12px; padding-center: 3px">&nbsp;
   			  <%=lockedBy %> 
   		</td>
     <%
     	}
     %>       
      
     
     <%
                       	} else {
                       %>
     <td align="center" style="background:#FFFFFF;">&nbsp;<INPUT type="checkbox" name="chkbox" value="<%=lockstring.substring(0, lockstring
											.length() )%>"/></td>
	 <td class="whiteFont" style="background:#FFFFFF;font-size:12px; padding-center: 3px">&nbsp;
   			  <%=lockedBy%> 
     </td>
     <%
     	} }
     %> 
        
    </tr>
    <%
    	}// end of while loop
	}
}
catch(Exception e)
{
	System.out.println("inside JSP catch 4444");
	e.printStackTrace();
	}
    %>
<%
	//// calculate next record start record  and end record 
			try {
				if (iTotalRows < (iPageNo + iShowRows)) {
					iEndResultNo = iTotalRows;
				} else {
					iEndResultNo = (iPageNo + iShowRows);
				}

				iStartResultNo = (iPageNo + 1);
				iTotalPages = ((int) (Math.ceil((double) iTotalRows
						/ iShowRows)));

			} catch (Exception e) {
				System.out.println("inside JSP catch");
				e.printStackTrace();
			}
%>
<tr>
<td colspan="3">
<div style="font-size:12px;" class="whiteFont"  id="rowsSummaryDiv">
<%
	//// index of pages 

			int i = 0;
			int cPage = 0;
			if (iTotalRows != 0) {

				cPage = ((int) (Math.ceil((double) iEndResultNo
						/ (iTotalSearchRecords * iShowRows))));

				int prePageNo = (cPage * iTotalSearchRecords)
						- ((iTotalSearchRecords - 1) + iTotalSearchRecords);

				if ((cPage * iTotalSearchRecords)
						- (iTotalSearchRecords) > 0) {
%>
          <a href="<%=path%>jsp/DisplayResultSet.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>"> << Previous</a>
         <%
         	}

         				for (i = ((cPage * iTotalSearchRecords) - (iTotalSearchRecords - 1)); i <= (cPage * iTotalSearchRecords); i++) {
         					if (i == ((iPageNo / iShowRows) + 1)) {
         %>
           <a href="<%=path%>jsp/DisplayResultSet.jsp?iPageNo=<%=i%>" style="cursor:pointer;color: red"><b><%=i%></b></a>
          <%
          	} else if (i <= iTotalPages) {
          %>
           <a href="<%=path%>jsp/DisplayResultSet.jsp?iPageNo=<%=i%>"><b><%=i%></b></a>
          <%
          	}
          				}
          				if (iTotalPages > iTotalSearchRecords
          						&& i < iTotalPages) {
          %>
         <a href="<%=path%>jsp/DisplayResultSet.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>"> >> Next</a> 
         <%
          	}
          			}
          %>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; Rows <%=iStartResultNo%> - <%=iEndResultNo%>   of  <%=iTotalRows%>
</div>
</td>
</tr>
</table></br>
<input type="hidden" id="hiddenInputId" name="hiddenInputName" />
<INPUT type="button" value="Lock Record" onclick="return generateLockingQuery('chkbox','lock')" />
<INPUT type="button" value="Unlock Record" onclick="return generateLockingQuery('chkbox','unlock')" />
<INPUT type="button" value="Save Test Data" onclick="generateReport();" />
<INPUT type="button" value="Mail Report" onclick="mailReport();" />



		</td>
	</tr>
</table>
 
</body>
</html:form>
<%
	try {
			if (psPagination != null) {
				psPagination.close();
			}
			if (rsPagination != null) {
				rsPagination.close();
			}

			if (psRowCnt != null) {
				psRowCnt.close();
			}
			if (rsRowCnt != null) {
				rsRowCnt.close();
			}

			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			System.out.println("exception caught while closing connections");
			e.printStackTrace();
		}
%>
<%
	} catch (Exception e) {
		msg=e.getMessage();
		System.out.println("Exception caught");
		e.printStackTrace();
	}
%>
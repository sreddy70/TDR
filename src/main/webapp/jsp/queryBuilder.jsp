<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ page import="java.util.*"%>
<%@ page import="com.csc.dpull.bean.*"%>


<%@page import="com.csc.dpull.util.Constants"%><head>
	<title>DPull</title>
	<link rel='STYLESHEET' type='text/css' href='./common/style.css'>
	<link rel="STYLESHEET" type="text/css" href="./codebase/dhtmlxtree.css">
	<script src='dwr/interface/DatabaseUtility.js'></script>
  	<script src='dwr/engine.js'></script>
  	<script src='dwr/util.js'></script>
	<script src="./codebase/dhtmlxcommon.js"></script>
	<script src="./codebase/dhtmlxtree.js"></script>
	<script type="text/javascript" src="common/jquery-1.4.2.js"></script>
</head>

<% 
String tablelist = (String)request.getAttribute("tablelist");
TableColumnListInfo tclist[] = (TableColumnListInfo[])request.getAttribute("tablecolumnlist");

String path = request.getScheme() + "://"
+ request.getServerName() + ":"
+ request.getServerPort() + request.getContextPath()
+ "/";
%>

<script language="javascript">
	var children= Array(); 
	window.history.forward(1);
/*
	function showDesc(){
	window.open("jsp/showColDescription.jsp","","left=100,top=100,screenX=100,screenY=100,width=400,height=300,scrollbars=1,resizable=no");
	}
*/
	
	tab1_flag = 0;
	tab2_flag = 0;
	tab3_flag = 0;
	tab1_title = "";
	tab2_title = "";
	tab3_title = "";
	rel12_text = "";
	rel13_text = "";
	rel23_text = "";
	db1_title = "";
	db2_title = "";
	db3_title = "";

	var relations = new Array();

	function isWhitespace(charToCheck) {
		var whitespaceChars = " \t\n\r\f";
		return (whitespaceChars.indexOf(charToCheck) != -1);
	}
	function ltrim(str) { 
		for(var k = 0; k < str.length && isWhitespace(str.charAt(k)); k++);
		return str.substring(k, str.length);
	}
	function rtrim(str) {
		for(var j=str.length-1; j>=0 && isWhitespace(str.charAt(j)) ; j--) ;
		return str.substring(0,j+1);
	}
	function trim(str) {
		return ltrim(rtrim(str));
	}

	function generateRelations()
	{
		
		document.getElementById("rel12").style.visibility = "hidden";
		document.getElementById("rel13").style.visibility = "hidden";
		document.getElementById("rel23").style.visibility = "hidden";
		rel12_text = "";
		rel13_text = "";
		rel23_text = "";
		
		for(x=0; x<relations.length; x++)
		{
			for(i=1; i<=3; i++)
			{
				for(j=1+1; j<=3; j++)
				{
					if(i!=j && j>i)
						if(  relations[x][0] == eval("tab"+i+"_title") && relations[x][2] == eval("tab"+j+"_title")
						  || relations[x][0] == eval("tab"+j+"_title") && relations[x][2] == eval("tab"+i+"_title")
								)
						{
							document.getElementById("rel"+i+j).style.visibility = "visible";
							old_rel = eval("rel" + i + j + "_text");
							eval("rel" + i + j + "_text="+ "'"+ old_rel+ relations[x][0] + "." + relations[x][1] + " = " + relations[x][2] + "." + relations[x][3] + " AND '");
						}
				}
			}
		}
		
		//remove 'AND' from the end of the relationship
		rel12_text = rel12_text.substring(0,rel12_text.lastIndexOf("AND"));
		rel13_text = rel13_text.substring(0,rel13_text.lastIndexOf("AND"));
		rel23_text = rel23_text.substring(0,rel23_text.lastIndexOf("AND"));
		if(rel12_text!='' || rel13_text!='' || rel23_text!='')
		{
			document.getElementById("infoMessage").innerHTML = 'Please select columns from selected tables' +'<br>'+'To know Table Relations, move cursor on joining lines';
		}
		else
		{
			if(tab1_title!=''||tab2_title!=''||tab3_title!='')
			{
				document.getElementById("infoMessage").innerHTML = 'Please select columns from selected tables';
			}
			else
			{
				document.getElementById("infoMessage").innerHTML = 'Please select table(s) from Test Data Repository in left panel';
			}
		}
		
	}

	var v;
	
	function showTooltip(message)
	{
		var IE = document.all?true:false;
		if (!IE) document.captureEvents(Event.MOUSEMOVE)
		//document.onmousemove = getMouseXY;
		var tempX = 0;
		var tempY = 0;
		if (IE) { // grab the x-y pos.s if browser is IE
		tempX = event.clientX + document.body.scrollLeft;
		tempY = event.clientY + document.body.scrollTop;
		}
		else {  // grab the x-y pos.s if browser is NS
		tempX = e.pageX;
		tempY = e.pageY;
		}
	var tool = document.getElementById('tooltipDiv');
	tool.innerHTML = message; 
	tool.style.top = tempY-25;
	tool.style.left = tempX;
	tool.style.display = "block";
	}
	
	function hideTooltip()
	{
		var tool = document.getElementById('tooltipDiv');
		tool.style.display = "none";
	}
	
</script>

<div style="display:none;position:absolute;" id="tooltipDiv" class="tooltip"></div>


<script type="text/javascript">
$(document).ready(function(){
	

	$('#refreshImgId').mouseover(function() {
		  $('#refreshImgId').animate({
		    opacity: 0.60
		    });
		});
	$('#refreshImgId').mouseout(function() {
		  $('#refreshImgId').animate({
		    opacity: 1.00
		    });
		});
	
	});

	var arrTables = new Array();

	function addRow(tableID,colName)
	{
		//alert("clicked checkbox");
		var table = document.getElementById(tableID);
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		var colCount = table.rows[0].cells.length;
	
		for(var i=0; i<colCount-1; i++) { // colCount-1 as we need to exclude column showing Add where clause
	
			var newcell	= row.insertCell(i);
		
			newcell.innerHTML = table.rows[1].cells[i].innerHTML;
			newcell.style.width="63px";
			newcell.align = "center";

			switch(newcell.childNodes[0].type) {
				case "text":					
						if(i==1){	
							newcell.childNodes[0].value = colName;
							newcell.childNodes[0].id=colName;
							newcell.childNodes[0].disabled=true;
							newcell.align = "center";
							
						}
						else
							newcell.childNodes[0].value = "";
							newcell.align = "center";
						break;
				case "checkbox":
						newcell.childNodes[0].checked = false;
						newcell.align = "center";
						break;
				case "select-one":
						newcell.childNodes[0].selectedIndex = 0;
						newcell.align = "center";
						break;
			}			
		}		
	}

function deleteRow(tableID,colName) {
	try {
	var table = document.getElementById(tableID);
	var rowCount = table.rows.length;

	for(var i=0; i<rowCount; i++) {
		var row = table.rows[i];
		//alert(row.cells[1].childNodes[0].id);
		var coltxt = row.cells[1].childNodes[0].id;		
		if(null != coltxt && 'undefined'!=coltxt && colName == coltxt) {
			if(rowCount <= 1) {
				alert("Cannot delete all the rows.");
				break;
			}
			table.deleteRow(i);
			rowCount--;
			i--;
		}

	}
	}catch(e) {
		alert(e);
	}
}

function deleteAllRows()
{
	var table = document.getElementById('dataTable');
	var rowCount = table.rows.length;
	//when there is no column checkbox, rowcount is equal to 2
	for(var i=0; i<(Number(rowCount)-2); i++) {
		table.deleteRow(2);	
	}
}

			function adddeleterow(object,colName){
			document.getElementById('queryta').value='';				
			var table = document.getElementById('dataTable');
			var rowCount = table.rows.length;
			var flag = false;
			//var colCount = table.rows[1].cells[1].nextSibling.id;
			var temptableName = colName.split('.');
			var tableName = temptableName[0];
			for(var i=0;i<arrTables.length;i++){
				if(arrTables[i]==tableName)
					flag=true;
			}
			if(!flag)
				arrTables[arrTables.length]=tableName;
			
				if(object.checked)
					addRow('dataTable',colName);	
				else	
					deleteRow('dataTable',colName);
				
			}
			

function generateQueryNew(){
	
	var selectClause = "";
	var aggFunction = "";
	var fromClause = "";
	var whereClause = "";
	var groupBy = "";
	var orderBy = "";
	var query1="select ";
	var query="";
	var joinCritetia = document.getElementById('jointxtarea').value;
	var table = document.getElementById('dataTable');
	var rowCount = table.rows.length;
	var colCount = table.rows[1].cells.length;
	var tableName="";
	var count=0;	

/*
    Commented old fromClause Generation 
	//From clause of query string formation.
	for(var i=0;i<arrTables.length;i++){		
		fromClause = fromClause+" "+arrTables[i]+",";
	}
*/

// new fromclause generation with only visible table
	for(var i=1;i<=3;i++)
	{
		table_title = eval("tab" + i + "_title")
		if(table_title != "")
			fromClause = fromClause + table_title + ","
	}	
	
	if(rowCount<3){
		alert("Please select atleast one column");
		return;
	}
	
	document.getElementById('fromtable').value = fromClause.substring(0,fromClause.length-1);
	document.getElementById('fromDatabase').value = db1_title!=''?db1_title:db2_title!=''?db2_title:db3_title!=''?db3_title:'';
	fromClause = " FROM "+fromClause.substring(0,fromClause.length-1);

	//Iterate the complete table.
	for(var i=2;i<rowCount;i++){
		var cols = table.rows[i];	

		//Aggregate function clause of query string formation.	
		if((cols.cells[3].childNodes[0].checked ==true) || (cols.cells[4].childNodes[0].checked ==true) ||(cols.cells[5].childNodes[0].checked ==true) ||(cols.cells[6].childNodes[0].checked ==true) ||(cols.cells[7].childNodes[0].checked ==true)){	
			if(cols.cells[3].childNodes[0].checked ==true)
			aggFunction = aggFunction+ ", SUM("+cols.cells[1].childNodes[0].value+")";								
			if(cols.cells[4].childNodes[0].checked ==true)	
				aggFunction =aggFunction+ ", AVG("+cols.cells[1].childNodes[0].value+")";						
			if(cols.cells[5].childNodes[0].checked ==true)	
				aggFunction =aggFunction+ ", MAX("+cols.cells[1].childNodes[0].value+")";
			if(cols.cells[6].childNodes[0].checked ==true)	
				aggFunction =aggFunction+ ", MIN("+cols.cells[1].childNodes[0].value+")";
			if(cols.cells[7].childNodes[0].checked ==true)	
				aggFunction =aggFunction+ ", COUNT("+cols.cells[1].childNodes[0].value+")";
			//alert("agg-"+aggFunction);
		}
		else
		{
			if(cols.cells[2].childNodes[0].value !="")//value of alias column
				selectClause = selectClause +" "+cols.cells[1].childNodes[0].value+" AS '"+cols.cells[2].childNodes[0].value+"',";
			else
				selectClause = selectClause +" "+cols.cells[1].childNodes[0].value+",";

			count++;
			//alert(selectClause);
		}
				
		//Where clause of query string formation.	
			// Here where clause is coming from where clause window and set in a hidden field
				whereClause =  document.getElementById('hiddenWhereClause').value
				
		//Group By clause of query string formation.
			if(cols.cells[0].childNodes[0].checked ==true)			
				groupBy = groupBy +" "+cols.cells[1].childNodes[0].value+",";
			
			
		//Order By clause of query string formation.
				if(cols.cells[8].childNodes[0].value !="")
					orderBy = orderBy+cols.cells[1].childNodes[0].value+" "+cols.cells[8].childNodes[0].value+",";			
			}	
	

			//Where clause for table relations
			if(rel12_text != "" || rel13_text != "" || rel23_text != "")
			{
				if(whereClause != "")
					whereClause = whereClause + " AND";
				if (rel12_text != ""/* && fromClause.indexOf(tab1_title)!=-1 && fromClause.indexOf(tab2_title)!=-1*/)
					whereClause = whereClause + " " + rel12_text + " AND";
				if (rel13_text != ""/* && fromClause.indexOf(tab1_title)!=-1 && fromClause.indexOf(tab3_title)!=-1*/)
					whereClause = whereClause + " " + rel13_text + " AND";
				if (rel23_text != ""/* && fromClause.indexOf(tab2_title)!=-1 && fromClause.indexOf(tab3_title)!=-1*/)
					whereClause = whereClause + " " + rel23_text + " AND";
				
				whereClause = whereClause.substring(0, whereClause.length-4);
			}

			if(groupBy!="")
				groupBy = " GROUP BY "+groupBy.substring(0,groupBy.length-1);
			
			
				
			// remove first comma from aggFunction in case no individual column got selected
					//alert(count);
					if (count==0){
					aggFunction = aggFunction.substring((aggFunction.indexOf(',')+1), aggFunction.length);
					}
			
			if(whereClause=="" && orderBy=="")
				query = "SELECT "+selectClause.substring(0,selectClause.length-1)+aggFunction+fromClause+groupBy;
			else if(whereClause=="" && orderBy!="")
				query = "SELECT "+selectClause.substring(0,selectClause.length-1)+aggFunction+fromClause+groupBy+" ORDER BY "+orderBy.substring(0,orderBy.length-1);
			else if(whereClause!="" && orderBy=="")
				query = "SELECT "+selectClause.substring(0,selectClause.length-1)+aggFunction+fromClause+" WHERE "+whereClause+groupBy;
			else
			query = "SELECT "+selectClause.substring(0,selectClause.length-1)+aggFunction+fromClause+" WHERE "+whereClause+groupBy+" ORDER BY "+orderBy.substring(0,orderBy.length-1);

			document.getElementById('queryta').value = query;

			}


			
function validateQueryNull(object){
	if(document.getElementById(object).value==''){
		alert('Please Enter Query');
		return false;
	}	
	if(document.getElementById(object).value.toUpperCase().indexOf(' FROM ')==-1)
	{
		alert('No From clause found in the query');
		return false;
	}
}

function refresh(){
	var answer= confirm("Refresh will clear the query builder page. Do you really want to continue?");
	if(answer){
		//window.location = "<path%>queryBuilderPage.do?actionType=queryBuilderPage";
		document.getElementById('queryta').value='';
		document.getElementById('hiddenWhereClause').value = "";
		for(var i=1; i<4;i++)
		{
			tableVal = eval('tab'+i+'_title');
			dbVal = eval('db'+i+'_title');
			if(tableVal!='' && dbVal!='')
			{
				closeBox(i, tableVal, dbVal);
			}
		}
	}
	else{
		//alert("no refresh");
	}
}

var colList= new Array();
var colListWithDatatypes= new Array();
var colListAsString="";
var colListWithDatatype="";

function openWindow(){	
	colList= new Array();
	colListWithDatatypes= new Array();
	colListAsString="";
	colListWithDatatype="";
	  var counter=0;
	  <%
		for(int i =0; i<tclist.length;i++){
	  %>		
		var tableName = '<%= tclist[i].getTABLE_NAME()%>';
		
		if(tableName == tab1_title || tableName == tab2_title || tableName == tab3_title )
		{		
		var colNames = '<%= tclist[i].getCOLUMN_NAME()%>';
		var	colDatatype='<%= tclist[i].getDATA_TYPE()%>';
		
	//	colList[counter]=tableName+"."+colNames;
	//	colListWithDatatypes[counter]=tableName+"."+colNames+"("+colDatatype+")";			
		colListAsString+=tableName+"."+colNames;
		colListAsString+=",";
		colListWithDatatype+=tableName+"."+colNames+"("+colDatatype+")";		
		colListWithDatatype+=",";
		counter=counter+1;
			
		}<%}%>
		//alert("without="+colListAsString);			
		//alert("with="+colListWithDatatype);
		 
	  for(i=0;i<counter;i++)
	  {
		//alert(colList[i]);
	  }
	 var url="./jsp/whereClause.jsp?columnList="+colList+"&columnListWithDatatypes="+colListWithDatatypes;
	 DevScorePopUpWindow= window.open(url,"","left=5,top=100,screenX=100,screenY=100,width=1000,height=410,scrollbars=1,resizable=no");
	 children[children.length] = DevScorePopUpWindow;
	}

function GetValueFromChild(myVal)
{
    myVal = myVal.substring((myVal.indexOf('where',0)+5), myVal.length);
    document.getElementById('hiddenWhereClause').value = myVal;
    alert('Where clause successfully created. To form query click Generate Query button shown at the bottom.');
}


function removeWhereClaue(){
	//alert(document.getElementById("queryta").value);
	document.getElementById("queryta").value="";
	document.getElementById('hiddenWhereClause').value = "";
	alert("Where clause has been removed. Please click 'Generate Query' button to create query");
}

function unloadMthd(){
	 //if (DevScorePopUpWindow && DevScorePopUpWindow.open && !DevScorePopUpWindow.closed) 
	 //{
		// win.close();
		
	 //}
	for(var n=0;n<children.length;n++)
	{
		//alert(children[n]);
		children[n].close();
	}
}

</script>

<html:form  styleId="queryForm"  action="/queryBuilder.do" target="resultPage">
<body onunload="unloadMthd()">
<html:hidden styleId="fromtable" name="QueryBuilderForm" property="fromtable" ></html:hidden>
<html:hidden styleId="fromDatabase" name="QueryBuilderForm" property="fromDatabase" ></html:hidden>
<input type="hidden" id="hiddenWhereClause" value="">
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
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#FFFFFF', startColorstr='#DDDDDD', gradientType='0');" class="tab_selected"><b>Query Builder</b></td>
					<td width="2"></td>
					<td width="120" align="center" style="padding:0 0 0 0; filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#108ae6', startColorstr='#108ae6', gradientType='0');"><html:link styleClass="tab_unselected" action="/showColDesc.do?actionType=showColDescription">Column Details</html:link></td>
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
	 
	<table style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');" >
		<tr>
			<td>
				<div id="treeboxbox_tree" style="width:225; height:700;background-color:#FFFFFF;border :1px solid Silver;; overflow:auto;"/>
			</td>
			<td rowspan="3" style="padding-left:12;" valign="top" class="whiteFont">
				<div id="logarea" style="height:325px;width:868px;background-color:#FFFFFF;border :1px solid Silver;; overflow:auto;">
					<center>
					<table cellspacing=0 cellpadding=0 width="100%">
						<tr>
							<td colspan="2" align="right"> <div id="infoMessage" class="infoMessage">Please select table(s) from Test Data Repository in left panel</div></td>
								<td align="right"><img src="images/refresh.jpg" id="refreshImgId" vspace="3"  hspace="3" style="cursor: pointer" onclick="refresh()" alt="Refresh Page"  ></img></td>
						</tr>
		
						<tr>
							<td  height="110" align="right"><div id="tab1" style="height:100px; width:254px; position:relative; left:0px; top:0px; background-color:#FFFFFF;border :1px solid blue; display:none; padding: 0 0 0 0;"></div></td>
							<td width="254" height="110"><div id="rel12" style="visibility:hidden" onmouseover="showTooltip(rel12_text)" onmouseout="hideTooltip()"><img src="images/12.gif"></div></td>
							<td  height="110"><div id="tab2" style="height:100px; width:254px; position:relative; left:0px; top:0px; background-color:#FFFFFF;border :1px solid blue; display:none; padding: 0 0 0 0;"></div></td>
						</tr>
						<tr>
							<td height="160" rowspan="2" align="right" valign="top"><div id="rel13" style="visibility:hidden;" onmouseover="showTooltip(rel13_text)" onmouseout="hideTooltip()" ><img src="images/13.gif" ></div></td>
							<td height="50">&nbsp;</td>
							<td height="160" rowspan="2" align="left" valign="top"><div id="rel23" style="visibility:hidden" onmouseover="showTooltip(rel23_text)" onmouseout="hideTooltip()"><img src="images/23.gif"></div></td>
						</tr>
						<tr>
							<td width="254" height="110"><div id="tab3" style="height:100px; width:254px; position:relative; left:0px; top:0px; background-color:#FFFFFF;border :1px solid blue; display:none; padding: 0 0 0 0;"></div></td>
						</tr>
					</table>
					</center>
				</div></br>
		<!-- harsh 868-->		
				<div id="logarea" style="height:225px;width:868px;background-color:#FFFFFF;border :1px solid Silver;; overflow:auto;">

			<span style="display:none">
				<b>Join Criteria</b>
				<textarea id="jointxtarea"></textarea></br>
			</span>
				<TABLE id="dataTable" width="100%"  border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
					<tr>
						<th align="center" class="whiteFont">Group By</th>
    					<th align="center" class="whiteFont">Expression</th>
    					<th align="center" class="whiteFont">Alias</th>
    					<th align="center" class="whiteFont">Sum</th>
    					<th align="center" class="whiteFont">Avg</th>
    					<th align="center" class="whiteFont">Max</th>
    					<th align="center" class="whiteFont">Min</th>
    					<th align="center" class="whiteFont">Count</th>	
    					<th align="center" class="whiteFont">Sort Type</th>  
    					<th></th>  					
  					</tr>  					
					<TR style="display: none">
						<TD align="right"><INPUT type="checkbox" name="chk"  /></TD>
						<TD align="center"><INPUT type="text" name="txt" size="30" /></TD>
						<TD align="center"><INPUT type="text" name="txt" size="10" /></TD>	
						<TD align="center"><INPUT type="checkbox" name="sum"   /></TD>
						<TD align="center"><INPUT type="checkbox" name="avg"   /></TD>
						<TD align="center"><INPUT type="checkbox" name="min"   /></TD>
						<TD align="center"><INPUT type="checkbox" name="max"   /></TD>
						<TD align="center"><INPUT type="checkbox" name="count"   /></TD>				
						<TD align="center">
							<SELECT name="Sort">
								<OPTION value="">[None]</OPTION>
								<OPTION value="ASC">Ascending</OPTION>
								<OPTION value="DESC">Descending</OPTION>
							</SELECT>
						</TD>					
					</TR>
				</TABLE>
				
				</div>
				<div align="right" style="padding-right:40px; height:2px;">
				<a href="javascript:openWindow()"><font color="blue">Add Where Clause</font></a> &nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:removeWhereClaue()"><font  color="blue">Remove Where Clause</font> </a>&nbsp;&nbsp;
			<!--
				<a href="javascript:openCriteriaWindow()"><font color="blue">Add Criterias</font></a>  -->
				</div>
				</br>
				
				<div id="logarea" style="height:125px;width:868px;border :1px solid Silver;; overflow:auto;">
				<html:textarea styleId="queryta" name="QueryBuilderForm" property="query" style="height:95px;width:865px; border :none; overflow:auto;"></html:textarea>
				<input type="button" value="Generate Query"  onclick="generateQueryNew();"/>
				<INPUT type="submit" value="Submit" onclick="return validateQueryNull('queryta')" />&nbsp;&nbsp;&nbsp;&nbsp;
				
				</div></br>
			</td>		
			
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	
<!-- <div class='sample_code'><div class="hl-main"><pre>HI</pre></div></div>  -->	
	<script>
	
	function closeBox(boxId, tableStr, dbName)
	{
		document.getElementById('queryta').value='';
		document.getElementById('hiddenWhereClause').value = "";
		document.getElementById(tableStr+"selctAllId").checked = false;
		selectAll(tableStr, dbName);
		theBox = document.getElementById("tab" + boxId);
		theBox.innerHTML = "";
		theBox.style.display = "none";
		eval("tab" + boxId + "_flag=0");
		eval("tab" + boxId + "_title=''");
		eval("db" + boxId + "_title=''");
		if (tab1_flag==0 && tab2_flag==0 && tab3_flag==0 )
		{
			document.getElementById("infoMessage").innerHTML = 'Please select table(s) from Test Data Repository in left panel';
 		}
		generateRelations();
	}
	
	
	function doLog(str1)
	{
		
		var arrColumnsSelected = new Array();
		var table = document.getElementById('dataTable');
		var rowCount = table.rows.length;
//		var log = document.getElementById("logarea");


// code to show-hide table and set appropriate flag - start
		var log = "";
		var selectedPosNum = "0";
		var dbName = "";
		if (str1 != '')
		{
			dbName = str1.split('.')[0];
			str1 = str1.split('.')[1];
			document.getElementById('queryta').value='';
			document.getElementById("infoMessage").innerHTML = 'Please select columns from selected tables';

			if(str1 == tab1_title || str1 == tab2_title || str1 == tab3_title )
			{
				alert("Table already exists on the dashboard.");
				return false;
			}
			if((dbName != db1_title && db1_title!='') 
					|| (dbName != db2_title && db2_title!='') 
						|| (dbName != db3_title && db3_title!='') )
			{
				alert("Please select a table from the single table schema");
				return false;
			}
			if(db1_title=='' && db2_title=='' && db3_title=='')
			{
				DatabaseUtility.fetchTableRelations(dbName, function(resultData) {
					relations = new Array(resultData.length);
					for(var i = 0 ; i<resultData.length; i++){
						var array1 = new Array();
						array1 = resultData[i];
						relations[i] = new Array(4);
						for(var j=0; j<4; j++)
						{
							relations[i][j] = array1[j];
						}
					}
				});
			}
			
			if(tab1_flag==0)
			{
				log = document.getElementById("tab1");
				tab1_flag = 1;
				selectedPosNum = "1";
				tab1_title = str1;
				db1_title = dbName;
			}
			else if(tab2_flag==0)
			{
				log = document.getElementById("tab2");
				tab2_flag = 1;
				selectedPosNum = "2";
				tab2_title = str1;
				db2_title = dbName;
			}
			else if(tab3_flag==0)
			{
				log = document.getElementById("tab3");
				tab3_flag = 1;
				selectedPosNum = "3";
				tab3_title = str1;
				db3_title = dbName;
			}
			else
			{
				return false;
			}
			log.style.display = "block";
			generateRelations();
		}
// code to show-hide table and set appropriate flag - end

		for(var i=2;i<rowCount;i++){
			var cols = table.rows[i];					
			arrColumnsSelected[i-2] = cols.cells[1].childNodes[0].value;
		}
				
		//log.innerHTML = "";

		var str = "";
		selectAllVar = "";
		
		if (str1!='')
		{
			var count = 0;
		<% for(int i =0; i<tclist.length;i++){ %>

			if (count<1 && str1 == '<%= tclist[i].getTABLE_NAME()%>' )
			{ 
				selectAllVar = "<input type=\"checkbox\" name=\"test\" id='"+str1+"selctAllId' style=\"position:relative; left:-3px;\" onClick=\"selectAll('"+str1+"', '"+dbName+"')\"/>";
				count = count +1;
			} 
		<% } %>
		}


		str = "<table width='100%' style=\"background-color:#bad1fc;padding: 0 0 0 0;\"><tr><td width='95%'>"
			+ selectAllVar
			+ "<font color=black><b>"+ str1 +"</b></font>"
			+ "</td><td align='center'>"
			+ "<a href='javascript:closeBox("+selectedPosNum+", \""+str1+"\", \""+dbName+"\")'>X</a>"
			+ "</td></tr></table>";

		str = str + "<div id='TB' value='"+str1+"' style='height:90px; width:252px; background-color:#FFFFFF; overflow:auto;' align=left>";
		
		
				<%for(int i =0; i<tclist.length;i++){ %>
				
					if(str1 == '<%= tclist[i].getTABLE_NAME()%>')
					{
						var checkboxId = str1+".<%= tclist[i].getCOLUMN_NAME()%>";
						
						if(arrColumnsSelected.length==0){
							str = str + "<table cellpadding=0 cellspacing=0 border=0 ><tr><td><input type=\"checkbox\" name=\"test\" id='"+str1+".<%= tclist[i].getCOLUMN_NAME()%>' onclick=\"adddeleterow(this,'"+str1+".<%= tclist[i].getCOLUMN_NAME()%>');\" /> </td><td><label for='chkbx1'/><%= tclist[i].getCOLUMN_NAME()%>  (<%= tclist[i].getDATA_TYPE()%>)</label></td></tr>";
						}
						else{
						var flag=false;
						for(j=0;j<arrColumnsSelected.length;j++){
							
							if(arrColumnsSelected[j]==checkboxId)
							{
								flag=true;								
								str = str + "<table cellpadding=0 cellspacing=0 border=0 ><tr><td><input type=\"checkbox\" name=\"test\" checked='true' id='"+str1+".<%= tclist[i].getCOLUMN_NAME()%>' onclick=\"adddeleterow(this,'"+str1+".<%= tclist[i].getCOLUMN_NAME()%>');\" /> </td><td><label for='chkbx1'/><%= tclist[i].getCOLUMN_NAME()%>  (<%= tclist[i].getDATA_TYPE()%>)</label></td></tr></table>";
							}									
						}						
						if(!flag)
						str = str + "<table cellpadding=0 cellspacing=0 border=0 ><tr><td><input type=\"checkbox\" name=\"test\"  id='"+str1+".<%= tclist[i].getCOLUMN_NAME()%>' onclick=\"adddeleterow(this,'"+str1+".<%= tclist[i].getCOLUMN_NAME()%>');\" /> </td><td><label for='chkbx1'/><%= tclist[i].getCOLUMN_NAME()%>  (<%= tclist[i].getDATA_TYPE()%>)</label></td></tr>";
						
						}
						
					}	
				<%}%>
			
				
				log.innerHTML = log.innerHTML+str+"</div></table></br>";
//				log.scrollTop = log.scrollHeight;
				log.scrollTop = 0;

			}
	
			function tonclick(id){
				
				doLog(tree.getItemText(id));
			};
			function tondblclick(id){
				if(trim(tree.getParentId(tree.getItemText(id)))=='<%=Constants.TDR_string%>' 
						|| trim(tree.getParentId(tree.getItemText(id)))=='')
				{
					doLog('');
				}
				else
				{
					var dbAndTbl = tree.getParentId(tree.getItemText(id))+'.'+tree.getItemText(id);
					doLog(dbAndTbl);
				}
			};			
			function tonopen(id,mode){
				return true;
			};
			
			function selectAll(tableStr, dbName)
			{
				
				<%for(int i =0; i<tclist.length;i++){ %>

				var tableName = '<%= tclist[i].getTABLE_NAME()%>';
				var databaseName = '<%= tclist[i].getDB_NAME()%>';
				if(dbName == databaseName &&tableName == tableStr)
				{
				var checkboxId = tableStr+'.<%= tclist[i].getCOLUMN_NAME()%>';
				if (document.getElementById(checkboxId)!=null)
				{
					document.getElementById(checkboxId).checked = false;
					document.getElementById(checkboxId).disabled = false;
					adddeleterow(document.getElementById(checkboxId),checkboxId);
				}
				if (document.getElementById(checkboxId)!=null && document.getElementById(tableStr + 'selctAllId').checked )
				{
					document.getElementById(checkboxId).checked = true;
					document.getElementById(checkboxId).disabled = true;
					adddeleterow(document.getElementById(checkboxId),checkboxId);
					
				}
				}
				<% } %>
			};
			
			tree=new dhtmlXTreeObject("treeboxbox_tree","100%","100%",0);
			tree.setImagePath("./codebase/imgs/csh_winstyle/");
			tree.setOnOpenHandler(tonopen); 
  			tree.attachEvent("onOpenEnd",function(nodeId, event){doLog("");});
			tree.setOnDblClickHandler(tondblclick);
			tree.deleteChildItems(0); 
			tree.loadXMLString("<%= tablelist%>");

		document.getElementById('queryta').value="";

	</script>

<!-- FOOTER -->
 <table callspacing="0" cellpadding="0" border="0" class="sample_footer"></table> 
<!-- FOOTER -->

</body>
</html:form>

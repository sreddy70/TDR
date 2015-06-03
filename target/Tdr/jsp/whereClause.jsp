<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%> 
<%@taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean"%>
<html>
<head>
	<title>Add Where Clause</title>
		<link rel='STYLESHEET' type='text/css' href='./common/style.css'>
		<link rel="STYLESHEET" type="text/css" href="./codebase/dhtmlxtree.css">
	
	<script type="text/javascript">
	var colList=window.opener.colList;
	var colListWithDatatypes=window.opener.colListWithDatatypes;

	
	var colListAsString=window.opener.colListAsString;
	var colListWithDatatype=window.opener.colListWithDatatype;
	var colListArr=new Array();
	var colListWDArr=new Array();	
	colListArr = colListAsString.split(',');		 
	colListWDArr = colListWithDatatype.split(',');
	
	
//	var columnList;   
	<%	
	String path = request.getScheme() + "://"
	+ request.getServerName() + ":"
	+ request.getServerPort() + request.getContextPath()
	+ "/";
	//String columnList;
	//if(request.getParameter("columnList")!=null){
	//	columnList = request.getParameter("columnList");
	//	session.setAttribute("colList", columnList);
	//}else{
	//	columnList = (String)session.getAttribute("colList");
	
	//}
		
	//String columnListWithDtype;
	//if(request.getParameter("columnListWithDatatypes")!=null){
	//	columnListWithDtype = request.getParameter("columnListWithDatatypes");
	//	session.setAttribute("columnList5", columnListWithDtype);
	//}else{
	//	columnListWithDtype = (String)session.getAttribute("columnList5");
	//
	//}
	
	
	
//	System.out.println("columnList without datatypes--"+columnList);
//	System.out.println("-columnList wit datatypes---"+columnListWithDtype);
	
	//String[] colListArray = columnList.split(",");
//	String[] colListWithDTArray = columnListWithDtype.split(",");
	
	//for(int i=0;i<colListArray.length;i++){
	//	System.out.println("colListArray--"+colListArray[i]);
//	}

	// System.out.println("-Harsh msg-"+request.getAttribute("msg"));
	String msg=(String)request.getAttribute("errorMsg");
	String printMsg="";	
	%>
			
	
	
	function showbox(selection ,exp,select ){
		//alert(selection);
		//alert(exp);
		//alert(select);
		if(selection=="Expression"){
		document.getElementById(exp).style.display='block';
		document.getElementById(select).style.display='none';
		}

		else if(selection=="Table Column"){
			document.getElementById(exp).style.display='none';
			document.getElementById(select).style.display='block';
			}
		}



	function addRows(){
		//Here row one as blank Tr is also present so
		//alert("Harsh: add row");		
		var table = document.getElementById('tableId');
		var oldRowCount = table.rows.length;
		var rowCount ;
		rowCount= parseInt(oldRowCount+1);
		//alert(rowCount);
			var row = table.insertRow(oldRowCount);
			row.id = "tr"+rowCount;
		//	alert(row.id);
		
			var cell0 = row.insertCell(0);
			cell0.setAttribute("id","andOrTd_"+rowCount);
			cell0.setAttribute("align","center");
			cell0.style.width="63px";
			var cell0Text = "";
			//alert("--1--");
			cell0Text+="<SELECT id='andOr_"+rowCount+"' name='andOr_"+rowCount+"'>";
			cell0Text+="<OPTION value='And'>And</OPTION>";
			cell0Text+="<OPTION value='Or'>Or</OPTION>";
			cell0Text+="</SELECT>";
			cell0.innerHTML = cell0Text;
			
			var cell1 = row.insertCell(1);
			cell1.setAttribute("id","leftParTd_"+rowCount);
			cell1.setAttribute("align","center");
			cell1.style.width="50px";
			var cell1Text = "";
			//alert("--2--");															
			cell1Text+="<input type='text' id='leftPar_"+rowCount+"' style='width: 40px;' value=' '>";
			cell1.innerHTML = cell1Text;
			
			var cell2 = row.insertCell(2);
			cell2.setAttribute("id","repCol1Td_"+rowCount);
			cell2.setAttribute("align","center");
			var cell2Text = "";
			//alert("--3--");
			
			var  repCol1 = document.getElementById("repCol1_"+rowCount);
			
			cell2Text+="<SELECT id='repCol1_"+rowCount+"' name='repCol1_"+rowCount+"'>";
			cell2Text+="<OPTION value='[None]'>[None]</OPTION>";			
			for(var i=0;i<colListArr.length;i++){				
				cell2Text+="<OPTION value='"+colListArr[i]+"'>"+colListWDArr[i]+"</OPTION>";
			}
			cell2Text+="</SELECT>";
			cell2.innerHTML = cell2Text;
			
			
			var cell3 = row.insertCell(3); 
			cell3.setAttribute("id","operatorTd_"+rowCount);
			cell3.setAttribute("align","center");
			var cell3Text = "";
			//alert("--4--");
			cell3Text+="<SELECT id='operator_"+rowCount+"' name='operator_"+rowCount+"'>";
			cell3Text+="<OPTION value='='>=</OPTION>";
			cell3Text+="<OPTION value='<'><</OPTION>";
			cell3Text+="<OPTION value='>'>></OPTION>";
			cell3Text+="<OPTION value='<='><=</OPTION>";
			cell3Text+="<OPTION value='>='>>=</OPTION>";
			cell3Text+="<OPTION value='Like'>Like</OPTION>"; 
			cell3Text+="<OPTION value='Not Like'>Not Like</OPTION>"; 
			cell3Text+="</SELECT>";												
			cell3.innerHTML = cell3Text;
			
			
			var cell4 = row.insertCell(4);
			cell4.setAttribute("id","colOrExpTd_"+rowCount);
			cell4.setAttribute("align","center");
			var cell4Text = "";
			//alert("--5--");
			cell4Text+="<SELECT id='colOrExp_"+rowCount+"' name='colOrExp_"+rowCount+"' onChange=\"showbox(this.value,'exp_"+rowCount+"','repCol2_"+rowCount+"');\">";
			cell4Text+="<OPTION value='Expression'>Expression</OPTION>";
			cell4Text+="<OPTION value='Table Column'>Table Column</OPTION>";
			cell4Text+="</SELECT>";
			cell4.innerHTML = cell4Text;
			
			var cell5 = row.insertCell(5);
			cell5.setAttribute("id","expSelectTd_"+rowCount); 
			cell5.setAttribute("align","center");
			var cell5Text = "";
			cell5Text+="<input type='text' id='exp_"+rowCount+"' style='display: block;' value=' '>";     
			//alert("--6--");
			cell5Text+="<SELECT id='repCol2_"+rowCount+"' name='repCol2_"+rowCount+"' style='display: none;'>";
			cell5Text+="<OPTION value='[None]'>[None]</OPTION>";			
			for(var i=0;i<colListArr.length;i++){				
				cell5Text+="<OPTION value='"+colListArr[i]+"'>"+colListWDArr[i]+"</OPTION>";
			}
			cell5Text+="</SELECT>"; 	
			cell5.innerHTML = cell5Text;
		
			var cell6 = row.insertCell(6);
			cell6.setAttribute("id","rightParTd_"+rowCount);		
			cell6.setAttribute("align","center");		
			cell6.style.width="40px";
			var cell6Text = "";
			//alert("--7--");
			cell6Text+="<input type='text' id='rightPar_"+rowCount+"'  style='width: 40px;' value=' '>";
			cell6.innerHTML = cell6Text;
			
			var cell7 = row.insertCell(7);
			cell7.setAttribute("id","deleteTd_"+rowCount);
			cell7.setAttribute("align","center");
			cell7.style.width="20px";
			cell7.innerHTML = "<img src='<%=path %>images/Close_small.gif' onclick='deleteRow("+ rowCount + ")' style=cursor:hand;>";
			cell7.width = "5%";		
		
		
			}
			
		function deleteRow(rowIndex){
		
		
		var table = document.getElementById('tableId');
		var oldRowCount = table.rows.length;
		rowCount= parseInt(oldRowCount);		
		//alert("rowIndex-"+rowIndex+"  rowCount-"+rowCount);
		var flag = 0;
		var i= rowIndex;
		if(rowIndex ==  rowCount){
			//alert("yes"+"rowIndex-"+rowIndex+"rowCount-"+rowCount);
			// deletes the last row
			table.deleteRow(rowIndex-1);			
			}		
		else{
		for (i = rowIndex; i < rowCount ; i++) {
			//alert("deleting in between");
			flag = 1;
			var j = parseInt(i) + 1;
			
			//alert("--1--");
			var SelectedAndOr = document.getElementById("andOr_" + i);
			var tempAndOrObj = document.getElementById("andOr_" + j);	
			//alert("i="+i+"  j="+j)
			//alert("less-"+SelectedAndOr.value+"  less+1--"+tempAndOrObj.value)
			var AndOrText ="";
			AndOrText += "<SELECT name='andOr_"+i+"' id='andOr_"+i+"'>";
			for(var k =0;k <  tempAndOrObj.options.length;k++){
			//alert("options-"+tempAndOrObj.options[k].value);
				AndOrText += "<option value='"+tempAndOrObj.options[k].value+"'>"+tempAndOrObj.options[k].value+"</option>";
		
			}
			document.getElementById("andOrTd_"+i).innerHTML = AndOrText;
			document.getElementById("andOrTd_"+i).style.width="63px";
			document.getElementById("andOr_"+i).value = document.getElementById("andOr_"+j).value;
			
			
			
			var selectedleftPar = document.getElementById("leftPar_" + i);
			var nextLeftPar = document.getElementById("leftPar_" + j);	
			//alert("i="+i+"  j="+j)
			//alert("less-"+selectedleftPar.value+"  less+1--"+nextLeftPar.value)
			var leftParText ="";
			leftParText += "<input type='text' id='leftPar_"+i+"' style='width: 40px;' value=nextLeftPar.value >";
			//alert("-3-");
			document.getElementById("leftParTd_"+i).innerHTML = leftParText;
			document.getElementById("leftParTd_"+i).style.width="50px";
			document.getElementById("leftPar_"+i).value = document.getElementById("leftPar_"+j).value;
			
			
			var SelectedCol1 = document.getElementById("repCol1_" + i);
			var tempCol1 = document.getElementById("repCol1_" + j);	
			//alert("i="+i+"  j="+j)
			//alert("less-"+SelectedCol1.value+"  less+1--"+tempCol1.value)
			var Col1Text ="";
			Col1Text += "<SELECT name='repCol1_"+i+"' id='repCol1_"+i+"'>";
			for(var k =0;k < tempCol1.options.length;k++){
			//alert("options-"+tempCol1.options[k].value);
				Col1Text += "<option value='"+tempCol1.options[k].value+"'>"+tempCol1.options[k].value+"</option>";
			
			}
			document.getElementById("repCol1Td_"+i).innerHTML = Col1Text;
			document.getElementById("repCol1_"+i).value = document.getElementById("repCol1_"+j).value;
			
			
			
			var SelectedOperator = document.getElementById("operator_" + i);
			var tempOperator = document.getElementById("operator_" + j);	
			//alert("i="+i+"  j="+j)
			//alert("less-"+SelectedOperator.value+"  less+1--"+tempOperator.value)
			var optrText ="";
			optrText += "<SELECT name='operator_"+i+"' id='operator_"+i+"'>";
			for(var k =0;k < tempOperator.options.length;k++){
			//alert("options-"+tempCol1.options[k].value);
				optrText += "<option value='"+tempOperator.options[k].value+"'>"+tempOperator.options[k].value+"</option>";
				
			}
			document.getElementById("operatorTd_"+i).innerHTML = optrText;
			document.getElementById("operator_"+i).value = document.getElementById("operator_"+j).value;
			
			
			var selectedColOrExp = document.getElementById("colOrExp_" + i);
			var tempColOrExp = document.getElementById("colOrExp_" + j);	
			//alert("i="+i+"  j="+j)
			//alert("less-"+selectedColOrExp.value+"  less+1--"+tempColOrExp.value)
			var colOrExpText ="";
			colOrExpText += "<SELECT name='colOrExp_"+i+"' id='colOrExp_"+i+"' onChange=\"showbox(this.value,'exp_"+i+"','repCol2_"+i+"');\">";
			for(var k =0;k < tempColOrExp.options.length;k++){
			//alert("options-"+tempColOrExp.options[k].value);
				colOrExpText += "<option value='"+tempColOrExp.options[k].value+"'>"+tempColOrExp.options[k].value+"</option>";
				
			}
			document.getElementById("colOrExpTd_"+i).innerHTML = colOrExpText;
			document.getElementById("colOrExp_"+i).value = document.getElementById("colOrExp_"+j).value;
			
			
			
			//alert("harsh8");
			var selectedExp = document.getElementById("exp_" + i);
			var tempExp = document.getElementById("exp_" + j);	
			var selectedSelect = document.getElementById("repCol2_" + i);
			var tempSelect = document.getElementById("repCol2_" + j);	
			//alert("i="+i+"  j="+j);
			var selectedColOrExp = document.getElementById("colOrExp_" + i).value;
			
			
			
			//alert("less-"+selectedExp.value+"  less+1--"+tempExp.value);
			//alert("less-"+selectedSelect.value+"  less+1--"+tempSelect.value);
			//alert("selectedColOrExp-"+selectedColOrExp);
			/*var expSelectText ="";
			if(selectedColOrExp=="Expression"){
			//alert("exp is blank");
			expSelectText += "<input type='text' id='exp_"+i+"'  value=tempExp.value >";
			} 
			if(selectedColOrExp=="Table Column"){
			expSelectText += "<SELECT name='repCol2_"+i+"' id='repCol2_"+i+"' >";
			for(var k =0;k < tempSelect.options.length;k++){
			//alert("options-"+tempSelect.options[k].value);
				expSelectText += "<option value='"+tempSelect.options[k].value+"'>"+tempSelect.options[k].value+"</option>";
				
			}
			}
			document.getElementById("expSelectTd_"+i).innerHTML = expSelectText;
			if(selectedColOrExp=="Expression"){
			document.getElementById("exp_"+i).value = document.getElementById("exp_"+j).value;
			}
			if(selectedColOrExp=="Table Column"){
			document.getElementById("repCol2_"+i).value = document.getElementById("repCol2_"+j).value;
			}*/

			var expSelectText ="";
			var displayText ="";
			var displaySelect ="";
			if(selectedColOrExp=="Expression"){
				displayText = 'block';
				displaySelect = 'none';
			} 
			if(selectedColOrExp=="Table Column"){
				displayText = 'none';
				displaySelect = 'block';
			}
			expSelectText += "<input type='text' id='exp_"+i+"'  value=' ' style='display: "+displayText+";'>";
			expSelectText += "<SELECT name='repCol2_"+i+"' id='repCol2_"+i+"' style='display: "+displaySelect+";'>";
			for(var k =0;k < tempSelect.options.length;k++){
			//alert("options-"+tempSelect.options[k].value);
				expSelectText += "<option value='"+tempSelect.options[k].value+"'>"+tempSelect.options[k].value+"</option>";
				
			}
			
			document.getElementById("expSelectTd_"+i).innerHTML = expSelectText;
			if(selectedColOrExp=="Expression"){
			document.getElementById("exp_"+i).value = document.getElementById("exp_"+j).value;
			document.getElementById("repCol2_"+i).value = '[None]';
			}
			if(selectedColOrExp=="Table Column"){
			document.getElementById("exp_"+i).value = ' ';
			document.getElementById("repCol2_"+i).value = document.getElementById("repCol2_"+j).value;
			}
			
		
			var selectedRightPar = document.getElementById("rightPar_" + i);
			var nextRightPar = document.getElementById("rightPar_" + j);	
			//alert("less-"+selectedRightPar.value+"  less+1--"+nextRightPar.value)
			var rightParText ="";
			rightParText += "<input type='text' id='rightPar_"+i+"' style='width: 40px;' value=nextRightPar.value>";
			document.getElementById("rightParTd_"+i).innerHTML = rightParText;
			document.getElementById("rightParTd_"+i).style.width="40px";
			document.getElementById("rightPar_"+i).value = document.getElementById("rightPar_"+j).value;
			
			
			}
		table.deleteRow(rowCount-1);	
	}
	
		
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
		function isWhitespace(charToCheck) {
			var whitespaceChars = " \t\n\r\f";
			return (whitespaceChars.indexOf(charToCheck) != -1);
		}
				
	
	
		function getAllValue() {	
		
		//alert("getAllValue");
		var table = document.getElementById('tableId');
		var totalRows = table.rows.length;
			
		//alert(totalRows);	
		if(document.getElementById("colList1").value=='[None]')
		{
			document.getElementById("errorId").innerHTML = 'Please select a column';
			return false;
		}
		else if(document.getElementById("colOrExp").value=='Expression')
		{
			if(trim(document.getElementById("expValue").value)=='')
			{
				document.getElementById("errorId").innerHTML = 'Please enter a value';
				return false;
			}
			else
			{
				document.getElementById("errorId").innerHTML = '';
			}
		}
		else if(document.getElementById("colOrExp").value=='Table Column')
		{
			if(document.getElementById("colList2").value=='[None]')
			{
				document.getElementById("errorId").innerHTML = 'Please select column in value field';
				return false;
			}
			else
			{
				document.getElementById("errorId").innerHTML = '';
			}
		}
		else
		{
			document.getElementById("errorId").innerHTML = '';
		}
		
		
		for ( var i = 1; i <=totalRows; i++) {
			       
			if (i == 1) {		
			} else {
				if (document.getElementById("repCol1_" + i).value=='[None]')
				{
					//error
					document.getElementById("errorId").innerHTML = 'Please select a column';
					return false;
				}
				else if(document.getElementById("colOrExp_" + i).value=='Expression')
				{
					if(trim(document.getElementById("exp_" + i).value)=='')
					{
						//error
						document.getElementById("errorId").innerHTML = 'Please enter a value';
						return false;
					}
					else
					{
						//no error
						document.getElementById("errorId").innerHTML = '';
					}
				}
				else if (document.getElementById("colOrExp_" + i).value=='Table Column')
				{
					if(document.getElementById("repCol2_" + i).value=='[None]')
					{
						// error
						document.getElementById("errorId").innerHTML = 'Please select column in value field';
						return false;
					}
					else
					{
						//no error
						document.getElementById("errorId").innerHTML = '';
					}
				}
				else
				{
					//no error
					document.getElementById("errorId").innerHTML = '';
				}
			}
		}
		var andOrVal = "";
		var leftParVal = "";
		var colList1Val = "";
		var operatorVal = "";
		var expOrSelectVal = "";	
		var expVal = "";	
		var colList2Val = "";	
		var rightParVal = "";	
			
		for ( var i = 1; i <=totalRows; i++) {
			       
			if (i == 1) {		
			} else {
				andOrVal += document.getElementById("andOr_" + i).value;
				leftParVal += document.getElementById("leftPar_" + i).value;
				colList1Val += document.getElementById("repCol1_" + i).value;
				operatorVal += document.getElementById("operator_" + i).value;
				expOrSelectVal += document.getElementById("colOrExp_" + i).value;
				expVal += document.getElementById("exp_" + i).value;
				colList2Val += document.getElementById("repCol2_" + i).value;
				rightParVal += document.getElementById("rightPar_" + i).value;
			
			if (i != (totalRows)) {
				andOrVal += ","; 
				leftParVal += ",";
				colList1Val += ",";
				operatorVal += ",";
				expOrSelectVal += ",";
				expVal += ",";
				colList2Val += ",";
				rightParVal += ",";
			}
			
			
			}
			

		}

	//	alert(andOrVal);
	//	alert('a'+leftParVal+'a');
	//	alert(colList1Val);
	//	alert(operatorVal);
	//	alert(expOrSelectVal);
	//	alert(expVal);
	//	alert(colList2Val);
	//	alert(rightParVal);
		
		document.getElementById("andOrVal").value = andOrVal;
		document.getElementById("leftParVal").value = leftParVal;		
		document.getElementById("colList1Val").value = colList1Val;
		document.getElementById("operatorVal").value = operatorVal;
		document.getElementById("expOrSelectVal").value = expOrSelectVal;
		document.getElementById("expVal").value = expVal;
		document.getElementById("colList2Val").value = colList2Val;
		document.getElementById("rightParVal").value = rightParVal;
		//document.myForm.submit();

		var presentAction = document.forms[0].action;	
		//alert(presentAction);	

		
		document.forms[0].submit();
		
		
	}
		




		function SendValueToParent() {
				//alert("SendValueToParent--"+document.getElementById('whereQuery').value);
		        window.opener.GetValueFromChild(document.getElementById('whereQuery').value) ;
		        window.close();
		        return false;
 		   }


		function addRowsAfterSubmit(obj){
			//Here row one as blank Tr is also present so
			var andOrArray=new Array();
			andOrArray = obj.formAndOrVal.split(',');
			var table = document.getElementById('tableId');
			//**********loop start***************
			if(andOrArray!=''){
			for(var index=0;index<andOrArray.length;index++) { 
			var oldRowCount = table.rows.length;
			var rowCount ;
			rowCount= parseInt(oldRowCount+1);
			//alert(rowCount);
				var row = table.insertRow(oldRowCount);
				row.id = "tr"+rowCount;
			//	alert(row.id);
			
				var cell0 = row.insertCell(0);
				cell0.setAttribute("id","andOrTd_"+rowCount);
				cell0.setAttribute("align","center");
				cell0.style.width="63px";
				var cell0Text = "";
				//alert("--1--"+obj.formAndOrVal.split(',')[index]);
				cell0Text+="<SELECT id='andOr_"+rowCount+"' name='andOr_"+rowCount+"'>";
				if(obj.formAndOrVal.split(',')[index]=='Or')
				{
					cell0Text+="<OPTION value='And'>And</OPTION>";
					cell0Text+="<OPTION value='Or' selected='selected'>Or</OPTION>";
				}
				else
				{
					cell0Text+="<OPTION value='And' selected='selected'>And</OPTION>";
					cell0Text+="<OPTION value='Or'>Or</OPTION>";
				}
				cell0Text+="</SELECT>";
				cell0.innerHTML = cell0Text;
				
				var cell1 = row.insertCell(1);
				cell1.setAttribute("id","leftParTd_"+rowCount);
				cell1.setAttribute("align","center");
				cell1.style.width="50px";
				var cell1Text = "";
				//alert("--2--"+obj.formLeftParVal.split(',')[index]);															
				cell1Text+="<input type='text' id='leftPar_"+rowCount+"' style='width: 40px;' value='"+obj.formLeftParVal.split(',')[index]+"'>";
				cell1.innerHTML = cell1Text;
				
				var cell2 = row.insertCell(2);
				cell2.setAttribute("id","repCol1Td_"+rowCount);
				cell2.setAttribute("align","center");
				var cell2Text = "";
				//alert("--3--"+obj.formColList1Val.split(',')[index]);
				
				var  repCol1 = document.getElementById("repCol1_"+rowCount);
				
				cell2Text+="<SELECT id='repCol1_"+rowCount+"' name='repCol1_"+rowCount+"'>";
				cell2Text+="<OPTION value='[None]'>[None]</OPTION>";			
				for(var i=0;i<colListArr.length;i++){	
					if(obj.formColList1Val.split(',')[index]==colListArr[i])
					{
						cell2Text+="<OPTION value='"+colListArr[i]+"' selected='selected'>"+colListWDArr[i]+"</OPTION>";
					}
					else
					{
						cell2Text+="<OPTION value='"+colListArr[i]+"'>"+colListWDArr[i]+"</OPTION>";
					}
				}
				cell2Text+="</SELECT>";
				cell2.innerHTML = cell2Text;
				
				var operatorArray=new Array("=","<",">","<=",">=","Like","Not Like");
				var operatorValArray=new Array("=","&lt;","&gt;","&lt;=","&gt;=","Like","Not Like");
				var cell3 = row.insertCell(3); 
				cell3.setAttribute("id","operatorTd_"+rowCount);
				cell3.setAttribute("align","center");
				var cell3Text = "";
				//alert("--4-OPERATOR-" + obj.formOperatorVal.split(',')[index]);
				cell3Text+="<SELECT id='operator_"+rowCount+"' name='operator_"+rowCount+"' >";
				for(var j = 0; j<operatorArray.length; j++)
				{
					if(obj.formOperatorVal.split(',')[index]==operatorValArray[j])
					{
						cell3Text+="<OPTION value='"+operatorArray[j]+"' selected='selected'>"+operatorArray[j]+"</OPTION>";
					}
					else
					{
						cell3Text+="<OPTION value='"+operatorArray[j]+"'>"+operatorArray[j]+"</OPTION>";
					}

					
				} 
				cell3Text+="</SELECT>";												
				cell3.innerHTML = cell3Text;
				
				
				var cell4 = row.insertCell(4);
				cell4.setAttribute("id","colOrExpTd_"+rowCount);
				cell4.setAttribute("align","center");
				var cell4Text = "";
				//alert("--5--");
				cell4Text+="<SELECT id='colOrExp_"+rowCount+"' name='colOrExp_"+rowCount+"' onChange=\"showbox(this.value,'exp_"+rowCount+"','repCol2_"+rowCount+"');\">";
				if(obj.formExpOrSelectVal.split(',')[index]=='Table Column')
				{
					cell4Text+="<OPTION value='Expression'>Expression</OPTION>";
					cell4Text+="<OPTION value='Table Column' selected='selected'>Table Column</OPTION>";
				}
				else
				{
					cell4Text+="<OPTION value='Expression' selected='selected'>Expression</OPTION>";
					cell4Text+="<OPTION value='Table Column'>Table Column</OPTION>";
				}
				cell4Text+="</SELECT>";
				cell4.innerHTML = cell4Text;
				
				var cell5 = row.insertCell(5);
				cell5.setAttribute("id","expSelectTd_"+rowCount); 
				cell5.setAttribute("align","center");
				var cell5Text = "";
				if(obj.formExpOrSelectVal.split(',')[index]!='Table Column')
				{
					cell5Text+="<input type='text' id='exp_"+rowCount+"' style='display: block;' value='"+obj.formExpVal.split(',')[index]+"'>";     
					//alert("--6--");
					cell5Text+="<SELECT id='repCol2_"+rowCount+"' name='repCol2_"+rowCount+"' style='display: none;'>";
					cell5Text+="<OPTION value='[None]'>[None]</OPTION>";			
					for(var i=0;i<colListArr.length;i++){				
						cell5Text+="<OPTION value='"+colListArr[i]+"'>"+colListWDArr[i]+"</OPTION>";
					}
					cell5Text+="</SELECT>"; 	
				}
				else
				{
					cell5Text+="<input type='text' id='exp_"+rowCount+"' style='display: none;' value='"+obj.formExpVal.split(',')[index]+"'>";     
					//alert("--6-6-");
					cell5Text+="<SELECT id='repCol2_"+rowCount+"' name='repCol2_"+rowCount+"' style='display: block;' value='"+obj.formColList2Val.split(',')[index]+"'>";
					cell5Text+="<OPTION value='[None]'>[None]</OPTION>";			
					for(var i=0;i<colListArr.length;i++){	
						if(obj.formColList2Val.split(',')[index]==colListArr[i])
						{
							cell5Text+="<OPTION value='"+colListArr[i]+"' selected='selected' >"+colListWDArr[i]+"</OPTION>";
						}
						else
						{
							cell5Text+="<OPTION value='"+colListArr[i]+"'>"+colListWDArr[i]+"</OPTION>";
						}			
						
					}
					cell5Text+="</SELECT>"; 
				}
				cell5.innerHTML = cell5Text;
			
				var cell6 = row.insertCell(6);
				cell6.setAttribute("id","rightParTd_"+rowCount);		
				cell6.setAttribute("align","center");		
				cell6.style.width="40px";
				var cell6Text = "";
				//alert("--7--");
				cell6Text+="<input type='text' id='rightPar_"+rowCount+"'  style='width: 40px;' value='"+obj.formRightParVal.split(',')[index]+"'>";
				cell6.innerHTML = cell6Text;
				
				var cell7 = row.insertCell(7);
				cell7.setAttribute("id","deleteTd_"+rowCount);
				cell7.setAttribute("align","center");
				cell7.style.width="20px";
				cell7.innerHTML = "<img src='<%=path %>images/Close_small.gif' onclick='deleteRow("+ rowCount + ")' style=cursor:hand;>";
				cell7.width = "5%";		
				}
				}
				//**********loop end***************
			
				}
		
		function onBodyLoad(){
				//alert("onBodyLoad");
				//var colListAsString=window.opener.colListAsString;					
				var colList1 = document.getElementById("colList1");
				var colList2 = document.getElementById("colList2");
				colList1.options[colList1.options.length]=new Option('[None]', '[None]');
				colList2.options[colList2.options.length]=new Option('[None]', '[None]');
				for(index in colListWDArr) {					
					colList1.options[colList1.options.length] = new Option(colListWDArr[index], colListArr[index]);
					colList2.options[colList2.options.length] = new Option(colListWDArr[index], colListArr[index]);
				}
				//selected columns in first row
				var formColList1 = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="colList1"/></logic:present>';
				var formColList2 = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="colList2"/></logic:present>';
				colList1.value = formColList1;
				colList2.value = formColList2;
				//comma separated form Vlaues
				var formAndOrVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="andOrVal"/></logic:present>';
				var formLeftParVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="leftParVal"/></logic:present>';
				var formColList1Val = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="colList1Val"/></logic:present>';
				var formOperatorVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="operatorVal"/></logic:present>';
				var formExpOrSelectVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="expOrSelectVal"/></logic:present>';
				var formExpVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="expVal"/></logic:present>';
				var formColList2Val = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="colList2Val"/></logic:present>';
				var formRightParVal = '<logic:present name="WhereClauseForm"><bean:write name="WhereClauseForm" property="rightParVal"/></logic:present>';
				var obj = new Object;
				obj.formAndOrVal = formAndOrVal;
				obj.formLeftParVal = formLeftParVal;
				obj.formColList1Val = formColList1Val;
				obj.formOperatorVal = formOperatorVal;
				obj.formExpOrSelectVal = formExpOrSelectVal;
				obj.formExpVal = formExpVal;
				obj.formColList2Val = formColList2Val;
				obj.formRightParVal = formRightParVal;
				addRowsAfterSubmit(obj);
				
			}

	
		function closeWindow()
		{
			window.close();
			
		}

	</script>
</head>
<html:form action="/whereClause.do">
<body onload="onBodyLoad()">
<table cellspacing="0" cellpadding="0" width="100%" border="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
	<tr valign="middle">
		<!-- COMPONENT ICON -->
		<td width="40" align='center'><img src='<%=path %>common/dhtmlxtree_icon.gif' id="dPullId" border='0'></td>
		<!-- COMPONENT NAME -->
		<td width="205" align="left"><b>DPull</b></td>
		<!-- SAMPLE TITLE -->
		<td>&nbsp;</td>
		<!-- CLOSE BUTTON -->
		<td width="250">&nbsp;</td>
		<td  align="right" style="padding-right: 25px;"><a href="javascript: void(0);" class="logout" onclick="closeWindow()"><b>Close</b></a></td>
	</tr>
</table> 
<TABLE id="outerTable" width="100%" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');"  border="0">
			<tr><td colspan="6">
				<TABLE id="dataTable" width="100%" border="0" bordercolor="green">
					<tr>
					
					<%
						if(msg !=null){
						printMsg=msg;
						System.out.println("printMsg-"+printMsg);
						}
					%>
					<td colspan="5" align="right" style="color: navy; font-weight: bold;">For non-numeric data types please enclose the value in quotes("")</td>
					<td colspan="3" align="right"><font color="red" style="font-weight: bold" id="errorId"><%=printMsg%></font></td>
					</tr>
					<tr height="10" style="filter:progid:DXImageTransform.Microsoft.Gradient(endColorstr='#C0CFE2', startColorstr='#FFFFFF', gradientType='0');">
						<th align="center" class="whiteFont" style="width:63px";>&nbsp;</th>
						<th align="center" class="whiteFont">Add '(' </th>
						<th align="center" class="whiteFont">Columns</th>
    					<th align="center" class="whiteFont">Operators</th>
    					<th align="center" class="whiteFont">Expression</th>
    					<th align="center" class="whiteFont">Value</th>
    					<th align="center" class="whiteFont">Add ')'</th>
    					<th align="center" class="whiteFont" style="width:20px";>&nbsp;</th>
    				</tr>
					<TR>
						<td align="center"  style="width:63px";>&nbsp;</td>
						<TD align="center" style="width: 50px;">
							<html:text styleId="leftParenthesis" name="WhereClauseForm" property="leftParenthesis" style="width: 40px;"></html:text>
						</TD>
						<td align="center">
								<SELECT name="colList1" id="colList1"></SELECT>
						</td>
						<td align="center">
							<html:select name="WhereClauseForm" property="operator">
								<html:option value="=">=</html:option> 
								<html:option value="<"><</html:option> 
								<html:option value=">">></html:option> 
								<html:option value="<="><=</html:option> 
								<html:option value=">=">>=</html:option> 
								<html:option value="Like">Like</html:option> 
								<html:option value="Not Like">Not Like</html:option> 
							</html:select>
						</td>						
									
					<TD align="center">
							<html:select name="WhereClauseForm" property="colOrExp" onchange="showbox(colOrExp.options[selectedIndex].value,'expValue','colList2')">
								<html:option value="Expression">Expression</html:option> 
								<html:option value="Table Column">Table Column</html:option> 
							</html:select>
					</TD> 	
					<td align="center">
						<logic:notEqual value="Table Column" name="WhereClauseForm" property="colOrExp">
							<html:text styleId="expValue" name="WhereClauseForm" property="expValue" style="display: block;"></html:text>
							<SELECT name="colList2"  id="colList2" style="display: none;"></SELECT>
						</logic:notEqual>
						<logic:equal value="Table Column" name="WhereClauseForm" property="colOrExp">
							<html:text styleId="expValue" name="WhereClauseForm" property="expValue" style="display: none;"></html:text>
							<SELECT name="colList2"  id="colList2" style="display: block;"></SELECT>
						</logic:equal>
					</td>
					
								  
					<TD align="center" style="width: 50px;">
						<html:text styleId="rightParenthesis" name="WhereClauseForm" property="rightParenthesis" style="width: 40px;"></html:text>
					</TD>
					<td align="center" style="width:20px";>&nbsp;</td>					
					</TR>
					
					<tr><td></td></tr>
					<tr><td></td></tr>
					</td></tr>
					</table>
					<tr><td colspan="6">
					<table id="tableId" border="0" bordercolor="red" width="100%">
	
		<%int Fetchindex = 0;%>
			<tr id="tr<%=Fetchindex%>">
			
				<td id="AndOrTd_<%=Fetchindex%>" style="width:63px;" align="center">	
								
				</td>
				
				<td id="leftPar_<%=Fetchindex%>" style="width:50px;" align="center">	
									
				</td>
				
				<td id="repCol1_<%=Fetchindex%>">						
					
				</td>	
							
				<td id="operator_<%=Fetchindex%>">				
						 	 			
				</td>
				<td id="colOrExp_<%=Fetchindex%>">	
					
				</td>				
				
				<td id="exp_<%=Fetchindex%>">
												
					</td>
					
								  
					<TD id="rightPar_<%=Fetchindex%>"  style="width:50px;" align="center">	
					
					
				
			</tr>				
		<%	Fetchindex++; %>
	</table>
					
					
					
					</td></tr>
					<tr><td></td></tr>
					<tr><td></td></tr>
					<tr><td colspan="6" align="center">
					<input type="button" value="ADD Rows" onclick="addRows()" >					
					 <input type="button" value="Generate Where Clause" name="generateWhereClause" onclick="return getAllValue();" />
					
					
					</td></tr>
					<tr><td></td></tr>
					<tr><td></td></tr>
					<tr><td colspan="6" align="center"><html:textarea  styleId="whereQuery" name="WhereClauseForm" property="whereClause" style="height:95px;width:865px; border :none; overflow:auto;"></html:textarea>
					
					
					
					
					<tr>
						<td colspan="6" align="center"><input type="button" value="Add where Clause to Parent Query" onclick="javascript: return SendValueToParent();" />
					</td></tr>
					<input type="hidden"  name="andOrVal" id="andOrVal"/>
					<input type="hidden"  name="leftParVal" id="leftParVal"/>
					<input type="hidden"  name="colList1Val" id="colList1Val"/>
					<input type="hidden"  name="operatorVal" id="operatorVal"/>
					<input type="hidden"  name="expOrSelectVal" id="expOrSelectVal"/>
					<input type="hidden"  name="expVal" id="expVal"/>
					<input type="hidden"  name="colList2Val" id="colList2Val"/>
					<input type="hidden"  name="rightParVal" id="rightParVal"/>
					
					
				<tr height="200px;"></tr>	
				</TABLE>
				<table callspacing="0" cellpadding="0" border="0" class="sample_footer"></table> 
</body>
</html:form>			
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	
<script>

		$(document).ready(function(){
			var startDate="${startDate}";
			var arr = startDate.split("/");
			Date1=arr[2]+"-"+arr[1]+"-"+arr[0];
			var startDateOfMonth="${startDateOfMonth}";
			var arr1 = startDateOfMonth.split("-");
			Date1=arr1[2]+"-"+arr1[1]+"-"+arr1[0];
			$("#dtFromDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
			$("#dtFromDate").datepicker('setDate', startDateOfMonth);	
			
			
			$("#dtToDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
			$("#dtToDate").datepicker('setDate', 'today');	
			
			
			
		});
		
		
		function funHelp(transactionName)
		{
			fieldName=transactionName;
			window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			//window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		}
		
		function funSetData(code){

		switch(fieldName){

			case 'AgentCode' : 
				funSetAgentCode(code);
				break;
	}

	}
		

		function funSetAgentCode(code){
			 
			$.ajax({
				type : "GET",
				url : getContextPath()+ "/loadAgentCode.html?agentCode=" + code,
				dataType : "json",
			
				success: function(response)
		        {
					
		        	if(response.strAgentCode=='Invalid Code')
		        	{
		        		alert("Invalid Agent Code");
		        		$("#txtAgentCode").val('');
		        	}
		        	else
		        	{					        	    	        		
		        		$("#txtAgentCode").val(response.strAgentCode);
		        		
		        	}
				},
				error: function(jqXHR, exception) 
				{
		            if (jqXHR.status === 0) {
		                alert('Not connect.n Verify Network.');
		            } else if (jqXHR.status == 404) {
		                alert('Requested page not found. [404]');
		            } else if (jqXHR.status == 500) {
		                alert('Internal Server Error [500].');
		            } else if (exception === 'parsererror') {
		                alert('Requested JSON parse failed.');
		            } else if (exception === 'timeout') {
		                alert('Time out error.');
		            } else if (exception === 'abort') {
		                alert('Ajax request aborted.');
		            } else {
		                alert('Uncaught Error.n' + jqXHR.responseText);
		            }		            
		        }			
			});
		}

		

	
function funExportReport()
{
var strAgentCode=$("#strAgentCode").val();
var frmDte1=$('#dtFromDate').val();
var toDte1=$('#dtToDate').val();
if($('#cmbSelectType').val() == 'Detail')
 {
	window.location.href = getContextPath()+"/exportCommissionDetailsReport.html?frmDte="+frmDte1+"&toDte="+toDte1;
 }
else 
 {
	window.location.href = getContextPath()+"/exportCommissionSummaryReport.html?frmDte="+frmDte1+"&toDte="+toDte1;
 }
}		

		
		
</script>
</head>

<body>
<div class="container transtable">
		<label id="formHeading">Agent Commission Report</label>
	   <s:form name="frmAgentCommissionReport" method="GET" action=""> 

		<div class="row">
			 <div class="col-md-2"><label>From Date</label>
				    <s:input type="text" id="dtFromDate" path="dteFromDate" required="true" class="calenderTextBox" style="width: 70%;"/>
	         </div>
	         
			 <div class="col-md-2"><label>To Date</label>
				    <s:input type="text" id="dtToDate" path="dteToDate" required="true" class="calenderTextBox" style="width: 70%;" />		
			 </div>
			 <div class="col-md-8"></div>
			 <div class="col-md-2">
				<label>Agent Code</label>
				<s:input type="text" id="txtAgentCode" path="strAgentCode" cssClass="searchTextBox" ondblclick="funHelp('AgentCode');"/>
			</div>
			 
			 
			  
		     <div class="col-md-2">
			 	<label>Report Type </label>
					  <s:select id="cmbSelectType" path="" style="width:auto;">
				 	<s:option value="Detail">Detail</s:option>
				    		<s:option value="Summary">Summary</s:option>
				    	</s:select>
			     </div>
			
			
		</div>
			<div class="col-md-8"></div>
			<br>
			<br>
		<p align="center" style="margin-right: 57%;">
			<!--  	<input type="submit" value="Export" class="btn btn-primary center-block" class="form_button" onclick="return funCallFormAction('submit',this)" /> -->
			<input type="submit" value="Export" class="btn btn-primary center-block" class="form_button" onclick="funExportReport()"  />
				&nbsp;
			    <input type="button" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
			</p>
		</s:form>
	</div>
</body>
</html>
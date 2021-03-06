<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Web Stocks</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
 
    <script type="text/javascript">
    
    var fieldName;
    
    function funCallFormExport()
    {
    	var fromDate=$("#txtFromDate").val();
    	var toDate=$("#txtToDate").val();
    	
    	window.location.href=getContextPath()+"/exportFoodCostPerConsumptionData.html?fromDate="+fromDate+"&toDate="+toDate;
    }
    
    
    function funFillTable(objFoodCostBean)
	{
		 var table=document.getElementById("tblFoodCostPerConsumption");	    
		 var rowCount=table.rows.length;
		 var row = table.insertRow(rowCount);	
		    
		 row.insertCell(0).innerHTML = "<input readonly=\"readonly\" size=\"50%\" class=\"Box\"  style=\"text-align: left;  height:20px;\"   value='"+objFoodCostBean.strGroupName+"' />";
		 row.insertCell(1).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='"+objFoodCostBean.dblCostValue.toFixed(2)+"' />";
		 row.insertCell(2).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='"+objFoodCostBean.dblSaleValue.toFixed(2)+"' />";
		 row.insertCell(3).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='"+objFoodCostBean.dblFCPer.toFixed(2)+"' />";  
	}
    
    
    function funCallFormAction()
    {
    	
    	var fromDate=$("#txtFromDate").val();
    	var toDate=$("#txtToDate").val();
    	    	
    /* 	var dteFromDate = new Date(fromDate);
    	
    	var day=1;
    	var month=dteFromDate.getMonth()+1;
    	var year=dteFromDate.getFullYear();
    	
    	var strDate=year+"-"+month+"-"+day; */
    	
    	
    	

		$("#tblFoodCostPerConsumption").empty();
		
		
		var table=document.getElementById("tblFoodCostPerConsumption");	    
	    var rowCount=table.rows.length;
	    var row = table.insertRow(rowCount);	
	    
	    
	    
	    row.insertCell(0).innerHTML = "<input readonly=\"readonly\" size=\"50%\" class=\"Box\"  style=\"text-align: left;  height:20px;\"   value='GROUP NAME' />";
	    row.insertCell(1).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='COST VALUE' />";
	    row.insertCell(2).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='SALE VALUE' />";
	    row.insertCell(3).innerHTML = "<input readonly=\"readonly\" size=\"30%\" class=\"Box\"  style=\"text-align: right;  height:20px;\"   value='FOOD COST %' />";	    
		
		
	    var searchUrl = getContextPath()+ "/getFoodCostPerConsumptionData.html?formDate="+fromDate+"&toDate="+toDate;
			$.ajax({
					type : "GET",
					url : searchUrl,
					dataType : "json",
					async : false,
					success : function(response)
					{

						$.each(response, function(i,item)
						{				
							 funFillTable(item);				    			
						});
					},
					error : function(jqXHR, exception)
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
    
    
    $(function() 
    {
		$(document).ajaxStart(function()
		{
			$("#wait").css("display", "block");
		});
		$(document).ajaxComplete(function()
	    {
			$("#wait").css("display", "none");		});

		var startDate="${startDate}";
		var arr = startDate.split("/");
		Date1=arr[0]+"-"+arr[1]+"-"+arr[2];
		var startDateOfMonth="${startDateOfMonth}";
		
		$("#txtFromDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		$("#txtFromDate").datepicker('setDate', startDateOfMonth);

		$("#txtToDate").datepicker({
			dateFormat : 'dd-mm-yy'
		});
		$("#txtToDate").datepicker('setDate', 'today');

	});
    
    
	
	
	function funSetData(code)
	{			
		switch (fieldName) 
		{			   
		   case '':
		    	
		        break;
		}
	}	
	
	function funHelp(transactionName)
	{
		fieldName=transactionName;
		
		//window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	}
	
	
       
    </script>
  </head>
  
	<body >
	<div class="container masterTable">
		<label id="formHeading">Food Cost(As per consumtion)</label>
         <s:form name="frmFoodCostPerConsumption" id="frmFoodCostPerConsumption" method="GET" action="" >
		
		<div class="row">
			 <div class="col-md-2"><label>From Date</label>
				<s:input type="text" id="txtFromDate" path="dteFromDate" required="true" class="calenderTextBox" style="width:70%"/>
			</div>							
				
			 <div class="col-md-2"><label>To Date</label>
				<s:input type="text" id="txtToDate" path="dteToDate" required="true" class="calenderTextBox" style="width:70%"/>
			</div>
		</div>
						
			<%-- <tr>
				<td><label>Item Type</label></td>
				<td><s:select id="cmbItemType" items="${mapItemType}" 	name="cmbItemType" cssClass="BoxW124px" path="strProdType" />											
			</tr> --%>
		
			<p align="center">
				<input type="button" value="Submit" class="btn btn-primary center-block" class="form_button" onclick="funCallFormAction()" />
				&nbsp;
				<input type="button" value="Export" class="btn btn-primary center-block" class="form_button" onclick="funCallFormExport()" />
				&nbsp;
				<input type="button" value="Reset" class="btn btn-primary center-block" class="form_button"  onclick="funResetFields()"/>
			</p>
			
			<div style="background-color: #fafbfb;border: 1px solid #ccc;display: block; height: 400px;	margin: auto;overflow-x: hidden; overflow-y: scroll;width: 99%;">
				<!-- Dynamic Table Generation for tab4 (Opening Balance) -->
				<table id="tblFoodCostPerConsumption" class="transTablex" style="width: 100%">				
					<thead>
						<tr>												 					       
				   		</tr>
				   	</thead>
				   	<tbody>
				   	</tbody>			   						   	    				  
				</table>	
			</div>		
		</s:form>
		</div>
	</body>
</html>
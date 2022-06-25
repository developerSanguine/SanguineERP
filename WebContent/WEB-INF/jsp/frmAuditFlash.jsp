<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	
	    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />

		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

	<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>	
	<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/pagination.js"/>"></script>
        <!-- Load data to paginate -->
	<link rel="stylesheet" href="<spring:url value="/resources/css/pagination.css"/>" />
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript">
// var ExportData;
 var StkFlashData;
 
 /**
	 * Ready Function for Initialize textField with default value
	 * And Set date in date picker 
	 * And Getting session Value
	 */
 $(document).ready(function() 
			{
				var startDate="${startDate}";
				var startDateOfMonth="${startDateOfMonth}";
				//alert(startDate);
				var arr = startDate.split("/");
				Dat=arr[0]+"-"+arr[1]+"-"+arr[2];		
				$("#txtFromDate").datepicker({ dateFormat: 'dd-mm-yy' });
				$("#txtFromDate").datepicker('setDate',startDateOfMonth);			
				$("#txtToDate").datepicker({ dateFormat: 'dd-mm-yy' });
				$("#txtToDate").datepicker('setDate', 'today');
				var strPropCode='<%=session.getAttribute("propertyCode").toString()%>';
				var locationCode ='<%=session.getAttribute("locationCode").toString()%>';
				$("#cmbProperty").val(strPropCode);
				$("#cmbLocation").val(locationCode);
				$("#btnExecute").click(function( event )
				{
					
				});
				/**
				 * Ready Function for Ajax Waiting
				 */
				 $(document).ajaxStart(function(){
					    $("#wait").css("display","block");
					  });
					  $(document).ajaxComplete(function(){
					    $("#wait").css("display","none");
					  });
					  
					  if($("#cmbProperty").val()=="ALL")
						 {
						  	$("#cmbLocation").val("ALL");
						 }
					
			});
			
    /**
	 * Combo box change event
	 */
	 function funChangeLocationCombo()
		{
			var propCode=$("#cmbProperty").val();
			funFillLocationCombo(propCode);
		}
	
	 /**
	  * Fill Combo box change Property code
	 **/
	function funFillLocationCombo(propCode) 
	{
		var searchUrl = getContextPath() + "/loadLocationForProperty.html?propCode="+ propCode;
		$.ajax({
			type : "GET",
			url : searchUrl,
			dataType : "json",
			success : function(response) {
				var html = '<option value="ALL">ALL</option>';
				$.each(response, function(key, value) {
					html += '<option value="' + value[1] + '">'+value[0]
							+ '</option>';
				});
				html += '</option>';
				$('#cmbLocation').html(html);
			},
			error: function(jqXHR, exception) {
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
 
 
	//Pagination Data
	 function showTable()
		{
			var optInit = getOptionsFromForm();
		    $("#Pagination").pagination(StkFlashData.length, optInit);
		   
		}

	var items_per_page = 10;
	function getOptionsFromForm(){
	    var opt = {callback: pageselectCallback};
		opt['items_per_page'] = items_per_page;
		opt['num_display_entries'] = 10;
		opt['num_edge_entries'] = 3;
		opt['prev_text'] = "Prev";
		opt['next_text'] = "Next";
	    return opt;
	}
	
		function pageselectCallback(page_index, jq)
		{
		    // Get number of elements per pagionation page from form
		    var max_elem = Math.min((page_index+1) * items_per_page, StkFlashData.length);
		    var newcontent="";
		    var combo1 = document.getElementById("cmbReportType");
		    var rptType = combo1.options[combo1.selectedIndex].text
		    
		    var combo2 = document.getElementById("cmbTransType");
		    var TransType = combo2.options[combo2.selectedIndex].text
		  /**
		   *Checking Report type and transaction type and create and fill table
		  **/
		    if(rptType=="Edited")
			{
		    	if(TransType=="GRN(Good Receiving Note)")
		    	   {
		    				 TransType=TransType.replace(/\s/g,"%20");
					    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">GRN Code</td><td id="labld2">Date</td><td id="labld3">Supplier Code</td><td id="labld4">Supplier Name</td><td id="labld5">Loc Code</td><td id="labld6">Location Name</td><td id="labld7">Bill No.</td><td id="labld8">Pay Mode</td><td>Total Amt</td><td id="labld9">User Created</td><td id="labld10">User Modified</td><td id="labld11">Date Created</td><td id="labld12">Last Modified</td></tr>';
					    	// Iterate through a selection of the content and build an HTML string
						    for(var i=page_index*items_per_page;i<max_elem;i++)
						    {
						    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
						        newcontent += '<td align="right">'+StkFlashData[i][8]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][10]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][11]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][12]+'</td></tr>';
						       
						    }
			    	
		    	}
		    if(TransType== "Opening Stock")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Opening Stock Code</td><td id="labld2">Loc Code</td><td id="labld3">Location Name</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType== "Physical Stk Posting")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Physical Stock Code</td><td id="labld2">Date</td><td id="labld3">Location Code</td><td id="labld4">Location Name</td><td id="labld5">SA Code</td><td id="labld6">User Created</td><td id="labld7">User Modified</td><td id="labld8">Created Date</td><td id="labld9">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType== "Production Order")
		    	{
		    	TransType=TransType.replace(/\s/g,"%20");
		    	}
		    if(TransType== "Purchase Indent")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">PI Code</td><td id="labld2">Date</td><td id="labld3">Location Code</td><td id="labld4">Location Name</td><td id="labld5">Narration</td><td id="labld6">Total Amt</td><td id="labld7">User Created</td><td id="labld8">User Modified</td><td id="labld9">Created Date</td><td id="labld10">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType== "Purchase Order")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");																														    	
			    	newcontent = '<table  id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">PO Code</td><td id="labld2">Date</td><td id="labld3">Supplier Code</td><td id="labld4">Supplier Name</td><td id="labld5">Against</td><td id="labld6">Total Amt</td><td id="labld7">User Created</td><td id="labld8">User Modified</td><td id="labld9">Created Date</td><td id="labld10">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType=="Purchase Return")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1">PR Code</td><td id="labld2">Date</td><td id="labld3">Against</td><td id="labld5">Narration</td><td id="labld6">Supp Code</td><td id="labld7">Supplier Name</td><td id="labld8">Total Amt</td><td id="labld9">User Created</td><td id="labld10">User Modified</td><td id="labld11">Date Created</td><td id="labld10">Last Modified</td></tr>';
				    // Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td> </tr>';
				    }
		    	}
		    if(TransType=="Stock Adjustment")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
		    	 	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1">SA Code</td><td id="labld2">Date</td><td id="labld3">Loc Code</td><td id="labld4">Location Name</td><td id="labld5">Narration</td><td id="labld6">Total Amt</td><td id="labld7">User Created</td><td id="labld8">User Modified</td><td id="labld9">Date Created</td><td id="labld10">Last Modified</td></tr>';
				    // Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td> </tr>';
				    }
		    	}
		    if(TransType=="Stock Transfer")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">ST Code</td><td id="labld2">Date</td><td id="labld3">From Location</td><td id="labld4">To Location</td><td id="labld5">Against</td><td id="labld6">Material Issue</td><td id="labld7">Narration</td><td id="labld8">User Created</td><td id="labld9">User Modified</td><td id="labld10">Created Date</td><td id="labld11">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType=="Work Order")
		    	{
		    	TransType=TransType.replace(/\s/g,"%20");
		    	}
		    if(TransType=="Material Return")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Material Return Code</td><td id="labld2">Date</td><td id="labld3">From Location</td><td id="labld4">To Location</td><td id="labld5">Against</td><td id="labld6">MIS Code</td><td id="labld7">Narration</td><td id="labld8">User Created</td><td id="labld9">User Modified</td><td id="labld10">Created Date</td><td id="labld11">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
			    	for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	/* newcontent += '<tr><td>'+StkFlashData[i][0]+'</td>'; */
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td></tr>';
				    }
		    	}
		    if(TransType=="Material Issue Slip")
		    	{
		    		
			    	
				    TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">MIS Code</td><td id="labld2">Date</td><td id="labld3">From Location</td><td id="labld4">From LocName</td><td id="labld5">To Location</td><td id="labld6">To LocName</td><td id="labld7">Bill No</td><td id="labld8">Pay Mode</td><td id="labld9">Total Amt</td><td id="labld10">User Created</td><td id="labld11">User Modified</td><td id="labld12">Created Date</td><td id="labld13">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td >'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][11]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][12]+'</td></tr>';
				       
				    }
		    	}
		    if(TransType=="Material Requisition")
		    	{
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Req Code</td><td id="labld2">Date</td><td id="labld3">From Location</td><td id="labld4">To Location</td><td id="labld5">Against</td><td id="labld6">Total Amt</td><td id="labld7">Narration</td><td id="labld8">User Created</td><td id="labld9">User Modified</td><td id="labld10">Created Date</td><td id="labld11">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td></tr>';
				       
				    }
		    	}
		    
		    if(TransType=="Invoice")
	    	{
		    	
			    TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1">Invoice Code</td><td id="labld2">Date</td><td id="labld3">Loc Code</td><td id="labld4">Location Name</td><td id="labld5">Bill No</td><td id="labld6">Pay Mode</td><td id="labld7">Total Amt</td><td id="labld8">User Created</td><td id="labld9">User Modified</td><td id="labld10">Date Created</td><td id="labld11">Last Modified</td></tr>';
			    // Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {

			    	var invoiceUrl=funOpenInvoiceFormat();
			    	newcontent += '<tr><td><a href='+invoiceUrl+'\.html?rptInvCode='+StkFlashData[i][0]+'&rptInvDate='+StkFlashData[i][1]+'\ target="\_blank\"  id="\StrInvCode."+(rowCount)+"\" >'+StkFlashData[i][0]+'</a></td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][10]+'</td></tr>';
			    }	
	    	}
		    if(TransType=="Product Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Product Code</td><td id="labld2">ProductName</td><td id="labld3">ProductType</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strProdCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Recipe Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Recipe Code</td><td id="labld2">ParentCode</td><td id="labld3">ProductName</td><td id="labld4">Valid From</td><td id="labld5">Valid To</td><td id="labld6">User Created</td><td id="labld7">User Modified</td><td id="labld8">Created Date</td><td id="labld9">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strBOMCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][8]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Country Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Country Code</td><td id="labld2">Country Name</td><td id="labld3">User Created</td><td id="labld4">User Modified</td><td id="labld5">Created Date</td><td id="labld6">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strCountryCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Tax Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Tax Code</td><td id="labld2">Tax Desc</td><td id="labld3">TaxOnSP</td><td id="labld4">Tax Type</td><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTaxCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td></tr>';
			       
			    }
	    	}
		    
		    if(TransType=="UD Report Category Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">UDCCode</td><td id="labld2">UDC Name</td><td id="labld3">UDC Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strUDCCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="User Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">User Code</td><td id="labld2">User Name</td><td id="labld3">Supper User</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strUserCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Property Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Property Code</td><td id="labld2">Property Name</td><td id="labld3">User Created</td><td id="labld4">User Modified</td><td id="labld5">Created Date</td><td id="labld6">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strPropertyCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Location Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Location Code</td><td id="labld2">Location Name</td><td id="labld3">Description</td><td id="labld4">Active</td><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strLocCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Property Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Product Code</td><td id="labld2">ProductName</td><td id="labld3">ProductType</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strProdCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Session Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Session Code</td><td id="labld2">Session Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6>Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strSessionCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Excise Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Excise Code</td><td id="labld2">ExciseChapterNo</td><td id="labld3">Rank</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strExciseCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Recipe Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Product Code</td><td id="labld2">ProductName</td><td id="labld3">ProductType</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strProdCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Sub Group Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Sub Group Code</td><td id="labld2">Sub Group Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strSGCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    
		    if(TransType=="Group Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Group Code</td><td id="labld2">Group Name</td><td id="labld3">Group Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strGCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    
		    if(TransType=="Report Group Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Report Group Code</td><td id="labld2">Report Group Name</td><td id="labld3">Property Code</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strReportGroupCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="TC Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">TC Code</td><td id="labld2">TC Name</td><td id="labld3">Applicable</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTCCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Route Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Route Code</td><td id="labld2">Route Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strRouteCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    
		    if(TransType=="Budget Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Budget Code</td><td id="labld2">Property Code</td><td id="labld3">Financial Year</td><td id="labld4"><td id="labld5">Start Month</td><td id="labld6">User Created</td><td id="labld7">User Modified</td><td id="labld8">Created Date</td><td id="labld9">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strBudgetCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="City Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">City Code</td><td id="labld2">City Name</td><td id="labld3">Country Cose</td><td id="labld4"><td id="labld5">State Code</td><td id="labld6">User Created</td><td id="labld7">User Modified</td><td id="labld8">Created Date</td><td id="labld9">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strCityCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Manufacture Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Manufacturer Code</td><td id="labld2">Manufacturer Name</td><td id="labld3">User Created</td><td id="labld4">User Modified</td><td id="labld5">Created Date</td><td id="labld6">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strManufacturerCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Reason Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Reason Code</td><td id="labld2">Reason Name</td><td id="labld3">Reason Desc</td><td id="labld4">Follow Ups</td><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strReasonCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][7]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Transporter Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Trans Code</td><td id="labld2">Trans Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Attribute Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Attribute Code</td><td id="labld2">Attribute Name</td><td id="labld3">Attribute Type</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strAttCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Vehicle Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Vehicle Code</td><td id="labld2">Vehicle Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strVehCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Vehicle Route Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Route Code</td><td id="labld2">Vehicle Code</td><td id="labld3">User Created</td><td id="labld4">User Modified</td><td id="labld5">Created Date</td><td id="labld6">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strRouteCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][5]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Settlement Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Settlement Code</td><td id="labld2">Settlement Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strSettlementCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Supplier Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Supplier Code</td><td id="labld2">Supplier Name</td><td id="labld3">Supplier Type</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strPCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Process Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Process Code</td><td id="labld2">Process Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strProcessCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="State Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">State Code</td><td id="labld2">State Name</td><td id="labld3">Description</td><td id="labld4">User Created</td><td id="labld5">User Modified</td><td id="labld6">Created Date</td><td id="labld7">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strStateCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="UOM Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">UOM Name</td><td id="labld2">ClientCode</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strUOMName='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Characteristics Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Characteristics Code</td><td id="labld2">Name</td><td id="labld3">Type</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strCharCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
		    if(TransType=="Currency Master")
	    	{
	    		TransType=TransType.replace(/\s/g,"%20");
		    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">Currency Code</td><td id="labld2">Currency Name</td><td id="labld3">Bank Name</td><td id="labld4"><td id="labld5">User Created</td><td id="labld6">User Modified</td><td id="labld7">Created Date</td><td id="labld8">Last Modified</td></tr>';
		    	// Iterate through a selection of the content and build an HTML string
			    for(var i=page_index*items_per_page;i<max_elem;i++)
			    {
			    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strCurrencyCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
			        newcontent += '<td align="right">'+StkFlashData[i][5]+'</td>';
			        newcontent += '<td>'+StkFlashData[i][6]+'</td></tr>';
			       
			    }
	    	}
			}
		    if(rptType=="Deleted")
			{
		    	if(TransType=="Material Issue Slip")
		    	   {
		    		
		    		TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">MIS Code</td><td id="labld2">Date</td><td id="labld3">From Location</td><td id="labld4">From LocName</td><td id="labld5">To Location</td><td id="labld6">To LocName</td><td id="labld7">Bill No</td><td id="labld8">Pay Mode</td><td id="labld9">Total Amt</td><td id="labld10">User Created</td><td id="labld11">User Modified</td><td id="labld12">Created Date</td><td id="labld13">Last Modified</td></tr>';
			    	// Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {
				    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td >'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][11]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][12]+'</td></tr>';
				       
				    }
		    	   }
		    	
		    	if(TransType=="Invoice")
		    	{
			    	
				    TransType=TransType.replace(/\s/g,"%20");
			    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1">Invoice Code</td><td id="labld2">Date</td><td id="labld3">Loc Code</td><td id="labld4">Location Name</td><td id="labld5">Bill No</td><td id="labld6">Pay Mode</td><td id="labld7">Total Amt</td><td id="labld8">User Created</td><td id="labld9">User Modified</td><td id="labld10">Date Created</td><td id="labld11">Last Modified</td></tr>';
				    // Iterate through a selection of the content and build an HTML string
				    for(var i=page_index*items_per_page;i<max_elem;i++)
				    {

				    	var invoiceUrl=funOpenInvoiceFormat();
				    	newcontent += '<tr><td><a href='+invoiceUrl+'\.html?rptInvCode='+StkFlashData[i][0]+'&rptInvDate='+StkFlashData[i][1]+'\ target="\_blank\"  id="\StrInvCode."+(rowCount)+"\" >'+StkFlashData[i][0]+'</a></td>';
				        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
				        newcontent += '<td align="right">'+StkFlashData[i][6]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][8]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
				        newcontent += '<td>'+StkFlashData[i][10]+'</td></tr>';
				    }	
		    	}
		    	if(TransType=="GRN(Good Receiving Note)")
		    	   {
		    				 TransType=TransType.replace(/\s/g,"%20");
					    	newcontent = '<table id="tblAuditFlash" class="transTablex" style="width: 100%;font-size:11px;font-weight: bold;"><tr bgcolor="#c0c0c0"><td id="labld1" size="10%">GRN Code</td><td id="labld2">Date</td><td id="labld3">Supplier Code</td><td id="labld4">Supplier Name</td><td id="labld5">Loc Code</td><td id="labld6">Location Name</td><td id="labld7">Bill No.</td><td id="labld8">Pay Mode</td><td>Total Amt</td><td id="labld9">User Created</td><td id="labld10">User Modified</td><td id="labld11">Date Created</td><td id="labld12">Last Modified</td></tr>';
					    	// Iterate through a selection of the content and build an HTML string
						    for(var i=page_index*items_per_page;i<max_elem;i++)
						    {
						    	newcontent += '<tr><td><a href='+getContextPath()+'/funOpenAuditRptSlip.html?strTransCode='+StkFlashData[i][0]+'&TransType='+TransType+'&TransMode=Edited target="_blank">'+StkFlashData[i][0]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][1]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][2]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][3]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][4]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][5]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][6]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][7]+'</td>';
						        newcontent += '<td align="right">'+StkFlashData[i][8]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][9]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][10]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][11]+'</td>';
						        newcontent += '<td>'+StkFlashData[i][12]+'</td></tr>';
						       
						    }
			    	
		    	}
		    	
			}
		     newcontent += '</table>';
		    // Replace old content with new content
		    $('#Searchresult').html(newcontent);
		   
		    // Prevent click eventpropagation
		    return false;
		}
		
		/**
		 * Geting Audit flash Data based on filter
		**/
		function funGetAuditFlashData()
		{			
			var fromDate=$("#txtFromDate").val();
			var toDate=$("#txtToDate").val();
			var locCode=$("#cmbLocation").val();
			var propCode=$("#cmbProperty").val();
		    var combo1 = document.getElementById("cmbReportType");
			var rptType = combo1.options[combo1.selectedIndex].text
		    var combo2 = document.getElementById("cmbTransType");
		    var TransType = combo2.options[combo2.selectedIndex].text
			var param1=locCode+","+propCode+","+TransType+","+rptType;	
		   
			var searchUrl=getContextPath()+"/frmAuditFlashReport.html?param1="+param1+"&fDate="+fromDate+"&tDate="+toDate;
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	StkFlashData=response;
				    	showTable();
				    	
				    },
				    error: function(jqXHR, exception) {
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
		
	
		/**
		 * Excel Export
		**/
		 $(document).ready(function () {
		 $("#btnExport").click(function() {  
			  var dtltbl = $('#dvStock').html(); 
			  window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#Searchresult').html()));
			});
		 }); 
		 
		
		 function funOpenInvoiceFormat()
			{
				var invPath="";
					invoiceformat='<%=session.getAttribute("invoieFormat").toString()%>';
					if(invoiceformat=="Format 1")
						{
							invPath="openRptInvoiceSlip";
							
						}
					else if(invoiceformat=="Format 2")
						{
							invPath="rptInvoiceSlipFromat2";
						}
					else if(invoiceformat=="Format 5")
						{
							invPath="rptInvoiceSlipFormat5Report";
						}
					else if(invoiceformat=="RetailNonGSTA4"){
						 invPath="openRptInvoiceRetailNonGSTReport";
						}
					else if("Format 6")
						{
							invPath="rptInvoiceSlipFormat6ReportForAudit";
						}
						else
					    {
							invPath="rptInvoiceSlipFormat6ReportForAudit";
					    }
				return invPath;
			}
		 function onClick()
		 {
			 funGetAuditFlashData();
			 return false;
		 }
		 
	</script>
</head>
<body>
<div class="container">
		<label id="formHeading">Audit Flash</label>
		<s:form action="frmAuditFlash.html" method="GET" name="frmAuditFlash">
		<br>
			<div class="row transTable">
				<div class="col-md-2">	
					<label>Property Name</label>
					<s:select id="cmbProperty" name="propCode" path="strPropertyCode" onchange="funChangeLocationCombo();">
				    	<s:options items="${listProperty}"/>
				    </s:select>
				</div>		
				<div class="col-md-2">		
					<label>Location</label>
					<s:select id="cmbLocation" name="locCode" path="strLocationCode">
			    		<s:options items="${listLocation}"/>
			    	</s:select>
				</div>
				
				<div class="col-md-2">		
					<label>Report Type</label>
					<s:select id="cmbReportType" path="">
						  <option value="Edited">Edited</option>
						  <option value="Deleted">Deleted</option>
					</s:select>
			    </div>		
				<div class="col-md-2">	
					<label>Transaction Type</label>
					<s:select id="cmbTransType" path="">
						<s:options items="${listAuditName}"/>
					</s:select>
			    </div>	
			    <div class="col-md-4"></div>	
				<div class="col-md-2">		
					<label id="lblFromDate">From Date</label>
			      	<s:input id="txtFromDate" name="fromDate" path="" cssClass="calenderTextBox" style="width:80%;"/>
			     </div> 
				 <div class="col-md-2">      
			        <label id="lblToDate">To Date</label>
			        <s:input id="txtToDate" name="toDate" path="" cssClass="calenderTextBox" style="width:80%;"/>
			     </div>
			     
				<div class="col-md-2"> 	
					<s:select path="strExportType" id="cmbExportType"  cssClass="BoxW124px" style="margin-top:26px; width:80%;">
						<option value="Excel">Excel</option>
					</s:select>	
				</div>
			</div>
			<div class="center" style="margin-right:40%;">
				<a href="#"><button class="btn btn-primary center-block" id="btnExecute" value="Execute" onclick="return onClick()" >Execute</button></a>&nbsp
			 	<a href="#"><button class="btn btn-primary center-block" id="btnExport" value="Export">Export</button></a>
			 </div>
			
		<br><br>
			<dl id="Searchresult" style="padding-left: 26px;overflow:auto;width: 95%"></dl>
			<div id="Pagination" class="pagination" style="padding-left: 26px;"></div>
		
			<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
				<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
			</div>
	</s:form>
</div>
</body>
</html>
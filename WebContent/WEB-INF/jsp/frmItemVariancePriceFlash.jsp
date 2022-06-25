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
	
<title>Insert title here</title>

<style type="text/css">
	#tblTransFlash tbody tr:first-child{
		background:#c0c0c0;
	}
	#tblTransFlash tbody{
		background:#fbfafa;
	}
	#tblTransFlash tbody td{
	border:1px solid #000;
	}
</style>	
	
<script type="text/javascript">
    var loggedInProperty="",loggedInLocation="";
    
 			//Ajax Waiting
   			$(document).ready(function() 
    		{
    			$(document).ajaxStart(function()
    		 	{
    			    $("#wait").css("display","block");
    		  	});
    		 	
    			$(document).ajaxComplete(function()
    			{
    			    $("#wait").css("display","none");
    			});	
    		});
 			
   		    //Set Date in date picker with default Value
    		$(document).ready(function() 
			{
				var startDate="${startDate}";
				var startDateOfMonth="${startDateOfMonth}";
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
				
				/*** Ready Function for Ajax Waiting
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
   		    
   		    
    		$(document).ready(function () 
    				{			 
    					$("#btnExport").click(function (e)
    					{
    					
    						var fromDate=$("#txtFromDate").val();
    						var toDate=$("#txtToDate").val();
    						var locCode=$("#cmbLocation").val();
    						var propCode=$("#cmbProperty").val();
    										
    							
    						window.location.href=getContextPath()+"/itemVarianceReportExcel.html?fDate="+fromDate+"&tDate="+toDate+"&propCode="+propCode+"&locCode="+locCode;
    							
    						
    								});
    				});

    		
   		    //Open Help
    		function funHelp(transactionName)
    		{
    			fieldName=transactionName;
    		//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
    			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
    	    }
    		
   		    //Get Product Data based on help selection 
    		function funSetProduct(code)
    		{
    			var searchUrl="";
    			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
    			$.ajax
    			({
    		        type: "GET",
    		        url: searchUrl,
    			    dataType: "json",
    			    success: function(response)
    			    {
    			    	if ('Invalid Code' == response.strProdCode) {
							alert('Invalid Product Code');
							$("#txtProdCode").val('');
	    		        	$("#lblProdName").text('');
    			    	}
    			    	else
    			    	{
	    			    	$("#txtProdCode").val(response.strProdCode);
	    		        	$("#lblProdName").text(response.strProdName);
    			    	}
    			    },
    				error: function(e)
    			    {
    			       	alert('Error:=' + e);
    			    }
    		    });
    		}
   		    
    		
    		//Get and Set Data from Help Selection 
    		function funSetData(code)
    		{
    			switch (fieldName) 
    			{			        
    			    case 'productmaster':
    			    	funSetProduct(code);
    			        break;
    			    case 'suppcode':
    			    	funSetSupplier(code);
    			        break;
    			}
    		}
    		
    		//Get and Set Supplier Data based on passing value(supplier Code) 
    		function funSetSupplier(code) {
				var searchUrl = "";
				searchUrl = getContextPath()
						+ "/loadSupplierMasterData.html?partyCode=" + code;

				$.ajax({
					type : "GET",
					url : searchUrl,
					dataType : "json",
					success : function(response) {
						if ('Invalid Code' == response.strPCode) {
							alert('Invalid Supplier Code');
							$("#txtSuppCode").val('');
							$("#txtSuppName").text('');
							$("#txtSuppCode").focus();
						} else {
							$("#txtSuppCode").val(response.strPCode);
							$("#txtSuppName").text(response.strPName);
						}
					},
					error : function(jqXHR, exception) {
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
    		
    		//On blur Event TextField
    		
    		
    function funOnClickExcecute()
			{
				
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var table = document.getElementById("tblTransFlash");
				var rowCount = table.rows.length;
				while(rowCount>0)
				{
					table.deleteRow(0);
					rowCount--;
				}
				
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var locCode=$("#cmbLocation").val();
				var propCode=$("#cmbProperty").val();
				
				funGetItemVarianceFlash(fromDate,toDate,locCode,propCode);
				
				return false;
			}
    		
    		function funGetItemVarianceFlash(fromDate,toDate,locCode,propCode)
    		{
    			var searchUrl=getContextPath()+"/frmItemVarianceReport.html?locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate+"&propCode="+propCode;
    			
    			$.ajax({
    			        type: "GET",
    			        url: searchUrl,
    				    dataType: "json",
    				    success: function(response)
    				    {
    				    	funShowItemVarianceFlash(response);
    				    	document.all[ 'dvTranswise' ].style.display = 'none';
    				    	document.all[ 'dvTransFlash' ].style.display = 'block';
    				    },
    					error: function(e)
    				    {
    				       	alert('Error:=' + e);
    				    }
    			      });
    		}
			
    		function funShowItemVarianceFlash(response)
    		{
    					
    			var table = document.getElementById("tblTransFlash");
    			var rowCount = table.rows.length;
    		    var row = table.insertRow(rowCount);
    		   
    			row.insertCell(0).innerHTML= "<label>Location Code</label>";
    			row.insertCell(1).innerHTML= "<label>Product Code</label>";
    			row.insertCell(2).innerHTML= "<label>product Name</label>";
    			row.insertCell(3).innerHTML= "<label>UOM</label>";
    			row.insertCell(4).innerHTML= "<label>Cost RM</label>";
    			row.insertCell(5).innerHTML= "<label>Actual Consumption</label>";
    			row.insertCell(6).innerHTML= "<label>Actual Consumption Value</label>";
    			row.insertCell(7).innerHTML= "<label>Potential Consumption Qty</label>";
    			row.insertCell(8).innerHTML= "<label>Potential Consumption Value</label>";
    			row.insertCell(9).innerHTML= "<label>Variance Qty</label>";
    			row.insertCell(10).innerHTML= "<label>Variance Value</label>";
    			row.insertCell(11).innerHTML= "<label>Variance Percentage</label>";
    			
    		
    			rowCount=rowCount+1;
    			//var records = [];
    			var fDate=$("#txtFromDate").val();
    			var tDate=$("#txtToDate").val();
    			var locCode=$("#cmbLocation").val();
    			var propCode=$("#cmbProperty").val();
    			
    			$.each(response, function(i,item)
    			{
    				var row1 = table.insertRow(rowCount);
    				if(item[1]!=0)
    				{
    					row1.insertCell(0).innerHTML= "<label>"+item[0]+"</label>";
    					row1.insertCell(1).innerHTML= "<label>"+item[1]+"</label>";
    					row1.insertCell(2).innerHTML= "<label>"+item[2]+"</label>";
    			   		row1.insertCell(3).innerHTML= "<label>"+item[3]+"</label>";
    			   		row1.insertCell(4).innerHTML= "<label>"+item[4]+"</label>";
    			   		row1.insertCell(5).innerHTML= "<label>"+item[5]+"</label>";
    					row1.insertCell(6).innerHTML= "<label>"+item[6]+"</label>";
    					row1.insertCell(7).innerHTML= "<label>"+item[7]+"</label>";
    			   		row1.insertCell(8).innerHTML= "<label>"+item[8]+"</label>";
    			   		row1.insertCell(9).innerHTML= "<label>"+item[9]+"</label>";
    			   		row1.insertCell(10).innerHTML= "<label>"+item[10]+"</label>";
    					row1.insertCell(11).innerHTML= "<label>"+item[11]+"</label>";
    					
    				  
    				}
    			});
    			
    			
    		}
    		
    		
    		
    		function funChangeLocationCombo() {
    			var propCode = $("#cmbProperty").val();
    			funFillLocationCombo(propCode);
    		}

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
    		
    		//Reset field
    		function funResetFields()
    		{
    			location.reload(true); 
    		}
    </script>
</head>

<body onload="funOnLoad();">
	<div class="container">
		<label id="formHeading">Items Variance Report</label>
		
	
	  <s:form action="frmItemVariancePriceFlash.html" method="GET" name="frmItemVariancePriceFlash" id="frmItemVariancePriceFlash">
		
	
		<div class="row transTable">
			
			<div class="col-md-2">
				<label>Property Code</label>
				<s:select id="cmbProperty" name="propCode" path="strPropertyCode" onchange="funChangeLocationCombo();">
			    	<s:options items="${listProperty}"/>
			 	</s:select>
			 </div>
			<div class="col-md-2">
				<label>Location</label>
				<s:select id="cmbLocation" name="locCode" path="strLocationCode">
			    	<s:options items="${listLocation}" />
			    </s:select>
			</div>	
			<div class="col-md-2">
				<label id="lblFromDate">From Date</label>
			     <s:input id="txtFromDate" name="fromDate" path="dtFromDate" cssClass="calenderTextBox" style="width:70%;"/>
			      <s:errors path="dtFromDate"></s:errors>
			 </div> 
			 <div class="col-md-2">   
				<label id="lblToDate">To Date</label>
			  	<s:input id="txtToDate" name="toDate" path="dtToDate" cssClass="calenderTextBox" style="width:70%;"/>
			    <s:errors path="dtToDate"></s:errors>
			 </div> 
			<div class="col-md-2"> 	
					<label>Report Type</label>
					<s:select id="cmbDocType" path="strDocType" cssClass="BoxW124px">
				    	<s:option value="XLS">EXCEL</s:option>
				    </s:select>
			</div>		
			
		</div>
		<div class="center" style="margin-right: 40%;">
			<a href="#"><button class="btn btn-primary center-block" id="btnExecute" value="Execute" onclick="return funOnClickExcecute()"
				>Execute</button></a>
			<button type="button" class="btn btn-primary center-block" id="btnExport" value="Export">Export</button>&nbsp
			<a href="#"><button class="btn btn-primary center-block"  value="Reset" onclick="funResetFields()">Reset</button></a>
		</div>	
		
		<div id="dvTransFlash" style="width: 100% ;height: 100% ; display: none;">
			<table id="tblTransFlash" class="transTable col13-right col14-right col15-right col16-right col17-right col18-right col19-right col20-right col21-right col22-right col23-right col24-right "></table>
		</div>
		
		<div id="dvTranswise" style="width: 100% ;height: 100% ; display: none;" >
			<table id="tblTranswise" class="transTable col5-right col6-right col7-right col8-right col9-right"></table>
		</div>
			
		<div id="wait"
			style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
			<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif"
				width="60px" height="60px" />
		</div>
	</s:form>
	
</div>
</body>
</html>
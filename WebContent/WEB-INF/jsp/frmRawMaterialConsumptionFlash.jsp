<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	
	    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />

		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	
	<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
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
	
	<style type="text/css">
	#tblTransFlashDetail tbody tr:first-child{
		background:#c0c0c0;
	}
	#tblTransFlashDetail tbody{
		background:#fbfafa;
	}
	#tblTransFlashDetail tbody td{
	border:1px solid #000;
	}
</style>	
	
	
	<script>

		$(function ()
		{
			var startDate="${startDate}";
			var startDateOfMonth="${startDateOfMonth}";
			var arr = startDate.split("/");
			Dat=arr[0]+"-"+arr[1]+"-"+arr[2];
			$( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtFromDate" ).datepicker('setDate', startDateOfMonth);
			$( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtToDate" ).datepicker('setDate', 'today');
			 var strPropCode='<%=session.getAttribute("propertyCode").toString()%>';
			 var locationCode ='<%=session.getAttribute("locationCode").toString()%>';
			 $("#cmbProperty").val(strPropCode);
			 $("#cmbLocation").val(locationCode);
			 var transecExportType='';
			
			

			$('a#urlDocCode').click(function() 
			{
			    $(this).attr('target', '_blank');
			});
			

			$('#prodCode').blur(function() {
				var code = $('#prodCode').val();
				if(code.trim().length > 0 && code !="?" && code !="/"){
					funSetData(code);
				}
			});
			
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
					var prodCode=$("#txtProdCode").val();
					funGetTransFlash(fromDate,toDate,locCode,prodCode);
					
					return false;
				}
				
		
		
		function funGetTransFlash(fromDate,toDate,locCode,prodCode)
		{
			if(prodCode=='')
				{
					prodCode='All';
				}
			var searchUrl=getContextPath()+"/frmRMCReport.html?locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate+"&prodCode="+prodCode;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funShowTransFlash(response);
				    	document.all[ 'dvTransFlashDetail' ].style.display = 'none';
				    	document.all[ 'dvTransFlash' ].style.display = 'block';
				    },
					error: function(e)
				    {
				       	alert('Error:=' + e);
				    }
			      });
		}
		
		
		
		function sortFunction(a, b) {
			var dateA = getDate(a).getTime();
			var dateB = getDate(b).getTime();
			return dateA < dateB ? 1 : -1;
		}

		function getDate(obj) {
			var parts = obj.tran_date.split('-');
			return new Date(parts[2], parts[1] - 1, parts[0]);
		}

		function funGetDate(date, format) {
			var retDate = '';
			if (format == 'dd-MM-yyyy') {
				var arr = date.split('-');
				retDate = arr[2] + "-" + arr[1] + "-" + arr[0];
			} else if (format == 'dd/MM/yyyy') {
				var arr = date.split('/');
				retDate = arr[2] + "-" + arr[1] + "-" + arr[0];
			}
			return retDate;
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
		
		function funShowTransFlash(response)
		{
					
			var table = document.getElementById("tblTransFlash");
			var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		   
			row.insertCell(0).innerHTML= "<label>Raw Material Code</label>";
			row.insertCell(1).innerHTML= "<label>Raw Material Name</label>";
			row.insertCell(2).innerHTML= "<label>Location Name</label>";
			row.insertCell(3).innerHTML= "<label>Raw Material Qty</label>";
			row.insertCell(4).innerHTML= "<label>Finished Product Code</label>";
			row.insertCell(5).innerHTML= "<label>Finished Product Name</label>";
			row.insertCell(6).innerHTML= "<label>Finished Product Qty</label>";
			row.insertCell(7).innerHTML= "<label>Recipe Conversion</label>";
			
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
				  
				}
			});
			
			
		}
		
		
		
		function funOnClickExcecuteDetail()
		{
			
			var fromDate=$("#txtFromDate").val();
			var toDate=$("#txtToDate").val();
			var table = document.getElementById("tblTransFlashDetail");
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
			var prodCode=$("#txtProdCode").val();
			funGetTransFlashDetail(fromDate,toDate,locCode,prodCode);
			
			return false;
		}
		
		
		function funGetTransFlashDetail(fromDate,toDate,locCode,prodCode)
		{
			if(prodCode=='')
				{
					prodCode='All';
				}
			var searchUrl=getContextPath()+"/frmRMCReportDetail.html?locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate+"&prodCode="+prodCode;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funShowTransFlashDetail(response);
				    	document.all[ 'dvTransFlash' ].style.display = 'none';
				    	document.all[ 'dvTransFlashDetail'].style.display = 'block';
				    },
					error: function(e)
				    {
				       	alert('Error:=' + e);
				    }
			      });
		}
		

		function funShowTransFlashDetail(response)
		{
					
			var table = document.getElementById("tblTransFlashDetail");
			var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		   
			row.insertCell(0).innerHTML= "<label>Raw Material Code</label>";
			row.insertCell(1).innerHTML= "<label>Raw Material Name</label>";
			row.insertCell(2).innerHTML= "<label>Location Name</label>";
			row.insertCell(3).innerHTML= "<label>Stk Adj Code</label>";
			row.insertCell(4).innerHTML= "<label> Stk Adj Date</label>";
			row.insertCell(5).innerHTML= "<label>Raw Material Qty</label>";
			row.insertCell(6).innerHTML= "<label>Display Qty</label>";
			row.insertCell(7).innerHTML= "<label>Finished Product Code</label>";
			row.insertCell(8).innerHTML= "<label>Finished Product Name</label>";
			row.insertCell(9).innerHTML= "<label>Finished Product Qty</label>";
			row.insertCell(10).innerHTML= "<label>Recipe Conversion</label>";
			
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
				  
				}
			});
			
		}
		
		
		$(document).ready(function() 
				{
					var startDate="${startDate}";
					var arr = startDate.split("/");
					 
					var date = new Date(); 
					var month=date.getMonth()+1;
		            Dat= 1 +"-"+month+"-"+date.getFullYear();
					
					$("#txtFromDate").datepicker({ dateFormat: 'dd-mm-yy' });
					$("#txtFromDate").datepicker('setDate',Dat);
					$("#txtToDate").datepicker({ dateFormat: 'dd-mm-yy' });
					$("#txtToDate").datepicker('setDate', 'today');
					$("#cmbLocation").val("${locationCode}");
					
					$("#btnExecute").click(function( event )
					{
						var fromDate=$("#txtFromDate").val();
						var toDate=$("#txtToDate").val();
						if($("#cmbReportType").val()=='Detail')
						{
							funOnClickExcecuteDetail();
							
						}
						
						if($("#cmbReportType").val()=='Summary')
						{
							funOnClickExcecute();
							
						}
					
						
					});
					
					function funAddReprtType()
					{
			        	var cSelectReport = document.getElementById("cmbReportType"); 
			        	while (cSelectReport.options.length > 0) 
				       	{ 
			        		cSelectReport.remove(0); 
				       	} 
			        
			        	cSelectReport.add(new Option('Detail'));
			        	cSelectReport.add(new Option('Summary'));
			        	 
					}
						
						
					$(document).ajaxStart(function()
					{
					    $("#wait").css("display","block");
					});
					
					$(document).ajaxComplete(function()
					{
						$("#wait").css("display","none");
					});
				});
				
		 
	
		
		
		$(document).ready(function () 
				{			 
					$("#btnExport").click(function (e)
					{
						var reportType=$("#cmbReportType").val();
						var fromDate=$("#txtFromDate").val();
						var toDate=$("#txtToDate").val();
						var locCode=$("#cmbLocation").val();
						var propCode=$("#cmbProperty").val();
						var prodCode=$("#txtProdCode").val();
						if(prodCode=='')
						{
							prodCode='All';
						}
					
					//	var param1=reportType+","+locCode+","+propCode+","+showZeroItems+","+strSGCode+","+strNonStkItems+","+strGCode+","+qtyWithUOM+","+strExportType+","+ratePickUpFrom;
						if(reportType == 'Detail')
							{
							
								window.location.href=getContextPath()+"/rawMaterialConsumptionDetailReport.html?fDate="+fromDate+"&tDate="+toDate+"&prodCode="+prodCode+"&locCode="+locCode;
							}
						else
							{
							
							window.location.href=getContextPath()+"/rawMaterialConsumptionSummaryReport.html?fDate="+fromDate+"&tDate="+toDate+"&prodCode="+prodCode+"&locCode="+locCode;
							}
								});
				});

		
		function funHelp(transactionName) {
			
			var locCode=$("#cmbLocation").val();
			fieldName = transactionName;
				window.open("searchform.html?formname=" + transactionName+"&locationCode="+locCode+"&searchText=", "",
					"dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
		}

		function funSetData(code) {
		
			switch (fieldName) {
		case 'productmaster':
			funSetProduct(code);
			break;
			
			
	
			
		}
		
	}

	function funSetProduct(code) {
		var searchUrl = "";

		searchUrl = getContextPath()
				+ "/loadProductMasterData.html?prodCode=" + code;
		$.ajax({
			type : "GET",
			url : searchUrl,
			dataType : "json",
			async :false,
			success : function(response) {
				$("#txtProdCode").val(response.strProdCode);
				$("#lblProdName").text(response.strProdName);
			//	weightedRate = response.dblCostRM;
				//dblLastSuppRate=0;
				//funBatchCheck(response.strProdCode);
				
			},
			error : function(e) {
				alert('Error:=' + e);
			}
		});
		
		
	}
	
		
		
	</script>
</head>
<body onload="funOnLoad();">
	<div class="container">
		<label id="formHeading">Raw Material Consumption (POS Sale)</label>
		<s:form action="frmRawMaterialConsumptionFlash.html" method="GET" name="frmRawMaterialConsumptionFlash" id="frmRawMaterialConsumptionFlash">
		
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
			    <s:input id="txtFromDate" name="fromDate" path="dteFromDate" cssClass="calenderTextBox" style="width:80%;"/>
			    <s:errors path="dteFromDate"></s:errors>
			</div>      
			<div class="col-md-2">		        
			    <label id="lblToDate">To Date</label>
			   	<s:input id="txtToDate" name="toDate" path="dteToDate" cssClass="calenderTextBox" style="width:80%;"/>
			     <s:errors path="dteToDate"></s:errors>
			</div> 
			<div class="col-md-4"></div>
			<div class="col-md-2">	    
				<label>Product</label>
				<input id="txtProdCode" ondblclick="funHelp('productmaster');" class="searchTextBox"/>
			  <!--    <s:input id="txtUserCode" path="strUserCode" cssClass="searchTextBox" name="UserCode" ondblclick="funHelp('productmaster')" />-->
			    <s:errors path="strProdCode"></s:errors>
			</div>
			<div class="col-md-2">    
			     <label id="lblProdName" style="background-color:#dcdada94; width: 100%; height: 37%; margin: 27px 0px; text-align:center;">All</label>
			</div>
			
			<div class="col-md-2">   	
				<s:select path="strReportType" id="cmbReportType" style="margin-top:28px;">
 				<option value="Detail">Detail</option> 
				<option value="Summary">Summary</option>
				</s:select>
			</div>
			
			<div class="col-md-2">   	
				<s:select path="strExportType" id="cmbExportType" style="margin-top:28px;">
			<!--	<option value="pdf">PDF</option> -->
					<option value="xls">Excel</option>
				</s:select>
			</div>
			
		</div>
		<div class="center" style="margin-right: 42%;">
			  <!-- <a href="#"><button class="btn btn-primary center-block" id="btnExecute" value="Execute" onclick="return funOnClickExcecute()"
				>Execute</button></a>
			<a href="#"><button class="btn btn-primary center-block" id="btnExport" value="Export" action=""
				>Export</button></a> -->
			<button type="button" class="btn btn-primary center-block" id="btnExecute" value="EXECUTE">Execute</button>
				<button type="button" class="btn btn-primary center-block" id="btnExport" value="Export">Export</button>&nbsp
		</div>
		<div id="dvTransFlash" style="width: 100% ;height: 100% ;display: none;">
			<table id="tblTransFlash" class="transTable col9-right col10-right col11-right col12-right col13-right col14-right col15-right col16-right ">
			</table>
		
		</div>
		
		<div id="dvTransFlashDetail" style="width: 100% ;height: 100% ;display: none;">
			<table id="tblTransFlashDetail" class="transTable col12-right col13-right col14-right col15-right col16-right col17-right col18-right col19-right col20-right col21-right col22-right ">
			</table>
		
		</div>
			
		<div id="dvTranswise" style="width: 100% ;height: 100% ; display: none;" >
			<table id="tblTranswise" class="transTable col5-right col6-right col7-right col8-right col9-right"></table>
		</div>
			
			<br><br>
	
		<br><br>
	</s:form>
</div>
</body>
</html>
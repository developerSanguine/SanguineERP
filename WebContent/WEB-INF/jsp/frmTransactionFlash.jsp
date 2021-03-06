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
			

			$('#txtUserCode').blur(function() {
				var code = $('#txtUserCode').val();
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
					transecExportType="summary";
					
					if($("#txtProdCode").val()=='')
					{
						alert("Enter Product Code!");
						return false;
					}
					
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
					var userCode=$("#txtUserCode").val();
					funGetTransFlash(fromDate,toDate,locCode,userCode);
					
					return false;
				}
				
		
		function funGetTransFlash(fromDate,toDate,locCode,userCode)
		{
			if(userCode=='')
				{
					userCode='All';
				}
			var searchUrl=getContextPath()+"/frmTransReport.html?locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate+"&userCode="+userCode;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funShowTransFlash(response);
				    	document.all[ 'dvTranswise' ].style.display = 'none';
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

		
		$(document).ready(
				function() {
					$("#btnExport").click(
							function() {
							
								var fDate = $("#txtFromDate").val();
								var tDate = $("#txtToDate").val();
								var userCode=$("#txtUserCode").val();
								var locCode = $("#cmbLocation").val();
								
								
								var flgTransShow = "${flgTransShow}";
								if (flgTransShow == 'true') {
									
									var param = ("${transData}");
									var spParam = param.split(',');
										window.location.href = getContextPath()+ "/downloadExcelTransReportFlashOrDetail.html?fDate=" + fDate+ "&tDate=" + tDate+"&userCode=" + spParam[5]+"&locCode="+locCode+"&transeRptType="+spParam[0];
								
								}else
									{
									   var str=''; 
										window.location.href = getContextPath()+ "/downloadExcelTransReportFlashOrDetail.html?fDate=" + fDate+ "&tDate=" + tDate+"&userCode=" + userCode+"&locCode="+locCode+"&transeRptType="+str;
									}
								
								
								
								
								
								
							});
				});

	/* 	$(document).ready(
				function() {
					var flgStkFlash = "${flgTransShow}";
					if (flgStkFlash == 'true') {
						var param = ("${transData}");
						var spParam = param.split(',');
						$("#cmbLocation").val(spParam[1]);
						$("#cmbProperty").val(spParam[2]);
						$("#txtProdCode").val(spParam[0]);
						funSetProduct(spParam[0]);
						$("#txtFromDate").val(spParam[3]);
						$("#txtToDate").val(spParam[4]);

						funGetStockLedger(spParam[3], spParam[4], spParam[1],
								spParam[2], spParam[0]);
					}
				}); */

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
		   
			row.insertCell(0).innerHTML= "<label>Transaction</label>";
			row.insertCell(1).innerHTML= "<label>Location Name</label>";
			row.insertCell(2).innerHTML= "<label>UserName</label>";
			row.insertCell(3).innerHTML= "<label>No of Transaction</label>";
	
			
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
					row1.insertCell(0).innerHTML= "<a id=\"urlDocCode\" href=\"openTransection.html?transType="+item[2]+"&fDate="+fDate+"&tDate="+tDate+"&locCode="+locCode+"&propCode="+propCode+"&user="+item[4]+"\" target=\"_blank\"  >"+item[2]+"</a>";
					row1.insertCell(1).innerHTML= "<label>"+item[3]+"</label>";
					row1.insertCell(2).innerHTML= "<label>"+item[4]+"</label>";
			   		row1.insertCell(3).innerHTML= "<a id=\"urlDocCode\" href=\"openTransection.html?transType="+item[2]+"&fDate="+fDate+"&tDate="+tDate+"&locCode="+locCode+"&propCode="+propCode+"&user="+item[4]+"\" target=\"_blank\" >"+item[1]+"</a>";
				   
				  
				}
			});
			
		}
	
		
		$(document).ready(
				function() {
					
					var flgTransShow = "${flgTransShow}";
					if (flgTransShow == 'true') {
						var param = ("${transData}");
						var spParam = param.split(',');
						$("#txtFromDate").val(spParam[1]);
						$("#txtToDate").val(spParam[2]);
						$("#cmbLocation").val(spParam[3]);
						$("#cmbProperty").val(spParam[4]);

						funGetTransDataTransWise(spParam[1], spParam[2], spParam[3],spParam[4], spParam[0],spParam[5]);
					}
				});
		
		
		
		function funGetTransDataTransWise(fromDate,toDate,locCode,propCode,transType,user)
		{
			
			var param1=locCode+","+propCode;
			var searchUrl=getContextPath()+"/showTransWiseData.html?transType="+transType+"&locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate+"&user="+user;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funShowTransWise(response,transType);  
				    	document.all[ 'dvTransFlash' ].style.display = 'none';
				    	document.all[ 'dvTranswise' ].style.display = 'block';
				    },
					error: function(e)
				    {
				       	alert('Error:=' + e);
				    }
			      });
		}
		
		function funShowTransWise(response,transType)
		{
					
			var table = document.getElementById("tblTranswise");
			var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		   
			row.insertCell(0).innerHTML= "<label>Tranection Code</label>";
			row.insertCell(1).innerHTML= "<label>Tranection date</label>";
			row.insertCell(2).innerHTML= "<label>Created User Name</label>";
			row.insertCell(3).innerHTML= "<label>Edited User Name</label>";
			row.insertCell(4).innerHTML= "<label>Total Value</label>";
	
			
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
					row1.insertCell(0).innerHTML= "<a id=\"urlDocCode\" href=\"openSlip.html?docCode="+item[0]+","+transType+"\" target=\"_blank\" >"+item[0]+"</a>";
					row1.insertCell(1).innerHTML= "<label>"+item[1]+"</label>";
					row1.insertCell(2).innerHTML= "<label>"+item[2]+"</label>";
			   		row1.insertCell(3).innerHTML= "<label>"+item[3]+"</label>";
			   		row1.insertCell(4).innerHTML= "<label>"+item[4]+"</label>";
				}
			});
			
		}
		
		function funHelp(transactionName)
		{
			fieldName=transactionName;
		//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		
		}	
		
		
		function funSetData(code)
		{
			$.ajax({
		        type: "GET",
		        url: getContextPath()+"/loadUserMasterData.html?userCode="+code,
		        dataType: "json",
		        success: function(response)
		        {
		        	if('Invalid Code' == response.strUserCode1){
			        	
		        	}else{
			        	$("#txtUserCode").val(response.strUserCode1);
			        	$("#lblUserName").text(response.strUserName1);
		        	}
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
		
		
	</script>
</head>
<body onload="funOnLoad();">
	<div class="container">
		<label id="formHeading">Transaction Summary Flash</label>
		<s:form action="frmTransectionFlash.html" method="GET" name="frmTransectionFlash" id="frmTransectionFlash">
		
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
				<label id="lblUser">User</label>
			    <s:input id="txtUserCode" path="strUserCode" cssClass="searchTextBox" name="UserCode" ondblclick="funHelp('usermaster')" />
			    <s:errors path="strUserCode"></s:errors>
			</div>
			<div class="col-md-2">    
			     <label id="lblUserName" style="background-color:#dcdada94; width: 100%; height: 37%; margin: 27px 0px; text-align:center;">All</label>
			</div>
			<div class="col-md-2">   	
				<s:select path="strExportType" id="cmbExportType" style="margin-top:28px;">
<!-- 				<option value="pdf">PDF</option> -->
					<option value="xls">Excel</option>
				</s:select>
			</div>
		</div>
		<div class="center" style="margin-right: 42%;">
			<a href="#"><button class="btn btn-primary center-block" id="btnExecute" value="Execute" onclick="return funOnClickExcecute()"
				>Execute</button></a>
			<a href="#"><button class="btn btn-primary center-block" id="btnExport" value="Export" onclick=""
				>Export</button></a>
		</div>
		<div id="dvTransFlash" style="width: 100% ;height: 100% ;display: none;">
			<table id="tblTransFlash" class="transTable col5-right col6-right col7-right col8-right col9-right"></table>
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
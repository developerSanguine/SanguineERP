<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Order</title>

         <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

<script type="text/javascript">
		
$(document).ready(function() 
		{		
			$(".tab_content").hide();
			$(".tab_content:first").show();
	
			$("ul.tabs li").click(function() {
				$("ul.tabs li").removeClass("active");
				$(this).addClass("active");
				$(".tab_content").hide();
				var activeTab = $(this).attr("data-state");
				$("#" + activeTab).fadeIn();
			});
			
			
		});
		
$(document).ready(function() {
	var message='';
	<%if (session.getAttribute("success") != null) {
		            if(session.getAttribute("successMessage") != null){%>
		            message='<%=session.getAttribute("successMessage").toString()%>';
		            <%
		            session.removeAttribute("successMessage");
		            }
					boolean test = ((Boolean) session.getAttribute("success")).booleanValue();
					session.removeAttribute("success");
					if (test) {
					%>	
		alert("Data Save successfully\n\n"+message);
	<%
	}}%>
	
	var code='';
	<%if(null!=session.getAttribute("rptDCCode")){%>
	code='<%=session.getAttribute("rptDCCode").toString()%>';
	<%session.removeAttribute("rptDCCode");%>
	var isOk=confirm("Do You Want to Generate Slip?");
	if(isOk){
		
		
		
	window.open(getContextPath()+"/openRptDeliveryChallanSlip.html?rptDCCode="+code,'_blank');
	}
	<%}%>

	});	
		
		
		function funHelp(transactionName)
		{
			fieldName = transactionName;
		//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;top=500,left=500")
		}

		 	function funSetData(code)
			{
				switch (fieldName)
				{
					    	
				    case 'deliveryChallan' :
				    	funSetDeliveryChallanData(code);
				    	break;
				    	
				    case 'deliveryChallanslip' :
				    	funSetDeliveryChallanData(code);
				    	break;
				        
				}
			}
		 	
		 	function funSetDeliveryChallanData(code)
			{
				gurl=getContextPath()+"/loadDeliveryChallanHdData.html?dcCode="+code;
				$.ajax({
			        type: "GET",
			        url: gurl,
			        dataType: "json",
			        success: function(response)
			        {		        	
			        		if('Invalid Code' == response.strDCCode){
			        			alert("Invalid Delivery Challan Code");
			        			$("#txtDCCode").val('');
			        			$("#txtDCCode").focus();
			        			
			        		}else{	
			        			
			        			$('#txtDCCode').val(response.strDCCode);
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
		 	
	
	$(function()
			{
				$("#txtDCCode").blur(function() 
						{
							var code=$('#txtDCCode').val();
							if(code.trim().length > 0 && code !="?" && code !="/")
							{
								//funSetReqData(code);
							}
						});
				
			});
	
	function funCallFormAction()
	{
		var dcCode= $('#txtDCCode').val();
// 		window.open(getContextPath()+"/openRptDCRetailSlip.html?rptDCCode="+dcCode,'_blank');
		window.open(getContextPath()+"/openRptDCSlip.html?rptDCCode="+dcCode,'_blank');
	}
		
</script>

</head>
<body onload="funOnLoad();">
	<div class="container transTable">
		<label id="formHeading">Delivery Challan Slip</label>
	<s:form name="DeliveryChallanSlip" method="GET"    >
<%-- 	action="rptDeliveryChallanInvoiceSlip.html" > --%>
<%-- 		action="rptDeliveryChallanSlip.html" > --%>
			

		<input type="hidden" value="${urlHits}" name="saddr">
		<br>
		    <div class="row">
			<div class="col-md-2"><label>DC Code</label>
				<s:input path="strDocCode" id="txtDCCode" ondblclick="funHelp('deliveryChallanslip')" cssClass="searchTextBox"/>
			</div>
			<!-- <div class="col-md-10"></div>		 -->			
			<div class="col-md-1.1"><label>Report Type</label>
				   <s:select id="cmbDocType" path="strDocType">
						<s:option value="PDF">PDF</s:option>
						<s:option value="XLS">EXCEL</s:option>
						<s:option value="HTML">HTML</s:option>
						<s:option value="CSV">CSV</s:option>
					</s:select>
			</div>

		</div>
		<br>
		<p align="right" style="margin-right:78%">
			<input type="submit" value="Submit"
				onclick="return funCallFormAction()" class="btn btn-primary center-block" 
				class="form_button" /> &nbsp <input
				type="button" id="reset" name="reset" value="Reset" class="btn btn-primary center-block" 
				class="form_button" /></a>
				
		</p>
		<br>
		<div id="wait"
			style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
			<img
				src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif"
				width="60px" height="60px" />
		</div>
	</s:form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="default.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Web Stocks</title>
        <script type="text/javascript" src="<spring:url value="/resources/js/pagination.js"/>"></script>
    
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
    			
//     		$("#txtSRDate").datepicker({ dateFormat: 'dd-mm-yy' });
//     		$("#txtSRDate" ).datepicker('setDate', 'today');
//     		$("#txtSRDate").datepicker();


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
    		<%
    		if(null!=session.getAttribute("rptSRCode"))
    		{%>
    			code='<%=session.getAttribute("rptSRCode").toString()%>';
    			<%session.removeAttribute("rptSRCode");%>
    			var isOk=confirm("Do You Want to Generate Slip?");
    			if(isOk)
    			{
    				window.open(getContextPath()+"/openRptSRSlip.html?rptDSCode="+code,'_blank');
    			}
    							
    			
    		<%}%>

    			});

    
    /**
	 * Open help window
	 */
	var fieldName="";	
	function funHelp(transactionName)
	{
		fieldName=transactionName;
		 window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;top=500,left=500")
	
	}
	
	
	/**
	 * Set Data after selecting form Help windows
	 */
	function funSetData(code)
	{					
		var searchUrl="";			
		switch (fieldName)
		{
	
			case 'salesReturn':
				funSetSRCode(code);					
			break;
		
			case 'salesReturnslip':
				funSetSRCode(code);					
			break;
			
		}
	}
	
	
	/**
	 * Get and set SR Code
	 */
	function funSetSRCode(code)
	{
		var searchUrl="";
		searchUrl=getContextPath()+"/loadSalesHdData.html?srCode="+code;			
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	$("#txtSRCode").val(response.strSRCode);
			    	
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
  
	<body >
	  <div class="container masterTable">
		<label id="formHeading">Sales Return Slip Sales Return Slip</label>
		<s:form name="SalesReturnSlip" method="GET" action="rptSalesReturnSlip.html" target="_blank">
			
			
<!-- 			<tr><th colspan="4"></th></tr> -->
				<div class="row">
					<div class="col-md-2"><label>SR Code</label>
								<s:input path="strSRCode" id="txtSRCode" ondblclick="funHelp('salesReturnslip')" 
 							cssClass="searchTextBox" style="height:48%"/>
 					</div> 
 					
			<%-- 	<div class="col-md-2"><label>SR Date</label> 
			<s:input path="dteSRDate" id="txtSRDate"  required="required"  cssClass="calenderTextBox" /></div>   --%>
			
					<div class="col-md-1.1"><label>Report Type</label>
						<s:select id="cmbDocType" path="strDocType">
					    		<s:option value="PDF">PDF</s:option>
					    		<s:option value="XLS">EXCEL</s:option>
					    		<s:option value="HTML">HTML</s:option>
					    		<s:option value="CSV">CSV</s:option>
					    	</s:select>
					</div>
				</div>
			<br/>
			<p align="center" style="margin-right: 67%;">
				<input type="submit" value="Submit" class="btn btn-primary center-block" class="form_button" />&nbsp;
				<input type="button"   value="Reset" class="btn btn-primary center-block" class="form_button" />
			</p>
			<br/>
		
		</s:form>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

<script type="text/javascript">
	var fieldName;

	$(function() 
	{
	});

	function funSetData(code){

		switch(fieldName){

			case 'BillingInstCode' : 
				funSetBillingInstCode(code);
				break;
		}
	}


	function funSetBillingInstCode(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadBillingInstCode.html?billingInstructions=" + code,
			dataType : "json",
			success: function(response)
	        {
				
	        	if(response.strBillingInstCode=='Invalid Code')
	        	{
	        		alert("Invalid Agent Code");
	        		$("#txtBillingInstCode").val('');
	        	}
	        	else
	        	{					        	    	        		
	        		$("#txtBillingInstCode").val(response.strBillingInstCode);
	        	    $("#txtBillingInstDesc").val(response.strBillingInstDesc);
	        
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
		});;
	}



	/**
	* Success Message After Saving Record
	**/
	 $(document).ready(function()
				{
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
	});


	function funHelp(transactionName)
	{
		fieldName=transactionName;
		window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		//window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	/**
	 *  Check Validation Before Saving Record
	 **/
	function funCallFormAction(actionName,object)
	{
		var flg=true;
		if($('#txtBillingInstDesc').val()=='')
		{
			 alert('Enter Billing Instructions Description');
			 flg=false;
		}
		return flg;
	}
	
	$('#baseUrl').click(function() 
			{  
				 if($("#txtBillingInstCode").val().trim()=="")
				{
					alert("Please Select Billing Instruction Code... ");
					return false;
				} 
					window.open('attachDoc.html?transName=frmBillingInstructions.jsp&formName=Member Profile&code='+$('#txtBillingInstCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			});
	
	
</script>

</head>
<body>
  <div class=" container masterTable">
	<label id="formHeading">Billing Instructions</label>
	<s:form name="BillingInstructions" method="POST" action="saveBillingInstructions.html">
          <div class="row">
             <div class="col-md-5">
               <div class="row">
				<div class="col-md-5"><label>Billing Instruction Code</label>
				      <s:input type="text" id="txtBillingInstCode" path="strBillingInstCode" cssClass="searchTextBox" ondblclick="funHelp('BillingInstCode');" style="height: 48%;"/>
				</div>
                 <div class="col-md-7"><label>Billing Instruction Desc</label>
			          <s:input type="text" id="txtBillingInstDesc" path="strBillingInstDesc"/>
				 </div>
			</div></div>
			</div>
	
		<br />
		<p align="center" style="margin-right: 350px">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button" onclick="return funCallFormAction('submit',this);"/>&nbsp;
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>

	</s:form>
	</div>
</body>
</html>

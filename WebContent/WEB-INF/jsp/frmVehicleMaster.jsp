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
	
<title></title>
<script type="text/javascript">
	var fieldName;

	$(function() 
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

	var clickCount =0.0;
	function funCallFormAction(actionName,object) 
		{
			if(clickCount==0){
				clickCount=clickCount+1;	
			if ($("#txtVehNo").val()=="") 
			    {
				 alert('Enter Route Name');
				 $("#txtVehNo").focus();
				 return false;  
			   }
			}
			else
			{
				return false;
			}
			return true; 
		}
	
	function funSetData(code){

		switch(fieldName){

			case 'VehCode' : 
				funSetVehCode(code);
				break;
		}
	}


	function funSetVehCode(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/LoadVehicleMaster.html?docCode=" + code,
			dataType : "json",
			success : function(response){ 
				
				if('Invalid Code' == response.strVehCode){
        			alert("Invalid Vehicle Code");
        			$("#txtVehCode").val('');
        			$("#txtVehCode").focus();
        		}else{
        			
        			$("#txtVehCode").val(response.strVehCode);
        			$("#txtVehNo").val(response.strVehNo);
        			$("#txtDesc").val(response.strDesc);
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







	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
</script>

</head>
<body>

	<div class="container">
	<label  id="formHeading">Vehicle Master</label>
	<s:form name="VehicleMaster" method="POST" action="saveVehicleMaster.html?saddr=${urlHits}">
		<div class="row masterTable">
			<div class="col-md-2">
				<label>Vehicle Code</label>
				<s:input colspan="3" type="text" id="txtVehCode" path="strVehCode" cssClass="searchTextBox" ondblclick="funHelp('VehCode');" readOnly="true;"/>
			</div>
			<div class="col-md-2">
				<label>Vehicle No</label>
				<s:input colspan="3" type="text" id="txtVehNo" path="strVehNo" />
			</div>
			<div class="col-md-2">
				<label>Description</label>
				<s:input colspan="3" type="text" id="txtDesc" path="strDesc" cssClass="BoxW124px" />
			</div>
		</div>
		<div class="center" style="margin-right: 51%;">
			<a href="#"><button class="btn btn-primary center-block" tabindex="3" value="Submit" onclick="return funCallFormAction('submit',this);">Submit</button></a>
			<a href="#"><button class="btn btn-primary center-block" onclick="funResetFields()" value="Reset" >Reset</button></a>
		</div>
		
	</s:form>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PROPERTY MASTER</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
  
<script type="text/javascript">
	/*On form Load It Reset form :Ritesh 22 Nov 2014*/
	$(document).ready(function() {
		resetForms('propertyForm');
		$("#txtPropName").focus();
	});

</script>
<script type="text/javascript">
	var fieldName;
	function funHelp(transactionName) {
		fieldName = transactionName;
		//window.open("searchform.html?formname=" + transactionName+ "&searchText=", 'window', 'width=600,height=600');
	//	 window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		 window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	}

	function funSetData(code) {
		switch (fieldName) {
		case "property":
			funSetPropertyData(code);
			break;
		}
	}
 
	function funSetPropertyData(code) {
		$("#txtPropCode").val(code);
		$.ajax({
			type : "GET",
			url : getContextPath() + "/loadPropertyMasterData.html?Code="
					+ code,
			dataType : "json",
			success : function(resp) {
				// we have the response
				if('Invalid Code' == resp.propertyCode){
					alert("Invalid Property Code")
					$("#txtPropCode").val('');
					$("#txtPropName").val('');
					$("#txtPropCode").focus();
					
				}else{
					$("#txtPropCode").val(resp.propertyCode);
					$("#txtPropName").val(resp.propertyName);
					/* $("#txtAddLine1").val(resp.addressLine1);
					$("#txtAddLine2").val(resp.addressLine2);
					$("#txtCity").val(resp.city);
					$("#txtState").val(resp.state);
					$("#txtCountry").val(resp.country);
					$("#txtPin").val(resp.pin);
					$("#txtPhone").val(resp.phone);
					$("#txtMobile").val(resp.mobile);
					$("#txtFax").val(resp.fax);
					$("#txtContact").val(resp.contact);
					$("#txtEmail").val(resp.email); */
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

	function funResetFields() {
		
		$("#txtPropName").focus();
	
	}

	$(function() {
		$('a#baseUrl').click(function() {
			if ($("#txtPropCode").val().trim() == "") {
				alert("Please Select Property Code");
				return false;
			}
			window.open('attachDoc.html?transName=frmPropertyMaster.jsp&formName=Property Master&code='+$('#txtPropCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		});
		
		$('#txtPropCode').blur(function(){			
				var code=$('#txtPropCode').val();
				if (code.trim().length > 0 && code !="?" && code !="/") {
				funSetPropertyData(code);
				}
		});
	});
	
 function onLoadFunction()
	{
	 
	}
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


 function funCallFormAction(actionName,object) 
	{
		var flg=true;
		if($('#txtPropCode').val()=='')
		{
			var code = $('#txtPropName').val();
			 $.ajax({
			        type: "GET",
			        url: getContextPath()+"/checkPropertName.html?porpName="+code,
			        async: false,
			        dataType: "text",
			        success: function(response)
			        {
			        	if(response=="true")
			        		{
			        			alert("Prpoerty Name Already Exist!");
			        			$('#txtPropName').focus();
			        			flg= false;
				    		}
				    	else
				    		{
				    			flg=true;
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
		//alert("flg"+flg);
		return flg;
	}
</script>
</head>

<body onload="onLoadFunction();">
	<div class="container masterTable">
		<label id="formHeading">Property Master</label>
	   <s:form name="propertyForm" method="POST" action="savePropertyMaster.html?saddr=${urlHits}">
   
		<div class="row">
				
			<!-- 	<a id="baseUrl" href="#"> Attach Documents</a>  -->
		
			<div class="col-md-2"><label>Property Code</label>
				  <s:input path="propertyCode" id="txtPropCode" readonly="true" ondblclick="funHelp('property');" cssClass="searchTextBox" />
			</div>

			<div class="col-md-3"><label>Name </label>
				  <s:input path="propertyName" id="txtPropName"  autocomplete="off" required="true"/>
			</div>
		 </div>
		<br />
	
		<p align="center" style="margin-right: 32%;">
			<input type="submit" value="Submit" class="btn btn-primary center-block" class="form_button"
				onclick="return funCallFormAction('submit',this);" />&nbsp; 
			<input type="reset"	value="Reset"  class="btn btn-primary center-block" class="form_button" onclick="funResetFields()" />
		</p>
	</s:form>
   	</div>
</body>
</html>
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
    var totalAmt=0.00;
	
//reset fields
	function funResetFields()
	{
		var folioText=document.getElementById("strFolioNo");
		folioText.disabled=false;
	}
	
	
//set folio Data
	function funSetFolioData(folioNo)
	{
		$("#strFolioNo").val(folioNo);
		var folioText=document.getElementById("strFolioNo");
		folioText.disabled=true;
		
	   var searchUrl=getContextPath()+"/loadFolioDataCheckOutDiscount.html?folioNo="+folioNo;
		$.ajax({
			
			url:searchUrl,
			type :"GET",
			dataType: "json",
	        success: function(response)
	        {
	        	if(response.strFolioNo=='Invalid Code')
	        	{
	        		alert("Invalid Folio No.");
	        		$("#strFolioNo").val('');
	        	}
	        	else
	        	{		
	        		var amt=0,subTotal=0,discount=0;
	        		$("#strFolioNo").val(response.strFolioNo);	
	        		$.each(response.listFolioDtlModel,function(i,item)
	        		{
	        			amt = item.dblDebitAmt;
	        			subTotal = subTotal + amt;
	        			if(item.strRevenueType=="Discount")
	        			{
	        				discount = item.dblDebitAmt;
	        			}
	            	 
	            	});
	        		$("#txtSubTotal").val(subTotal);
// 	        		$("#txtDiscountPer").val(discount);
// 	        		if($("#txtDiscountPer").val().length>0)
// 	        		{
// 	        			var discPer=document.getElementById("txtDiscountPer");
// 	        			discPer.disabled=true;
// 	        		}
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
		}); 
	}


	function funValidateFields()
	{
		var flag=true;
		
		if($("#strFolioNo").val().trim().length==0)
		{
			alert("Please Select Folio No.");	
			flag=false;
		}
		else
		{
			var folioText=document.getElementById("strFolioNo");
			folioText.disabled=false;
		}		
		return flag;
	}

	/**
	* Success Message After Saving Record
	**/
	$(document).ready(function()
	{
		var message='';
		<%if (session.getAttribute("success") != null) 
		{
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
			}
		}%>
		
		 var pmsDate='<%=session.getAttribute("PMSDate").toString()%>';
		  var dte=pmsDate.split("-");
		  $("#txtPMSDate").val(dte[2]+"-"+dte[1]+"-"+dte[0]);
	});
	/**
		* Success Message After Saving Record
	**/
	
	
	function funSetData(code)
	{
		switch(fieldName)
		{
			
			case "folioNo":
				funSetFolioData(code);
				break;
		}
	}

	function funHelp(transactionName)
	{
		fieldName=transactionName;
		window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		//window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
            return false;

        return true;
    }
	
	
	
				
 			$('#baseUrl').click(function() 
 			{  
 				 if($("#strFolioNo").val().trim()=="")
 				{
 					alert("Please select Folio no..");
 					return false;
 				} 
 				window.open('attachDoc.html?transName=frmCheckoutDiscountMaster.jsp&formName=Member Profile&code='+$('#strFolioNo').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
 			});
</script>

</head>
<body>
  <div class="container masterTable">	
	<label id="formHeading">CheckOut Discount Master</label>
	<s:form name="CheckOut Discount Master" method="POST" action="saveCheckoutDiscount.html">
		<div class="row">
			    <div class="col-md-2"><label>Folio No.</label>
			    	<s:input id="strFolioNo" path="strFolioNo" readonly="true" style="height: 48%" ondblclick="funHelp('folioNo')" cssClass="searchTextBox"/>
				</div>
			
				<div class="col-md-1"><label>Sub Total</label>
			    	<s:input id="txtSubTotal" path="dblDebitAmt"   class="decimal-places-amt numberField" value="0" placeholder="amt" onkeypress="javascript:return isNumber(event)" />
				</div>
			
				<div class="col-md-1"><label>Discount %</label>
			    	<s:input id="txtDiscountPer" path="dblDiscPer"   class="decimal-places-amt numberField" value="0" placeholder="disc" onkeypress="javascript:return isNumber(event)" />
				</div>
			
		</div>
		<br />
		<p align="center" style="margin-right:48%">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button" onclick="return funValidateFields()"/>&nbsp;
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>

	</s:form>
	</div>
</body>
</html>

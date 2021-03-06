<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Extra Bed Master</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

<script type="text/javascript">

var fieldName;




//Initialize tab Index or which tab is Active
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
		
	$(document).ajaxStart(function(){
	    $("#wait").css("display","block");
	});
	$(document).ajaxComplete(function(){
	   	$("#wait").css("display","none");
	});
});

/**
linked account code
**/
function funSetAccountCode(code){

	$.ajax({
		type : "GET",
		url : getContextPath()+ "/getAccountMasterDtl.html?accountCode=" + code,
		dataType : "json",			
		success : function(response)
		{
			if(response.strAccountCode=='Invalid Code')
        	{
        		alert("Invalid Account Code");
        		$("#txtAccountCode").val('');
        	}
        	else
        	{
        		$("#txtAccountCode").val(response.strAccountCode);
        		$("#txtAccountName").val(response.strAccountName);
        	}
		},
		error : function(jqXHR, exception)
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


		/**
		* Open Help
		**/
		function funHelp(transactionName)
		{	  
			fieldName=transactionName;
			window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		    //window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		}
		

		/**
		*   Attached document Link
		**/
		$(function()
		{
		
			$('a#baseUrl').click(function() 
			{
				if($("#txtExtraBedTypeCode").val().trim()=="")
				{
					alert("Please Select ExtraBedType Code");
					return false;
				}
			   window.open('attachDoc.html?transName=frmExtraBed.jsp&formName=ExtraBed Master&code='+$('#txtExtraBedTypeCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			});
			
			/**
			* On Blur Event on Extra Bed Code Textfield
			**/
			$('#txtExtraBedTypeCode').blur(function() 
			{
					var code = $('#txtExtraBedTypeCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/")
					{				
						funSetExtraBedData(code);				
					}
			});
			
			$('#txtExtraBedTypeDesc').blur(function () {
				 var strExtraBedTypeDesc=$('#txtExtraBedTypeDesc').val();
			      var st = strExtraBedTypeDesc.replace(/\s{2,}/g, ' ');
			      $('#txtExtraBedTypeDesc').val(st);
				});
			
		});
		
	
		function funSetExtraBedData(code)
		{
			$("#txtExtraBedTypeCode").val(code);
			var searchurl=getContextPath()+"/loadExtraBedMasterData.html?extraBedCode="+code;
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	if(response.strExtraBedTypeCode=='Invalid Code')
				        	{
				        		alert("Invalid ExtraBed Code");
				        		$("#txtExtraBedTypeCode").val('');
				        	}
				        	else
				        	{
					        	$("#txtExtraBedTypeDesc").val(response.strExtraBedTypeDesc);
					        	$("#txtNoOfBed").val(response.intNoBeds);
					        	$("#txtChargePerBed").val(response.dblChargePerBed);
					        	if(response.strAccountCode!="NA")
					        	{
					        	funSetAccountCode(response.strAccountCode);
					        	}
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
		
		

		/**
		* Get and Set data from help file and load data Based on Selection Passing Value(Extra Bed Code)
		**/
		
		function funSetData(code)
		{
			switch(fieldName)
			{

				case 'extraBed' : 
					funSetExtraBedData(code);
					break;
					
				case "accountCode":
					funSetAccountCode(code);
					break;	
			}									
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
		
		

			/**
			 *  Check Validation Before Saving Record
			 **/
					function funCallFormAction(actionName,object) 
					{
						var flg=true;
						if($('#txtExtraBedTypeDesc').val()=='')
						{
							 alert('Enter Bed Description ');
							 flg=false;
							  
						}
						if($('#txtNoOfBed').val()=='')
						{
							 alert('Enter No of Bed ');
							 flg=false;
							  
						}
						if($('#txtChargePerBed').val()=='')
						{
							 alert('Enter Bed Charges');
							 flg=false;
							  
						}
						return flg;
					}
		
					function isNumber(evt) {
				        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
				        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
				            return false;

				        return true;
				    }  
		
			 $('#baseUrl').click(function() 
		    			{  
		    				 if($("#txtExtraBedTypeCode").val().trim()=="")
		    				{
		    					alert("Please Select Extra Bed Type..  ");
		    					return false;
		    				} 
		    					window.open('attachDoc.html?transName=frmExtraBed.jsp&formName=Member Profile&code='+$('#txtExtraBedTypeCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		    			});
	
</script>







</head>
<body>
	<div class="container masterTable"> 
		<label id="formHeading">Extra Bed Master</label>
	    <s:form name="ExtraBed" method="GET" action="saveExtraBedMaster.html?" >
	     <div id="tab_container">
				<ul class="tabs">
					<li data-state="tab1" style="width: 7%" class="active" >General</li>
					<li data-state="tab2" style="width: 7%">LinkUp</li>
				</ul>
							
				<!-- General Tab Start -->
		<div id="tab1" class="tab_content" style="height: 150px">
	 		<div class="row" style="margin-top: 4%">
				<!-- <div class="col-md-12" align="center"><a id="baseUrl" style="margin-left:-48%;display:none"
					href="#"> Attach Documents</a>&nbsp; &nbsp; &nbsp;
					&nbsp;</div> -->
			
			<div class="col-md-2"><label>Extra Bed Type</label>
				<s:input id="txtExtraBedTypeCode" path="strExtraBedTypeCode" cssClass="searchTextBox" style="height: 50%;" ondblclick="funHelp('extraBed')" />				
			</div>
			
			<div class="col-md-2"><label>Extra Bed Type Desc</label>
				<s:input id="txtExtraBedTypeDesc" path="strExtraBedTypeDesc"/>				
			</div>
			<div class="col-md-8"></div>
			
			<div class="col-md-1"><label>No Of Beds</label>
				<s:input id="txtNoOfBed" path="intNoBeds" style="text-align:right;" onkeypress="javascript:return isNumber(event)"/>				
			</div>
			
			<div class="col-md-1.1"><label>Charge Per Bed</label>
				<s:input id="txtChargePerBed" path="dblChargePerBed" style="text-align:right;width: 50%;" onkeypress="javascript:return isNumber(event)" />				
			</div>
			
		</div>
		</div>
		<!--General Tab End  -->
						
						
			<!-- Linkedup Details Tab Start -->
			<div id="tab2" class="tab_content" style="height:130px">
			<br> 
			<br>			
				<div class="row">
						<div class="col-md-2"><label>Account Code</label>
						    <s:input id="txtAccountCode" path="strAccountCode" readonly="true" ondblclick="funHelp('accountCode')" style="height: 45%" cssClass="searchTextBox"/>
						</div>
						 <div class="col-md-2"><s:input id="txtAccountName" path="" readonly="true" style="margin-top:17%"/>		        			        						    			    		        			  
						</div>
				</div>
			</div>
		</div>
		
		<p align="center" style="margin-right:49%">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button"  onclick="return funCallFormAction('submit',this);"  />
            &nbsp;
            <input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" />
       </p>
	</s:form>
	</div>
</body>
</html>
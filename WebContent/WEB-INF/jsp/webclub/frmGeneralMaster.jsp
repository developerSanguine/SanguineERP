<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>

<style type="text/css">
.divBorder {
	margin-top: -1px;
	margin-bottom: 15px;
	margin-left: 1px;
	border: 1px solid;
	height: 292px;
	width: 200px;
	overflow-x: scroll;
	overflow-y: scroll;
}
</style>


<script type="text/javascript">
	var gtblActiveState;
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

	function funResetFields()
	{
		location.reload(true); 
	}

	var fieldName;

	$(function() 
	{
		document.all[ 'Area' ].style.display = 'none';
		document.all[ 'City' ].style.display = 'none';
		document.all[ 'Country' ].style.display = 'none';
		document.all[ 'Region' ].style.display = 'none';
 		document.all[ 'State' ].style.display = 'none';
 		document.all[ 'Designation' ].style.display = 'none';
 		document.all[ 'Education' ].style.display = 'none';
 		document.all[ 'Marital' ].style.display = 'none';
 		document.all[ 'Profession' ].style.display = 'none';
 		document.all[ 'Reason' ].style.display = 'none';
 		
 		document.all[ 'Relation' ].style.display = 'none';
  		document.all[ 'Staff' ].style.display = 'none';
 		document.all[ 'CurrencyDetails' ].style.display = 'none';
 		document.all[ 'CurrencyDetails2' ].style.display = 'none';
 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
  		document.all[ 'InvitedBy' ].style.display = 'none';
  		document.all[ 'ItemCategory' ].style.display = 'none';
  		document.all[ 'Profile' ].style.display = 'none';
  		document.all[ 'Salutation' ].style.display = 'none';
  		document.all[ 'Title' ].style.display = 'none';
 		showDiv( 'Area' );
 		
	});

	function funSetData(code){

		switch(fieldName){

			case 'WCAreaMaster' : 
				funSetAreaCode(code);
				break;
			case 'WCCityMaster' : 
				funSetCityCode(code);
				break;
			case 'WCCountryMaster' : 
				funSetCountryCode(code);
				break;
			case 'WCStateMaster' : 
				funSetStateCode(code);
				break;
			case 'WCRegionMaster' : 
				funSetRegionCode(code);
				break;
			case 'WCEducationMaster' : 
				funSetEducationCode(code);
				break;
			case 'WCMaritalMaster' : 
				funSetMaritalCode(code);
				break;
			case 'WCProfessionMaster' : 
				funSetProfessionCode(code);
				break;
			case 'WCDesignationMaster' : 
				funSetDesignationCode(code);
				break;
			case 'WCReasonMaster' : 
				funSetReasonCode(code);
				break;
				
				
			case 'WCCommitteeMemberRole' : 
				funSetRoleCode(code);
				break;	
				
			case 'WCRelationMaster' : 
				funSetRelationCode(code);
				break;
				
			case 'WCStaffMaster' : 
				funSetStaffCode(code);
				break;
				
			case 'WCCurrencyDetailsMaster' : 
				funSetCurrencyDetailsCode(code);
				break;
				
			case 'WCInvitedByMaster' : 
				funSetInvitedCode(code);
				break;
				
			case 'WCItemCategoryMaster' : 
				funSetItemCategoryCode(code);
				break;
				
			case 'WCProfileMaster' : 
				funSetProfileCode(code);
				break;
				
			case 'WCSalutationMaster' : 
				funSetSalutationCode(code);
				break;
				
			case 'WCTitleMaster' : 
				funSetTitleCode(code);
				break;
				
				
				
				
		}
	}


	function funSetAreaCode(code){

		$("#txtAreaCode").val(code);
		var searchurl=getContextPath()+"/loadAreaCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strAreaCode=='Invalid Code')
		        	{
		        		alert("Invalid Group Code");
		        		$("#txtGroupCode").val('');
		        	}
		        	else
		        	{
			        	$("#txtAreaName").val(response.strAreaName);
			        	$("#txtCityCode").val(response.strCityCode);
			        	var citycode=response.strCityCode;
			        	if(!(citycode.length==0))
			        		{
			        			
				        		var searchurl=getContextPath()+"/loadCityCode.html?docCode="+citycode;
				        		//alert(searchurl);
				        		
				        			$.ajax({
				        		        type: "GET",
				        		        url: searchurl,
				        		        dataType: "json",
				        		        success: function(response)
				        		        {
				        		        	if(response.strCityCode=='Invalid Code')
				        		        	{
				        		        		alert("Invalid City Code In");
				        		        		$("#txtCityCode").val('');
				        		        	}
				        		        	else
				        		        	{
				        		        		$("#txtCityName").val(response.strCityName);
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
			        	
			        	
			        	$("#txtCityName").focus();
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


	function funSetCityCode(code){
		
		
		var stateCode = "";
		var countryCode = "";
		$("#txtCityCode").val(code);
		var searchurl=getContextPath()+"/loadCityCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strCityCode=='Invalid Code')
		        	{
		        		alert("Invalid City Code In");
		        		$("#txtCityCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtCityName").val(response.strCityName);
		        		$("#txtCityStdCode").val(response.strSTDCode);
		        		$("#txtStateCode").val(response.strStateCode);
		        		$("#txtCountryCode").val(response.strCountryCode);
		        		
		        		var stateCode= response.strStateCode;
		        		var countryCode= response.strCountryCode;
		        		
		        		if(!(countryCode.length==0))
		        			{
			        			var searchurl=getContextPath()+"/loadCountryCode.html?docCode="+countryCode;
			        			//alert(searchurl);
			        			
			        				$.ajax({
			        			        type: "GET",
			        			        url: searchurl,
			        			        dataType: "json",
			        			        success: function(response)
			        			        {
			        			        	if(response.strCountryCode=='Invalid Code')
			        			        	{
			        			        		alert("Invalid Country Code In");
			        			        		$("#txtCountryCode").val('');
			        			        	}
			        			        	else
			        			        	{
			        			        		$("#txtCountryName").val(response.strCountryName);
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
		        		
		        		if(!(stateCode.lenght==0))
		        			{
		        			var searchurl=getContextPath()+"/loadStateCode.html?docCode="+stateCode;
		        			//alert(searchurl);
		        			
		        				$.ajax({
		        			        type: "GET",
		        			        url: searchurl,
		        			        dataType: "json",
		        			        success: function(response)
		        			        {
		        			        	if(response.strStateCode=='Invalid Code')
		        			        	{
		        			        		alert("Invalid State Code In");
		        			        		$("#txtStateCode").val('');
		        			        	}
		        			        	else
		        			        	{
		        			        		$("#txtStateName").val(response.strStateName);
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
	

	function funSetRegionCode(code){
		
		$("#txtRegionCode").val(code);
		var searchurl=getContextPath()+"/loadRegionCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strRegionCode=='Invalid Code')
		        	{
		        		alert("Invalid Region Code In");
		        		$("#txtRegionCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtRegionName").val(response.strRegionName);
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
	

	function funSetCountryCode(code){

		$("#txtCountryCode").val(code);
		var searchurl=getContextPath()+"/loadCountryCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strCountryCode=='Invalid Code')
		        	{
		        		alert("Invalid Country Code In");
		        		$("#txtCountryCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtCountryName").val(response.strCountryName);
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
	
	function funSetStateCode(code){

		$("#txtStateCode").val(code);
		var searchurl=getContextPath()+"/loadStateCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strStateCode=='Invalid Code')
		        	{
		        		alert("Invalid State Code In");
		        		$("#txtStateCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtStateName").val(response.strStateName);
		        		$("#txtStateDesc").val(response.strStateDesc);
		        		$("#txtCountryCode").val(response.strCountryCode);
		        		$("#txtRegionCode").val(response.strRegionCode);
		        		var regionCode=response.strRegionCode;
		        		var countrycode=response.strCountryCode;
		        		
			        	if(!(regionCode.length==0))
			        		{
			        			
				        		var searchurl=getContextPath()+"/loadRegionCode.html?docCode="+regionCode;
				        		//alert(searchurl);
				        		
				        			$.ajax({
				        		        type: "GET",
				        		        url: searchurl,
				        		        dataType: "json",
				        		        success: function(response)
				        		        {
				        		        	if(response.strRegionCode=='Invalid Code')
				        		        	{
				        		        		alert("Invalid Region Code");
				        		        		$("#txtRegionCode").val('');
				        		        	}
				        		        	else
				        		        	{
				        		        		$("#txtRegionName").val(response.strRegionName);
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
			        	
			        	if(!(countrycode.length==0))
		        		{
		        			
			        		var searchurl=getContextPath()+"/loadCountryCode.html?docCode="+countrycode;
			        		//alert(searchurl);
			        		
			        			$.ajax({
			        		        type: "GET",
			        		        url: searchurl,
			        		        dataType: "json",
			        		        success: function(response)
			        		        {
			        		        	if(response.strCountryCode=='Invalid Code')
			        		        	{
			        		        		alert("Invalid Country Code");
			        		        		$("#txtCountryCode").val('');
			        		        	}
			        		        	else
			        		        	{
			        		        		$("#txtCountryName").val(response.strCountryName);
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
	
	
	function funSetEducationCode(code){

		$("#txtEducationCode").val(code);
		var searchurl=getContextPath()+"/loadEducation.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strEducationCode=='Invalid Code')
		        	{
		        		alert("Invalid Education Code In");
		        		$("#txtEducationCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtEducationDesc").val(response.strEducationDesc);
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
	
	
	
	
	function funSetMaritalCode(code){

		$("#txtMaritalCode").val(code);
		var searchurl=getContextPath()+"/loadMarital.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strMaritalCode=='Invalid Code')
		        	{
		        		alert("Invalid Education Code In");
		        		$("#txtMaritalCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtMaritalName").val(response.strMaritalName);
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
	
	function funSetProfessionCode(code){

		$("#txtProfessionCode").val(code);
		var searchurl=getContextPath()+"/loadProfession.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strProfessionCode=='Invalid Code')
		        	{
		        		alert("Invalid Profession Code In");
		        		$("#txtProfessionCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtProfessionName").val(response.strProfessionName);
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
	
	
	
	
	function funSetDesignationCode(code){

		$("#txtDesignationCode").val(code);
		var searchurl=getContextPath()+"/loadDesignation.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strDesignationCode=='Invalid Code')
		        	{
		        		alert("Invalid Designation Code In");
		        		$("#txtDesignationCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtDesignationName").val(response.strDesignationName);
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
	
	
	
	 
	function funSetReasonCode(code){

		$("#txtReasonCode").val(code);
		var searchurl=getContextPath()+"/loadReason.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strReasonCode=='Invalid Code')
		        	{
		        		alert("Invalid Reason Code In");
		        		$("#txtReasonCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtReasonName").val(response.strReasonDesc);
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
	
	function funSetRoleCode(code){

		$("#txtCommitteeMemberRoleCode").val(code);
		var searchurl=getContextPath()+"/loadCommitteeMemberRole.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strRoleCode=='Invalid Code')
		        	{
		        		alert("Invalid CommitteeMemberRole Code In");
		        		$("#txtCommitteeMemberRoleCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtCommitteeMemberRoleDesc").val(response.strRoleDesc);
		        		$("#txtCommitteeMemberRoleRank").val(response.intRoleRank);
		        		
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
	
 function funSetRelationCode(code){
		
 		$("#txtRelationCode").val(code);
 		var searchurl=getContextPath()+"/loadRelationCode.html?docCode="+code;
 		//alert(searchurl);
		
 			$.ajax({
 		        type: "GET",
 		        url: searchurl,
 		        dataType: "json",
 		        success: function(response)
 		        {
 		        	if(response.strRelationCode=='Invalid Code')
 		        	{
 		        		alert("Invalid Relation Code In");
		        		$("#txtRelationCode").val('');
 		        	}
 		        	else
 		        	{
 		        		$("#txtRelationName").val(response.strRelation);
 		        		$("#txtAgeLimit").val(response.strAgeLimit);
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
	
 function funSetStaffCode(code){
		
		$("#txtStaffCode").val(code);
		var searchurl=getContextPath()+"/loadStaffCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strStaffCode=='Invalid Code')
		        	{
		        		alert("Invalid Staff Code In");
		        		$("#txtStaffCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtStaffName").val(response.strStaffName);
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
	
 function funSetCurrencyDetailsCode(code){
		
		$("#txtCurrencyDetailsCode").val(code);
		var searchurl=getContextPath()+"/loadCurrencyDetailsCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strCurrCode=='Invalid Code')
		        	{
		        		alert("Invalid Staff Code In");
		        		$("#txtCurrencyDetailsCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtCurrencyDetailsName").val(response.strDesc);
		        		$("#txtCurrUnit").val(response.strCurrUnit);
		        		$("#txtExchangeRate").val(response.strExchangeRate);
		        		$("#txtTraChkRate").val(response.strTraChkRate);
		        		$("#txtDec").val(response.intDec);
		        		$("#txtShortDesc").val(response.strShortDesc);
		        		$("#txtLongDeciDesc").val(response.strLongDeciDesc);
		        		$("#txtShortDeciDesc").val(response.strShortDeciDesc);
		        		
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
	
 function funSetInvitedCode(code){
		
		$("#txtInvitedByCode").val(code);
		var searchurl=getContextPath()+"/loadInvitedByCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strInvCode=='Invalid Code')
		        	{
		        		alert("Invalid Invited Code In");
		        		$("#txtInvitedByCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtInvitedByName").val(response.strInvName);
		        		$("#txtMecompCode").val(response.strMecompCode);
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
	
 function funSetItemCategoryCode(code){
		
		$("#txtItemCategoryCode").val(code);
		var searchurl=getContextPath()+"/loadItemCategoryCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strItemCategoryCode=='Invalid Code')
		        	{
		        		alert("Invalid Invited Code In");
		        		$("#txtItemCategoryCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtItemCategoryName").val(response.strItemCategoryName);
		        		
		        		$("#txtAccountIn").val(response.strAccountIn);
		        		$("#txtSideledgerCode").val(response.strSideledgerCode);
		        		$("#txtTaxCode").val(response.strTaxCode);
		        		$("#txtTaxName").val(response.strTaxName);
		        		$("#txtTaxType").val(response.strTaxType);
		        		$("#txtSideledgerCode").val(response.strSideledgerCode);
		        		$("#txtGLCode").val(response.strGLCode);
		        		$("#txtAddUserId").val(response.strAddUserId);
		        		$("#txtItemTypeCode").val(response.strItemTypeCode);
		        		$("#txtCatItemType").val(response.strCatItemType);
		        		$("#txtDisAccIn").val(response.strDisAccIn);
		        		$("#txtFreeze").val(response.strFreeze);
		        		
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
	
 function funSetProfileCode(code){
		
		$("#txtProfileCode").val(code);
		var searchurl=getContextPath()+"/loadProfileCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strProfileCode=='Invalid Code')
		        	{
		        		alert("Invalid Invited Code In");
		        		$("#txtProfileCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtProfileName").val(response.strProfileDesc);
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

	
 function funSetSalutationCode(code){
		
		$("#txtSalutationCode").val(code);
		var searchurl=getContextPath()+"/loadSalutationCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strSalutationCode=='Invalid Code')
		        	{
		        		alert("Invalid Invited Code In");
		        		$("#txtSalutationCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtSalutationName").val(response.strSalutationDesc);
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
 
 function funSetTitleCode(code){
		
		$("#txtTitleCode").val(code);
		var searchurl=getContextPath()+"/loadTitleCode.html?docCode="+code;
		//alert(searchurl);
		
			$.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strTitleCode=='Invalid Code')
		        	{
		        		alert("Invalid Invited Code In");
		        		$("#txtTitleCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtTitleName").val(response.strTitleDesc);
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

	function funShowTableGUI(divID)
	{
		// for hide Table GUI
		document.all["divAreaTable"].style.display = 'none';
		document.all["divCityTable"].style.display = 'none';
		document.all["divRegionTable"].style.display = 'none';
		document.all["divStateTable"].style.display = 'none';
		document.all["divCountryTable"].style.display = 'none';
		document.all["divDesignationTable"].style.display = 'none';
		document.all["divReasonTable"].style.display = 'none';
		document.all["divProfessionTable"].style.display = 'none';
		document.all["divMaritalTable"].style.display = 'none';
		document.all["divEducationTable"].style.display = 'none';
		document.all["divCommitteeMemberRoleTable"].style.display = 'none';
		document.all[ 'divRelationTable' ].style.display = 'none';
		

 		document.all["divStaffTable"].style.display = 'none';
 		document.all["divCurrencyDetailsTable"].style.display = 'none';
 		document.all["divInvitedByTable"].style.display = 'none';
 		document.all["divItemCategoryTable"].style.display = 'none';
 		document.all["divProfileTable"].style.display = 'none';
 		document.all["divSalutationTable"].style.display = 'none';
 		document.all["divTitleTable"].style.display = 'none';
		
		
		// for show Table GUI
		document.all[divID].style.display = 'block';
		gtblActiveState=divID;
	}



	function funHelp(transactionName)
	{
		fieldName=transactionName;
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	
	function showDiv( id ) {
		
		switch (id)
		{
		
		case 'Region' :
			
			
			// shown table, Rows and Form Element	
			funShowTableGUI("div"+id+"Table");
			funCallAjexForParticulorTable(id);
			
			document.all[ id ].style.display = 'block';
			document.all["lbl" + id + "Code"].style.display = 'block';
			document.all["txt" + id + "Code"].style.display = 'block';
			document.all["lbl" + id + "Name"].style.display = 'block';
			document.all["txt" + id + "Name"].style.display = 'block';
				
			
			document.all.txtAreaCode.value = '';
			document.all["txt" + id + "Code"].focus();
			
			// Not shown Rows
			document.all[ 'Area' ].style.display = 'none';
			document.all[ 'City' ].style.display = 'none';
			document.all[ 'Country' ].style.display = 'none';
			document.all[ 'State' ].style.display = 'none';
			document.all[ 'Designation' ].style.display = 'none';
			document.all[ 'Education' ].style.display = 'none';
			document.all[ 'Marital' ].style.display = 'none';
			document.all[ 'Profession' ].style.display = 'none';
			document.all[ 'Reason' ].style.display = 'none';
			document.all[ 'CommitteeMemberRole' ].style.display = 'none';
			document.all[ 'Relation' ].style.display = 'none';
			

			document.all["Staff"].style.display = 'none';
 			document.all["CurrencyDetails"].style.display = 'none';
 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
			document.all["InvitedBy"].style.display = 'none';
 			document.all["ItemCategory"].style.display = 'none';
 			document.all["ItemCategory2"].style.display = 'none';
 			document.all["ItemCategory3"].style.display = 'none';
 			document.all["ItemCategory4"].style.display = 'none';
			document.all["Profile"].style.display = 'none';
			document.all["Salutation"].style.display = 'none';
			document.all["Title"].style.display = 'none';
			
			$("#txtRegionName").attr('readonly', false);
			$("#txtRegionCode").val('');
			$("#txtRegionName").val('');
			$("#hidMasterID").val('Region');
			
			break;	
		
		
			case 'Area' :
				// shown table, Rows and Form Element	
			funShowTableGUI("div"+id+"Table");
			funCallAjexForParticulorTable(id);
			
			document.all[ id ].style.display = 'block';
			document.all["lbl" + id + "Code"].style.display = 'block';
			document.all["txt" + id + "Code"].style.display = 'block';
			document.all["lbl" + id + "Name"].style.display = 'block';
			document.all["txt" + id + "Name"].style.display = 'block';
			
			document.all.txtAreaCode.value = '';
			document.all["txt" + id + "Code"].focus();
			
			document.all[ 'City' ].style.display = 'block';
			document.all['lblCityCode'].style.display = 'block';
			document.all['txtCityCode'].style.display = 'block';
			document.all['lblCityName'].style.display = 'block';			
			document.all['txtCityName'].style.display = 'block';

			// Not Shown Rows Fields
			document.all['lblCityStdCode'].style.display = 'none';
			document.all['txtCityStdCode'].style.display = 'none';
			
			// Not shown Rows
 			document.all[ 'Country' ].style.display = 'none';
 			document.all[ 'Region' ].style.display = 'none';
 			document.all[ 'State' ].style.display = 'none';
 			document.all[ 'Designation' ].style.display = 'none';
 			document.all[ 'Education' ].style.display = 'none';
 			document.all[ 'Marital' ].style.display = 'none';
 			document.all[ 'Profession' ].style.display = 'none';
 			document.all[ 'Reason' ].style.display = 'none';
 			document.all[ 'CommitteeMemberRole' ].style.display = 'none';
 			document.all[ 'Relation' ].style.display = 'none';
 			document.all["Staff"].style.display = 'none';
 			document.all["CurrencyDetails"].style.display = 'none';
 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
			document.all["InvitedBy"].style.display = 'none';
 			document.all["ItemCategory"].style.display = 'none';
 			document.all["ItemCategory2"].style.display = 'none';
 			document.all["ItemCategory3"].style.display = 'none';
 			document.all["ItemCategory4"].style.display = 'none';
			document.all["Profile"].style.display = 'none';
			document.all["Salutation"].style.display = 'none';
			document.all["Title"].style.display = 'none';
			
			$("#txtCityName").attr('readonly', true);
 			$("#hidMasterID").val('Area');
 			
			break;
			
			case 'City' :


				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				document.all["lbl" + id + "StdCode"].style.display = 'block';
				document.all["txt" + id + "StdCode"].style.display = 'block';
				
				document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				document.all[ 'Country' ].style.display = 'block';
				document.all["lbl" + "Country" + "Code"].style.display = 'block';
				document.all["txt" + "Country" + "Code"].style.display = 'block';
				document.all["lbl" + "Country" + "Name"].style.display = 'block';
				document.all["txt" + "Country" + "Name"].style.display = 'block';
				document.all[ 'State' ].style.display = 'block';
				document.all["lbl" + "State" + "Code"].style.display = 'block';
	 			document.all["txt" + "State" + "Code"].style.display = 'block';
	 			document.all["lbl" + "State" + "Name"].style.display = 'block';
	 			document.all["txt" + "State" + "Name"].style.display = 'block';
				
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
 				document.all[ 'Region' ].style.display = 'none';
 				document.all[ 'Designation' ].style.display = 'none';
 				document.all[ 'Education' ].style.display = 'none';
 				document.all[ 'Marital' ].style.display = 'none';
 				document.all[ 'Profession' ].style.display = 'none';
 				document.all[ 'Reason' ].style.display = 'none';
 				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
 				document.all[ 'Relation' ].style.display = 'none';
 				document.all["Staff"].style.display = 'none';
 	 			document.all["CurrencyDetails"].style.display = 'none';
 	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
 	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
 				document.all["InvitedBy"].style.display = 'none';
 	 			document.all["ItemCategory"].style.display = 'none';
 	 			document.all["ItemCategory2"].style.display = 'none';
 	 			document.all["ItemCategory3"].style.display = 'none';
 	 			document.all["ItemCategory4"].style.display = 'none';
 				document.all["Profile"].style.display = 'none';
 				document.all["Salutation"].style.display = 'none';
 				document.all["Title"].style.display = 'none';
 				
 				$("#txtCityName").attr('readonly', false);
 				$("#txtStateName").attr('readonly', true);
 				$("#txtCountryName").attr('readonly', true);
 				$("#txtCityCode").val('');
 				$("#txtCityName").val('');
 				$("#txtStateCode").val('');
 				$("#txtStateName").val('');
 				$("#txtCityStdCode").val('');
 				$("#txtCountryCode").val('');
 				$("#txtCountryName").val('');
 				
 				
 				$("#hidMasterID").val('City');
 				
				break;
				
			
				
				
				
			case 'Country' :
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				
				document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#txtCountryName").attr('readonly', false);
				$("#hidMasterID").val('Country');
				
				break;
				
				
			case 'State' :
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
	 			document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				document.all["lbl" + id + "Desc"].style.display = 'block';
				document.all["txt" + id + "Desc"].style.display = 'block';
				
				document.all.txtStateCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				document.all[ 'Region' ].style.display = 'block';
				document.all['lblRegionCode'].style.display = 'block';
				document.all['txtRegionCode'].style.display = 'block';
				document.all['lblRegionName'].style.display = 'block';			
				document.all['txtRegionName'].style.display = 'block';
				
				document.all[ 'Country' ].style.display = 'block';
				document.all['lblCountryCode'].style.display = 'block';
				document.all['txtCountryCode'].style.display = 'block';
				document.all['lblCountryName'].style.display = 'block';			
				document.all['txtCountryName'].style.display = 'block';
	
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#txtStateName").attr('readonly', false);
				$("#txtCountryName").attr('readonly', true);
				$("#txtRegionName").attr('readonly', true);
				$("#txtRegionCode").val('');
				$("#txtRegionCode").val('');
				$("#txtRegionName").val('');
				$("#txtCountryCode").val('');
				$("#txtCountryName").val('');
				$("#hidMasterID").val('State');				
				break;	
				
				
			case "Designation" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('Designation');
				
				break;
				
			case "Education" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Desc"].style.display = 'block';
				document.all["txt" + id + "Desc"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				
				$("#hidMasterID").val('Education');
			
				break;
				
// 			case "Marital" :	
				
// 				// shown table, Rows and Form Element	
// 				funShowTableGUI("div"+id+"Table");
// 				funCallAjexForParticulorTable(id);
				
// 				document.all[ id ].style.display = 'block';
// 				document.all["lbl" + id + "Code"].style.display = 'block';
// 				document.all["txt" + id + "Code"].style.display = 'block';
// 				document.all["lbl" + id + "Name"].style.display = 'block';
// 				document.all["txt" + id + "Name"].style.display = 'block';
				
// 				document.all.txtDesignationCode.value = '';
// 				document.all["txt" + id + "Code"].focus();
				
// 				// Not shown Rows
// 				document.all[ 'Area' ].style.display = 'none';
// 				document.all[ 'City' ].style.display = 'none';
// 				document.all[ 'Region' ].style.display = 'none';
// 				document.all[ 'State' ].style.display = 'none';
// 				document.all[ 'Country' ].style.display = 'none';
// 				document.all[ 'Designation' ].style.display = 'none';
// 				document.all[ 'Education' ].style.display = 'none';
// 				document.all[ 'Profession' ].style.display = 'none';
// 				document.all[ 'Reason' ].style.display = 'none';
				
// 				$("#hidMasterID").val('Education');
			
// 				break;
				
			case "Marital" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
						
				
				$("#hidMasterID").val('Marital');
			
				break;	
				
				
			case "Profession" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				
				$("#hidMasterID").val('Profession');
			
				break;	
				
			case "Reason" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				
				$("#hidMasterID").val('Reason');
			
				break;	
				
				
			case "CommitteeMemberRole" :	
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Desc"].style.display = 'block';
				document.all["txt" + id + "Desc"].style.display = 'block';
				document.all["lbl" + id + "Rank"].style.display = 'block';
				document.all["txt" + id + "Rank"].style.display = 'block';
				
				document.all.txtDesignationCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				
				$("#hidMasterID").val('CommitteeMemberRole');
			
				break;		
				
			case 'Relation' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				 funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				document.all["txtAgeLimit"].style.display = 'block';	
				document.all["lblAgeLimit"].style.display = 'block';
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
	 			document.all["CurrencyDetails"].style.display = 'none';
	 			document.all[ 'CurrencyDetails2' ].style.display = 'none';
	 	 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('Relation');
				
				break;	
				
			case 'Staff' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				 funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
					
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				$("#hidMasterID").val('Staff');
				
				break;	
				
			case 'CurrencyDetails' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all[ 'CurrencyDetails2' ].style.display = 'block';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				document.all["txtCurrUnit"].style.display = 'block';
				document.all["lblCurrUnit"].style.display = 'block';
				
				document.all["txtExchangeRate"].style.display = 'block';
				document.all["lblExchangeRate"].style.display = 'block';
				document.all["txtTraChkRate"].style.display = 'block';
				document.all["lblTraChkRate"].style.display = 'block';
				document.all["txtDec"].style.display = 'block';
				document.all["lblDec"].style.display = 'block';
				document.all["txtShortDesc"].style.display = 'block';
				document.all["lblShortDesc"].style.display = 'block';
				document.all["txtLongDeciDesc"].style.display = 'block';
				document.all["lblLongDeciDesc"].style.display = 'block';
				document.all["txtShortDeciDesc"].style.display = 'block';
				document.all["lblShortDeciDesc"].style.display = 'block';
				
				
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('CurrencyDetails');
				
				break;	
				
			case 'InvitedBy' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				 funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
				document.all["txtMecompCode"].style.display = 'block';	
				document.all["lblMecompCode"].style.display = 'block';	
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('InvitedBy');
				
				break;	
				
			case 'ItemCategory' :
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["ItemCategory2"].style.display = 'block';
	 			document.all["ItemCategory3"].style.display = 'block';
	 			document.all["ItemCategory4"].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
					
				document.all["txtAccountIn"].style.display = 'block';
	 			document.all["lblAccountIn"].style.display = 'block';
	 			document.all["txtSideledgerCode"].style.display = 'block';
	 			document.all["lblSideledgerCode"].style.display = 'block';
	 			document.all["txtTaxCode"].style.display = 'block';
	 			document.all["lblTaxCode"].style.display = 'block';
	 			document.all["txtTaxName"].style.display = 'block';
	 			document.all["lblTaxName"].style.display = 'block';
	 			document.all["txtTaxType"].style.display = 'block';
	 			document.all["lblTaxType"].style.display = 'block';
	 			document.all["txtSideledgerCode"].style.display = 'block';
	 			document.all["lblSideledgerCode"].style.display = 'block';
	 			document.all["txtGLCode"].style.display = 'block';
	 			document.all["lblGLCode"].style.display = 'block';
	 			document.all["txtAddUserId"].style.display = 'block';
	 			document.all["lblAddUserId"].style.display = 'block';
	 			document.all["txtItemTypeCode"].style.display = 'block';
	 			document.all["lblItemTypeCode"].style.display = 'block';
	 			document.all["txtCatItemType"].style.display = 'block';
	 			document.all["lblCatItemType"].style.display = 'block';
	 			document.all["txtDisAccIn"].style.display = 'block';
	 			document.all["lblDisAccIn"].style.display = 'block';
	 			document.all["txtFreeze"].style.display = 'block';
	 			document.all["lblFreeze"].style.display = 'block';
	 			
	 			
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('ItemCategory');
				
				break;	
				
			case 'Profile' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
					
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('Profile');
				
				break;	
				
			case 'Salutation' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
					
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				
				document.all["Title"].style.display = 'none';
				
				$("#hidMasterID").val('Salutation');
				
				break;	
				
			case 'Title' :
				
				
				// shown table, Rows and Form Element	
				funShowTableGUI("div"+id+"Table");
				funCallAjexForParticulorTable(id);
				
				document.all[ id ].style.display = 'block';
				document.all["lbl" + id + "Code"].style.display = 'block';
				document.all["txt" + id + "Code"].style.display = 'block';
				document.all["lbl" + id + "Name"].style.display = 'block';
				document.all["txt" + id + "Name"].style.display = 'block';
					
				
				//document.all.txtAreaCode.value = '';
				document.all["txt" + id + "Code"].focus();
				
				// Not shown Rows
				document.all[ 'Area' ].style.display = 'none';
				document.all[ 'City' ].style.display = 'none';
				document.all[ 'Country' ].style.display = 'none';
				document.all[ 'State' ].style.display = 'none';
				document.all[ 'Designation' ].style.display = 'none';
				document.all[ 'Education' ].style.display = 'none';
				document.all[ 'Marital' ].style.display = 'none';
				document.all[ 'Profession' ].style.display = 'none';
				document.all[ 'Reason' ].style.display = 'none';
				document.all[ 'CommitteeMemberRole' ].style.display = 'none';
				
				document.all[ 'Region' ].style.display = 'none';
				document.all[ 'Relation' ].style.display = 'none';
				document.all["Staff"].style.display = 'none';
				document.all["CurrencyDetails"].style.display = 'none';
				document.all[ 'CurrencyDetails2' ].style.display = 'none';
		 		document.all[ 'CurrencyDetails3' ].style.display = 'none';
				document.all["InvitedBy"].style.display = 'none';
	 			document.all["ItemCategory"].style.display = 'none';
	 			document.all["ItemCategory2"].style.display = 'none';
	 			document.all["ItemCategory3"].style.display = 'none';
	 			document.all["ItemCategory4"].style.display = 'none';
				document.all["Profile"].style.display = 'none';
				document.all["Salutation"].style.display = 'none';
			
				
				$("#hidMasterID").val('Title');
				
				break;	
				
				
				
		}
	}	
	
	function funAddRowInAreaTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblAreaMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    
	    var strAreaCode = rowData[0];
    	var strAreaName = rowData[1];
   		var strCityCode = rowData[2];
		var strCityName = rowData[3];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbAreaCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtAreaCode."+(rowCount)+"\" value='"+strAreaCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtAreaName."+(rowCount)+"\" value='"+strAreaName+"' />";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"10%\" id=\"txtCityCode."+(rowCount)+"\" value='"+strCityCode+"' />";
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"10%\" id=\"txtCityName."+(rowCount)+"\" value='"+strCityName+"' />";
	    row.insertCell(4).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblAreaMasterData)">';	    
	}
	
	function funAddRowInCityTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblCityMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strCityCode = rowData[0];
    	var strCityName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbCityCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtCityCode."+(rowCount)+"\" value='"+strCityCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtCityName."+(rowCount)+"\" value='"+strCityName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblCityMasterData)">';	    

	}
	
	function funAddRowInRegionTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblRegionMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strRegionCode = rowData[0];
    	var strRegionName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbRegionCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtRegionCode."+(rowCount)+"\" value='"+strRegionCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtRegionName."+(rowCount)+"\" value='"+strRegionName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblRegionMasterData)">';	    

	}
	
	function funAddRowInStateTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblStateMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strStateCode = rowData[0];
    	var strStateName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbStateCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtStateCode."+(rowCount)+"\" value='"+strStateCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtStateName."+(rowCount)+"\" value='"+strStateName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblStateMasterData)">';	    

	}
	
	function funAddRowInCountryTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblCountryMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strCountryCode = rowData[0];
    	var strCountryName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbCountryCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtCountryCode."+(rowCount)+"\" value='"+strCountryCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtCountryName."+(rowCount)+"\" value='"+strCountryName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblCountryMasterData)">';	    

	}
	
	function funAddRowInEducationTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblEducationMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strEducationCode = rowData[0];
    	var strEducationDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbEducationCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtEducationCode."+(rowCount)+"\" value='"+strEducationCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtEducationDesc."+(rowCount)+"\" value='"+strEducationDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblEducationMasterData)">';	    

	}
	
	function funAddRowInMaritalTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblMaritalMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strMaritalCode = rowData[0];
    	var strMaritalName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbMaritalCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"15%\" id=\"txtMaritalCode."+(rowCount)+"\" value='"+strMaritalCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"15%\" id=\"txtMaritalDesc."+(rowCount)+"\" value='"+strMaritalName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblMaritalMasterData)">';	    

	}
	
	function funAddRowInProfessionTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblProfessionMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProfessionCode = rowData[0];
    	var strProfessionName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbProfessionCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"13%\" id=\"txtProfessionCode."+(rowCount)+"\" value='"+strProfessionCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtProfessionName."+(rowCount)+"\" value='"+strProfessionName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblProfessionMasterData)">';	    

	}
	
	function funAddRowInDesignationTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblDesignationMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strDesignationCode = rowData[0];
    	var strDesignationName = rowData[1];
		
	   // row.insertCell(0).innerHTML= "<input id=\"cbDesignationCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"13%\" id=\"txtDesignationCode."+(rowCount)+"\" value='"+strDesignationCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtDesignationName."+(rowCount)+"\" value='"+strDesignationName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblDesignationMasterData)">';	    

	}
	
	function funAddRowInReasonTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblReasonMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strReasonCode = rowData[0];
    	var strReasonDesc = rowData[1];
		
	   // row.insertCell(0).innerHTML= "<input id=\"cbReasonCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtReasonCode."+(rowCount)+"\" value='"+strReasonCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtReasonDesc."+(rowCount)+"\" value='"+strReasonDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblReasonMasterData)">';	    

	}
	
	function funAddRowInCommitteeMemberRole(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblCommitteeMemberRoleMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strRoleCode = rowData[0];
    	var strRoleDesc = rowData[1];
    	var intRoleRank = rowData[2];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbRoleCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtReasonCode."+(rowCount)+"\" value='"+strRoleCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtReasonDesc."+(rowCount)+"\" value='"+strRoleDesc+"' />";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtRoleRank."+(rowCount)+"\" value='"+intRoleRank+"' />";
	    row.insertCell(3).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblCommitteeMemberRoleMasterData)">';	    

	}
	
	
	function funAddRowInRelationTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblRelationMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strRelationCode = rowData[0];
    	var strRelationDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbRelationCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtRelationCode."+(rowCount)+"\" value='"+strRelationCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"23%\" id=\"txtRelationDesc."+(rowCount)+"\" value='"+strRelationDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblRelationMasterData)">';	    

	}
	
	function funAddRowInStaffTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblStaffMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strStaffCode = rowData[0];
    	var strStaffName = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbStaffCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtStaffCode."+(rowCount)+"\" value='"+strStaffCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtStaffName."+(rowCount)+"\" value='"+strStaffName+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblStaffMasterData)">';	    

	}
	
	function funAddRowInCurrencyDetailsTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblCurrencyDetailsMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strCurrCode = rowData[0];
    	var strCurrDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbCurrCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"16%\" id=\"txtCurrCode."+(rowCount)+"\" value='"+strCurrCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtCurrDesc."+(rowCount)+"\" value='"+strCurrDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblCurrencyDetailsMasterData)">';	    

	}
	
	function funAddRowInInvitedByTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblInvitedByMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strInvitedByCode = rowData[0];
    	var strInvitedByDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbInvitedByCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtInvitedByCode."+(rowCount)+"\" value='"+strInvitedByCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtInvitedByDesc."+(rowCount)+"\" value='"+strInvitedByDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblInvitedByMasterData)">';	    

	}
	
	function funAddRowInItemCategoryTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblItemCategoryMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strItemCategoryCode = rowData[0];
    	var strItemCategoryDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbItemCategoryCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"15%\" id=\"txtItemCategoryCode."+(rowCount)+"\" value='"+strItemCategoryCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"22%\" id=\"txtItemCategoryDesc."+(rowCount)+"\" value='"+strItemCategoryDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblItemCategoryMasterData)">';	    

	}
	function funAddRowInProfileTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblProfileMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProfileCode = rowData[0];
    	var strProfileDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbProfileCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtProfileCode."+(rowCount)+"\" value='"+strProfileCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtProfileDesc."+(rowCount)+"\" value='"+strProfileDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblProfileMasterData)">';	    

	}
	function funAddRowInSalutationTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblSalutationMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strSalutationCode = rowData[0];
    	var strSalutationDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbSalutationCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtSalutationCode."+(rowCount)+"\" value='"+strSalutationCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtSalutationDesc."+(rowCount)+"\" value='"+strSalutationDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblSalutationMasterData)">';	    

	}
	function funAddRowInTitleTable(rowData)
	{
		//alert(qty);
		var table = document.getElementById("tblTitleMasterData");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strTitleCode = rowData[0];
    	var strTitleDesc = rowData[1];
		
	    //row.insertCell(0).innerHTML= "<input id=\"cbTitleCodeSel."+(rowCount)+"\" type=\"checkbox\" class=\"Box\"  value=\"Tick\" onClick=\"funCheckboxCheck()\" />";
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"11%\" id=\"txtTitleCode."+(rowCount)+"\" value='"+strTitleCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"25%\" id=\"txtTitleDesc."+(rowCount)+"\" value='"+strTitleDesc+"' />";
	    row.insertCell(2).innerHTML= '<input type="button" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this,tblTitleMasterData)">';	    

	}
	
	
	//delete row function 
	function funDeleteRow(obj,tblname)
		{
		    var index = obj.parentNode.parentNode.rowIndex;	
		    var value,code;
		    var table = document.getElementById(tblname.id);
		    table.deleteRow(index);
		    var tablevalue='';
		    switch(tblname.id)	
			{
				case "tblAreaMasterData" :
							{
								//value= obj.parentNode.parentNode.cells[4].childNodes[0].defaultValue;		    
						    	code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;	
								tablevalue="Area";
									break;
							}
							
				case "tblCityMasterData" :
							{
								//value= obj.parentNode.parentNode.cells[3].childNodes[0].defaultValue;		    
						    	code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;	
								tablevalue="City";
									break;
							}
				
				case "tblRegionMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;						
								tablevalue="Region";
									break;
							}
				case "tblStateMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;						
								tablevalue="State";
									break;
							}
							
				case "tblCountryMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Country";
									break;
							}
				case "tblEducationMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Education";
									break;
							}				
				case "tblMaritalMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Marital";
									break;
							}
				
				case "tblProfessionMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Profession";
									break;
							}
				case "tblDesignationMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Designation";			
									break;
							}
							
				case "tblReasonMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Reason";
									break;
							}
				case "tblCommitteeMemberRoleMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="CommitteeMemberRole";	
									break;
							}			
				
				case "tblRelationMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Relation";
									break;
							}
				case "tblStaffMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Staff";
									break;
							}
				
				case "tblCurrencyDetailsMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="CurrencyDetails";
									break;
							}
				case "tblInvitedByMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="InvitedBy";
									break;
							}
				case "tblItemCategoryMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="ItemCategory";								
									break;
							}
				case "tblProfileMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Profile";	
									break;
							}
				case "tblSalutationMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Salutation";	
									break;
							}
				case "tblTitleMasterData" :
							{
								code = obj.parentNode.parentNode.cells[0].childNodes[0].defaultValue;
								tablevalue="Title";	
									break;
							}
			}
		    
		    
		    funDeleteRowValue(code,tablevalue);
		}
	
	function funDeleteRowValue(code,tableName)
	{
		flgSACode=false;
		var searchUrl="";
		
		searchUrl=getContextPath()+"/deleteRowAreaValue.html?docCode="+code+"&tblname="+tableName;
		//alert(searchUrl);
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    success: function(response)
			    {		
					    	
							
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
	function funDeleteRowCity(obj)
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var value = obj.parentNode.parentNode.cells[4].childNodes[0].defaultValue;		    
	    var table = document.getElementById("tblCityMasterData");
	    table.deleteRow(index);		   
	}
	
	function funCallAjexForParticulorTable(tableName)
	{
		flgSACode=false;
		var searchUrl="";
		
		searchUrl=getContextPath()+"/loadAllDataOfPaticulorMaster.html?docCode="+tableName;
		//alert(searchUrl);
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    success: function(response)
			    {
    	    		funDeleteTableAllRowsOfParticulorTable(tableName);
			    	$.each(response, function(i,item)
					{
			    		var arr = jQuery.makeArray( response[i] );
			    		
			    		funFillDataOfParticulorTable(tableName,arr);
			    		
					}); 
							
					    	
							
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
	
	

	
	
	function funDeleteTableAllRowsOfParticulorTable(tableName)
	{
		switch(tableName)
		{
			case "Area" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			case "City" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Region" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Country" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
				
			case "State" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Education" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Marital" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Profession" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
			
			case "Reason" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
		
			case "Designation" :
						{
								$("#tbl"+tableName+ "MasterData tr").remove();
								break;
						}
						
			case "CommitteeMemberRole" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}			
			
			case "Relation" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "Staff" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			
			case "CurrencyDetails" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "InvitedBy" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "ItemCategory" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "Profile" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "Salutation" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
			case "Title" :
			{
					$("#tbl"+tableName+ "MasterData tr").remove();
					break;
			}
		}
		
	}
	
	
	function funFillDataOfParticulorTable(tableName,arr)
	{
		switch(tableName)
		{
			case "Area" :
						{
								funAddRowInAreaTable(arr);
								break;
						}
			case "City" :
						{
								funAddRowInCityTable(arr);
								break;
						}
			
			case "Region" :
						{
								funAddRowInRegionTable(arr);
								break;
						}
			
			case "Country" :
						{
								funAddRowInCountryTable(arr);
								break;
						}
				
			case "State" :
						{
								funAddRowInStateTable(arr);
								break;
						}
			
			case "Education" :
						{
								funAddRowInEducationTable(arr);
								break;
						}
			
			case "Marital" :
						{
								funAddRowInMaritalTable(arr);
								break;
						}
			
			case "Profession" :
						{
								funAddRowInProfessionTable(arr);
								break;
						}
			
			case "Reason" :
						{
								funAddRowInReasonTable(arr);
								break;
						}
		
			case "Designation" :
						{
								funAddRowInDesignationTable(arr);
								break;
						}
						
			case "CommitteeMemberRole" :
						{
								funAddRowInCommitteeMemberRole(arr);
								break;
						}			
		
			case "Relation" :
			{
					funAddRowInRelationTable(arr);
					break;
			}
			
			case "Staff" :
			{
					funAddRowInStaffTable(arr);
					break;
			}
			
			case "CurrencyDetails" :
			{
					funAddRowInCurrencyDetailsTable(arr);
					break;
			}
			
			case "InvitedBy" :
			{
					funAddRowInInvitedByTable(arr);
					break;
			}
			case "ItemCategory" :
			{
					funAddRowInItemCategoryTable(arr);
					break;
			}
			case "Profile" :
			{
					funAddRowInProfileTable(arr);
					break;
			}
			case "Salutation" :
			{
					funAddRowInSalutationTable(arr);
					break;
			}
			case "Title" :
			{
					funAddRowInTitleTable(arr);
					break;
			}
		}
		
		
	}
	
function funCheckTableActive()
{
	var flag=true;
	if(gtblActiveState=='divAreaTable')
	{		
		if($("#txtAreaName").val().trim().length==0)
			{
				alert("Please Enter Area Name");
				flag=false;
			}
		else if($("#txtCityName").val().trim().length==0)
			{
				alert("Please Select City Code");
				flag=false;
			}
		
	}
	else if(gtblActiveState=='divCityTable')
	{
		
		if($("#txtCityName").val().trim().length==0)
		{
			alert("Please Enter City Name");
			flag=false;				
		}
		else if($("#txtStateName").val().trim().length==0)
		{
			alert("Please Select State Code");
			flag=false;
		}
		else if($("#txtCountryName").val().trim().length==0)
		{
			alert("Please Enter Country Code");
			flag=false;
		}
		else if($("#txtCityStdCode").val().trim().length==0)
		{
			alert("Please Enter STD Code");
			flag=false;
		}
		
	}
	else if(gtblActiveState=='divRegionTable')
	{
		if($("#txtRegionName").val().trim().length==0)
		{
			alert("Please Enter Region Name");
			flag=false;				
		}
		
	}
	else if(gtblActiveState=='divStateTable')
	{
		if($("#txtStateName").val().trim().length==0)
		{
			alert("Please Enter State Name");
			flag=false;
		}
		else if($("#txtCountryName").val().trim().length==0)
		{
			alert("Please Select Country Code");
			flag=false;
		}
		else if($("#txtRegionName").val().trim().length==0)
		{
			alert("Please Select Region Code`");
			flag=false;				
		}
	}
	else if(gtblActiveState=='divCountryTable')
	{
		if($("#txtCountryName").val().trim().length==0)
		{
			alert("Please Enter Country Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divDesignationTable')
	{				
		if($("#txtDesignationName").val().trim().length==0)
		{
			alert("Please Enter Designation Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divReasonTable')
	{ 
		if($("#txtReasonName").val().trim().length==0)
		{
			alert("Please Enter Reason Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divProfessionTable')
	{		
		if($("#txtProfessionName").val().trim().length==0)
		{
			alert("Please Enter Profession Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divMaritalTable')
	{		
		if($("#txtMaritalName").val().trim().length==0)
		{
			alert("Please Enter Marital Status");
			flag=false;
		}
	}
	else if(gtblActiveState=='divEducationTable')
	{
		if($("#txtEducationDesc").val().trim().length==0)
		{
			alert("Please Enter Education Desc");
			flag=false;
		}
	}
	else if(gtblActiveState=='divCommitteeMemberRoleTable')
	{
		if($("#txtCommitteeMemberRoleDesc").val().trim().length==0)
		{
			alert("Please Enter Role Desc");
			flag=false;
		}	
	}
	else if(gtblActiveState=='divRelationTable')
	{		
		if($("#txtRelationName").val().trim().length==0)
		{
			alert("Please Enter Relation Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divStaffTable')
	{
		if($("#txtStaffName").val().trim().length==0)
		{
			alert("Please Enter Staff Name");
			flag=false;
		}
	
	}
	else if(gtblActiveState=='divCurrencyDetailsTable')
	{
		if($("#txtCurrencyDetailsName").val().trim().length==0)
		{
			alert("Please Enter Currency Details Name");
			flag=false;
		}
		else if($("#txtCurrUnit").val().trim().length==0)
		{
			alert("Please Enter Currency Unit");
			flag=false;
		}
		else if($("#txtExchangeRate").val().trim().length==0)
		{
			alert("Please Enter Exchange Rate");
			flag=false;
		}
		else if($("#txtExchangeRate").val().trim().length==0)
		{
			alert("Please Enter Tra Chk Rate");
			flag=false;
		}
		else if($("#txtShortDesc").val().trim().length==0)
		{
			alert("Please Enter Short Desc");
			flag=false;
		}
		else if($("#txtShortDeciDesc").val().trim().length==0)
		{
			alert("Please Enter ShortDeciDesc");
			flag=false;
		}
	}
	else if(gtblActiveState=='divInvitedByTable')
	{
		if($("#txtInvitedByName").val().trim().length==0)
		{
			alert("Please Enter InvitedBy Name");
			flag=false;
		}
		else if($("#txtMecompCode").val().trim().length==0)
		{
			alert("Please Enter MecompCode");
			flag=false;
		}
	}
	else if(gtblActiveState=='divItemCategoryTable')
	{
		if($("#txtItemCategoryName").val().trim().length==0)
		{
			alert("Please Enter ItemCategory Name");
			flag=false;
		}
		else if($("#txtAccountIn").val().trim().length==0)
		{
			alert("Please Enter Account In");
			flag=false;
		}
		else if($("#txtSideledgerCode").val().trim().length==0)
		{
			alert("Please Enter Side ledger");
			flag=false;
		}
		else if($("#txtTaxCode").val().trim().length==0)
		{
			alert("Please Enter Tax Code");
			flag=false;
		}
		else if($("#txtTaxCode").val().trim().length==0)
		{
			alert("Please Enter Tax Code");
			flag=false;
		}
		else if($("#txtTaxName").val().trim().length==0)
		{
			alert("Please Enter Tax Name");
			flag=false;
		}
		else if($("#txtTaxType").val().trim().length==0)
		{
			alert("Please Enter Tax Type");
			flag=false;
		}
		else if($("#txtGLCode").val().trim().length==0)
		{
			alert("Please Enter GL Code");
			flag=false;
		}
		else if($("#txtAddUserId").val().trim().length==0)
		{
			alert("Please Enter Add User Id");
			flag=false;
		}
		else if($("#txtItemTypeCode").val().trim().length==0)
		{
			alert("Please Enter Item Type Code");
			flag=false;
		}
		else if($("#txtCatItemType").val().trim().length==0)
		{
			alert("Please Enter Cat Item Type");
			flag=false;
		}
		else if($("#txtCatItemType").val().trim().length==0)
		{
			alert("Please Enter Cat Item Type");
			flag=false;
		}
		else if($("#txtDisAccIn").val().trim().length==0)
		{
			alert("Please Enter DisAccIn");
			flag=false;
		}
		else if($("#txtFreeze").val().trim().length==0)
		{
			alert("Please Enter Freeze");
			flag=false;
		}		

	}
	else if(gtblActiveState=='divProfileTable')
	{
		if($("#txtProfileName").val().trim().length==0)
		{
			alert("Please Enter Profile Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divSalutationTable')
	{
		if($("#txtSalutationName").val().trim().length==0)
		{
			alert("Please Enter Salutation Name");
			flag=false;
		}
	}
	else if(gtblActiveState=='divTitleTable')
	{
		if($("#txtTitleName").val().trim().length==0)
		{
			alert("Please Enter Title Name");
			flag=false;
		}
	}
	return flag;
}

	
	
	
	
</script>


</head>
<body>

	<div class="container">
		<label id="formHeading">General Master</label> <br /> <br />

		<s:form name="frmGeneralMaster" method="POST"
			action="saveWebClubGeneralMaster.html">




			<div>
				<div class="divBorder" style="float: left; width: 200px; background-color: #fafbfb;">
					<a href="#" onclick="showDiv( 'Area' );">Area</a> <br> 
					<a href="#" onclick="showDiv( 'City' );">City</a> <br> 
				    <a href="#" onclick="showDiv( 'Region' );">Region</a> <br> 
				    <a href="#" onclick="showDiv( 'State' );">State</a> <br> 
				    <a href="#" onclick="showDiv( 'Country' );">Country</a> <br> 
				    <a href="#" onclick="showDiv( 'Education' );">Eduction</a> <br>
					<a href="#" onclick="showDiv( 'Marital' );">Marital Status</a> <br>
					<a href="#" onclick="showDiv( 'Profession' );">Profession</a> <br>
					<a href="#" onclick="showDiv( 'Designation' );">Designation</a> <br>
					<a href="#" onclick="showDiv( 'Reason' );">Reason</a> <br> 
					<a href="#" onclick="showDiv( 'CommitteeMemberRole' );">Committee Member Role</a> <br> 
					<a href="#" onclick="showDiv( 'Relation' );">Relation</a><br>
				    <a href="#" onclick="showDiv( 'Staff' );">Staff</a> <br>
					<a href="#" onclick="showDiv( 'CurrencyDetails' );">Currency</a> <br>
					<a href="#" onclick="showDiv( 'InvitedBy' );">Invited By</a> <br>
					<a href="#" onclick="showDiv( 'ItemCategory' );">Item Category</a><br> 
					<a href="#" onclick="showDiv( 'Profile' );">Profile Source</a> <br>
				    <a href="#" onclick="showDiv( 'Salutation' );">Salutation</a>
					<br> <a href="#" onclick="showDiv( 'Title' );">Title</a> <br>



				</div>

				<div id="divAreaTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 6.5%;">Area Code</td>
							<td style="width: 11%;">Area Name</td>
							<td style="width: 6%;">City Code</td>
							<td style="width: 25%;">Area Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblAreaMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
								<col style="width: 10%">
								<col style="width: 19%">
								<col style="width: 10%">
								<col style="width: 26%">
								<col style="width: 15%">
								
							</tbody>
						</table>
					</div>
				</div>

				<div id="divCityTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.5%;"></td>
							<td style="width: 8%;">City Code</td>
							<td style="width: 27%;">City Name</td>
							<td style="width: 29%;"></td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblCityMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divRegionTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr  style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2.3%;">Region Code</td>
							<td style="width: 20%;">Region Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblRegionMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divStateTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr  style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2.3%;">State Code</td>
							<td style="width: 2%;">State Name</td>
							<td style="width: 10%;">Delete</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblStateMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divCountryTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Country Code</td>
							<td style="width: 2%;">Country Name</td>
							<td style="width: 10%;">Delete</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblCountryMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divDesignationTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 1.8%;">Designation Code</td>
							<td style="width: 20%;">Designation Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblDesignationMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 6%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divReasonTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Reason Code</td>
							<td style="width: 20%;">Reason Desc</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblReasonMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divProfessionTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Profession Code</td>
							<td style="width: 20%;">Profession Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblProfessionMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 6%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>


				<div id="divMaritalTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 3.3%;">Marital Status Code</td>
							<td style="width: 20%;">Marital Status </td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblMaritalMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 21%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divEducationTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 1.5%;">Education Code</td>
							<td style="width: 20%;">Education Desc</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblEducationMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divCommitteeMemberRoleTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 5%;">Role Code</td>
							<td style="width: 9%;">Role Desc</td>
							<td style="width: 23%;">Role Rank</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblCommitteeMemberRoleMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll" class="transTablex col8-center">
							<tbody>
							<col style="width: 13%">
							<col style="width: 25%">
							<col style="width: 20%">
							</tbody>
						</table>
					</div>



				</div>

				<div id="divRelationTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Relation Code</td>
							<td style="width: 20%;">Relation Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblRelationMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5.3%">
							<col style="width: 10%">
							<col style="width: 26%">


							</tbody>
						</table>
					</div>
				</div>

				<div id="divStaffTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2.3%;">Staff Code</td>
							<td style="width: 20%;">Staff Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblStaffMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">


							</tbody>
						</table>
					</div>
				</div>

				<div id="divCurrencyDetailsTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 3.2%;">Currency  Details  Code</td>
							<td style="width: 20%;">Currency  Details  Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblCurrencyDetailsMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 17%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divInvitedByTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Invited By Code</td>
							<td style="width: 20%;">Invited By Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblInvitedByMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divItemCategoryTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 3.2%;">Item Category Code</td>
							<td style="width: 20%;">Item Category Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblItemCategoryMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 7.2%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divProfileTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Profile Code</td>
							<td style="width: 20%;">Profile Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblProfileMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divSalutationTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 2%;">Salutation Code</td>
							<td style="width: 20%;">Salutation Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblSalutationMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5.5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>

				<div id="divTitleTable" class="dynamicTableContainer"
					style="height: 293px; width: 803px !important; margin: 0px 2px 4px 4px !important; display: none;">
					<table
						style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
						<tr style="background-color:#c0c0c0;">
							<td style="width: 0.3%;"></td>
							<td style="width: 3%;">Title Code</td>
							<td style="width: 20%;">Title Name</td>
						</tr>
					</table>
					<div
						style="border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
						<table id="tblTitleMasterData"
							style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 26%">
							</tbody>
						</table>
					</div>
				</div>





			</div>

			<table class="container masterTable" style="width:700px;">
				<tr id="Area" style="height:70px !important;">
		

			<td><label id="lblAreaCode" style="display:none">Area Code</label>
			     <s:input id="txtAreaCode" path="strAreaCode"
						cssClass="searchTextBox" style="display:none" readonly="true" ondblclick="funHelp('WCAreaMaster')"/></td>
			<td><label id="lblAreaName" style="display:none">Area Name </label>
			      <s:input id="txtAreaName" path="strAreaName"  style="display:none" /></td>
		
		</tr>
		<tr id="City" style="height:70px !important;">
				
				<td><label id="lblCityCode" style="display:none">City Code</label>
				        <s:input id="txtCityCode" path="strCityCode"
							cssClass="searchTextBox" style="display:none" ondblclick="funHelp('WCCityMaster')"/></td>
				<td><label id="lblCityName" style="display:none">City Name </label>
				        <s:input id="txtCityName" path="strCityName"
							 style="display:none" /></td>
				<td><label id="lblCityStdCode" style="display:none">STD Code </label>
				       <s:input id="txtCityStdCode" path="strStdCode"
						 style="display:none" /></td>
			
		</tr>
				<tr id="State" style="height:70px !important;">

					<td><label id="lblStateCode" style="display: none">State
							Code</label>
					       <s:input id="txtStateCode" path="strStateCode"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCStateMaster')" /></td>
					<td><label id="lblStateName" style="display: none">State
							Name </label>
				           <s:input id="txtStateName" path="strStateName"
						   style="display:none" /></td>
					<td><label id="lblStateDesc" style="display: none">Description
					</label>
					     <s:input id="txtStateDesc" path="strStateDesc"
							 style="display:none" /></td>

				</tr>

				<tr id="Country" style="height:70px !important;">

					<td><label id="lblCountryCode" style="display: none">Country
							Code</label>
				        <s:input id="txtCountryCode" path="strCountryCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCCountryMaster')" /></td>
					<td><label id="lblCountryName" style="display: none">Country
							Name </label>
					    <s:input id="txtCountryName" path="strCountryName"
							style="display:none" /></td>

				</tr>

				<tr id="Region" style="height:70px !important;">

					<td><label id="lblRegionCode" style="display: none">Region
							Code</label>
					       <s:input id="txtRegionCode" path="strRegionCode"  readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCRegionMaster')" /></td>
					<td><label id="lblRegionName" style="display: none">Region
							Name </label>
				          <s:input id="txtRegionName" path="strRegionName"
							style="display:none" /></td>

				</tr>

				<tr id="Designation" style="height:70px !important;">

					<td><label id="lblDesignationCode" style="display: none">Designation
							Code</label>
					     <s:input id="txtDesignationCode" path="strDesignationCode" cssClass="searchTextBox" readonly="true" style="display:none" ondblclick="funHelp('WCDesignationMaster')" /></td>
					<td><label id="lblDesignationName" style="display: none">Designation
							Name </label>
				     <s:input id="txtDesignationName" path="strDesignationName"
							 style="display:none" /></td>

				</tr>

				<tr id="Education" style="height:70px !important;">

					<td><label id="lblEducationCode" style="display: none">Education
							Code</label>
					     <s:input id="txtEducationCode" path="strEducationCode"
							cssClass="searchTextBox" style="display:none" readonly="true"
							ondblclick="funHelp('WCEducationMaster')" /></td>
					<td><label id="lblEducationDesc" style="display: none">Education
							Desc </label>
				       <s:input id="txtEducationDesc" path="strEducationDesc"
							style="display:none" /></td>

				</tr>

				<tr id="Marital" style="height:70px !important;">

					<td><label id="lblMaritalCode" style="display: none">Marital
							Code</label>
					      <s:input id="txtMaritalCode" path="strMaritalCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCMaritalMaster')" /></td>
					<td><label id="lblMaritalName" style="display: none">Marital
							Status </label>
					     <s:input id="txtMaritalName" path="strMaritalName"
							style="display:none" /></td>

				</tr>

				<tr id="Profession" style="height:70px !important;">

					<td><label id="lblProfessionCode" style="display: none">Profession
							Code</label>
					     <s:input id="txtProfessionCode" path="strProfessionCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCProfessionMaster')" /></td>
					<td><label id="lblProfessionName" style="display: none">Profession
							Name </label>
					     <s:input id="txtProfessionName" path="strProfessionName"
							style="display:none" /></td>

				</tr>

				<tr id="Reason" style="height:70px !important;">

					<td><label id="lblReasonCode" style="display: none">Reason
							Code</label>
					    <s:input id="txtReasonCode" path="strReasonCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCReasonMaster')" /></td>
					<td><label id="lblReasonName" style="display: none">Reason
							Name </label>
				        <s:input id="txtReasonName" path="strReasonDesc"
							style="display:none" /></td>

				</tr>

				<tr id="CommitteeMemberRole" style="height:70px !important;">

					<td><label id="lblCommitteeMemberRoleCode"
						style="display: none">Role Code</label>
					       <s:input id="txtCommitteeMemberRoleCode"
							path="strRoleCode" cssClass="searchTextBox" style="display:none" readonly="true"
							ondblclick="funHelp('WCCommitteeMemberRole')" /></td>
					<td><label id="lblCommitteeMemberRoleDesc"
						style="display: none">Role Desc </label>
					       <s:input id="txtCommitteeMemberRoleDesc"
							path="strRoleDesc" style="display:none" /></td>
					<td><label id="lblCommitteeMemberRoleRank"
						style="display: none">Role Rank </label>
				          <s:input id="txtCommitteeMemberRoleRank"
							path="intRoleRank" style="display:none" /></td>

				</tr>

				<tr id="Relation" style="height:70px !important;">

					<td><label id="lblRelationCode" style="display: none">Relation
							Code</label>
					   <s:input id="txtRelationCode" path="strRelationCode"  readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCRelationMaster')" /></td>
					<td><label id="lblRelationName" style="display: none">Relation
							Name </label>
					     <s:input id="txtRelationName" path="strRelationDesc"
							style="display:none" /></td>
					<td><label id="lblAgeLimit" style="display: none">Age
							Limit </label>
					    <s:input id="txtAgeLimit" path="strAgeLimit"
							style="display:none" /></td>

				</tr>

				<tr id="Staff" style="height:70px !important;">

					<td><label id="lblStaffCode" style="display: none">Staff
							Code</label>
					     <s:input id="txtStaffCode" path="strStaffCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCStaffMaster')" /></td>
					<td><label id="lblStaffName" style="display: none">Staff
							Name </label>
					      <s:input id="txtStaffName" path="strStaffName"
							 style="display:none" /></td>

				</tr>

				<tr id="CurrencyDetails" style="height:70px !important;">

					<td><label id="lblCurrencyDetailsCode" style="display: none">CurrencyDetails
							Code</label>
						<s:input id="txtCurrencyDetailsCode" path="strCurrCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCCurrencyDetailsMaster')" /></td>
					<td><label id="lblCurrencyDetailsName" style="display: none">CurrencyDetails
							Name </label>
						<s:input id="txtCurrencyDetailsName" path="strDesc"
					             style="display:none" /></td>
					<td><label id="lblCurrUnit" style="display: none">Currency
							Unit</label>
						<s:input id="txtCurrUnit" path="strCurrUnit"
						          style="display:none" /></td>
				</tr>

				<tr id="CurrencyDetails2" style="height:70px !important;">


					<td><label id="lblExchangeRate" style="display: none">Exchange
							Rate </label>
						<s:input id="txtExchangeRate" path="strExchangeRate"
							  style="display:none" /></td>
					<td><label id="lblTraChkRate" style="display: none">TraChkRate
						</label>
						<s:input id="txtTraChkRate" path="strTraChkRate"
							 style="display:none" /></td>
					<td><label id="lblDec" style="display: none">intDec</label>
						<s:input id="txtDec" path="intDec" 
							style="display:none" /></td>
				</tr>

				<tr id="CurrencyDetails3" style="height:70px !important;">


					<td><label id="lblShortDesc" style="display: none">Short
							Desc </label>
						<s:input id="txtShortDesc" path="strShortDesc"
							 style="display:none" /></td>
					<td><label id="lblLongDeciDesc" style="display: none">Long Desc
						</label>
						<s:input id="txtLongDeciDesc" path="strLongDeciDesc"
						       style="display:none" /></td>
					<td><label id="lblShortDeciDesc" style="display: none">Short Desc</label>
						<s:input id="txtShortDeciDesc" path="strShortDeciDesc"
							style="display:none" /></td>
				</tr>

				<tr id="InvitedBy" style="height:70px !important;">

					<td><label id="lblInvitedByCode" style="display: none">InvitedBy
							Code</label>
							<s:input id="txtInvitedByCode" path="strInvCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCInvitedByMaster')" /></td>
					<td><label id="lblInvitedByName" style="display: none">InvitedBy
							Name </label>
						<s:input id="txtInvitedByName" path="strInvName"
							   style="display:none" /></td>
					<td><label id="lblMecompCode" style="display: none">MecompCode
					</label>
						<s:input id="txtMecompCode" path="strMecompCode"
							 style="display:none" /></td>

				</tr>

				<tr id="ItemCategory" style="height:70px !important;">

					<td><label id="lblItemCategoryCode" style="display: none">ItemCategory
							Code</label>
						<s:input id="txtItemCategoryCode"
							path="strItemCategoryCode" cssClass="searchTextBox" readonly="true"
							style="display:none" ondblclick="funHelp('WCItemCategoryMaster')" /></td>
					<td><label id="lblItemCategoryName" style="display: none">ItemCategory
							Name </label>
						<s:input id="txtItemCategoryName"
							path="strItemCategoryName" 
							style="display:none" /></td>
					<td><label id="lblAccountIn" style="display: none">AccountIn
						</label>
						<s:input id="txtAccountIn" path="strAccountIn"
							 style="display:none" /></td>

				</tr>

				<tr id="ItemCategory2" style="height:70px !important;">



					<td><label id="lblSideledgerCode" style="display: none">SideledgerCode
						</label>
						<s:input id="txtSideledgerCode" path="strSideledgerCode"
							 style="display:none" /></td>
					<td><label id="lblTaxCode" style="display: none">TaxCode</label>
						<s:input id="txtTaxCode" path="strTaxCode"
							 style="display:none" /></td>
					<td><label id="lblTaxName" style="display: none">Tax
							Name</label>
						<s:input id="txtTaxName" path="strTaxName"
							 style="display:none" /></td>
					<td><label id="lblTaxType" style="display: none">Tax
							Type</label>
						<s:input id="txtTaxType" path="strTaxType"
							 style="display:none" /></td>
				</tr>

				<tr id="ItemCategory3" style="height:70px !important;">

					<td><label id="lblGLCode" style="display: none">GLCode
						</label>
						<s:input id="txtGLCode" path="strGLCode"
							 style="display:none" /></td>

					<td><label id="lblAddUserId" style="display: none">AddUserId
						</label>
						<s:input id="txtAddUserId" path="strAddUserId"
							 style="display:none" /></td>
					<td><label id="lblItemTypeCode" style="display: none">ItemTypeCode</label>
						<s:input id="txtItemTypeCode" path="strItemTypeCode"
							 style="display:none" /></td>
				</tr>
				<tr id="ItemCategory4" style="height:70px !important;">



					<td><label id="lblCatItemType" style="display: none">CatItemType
						</label>
						<s:input id="txtCatItemType" path="strCatItemType"
							 style="display:none" /></td>
					<td><label id="lblDisAccIn" style="display: none">DisAccIn</label>
						<s:input id="txtDisAccIn" path="strDisAccIn"
							 style="display:none" /></td>

					<td><label id="lblFreeze" style="display: none">Freeze
						</label>
						<s:input id="txtFreeze" path="strFreeze"
							 style="display:none" /></td>
				</tr>
				<tr id="Profile" style="height:70px !important;">

					<td><label id="lblProfileCode" style="display: none">Profile
							Code</label>
						<s:input id="txtProfileCode" path="strProfileCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCProfileMaster')" /></td>
					<td><label id="lblProfileName" style="display: none">Profile
							Name </label>
						<s:input id="txtProfileName" path="strProfileDesc"
							 style="display:none" /></td>

				</tr>

				<tr id="Salutation" style="height:70px !important;">

					<td><label id="lblSalutationCode" style="display: none">Salutation
							Code</label>
						<s:input id="txtSalutationCode" path="strSalutationCode" readonly="true"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCSalutationMaster')" /></td>
					<td><label id="lblSalutationName" style="display: none">Salutation
							Name </label>
						<s:input id="txtSalutationName" path="strSalutationDesc"
							 style="display:none" /></td>

				</tr>

				<tr id="Title" style="height:70px !important;">

					<td><label id="lblTitleCode" style="display: none">Title
							Code</label>
						<s:input id="txtTitleCode" path="strTitleCode"
							cssClass="searchTextBox" style="display:none"
							ondblclick="funHelp('WCTitleMaster')" /></td>
					<td><label id="lblTitleName" style="display: none">Title
							Name </label>
						<s:input id="txtTitleName" path="strTitleDesc"
							 style="display:none" /></td>

				</tr>


			</table>
			<p>
				<s:input type="hidden" id="hidMasterID" path="strMasterID"></s:input>
			</p>
			
			<div class="center" style="text-align: center;">
				<a href="#"><button class="btn btn-primary center-block" value="Submit" onclick="return funCheckTableActive()" class="form_button">Submit</button></a> 
				&nbsp;
				<a href="#"><button class="btn btn-primary center-block" type="reset" value="Reset" class="form_button" onclick="funResetField()">Reset</button></a>
			</div>

		</s:form>
	</div>
</body>
</html>

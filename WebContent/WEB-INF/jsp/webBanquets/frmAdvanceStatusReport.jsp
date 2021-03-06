<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var fieldName="";
	/**
	 * Ready Function for Ajax Waiting and reset form
	 */
	$(document).ready(function() 
		{
			$(document).ajaxStart(function()
		 	{
			    $("#wait").css("display","block");
		  	});
		 	
			$(document).ajaxComplete(function()
			{
			    $("#wait").css("display","none");
			});				
			
		});
		
		/**
		 * Ready Function for Initialization Text Field with default value 
		 * Set Date in date picker
		 * Getting session value
		 */
		$(function() 
		{
	    	var startDate="${startDate}";
			var arr = startDate.split("/");
			Date1=arr[0]+"-"+arr[1]+"-"+arr[2];	
	    	$( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });		
			$("#txtFromDate" ).datepicker('setDate', Date1);
			$( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });		
			$("#txtToDate" ).datepicker('setDate', 'today');		
		});

		
		
		/**
		 * Open help windows
		 */
		function funHelp(transactionName)
		{
		  	fieldName=transactionName;
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
		}
		
		 /**
		 * Set Data after selecting form Help windows
		 */
		function funSetData(code)
		{
			switch (fieldName) 
			{
			    
			}
		}
		

		 /**
		   * Checking Validation before submiting the data
		  **/
		 function btnSubmit_Onclick() 
			{	
			 
				var spFromDate=$("#txtFromDate").val().split('-');
				var spToDate=$("#txtToDate").val().split('-');
				var FromDate= new Date(spFromDate[2],spFromDate[1]-1,spFromDate[0]);
				var ToDate = new Date(spToDate[2],spToDate[1]-1,spToDate[0]);
				if(!fun_isDate($("#txtFromDate").val())) 
			    {
					 alert('Invalid From Date');
					 $("#txtFromDate").focus();
					 return false;  
			    }
			    if(!fun_isDate($("#txtToDate").val())) 
			    {
					 alert('Invalid To Date');
					 $("#txtToDate").focus();
					 return false;  
			    }
				if(ToDate<FromDate)
				{
						alert("To Date Should Not Be Less Than Form Date");
				    	$("#txtToDate").focus();
						return false;		    	
				}
		    	if($("#txtFromDate").val()=='')
			    {
			    	alert("Please enter From Date");
			    	return false;
			    }
			    if($("#txtToDate").val()=='')
			    {
			    	alert("Please enter To Date");
			    	return false;
			    }	 			    
			}			
		
	   /**
		 * Reset form
		**/
		function funResetFields()
		{
			location.reload(true); 
		}
		</script>
	</head>
<body>
	<div class="container transTable">
		<label id=lblFormHeader style="font-family:'trebuchet ms';font-size: 20px;color: #646777;font-weight: bold;padding:0px;">Receipt Register Report</label>
	   <s:form id="formTag" name="frmAdvanceStatusReport" method="POST" action="rptAdvanceStatusReport.html" target="_blank">
	
	   <div class="row">
          
				<div class="col-md-2"><label>From Date</label>
				        <s:input id="txtFromDate" path="dtFromDate" value="" readonly="readonly" cssClass="calenderTextBox" required="true" style="width:70%;"/>
				</div>
				
				<div class="col-md-2"><label>To Date</label>
				        <s:input id="txtToDate" path="dtToDate" value="" readonly="readonly" cssClass="calenderTextBox " required="true" style="width:70%;"/>
		        </div>
			</div>
				
		<br>
		<p align="center" style="margin-right: 57%;">
			<input type="submit" value="Submit" class="btn btn-primary center-block" class="form_button" onclick="return btnSubmit_Onclick()" /> 
			&nbsp;
			<input type="button" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()" />
		</p>
		
		<div id="wait" style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
			<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
		</div>
	</s:form>
	</div>
</body>
</html>
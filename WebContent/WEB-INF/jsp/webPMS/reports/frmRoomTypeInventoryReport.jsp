<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
    
</head>
<script>

   function funValidateFields()
	{
		var flag=false;
			flag=true;
			
			var fromDate=$("#dteFromDate").val();
 			var strDocType=$("#cmbDocType").val();
			
			var fd=fromDate.split("-")[0];
			var fm=fromDate.split("-")[1];
			var fy=fromDate.split("-")[2];

			
			$("#dteFromDate").val(fy+"-"+fm+"-"+fd);
			
		
			
			window.open(getContextPath()+"/rptRoomTypeInventoryReport.html?fromDate="+fy+"-"+fm+"-"+fd+"&strDocType="+strDocType);
		
		return flag;
	}


//set date
		$(document).ready(function(){
			
			var pmsDate='<%=session.getAttribute("PMSDate").toString()%>';
			
			$("#dteFromDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
			$("#dteFromDate").datepicker('setDate', pmsDate);	
			
			
			$("#dteToDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
			$("#dteToDate").datepicker('setDate', pmsDate);	
		});
		
		
		
		
</script>
<body onload="funOnLoad();">
	<div class="container masterTable">
		<label id="formHeading">Room Type Inventory </label>
	     <s:form name="frmRoomTypeInventory" method="GET" action="" >
		<div class="row">
            <div class="col-md-3">
			    <div class="row">
					 <div class="col-md-6"><label>Date</label>
				          <s:input type="text" id="dteFromDate" path="dteFromDate" required="true" class="calenderTextBox" />
				     </div>
				     
<!-- 				<td><label>To Date</label></td> -->
<%-- 				<td><s:input type="text" id="dteToDate" path="dteToDate" required="true" class="calenderTextBox" /></td>				 --%>
		             
		              <div class="col-md-6"><label>Report Type </label>
				           <s:select id="cmbDocType" path="strDocType">
						         <s:option value="PDF">PDF</s:option>
						         <s:option value="XLS">EXCEL</s:option>
					       </s:select>
					  </div>
			      </div>
		  </div></div>
		<br>
	<p align="center" style="margin-right:66%">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button" onclick="return funValidateFields()"/>&nbsp;
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>	
	</s:form>
   </div>
</body>
</html>
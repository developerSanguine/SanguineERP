<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>

<script type="text/javascript">
/**
 * Open help windows
 */
function funHelp(transactionName)
{
	fieldName=transactionName;
    
   // window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
    window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
}

/**
 * Set Data after selecting form Help windows
 */
function funSetData(code)
{
	$("#txtSCGRNCode").val(code);
	

}



</script>
<body>
	<div class="container">
	  <label id="formHeading">GRN SC Report</label>
	   <s:form name="frmGRNSCReport" method="GET" action="rptGRNSCReport.html" >
		<input type="hidden" value="${urlHits}" name="saddr">
		<br>
		<div class="row transTable">
			<div class="col-md-2"><label>Sub Contractor Return Code</label>
				<s:input path="strDocCode" id="txtSCGRNCode" ondblclick="funHelp('SCGRNCode')" cssClass="searchTextBox" />
			</div>
		</div>
		<br>
		<p align="left" style="margin-left:10%;">
			<input type="submit" value="Submit" onclick="" class="btn btn-primary center-block" class="form_button" /> &nbsp; 
			<a STYLE="text-decoration: none" href="frmGRNSCReport.html?saddr=${urlHits}">
			<input type="button" id="reset" name="reset" value="Reset" class="btn btn-primary center-block" class="form_button"/></a>
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
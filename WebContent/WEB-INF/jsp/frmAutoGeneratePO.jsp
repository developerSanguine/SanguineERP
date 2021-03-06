<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
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
 
 <style>
 #formName {
	font-family: 'trebuchet ms';
	font-size: 20px;
	color: #646777;
	font-weight: bold;
	padding:0px;
}
 </style>
<script type="text/javascript">
function getContextPath() {
	return window.location.pathname.substring(0, window.location.pathname
			.indexOf("/", 2));
	
}


$(function()
		{
			
		//	boolean flgStkCal = false;
			$("#txtFromInvDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
		 	$("#txtToInvDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
		 	$('#txtFromInvDate').datepicker('setDate', 'today');
		 /* 	Date todayDate = new Date();
		 	alert(todayDate.get);
		 	var arr = Date[0].split("-");
			Dat=arr[2]+"-"+arr[1]+"-"+arr[0];	 */
		 	$('#txtToInvDate').datepicker('setDate', 'today');
			
		});
		
		
	function funOpenHelp(transactionName)
	{
		fieldName = transactionName;
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1100px;dialogLeft:200px;")
	}

	function funSetData(code)
	{
		switch (fieldName)
		{
		    case 'productInUse':
		    	funSetProduct(code);
		        break;
		        
		}
	}
	
	function funSetProduct(code)
	{
		var fDate = $("#txtFromInvDate").val();
		fDate = fDate.split("-")[2]+"-"+fDate.split("-")[1]+"-"+fDate.split("-")[0];
		var tDate = $("#txtToInvDate").val();
		tDate = tDate.split("-")[2]+"-"+tDate.split("-")[1]+"-"+tDate.split("-")[0];
		var intDays = $("#txtIntNoDays").val();
		var suppCode=$("#hidSuppCode").val();
		
		var searchUrl="";
		searchUrl=getContextPath()+"/loadProdPOData.html?prodCode="+code+"&dtFrom="+fDate+"&dtTo="+tDate+"&noDays="+intDays+"&suppCode="+suppCode,
		$.ajax
		({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    success: function(response)
		    {
		    	//alert(response.strUOM);
		    	if('Invalid Code' == response.strProdCode){
		    		alert('Invalid Product Code');
			    	$("#txtProdCode").val('');
			    	$("#lblProdName").text('');
			    	$("#txtProdCode").focus();
		    	}
		    	else
		    	{
			    	$("#txtProdCode").val(response.strProdCode);
			    	$('#txtProdCode').attr('readonly', true);
			    	$("#lblProdName").text(response.strProdName);
			    	$("#lblUOM").text(response.strUOM.toUpperCase());
			    	
			    	$("#hidOrderQty").val(response.dblOrderQty);
			    	$("#hidCurrStk").val(response.dblCurrentStk);
			    	$("#hidPOQty").val(response.dblOpenPOQty);
			    	$("#hidTotQty").val(response.dblTotalQty);
			    	
			    	$("#hidWeight").val(response.dblWeight);
			    	$("#hidUnitPrice").val(response.dblUnitPrice);
			    	$("#hidSuppCode").val(response.strSuppCode);
			    	$("#hidSuppName").val(response.strSuppName);
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

	
	 function btnClose_onclick()
	 {
		
		 $.ajax({				
			 	type: "POST",
			    url: $("#autoPO").attr("action"),
			    data:$("#autoPO").serialize(),
			    async: false,
			    context: document.body,
			    dataType: "json",
			    success: function(response)
			    {	
						str=response;
						window.returnValue = str;
						window.close();
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
	 
	 function funAddProduct()
	 {
		 var table = document.getElementById("tblProdDet");
		 var rowCount = table.rows.length;
		 var row = table.insertRow(rowCount); 
		 var strProdCode=  $("#txtProdCode").val();
		 var strProdName=  $("#lblProdName").text();
		 var strUOM=  $("#lblUOM").text();
		 var dblOrderQty= $("#hidOrderQty").val();
		 var dblCurrentStk=	$("#hidCurrStk").val();
		 var dblOpenPOQty= $("#hidPOQty").val();
		 var dblTotalQty= $("#hidTotQty").val();
		 
		 var dblWeight = $("#hidWeight").val();
		 var dblUnitPrice =	$("#hidUnitPrice").val();
	     var strSuppCode = $("#hidSuppCode").val();
	     var strSuppName = 	$("#hidSuppName").val();
		 
		 row.insertCell(0).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" size=\"8%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
		 row.insertCell(1).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"34%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
		 row.insertCell(2).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].strUOM\" readonly=\"readonly\" class=\"Box\" size=\"8%\" id=\"txtUOM."+(rowCount)+"\" value='"+strUOM+"'/>";
		 row.insertCell(3).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblOrderQty\" readonly=\"readonly\" class=\"Box\" size=\"8%\"  style=\"text-align: right;\" class=\"decimal-places inputText-Auto QtyCell\" id=\"txtOpenPOQty."+(rowCount)+"\" value="+dblOrderQty+" >";
		 row.insertCell(4).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblCurrentStk\" readonly=\"readonly\" class=\"Box\"  size=\"8%\"  style=\"text-align: right;\" class=\"decimal-places inputText-Auto\" id=\"txtCurrentStk."+(rowCount)+"\" value="+dblCurrentStk+" >";
		 row.insertCell(5).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblOpenPOQty\" readonly=\"readonly\" class=\"Box\" size=\"8%\" style=\"text-align: right;\" \size=\"3.9%\" id=\"txtOpenPOQty."+(rowCount)+"\"   value='"+dblOpenPOQty+"'/>";
		 row.insertCell(6).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblTotalQty\" type=\"text\" required = \"required\" size=\"6%\" style=\"text-align: right;border: 1px solid #a2a2a2; padding: 1px;\" class=\"decimal-places-amt inputText-Auto price\" id=\"txtTotalQty."+(rowCount)+"\" value="+dblTotalQty+" >";
		 row.insertCell(7).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)"  style=\"margin-left: 45%;\" >';	 
		 
		 row.insertCell(8).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblWeight\" readonly=\"readonly\" class=\"Box\" type=\"hidden\"   value="+dblWeight+" >";
		 row.insertCell(9).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" type=\"hidden\"  value="+dblUnitPrice+" >";
		 row.insertCell(10).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].strSuppCode\" readonly=\"readonly\" class=\"Box\"  type=\"hidden\"  value='"+strSuppCode+"'/>";
		 row.insertCell(11).innerHTML= "<input name=\"listAutoGenPOBean["+(rowCount)+"].strSuppName\" type=\"text\" required = \"required\" type=\"hidden\" value='"+strSuppName+"' >";
		 
		 funResetField();
	 }
	
	 function funDeleteRow(obj) 
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblProdDet");
		    var rowCount = table.rows.length;
		    table.deleteRow(index);		   
			
		}
	
	function funResetField()
	{
		 $("#txtProdCode").val('');
		 $("#lblProdName").text('');
		 $("#lblUOM").text('');
		 $("#hidOrderQty").val('');
		 $("#hidCurrStk").val('');
		 $("#hidPOQty").val('');
		 $("#hidTotQty").val('');
		 
		 $("#hidWeight").val('');
		 $("#hidUnitPrice").val('');
	     $("#hidSuppCode").val('');
	     $("#hidSuppName").val('');
	}
	
</script>

</head>
<body style="height: 100%">
<div class="container" style="width: 100%;height: 100%;background-color:#d8d8d894; ">
<div id="formHeading">
		<label id="formName">Auto Generate Purchase Order From Sales</label>
	</div>
	<br><br>
	<s:form id="autoPO" name="autoPO" method="post" action="SaveSessionPO.html">
	
	<div class="row masterTable">
		
		<div class="col-md-2"><label>From Sales Date</label>
		      <s:input path="dtFromInvDate" id="txtFromInvDate"	pattern="\d{1,2}-\d{1,2}-\d{4}" required="required" cssClass="calenderTextBox" />
		</div>
											
		<div class="col-md-2"><label>To Sales Date</label>									
		     <s:input path="dtToInvDate" id="txtToInvDate" pattern="\d{1,2}-\d{1,2}-\d{4}" required="required" cssClass="calenderTextBox" />
		</div>		
		<div class="col-md-8"></div>
		
		<div class="col-md-2"><label>No of Days</label>	
		      <s:input id="txtIntNoDays" value="1" type="text" path="intNoDays" ></s:input>																
		</div>
		
		<div class="col-md-2"><label>Product</label>
			   <input id="txtProdCode" ondblclick="funOpenHelp('productInUse');" class="searchTextBox" />
	     </div>
	     
		<div class="col-md-2"><label id="lblProdName" class="namelabel"></label></div>
		<div class="col-md-2"><label id="lblUOM" class="namelabel" ></label></div>								

<!-- 		<td ><input id="txtUOM"  class="BoxW124px"></input></td>								 -->
		
		<div class="col-md-2"><br><input type="button" value="Add" onclick="funAddProduct()" class="btn btn-primary center-block"  />						
		</div>
	</div>
		
		<div class="dynamicTableContainer" style="height: 300px;">
								<table
									style="height: 20px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
									<tr bgcolor="#c0c0c0">
										<td width="5%">Product Code</td>
										<!--  COl1   -->
										<td width="14%">Product Name</td>
										<!--  COl2   -->
										<td width="5%">UOM</td>
										<!--  COl3   -->
										<td width="5%">Order Qty</td>
										<!--  COl4   -->
										<td width="4%">Current Stock</td>
										<!--  COl5   -->
										<td width="5%">Open PO Qty</td>
										<!--  COl6   -->
										<td width="5%">Total Qty</td>
										<!--  COl7   -->
										<td width="4%">Delete</td>
										<!--  COl8   -->
										
									</tr>
								</table>
								<div
									style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
									<table id="tblProdDet"
										style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
										class="transTablex col15-center">
										<tbody>
										<col style="width: 6%">
										<!--  COl1   -->
										<col style="width: 18%">
										<!--  COl2   -->
										<col style="width: 6%">
										<!--  COl3   -->
										<col style="width: 6%">
										<!--  COl4   -->
										<col style="width: 6%">
										<!--  COl5   -->
										<col style="width: 6%">
										<!--  COl6   -->
										<col style="width: 6%">
										<!--  COl7   -->
										<col style="width: 4%">
										<!--  COl8   -->
										<col style="width: 0%">
										<!--  COl9   -->
										<col style="width: 0%">
										<!--  COl10   -->
										<col style="width: 0%">
										<!--  COl11   -->
										<col style="width: 0%">
										<!--  COl12   -->
										
										
										</tbody>

									</table>
								</div>

							</div>
				
		<table>
		
		
			<tr>
<!-- 				<td><input type="submit" value="Add Document" /></td> -->
				
				<input id="btnClose" type="submit" value="Close" style="text-align:center;" class="btn btn-primary center-block"  class="smallButton" onclick="btnClose_onclick()" />
			</tr>
		</table>
		
		<s:input type="hidden" id="hidOrderQty" path="dblOrderQty"></s:input>
			<s:input type="hidden" id="hidCurrStk" path="dblCurrentStk"></s:input>
			<s:input type="hidden" id="hidPOQty" path="dblOpenPOQty"></s:input>
			<s:input type="hidden" id="hidTotQty" path="dblTotalQty"></s:input>
			<s:input type="hidden" id="hidWeight" path="dblWeight"></s:input>
			<s:input type="hidden" id="hidUnitPrice" path="dblUnitPrice"></s:input>
			<s:input type="hidden" id="hidSuppCode" path="strSuppCode" value="${suppCode}" ></s:input>
			<s:input type="hidden" id="hidSuppName" path="strSuppName"></s:input>
	</s:form>
   </div>

</div>
</body>
</html>
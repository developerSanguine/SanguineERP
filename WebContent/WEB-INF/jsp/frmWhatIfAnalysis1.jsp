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

	<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>	
	<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>

<style type="text/css">
.contents{
 min-height: calc(100vh - -100px);
}

</style>	
	
<script>
 	
	var ExportData;
	var dblRate=0.0;
		$(function ()
		{
			$("#btnSubmit").click(function( event )
			{
				$("#t2").trigger('click');
				funGetChildNodes();
			});
			
			$('#txtProdCode').blur(function () {
			  	var code=$('#txtProdCode').val();   
				if (code.trim().length > 0 && code !="?" && code !="/"){
					funSetProduct(code);
				}
			});
			
			$('#txtOPCode').blur(function () {
			  	var code=$('#txtOPCode').val();   
				if (code.trim().length > 0 && code !="?" && code !="/"){
					funSetOPData(code);
				}
			});
		});
		
		$(document).ready(function() {
			$(".tab_content").hide();
			$(".tab_content:first").show();
			$("ul.tabs li").click(function() 
			{
				$("ul.tabs li").removeClass("active");
				$(this).addClass("active");
				$(".tab_content").hide();

				var activeTab = $(this).attr("data-state");
				$("#" + activeTab).fadeIn();
			});
		});
		
		
		function funHelp(transactionName)
		{
			fieldName=transactionName;
	    //    window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	        window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	    }
		
		
		function funSetData(code)
		{
			switch (fieldName)
			{
			    case 'ProductRecipe':
			    	funSetProduct(code);
			    	break;
			    	
			    case 'ProductionOrder':
			    	$("#txtOPCode").val(code);
					funSetOPData(code);
					break;
			}
		}
		
		
		function funRemProdRows() {
			var table = document.getElementById("tblProduct");
			var rowCount = table.rows.length;

			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		
		function funRemChildProdRows() {
			var table = document.getElementById("tblChildNodes");
			var rowCount = table.rows.length;

			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		
		function funGetChildNodes()
		{
			funRemChildProdRows();
			var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;
		    var prodList="",prodQtyList="";
		    for(var cnt=0;cnt<rowCount;cnt++)
		    {
		    	var prodCode=document.getElementById("txtProdCode."+cnt).value;		    	
		    	var qty=document.getElementById("txtQuantity."+cnt).value;
		    	prodList+=","+prodCode+"!"+qty;
		    }
		    var rateFrom=$("#cmbRatePickUpFrom").val();
		    var semiProduct=$("#cmbSemiProduct").val();
		    
		    	var searchUrl=getContextPath()+"/getChildNodes1.html?prodCode="+prodList+"&rateFrom="+rateFrom+"&semiProduct="+semiProduct;
		    	
		    	$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {				    	
				    	$.each(response, function(i,itemDtl)
						{				    		
							/*funAddChildProducts(itemDtl[0],itemDtl[1],itemDtl[2],itemDtl[3].toFixed(maxQuantityDecimalPlaceLimit),itemDtl[4].toFixed(maxAmountDecimalPlaceLimit),itemDtl[5]
							,itemDtl[6],itemDtl[7],itemDtl[8],itemDtl[9],itemDtl[10].toFixed(maxAmountDecimalPlaceLimit),itemDtl[11],itemDtl[12]);*/
							
				    		funAddChildProducts(itemDtl.prodCode,itemDtl.prodName,itemDtl.uom,itemDtl.reqdQty.toFixed(maxQuantityDecimalPlaceLimit)
				    			,itemDtl.currentStock.toFixed(maxAmountDecimalPlaceLimit),itemDtl.openPOQty,itemDtl.orderQty
								,itemDtl.suppCode,itemDtl.suppName,itemDtl.leadTime,itemDtl.amount.toFixed(maxAmountDecimalPlaceLimit),itemDtl[11],itemDtl[12]);
							
						});
				    	
				    	funAddTotal();
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
		    	
				/*$.ajax({
				        type: "GET",
				        url: searchUrl,
					    dataType: "json",
					    success: function(response)
					    {
					    	for(var cnt=0;cnt<response.length;cnt++)
					    	{
					    		funAddChildProducts(response[cnt][0],response[cnt][1],response[cnt][2],response[cnt][3]
					    		,response[cnt][4],response[cnt][5],response[cnt][6],response[cnt][7],response[cnt][8],response[cnt][9]
					    		,response[cnt][10],response[cnt][11],response[cnt][12]);
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
				      });*/
		    
		}
		
		
		function funAddChildProducts(childCode,childName,partNo,reqQty,currentStk,openPO,orderQty,suppCode
				,suppName,leadTime,rate,expectedDate,value) 
		{   
		    var table = document.getElementById("tblChildNodes");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtProdCode."+(rowCount)+"\" value="+childCode+">";
		    row.insertCell(1).innerHTML= "<input width=\"10%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtProdName."+(rowCount)+"\" value='"+childName+"'>";
		    row.insertCell(2).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPartNo."+(rowCount)+"\" value="+partNo+">";
		    row.insertCell(3).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtQuantity."+(rowCount)+"\" value="+reqQty+">";
		    row.insertCell(4).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+currentStk+">";
		    row.insertCell(5).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+openPO+">";
		    row.insertCell(6).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+orderQty+">";
		    row.insertCell(7).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+suppCode+">";
		    row.insertCell(8).innerHTML= "<input width=\"10%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+suppName+">";
		    row.insertCell(9).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+leadTime+">";
		    row.insertCell(10).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+rate+">";
		    row.insertCell(11).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+expectedDate+">";
		    row.insertCell(12).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+value+">";		    
		    row.insertCell(13).innerHTML= '<input width=\"5%\" type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';		    
		    dblRate=parseFloat(dblRate)+parseFloat(rate);
		    return false;
		}
		function funAddTotal()
		{
			var table = document.getElementById("tblChildNodes");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    dblRate=dblRate.toFixed(maxAmountDecimalPlaceLimit)
		    
		    row.insertCell(0).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtProdCode."+(rowCount)+"\" value=>";
		    row.insertCell(1).innerHTML= "<input width=\"10%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtProdName."+(rowCount)+"\" value=>";
		    row.insertCell(2).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPartNo."+(rowCount)+"\" value=>";
		    row.insertCell(3).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtQuantity."+(rowCount)+"\" value=>";
		    row.insertCell(4).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(5).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(6).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(7).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(8).innerHTML= "<input width=\"10%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(9).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value='Total'>";
		    row.insertCell(10).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value="+dblRate+">";
		    row.insertCell(11).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";
		    row.insertCell(12).innerHTML= "<input width=\"5%\" readonly=\"readonly\" class=\"Box\" name=\"listChild["+(rowCount)+"]\" id=\"txtPrice."+(rowCount)+"\" value=>";		    
		    row.insertCell(13).innerHTML= '<input width=\"5%\" readonly=\"readonly\" class=\"Box\"  value =  >';		    
		}
		
		function funSetOPData(code) 
		{
			funRemProdRows();
			searchUrl = getContextPath() + "/loadOPDtlData.html?OPCode=" + code;
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				success : function(response) {
					$.each(response, function(i, item) {
						funAddProdDetailsForProdOrder(response[i].strProdCode,response[i].strProdName,''
								,response[i].dblQty,response[i].dblUnitPrice);
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
		
		
		function funSetProduct(code)
		{	
			var searchUrl=getContextPath()+"/loadProductFromRecipe.html?prodCode="+code;
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	$.each(response, function(i,item)
						{
				    		$("#txtProdCode").val(response[i][0]);
				    		$("#lblProdName").text(response[i][2]);
				    		$("#lblPartNo").text(response[i][1]);
				    		$("#txtQuantity").focus();
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
		
		
		function funAddProdDetailsRow() 
		{
		    var prodCode = $("#txtProdCode").val();
		    var prodName = $("#lblProdName").text();
		    var partNo = $("#lblPartNo").text();
		    var qty = $("#txtQuantity").val();
		    var price = $("#txtPrice").val();
		    //arrParentProd=arrParentProd+","+prodCode;
		    
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtProdCode."+(rowCount)+"\" value="+prodCode+ ">";
		    row.insertCell(1).innerHTML= "<input width=\"15%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtProdName."+(rowCount)+"\" value='"+prodName+"'>";
		    row.insertCell(2).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtPartNo."+(rowCount)+"\" value="+partNo+">";
		    row.insertCell(3).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtQuantity."+(rowCount)+"\" value="+qty+">";
		    row.insertCell(4).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtPrice."+(rowCount)+"\" value="+price+">";
		    row.insertCell(5).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';
		    funResetFields();
		    return false;
		}
		
		function funAddProdDetailsForProdOrder(prodCode,prodName,partNo,qty,price) 
		{
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    //arrParentProd=arrParentProd+","+prodCode;
		    
		    row.insertCell(0).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtProdCode."+(rowCount)+"\" value="+prodCode+">";
		    row.insertCell(1).innerHTML= "<input width=\"15%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtProdName."+(rowCount)+"\" value='"+prodName+"' \> ";
		    row.insertCell(2).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtPartNo."+(rowCount)+"\" value="+partNo+">";
		    row.insertCell(3).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtQuantity."+(rowCount)+"\" value="+qty+">";
		    row.insertCell(4).innerHTML= "<input width=\"4%\" readonly=\"readonly\" class=\"Box\" name=\"listProduct["+(rowCount)+"]\" style=\"width:100%;\" id=\"txtPrice."+(rowCount)+"\" value="+price+">";
		    row.insertCell(5).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';
		    
		    return false;
		}
		
		function funResetFields()
		{
			$("#txtProdCode").val('');
			$("#lblProdName").text('');
			$("#lblPartNo").text('');
			$("#txtQuantity").val('0');
			$("#txtPrice").val('0');
		}
		
		 $(document).ready(function () {
		 $("#btnExport").click(function() {  
			  var dtltbl = $('#dvWhatIf').html(); 
			  window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#dvWhatIf').html()));
			});
		 });
		 
		 function funDeleteRow(obj)  
			{
			    var index = obj.parentNode.parentNode.rowIndex;
			    var table = document.getElementById("tblProduct");
			    table.deleteRow(index);
			    
			}
		 
	</script>
</head>
<body>
	<div class="container">
		<label id="formHeading">What If Analysis</label>
		<s:form action="saveWhatIfAnanlysis.html" method="POST" name="whatIfAnanlysis">
		<div id="tab_container">
			<ul class="tabs">
				<li class="active" id="t1" data-state="tab1">General</li>
				<li data-state="tab2" id="t2">What If Analysis</li>
			</ul>
	
			<div id="tab1" class="tab_content" style="height: 500px;">
				<div class="row transTable">
					<div class="col-md-12">
						<p style="font-size:13px; margin-top:10px;">Product Details</p>	
					</div>
						<div class="col-md-2">						
							<label>Product</label>
							<input id="txtProdCode" type="text" ondblclick="funHelp('ProductRecipe');" Class="searchTextBox"/>
						</div>
						<div class="col-md-2">
							<label id="lblProdName" style="background-color:#dcdada94;  text-align:center;width: 100%; height: 42%; margin: 27px 0px;" ></label>
						</div>
						<div class="col-md-2">
							<label id="lblPartNo" style="background-color:#dcdada94; text-align:center; width: 100%; height: 42%; margin: 27px 0px;"></label>
						</div>
						<div class="col-md-6"></div>
						<div class="col-md-2">
							<label>Quantity</label>
							<input id="txtQuantity" type="text" Class="decimal-places-amt numberField"/>
						</div>
						<div class="col-md-2">
							<label>Price</label>
							<input id="txtPrice" type="text" Class="decimal-places-amt numberField"/>
						</div>
						<div class="col-md-2">		
							<label>Rate PickUp From</label>
							<select  id="cmbRatePickUpFrom" class="BoxW48px" style="width:130px" >
								<option selected="selected" value="Product Master">Product Master</option>
								<option value="Last Purchase Rate">Last Purchase Rate</option>
							</select>
						</div>
						<div class="col-md-6"></div>
						<div class="col-md-2">		
							<label>Show Semi Product</label>
							<select  id="cmbSemiProduct" class="BoxW48px" style="width:50%;" >
								<option selected="selected" value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
						</div>
						<div class="col-md-2">		
							<input type="button" value="ADD" onclick="funAddProdDetailsRow();" class="btn btn-primary center-block" style="margin-top:23px;"/>
						</div>
				</div>
						
				<br>		
				<div class="row transTable">
					<div class="col-md-2">	
						<label>Production Order Code</label>
						<input id="txtOPCode" type="text" ondblclick="funHelp('ProductionOrder');" Class="searchTextBox"/>
					</div>
				</div>
				
				<div class="dynamicTableContainer" style="height: 150px;width:70%;">
					<table style="height:20px;border:#0F0;width:100%;font-size:11px;font-weight: bold;">
						<tr bgcolor="#c0c0c0">
							<td width="6%">Product Code</td>
							<td width="6%">Product Name</td>
							<td width="4%">Part No</td>
							<td width="4%">Quantity</td>
							<td width="5%">Price</td>
							<td width="1%">Delete</td>
						</tr>
					</table>
						<div style="background-color:#fbfafa;
						   border: 1px solid #ccc;
						   display: block;
						   height: 250px;
						   margin: auto;
						   overflow-x: hidden;
						   overflow-y: scroll;
						   width: 100%;">
						   
						<table id="tblProduct" style="width:100%;border:
							#0F0;table-layout:fixed;overflow:scroll" class="transTablex ">		
							
						<tbody>
							<col style="width: 5%">
							<!-- col1   -->
							
							<col style="width: 6%">
							<!-- col3   -->
							<col style="width: 4%">
							<!-- col4   -->
							<col style="width: 4%">
							<!-- col5   -->
							<col style="width: 4%">
							<!-- col6   -->
							<col style="width: 2%">
							<!-- col7   -->
				
						</tbody>
						</table>
					</div>
				</div>
				<br><br>
			</div>
			
			<div id="tab2" class="tab_content" style="margin-top:52px;height: 305px;"> 
<!-- 				<table class="transTable"> -->
<!-- 					<tr><th colspan="6" align="left">  </th></tr> -->
<!-- 				</table> -->
							
<!-- 				<table class="transTable" id="tblWhatIFFlashColumns"> -->
<!-- 					<tr> -->
<!-- 						<td width="5%">Product Code</td> -->
<!-- 						<td width="7%">Product Name</td> -->
<!-- 						<td width="5%">UOM</td> -->
<!-- 						<td width="5%">Qty Required</td> -->
<!-- 						<td width="5%">Current Stock</td> -->
<!-- 						<td width="5%">Open PO</td> -->
<!-- 						<td width="5%">Order Qty</td> -->
<!-- 						<td width="5%">Supplier Code</td> -->
<!-- 						<td width="7%">Supplier Name</td> -->
<!-- 						<td width="5%">Lead Time</td> -->
<!-- 						<td width="5%">Rate</td> -->
<!-- 						<td width="5%">Expected Date</td>						 -->
<!-- 					</tr> -->
<!-- 				</table> -->
						
<!-- 				<div id="dvWhatIf" style="width: 100% ;height: 100% ;padding-left: 26px;"> -->
<!-- 					<table class="transTablex col14-center" id="tblChildNodes"> -->
<!-- 						<tbody> -->
<%-- 					<col style="width: 4%"> --%>
<!-- 					col1   -->
					
<%-- 					<col style="width: 10%"> --%>
<!-- 					col3   -->
<%-- 					<col style="width: 2%"> --%>
<!-- 					col4   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col5   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col6   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col7   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col8   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col9   -->
<%-- 					<col style="width: 10%"> --%>
<!-- 					col10   -->
					
<%-- 					<col style="width: 5%"> --%>
<!-- 					col11   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col12   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col13   -->
<%-- 					<col style="width: 5%"> --%>
<!-- 					col14   -->
<%-- 					<col style="width: 2%"> --%>
<!-- 					</tbody> -->
<!-- 					</table> -->
<!-- 				</div> -->
				
<!-- 				<p align="center"> -->
<!-- 					<input id="btnExport" type="button" value="EXPORT" id="export" class="form_button" /> -->
<!-- 				</p> -->
<!-- 			</div> -->

		<div class="dynamicTableContainer" id="dvWhatIf" style="height: 330px; overflow-x:hidden;border-style:none;">
			<table style="height: 20px; border: #0F0;width: 100%;font-size:11px;overflow-x:scroll;
			font-weight: bold;">
				<tr bgcolor="#c0c0c0">
<!-- 					<td width="6%">Prod Code</td>					 -->
<!-- 					<td width="22%">Product Name</td>	 -->
<!-- 					<td width="3%">UOM</td>	 -->
<!-- 					<td width="3%">Stock</td>				 -->
<!-- 					<td width="5%">Issue Qty</td> -->
<!--                     <td width="5%">Pending Qty</td>  -->
<!--                     <td width="5%">Unit Price</td> -->
<!--                     <td width="5%">Total Price</td>  -->
<!--                     <td width="8%">MR Code</td>         -->
<!-- 					<td width="14%">Remarks</td> -->
<!-- 					<td width="5%">Delete</td> -->

					<td width="3%">Product Code</td> 
 						<td width="7%">Product Name</td>
 						<td width="2.3%">UOM</td> 
 						<td width="4%">Qty Required</td> 
						<td width="4%">Current Stock</td> 
						<td width="3%">Open PO</td>
						<td width="3%">Order Qty</td>
 						<td width="3%">Supplier Code</td>
						<td width="7%">Supplier Name</td> 
 						<td width="3%">Lead Time</td> 
 						<td width="3%">Amt</td> 
 						<td width="3%">Expected Date</td>
 						<td width="3%"></td>
 						<td width="2%"></td>	

				</tr>
			</table>
			<div
				style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 230px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
					<table id="tblChildNodes"
					style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
					class="transTablex col11-center">
					<tbody>
					<col style="width: 3.2%">
<!-- 					col1   -->
					
					<col style="width: 7%">
<!-- 					col3   -->
					<col style="width: 2.3%">
<!-- 					col4   -->
					<col style="width: 4%">
<!-- 					col5   -->
					<col style="width: 4%">
<!-- 					col6   -->
					<col style="width: 3%">
<!-- 					col7   -->
					<col style="width: 3%">
<!-- 					col8   -->
					<col style="width: 3.5%">
<!-- 					col9   -->
					<col style="width: 7%">
<!-- 					col10   -->
					
					<col style="width: 2.8%">
<!-- 					col11   -->
					<col style="width: 3%">
<!-- 					col12   -->
					<col style="width: 3%">
<!-- 					col13   -->
					<col style="width: 3%">
<!-- 					col14   -->
					<col style="width: 1%">
					</tbody>
				</table>
			</div>
			<p align="center">
				<input id="btnExport" type="button" value="EXPORT" id="export" class="btn btn-primary center-block" style="margin-top:20px;"/>
			</p>
		</div>
	</div>

	<div class="center" style="text-align:center">
		 <a href="#"><button class="btn btn-primary center-block" id="btnSubmit" id="formsubmit" value="Submit">Submit</button></a>
		 &nbsp;
		 <a href="#"><button class="btn btn-primary center-block"  value="Reset" onclick=" return funResetField()">Reset</button></a>
	</div>

	</div>
	</s:form>
</div>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
<style type="text/css">
  .transTable{
    width:100%;
    }
  #tblStockLedger tr:first-child{
     background-color: #c0c0c0;
     }
   #dvStockLedgerSummary tr:first-child{
     background-color: #c0c0c0;
     }
</style>	
	
<script>
	var dblLastSuppRate=0;
		$(function ()
		{
			/* var startDate="${startDate}";
			var arr = startDate.split("/");
			Dat=arr[0]+"-"+arr[1]+"-"+arr[2]; */
			
			var startDate="${startDate}";
			var arr = startDate.split("/");
			
			
			<%-- strLastSuppRateShowInStockFlash= '<%= request.getAttribute("strLastSuppRateShowInStockFlash") %>';
			if(strLastSuppRateShowInStockFlash==null){
				strLastSuppRateShowInStockFlash='N';
			} --%>
			 
			 
			var date = new Date(); 
			var month=date.getMonth()+1;
            Dat= 1 +"-"+month+"-"+date.getFullYear();
			$( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtFromDate" ).datepicker('setDate', Dat);
			$( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtToDate" ).datepicker('setDate', 'today');
			 var strPropCode='<%=session.getAttribute("propertyCode").toString()%>';
			 var locationCode ='<%=session.getAttribute("locationCode").toString()%>';
			 $("#cmbProperty").val(strPropCode);
			 $("#cmbLocation").val(locationCode);
			
			 var weightedRate = 0.0;
			
			$("#btnExecute").click(function( event )
			{
				if($("#txtProdCode").val()=='')
				{
					alert("Enter Product Code!");
					return false;
				}
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var table = document.getElementById("tblStockLedger");
				var rowCount = table.rows.length;
				while(rowCount>0)
				{
					table.deleteRow(0);
					rowCount--;
				}
				var table1 = document.getElementById("tblStockLedgerSummary");
				var rowCount1 = table1.rows.length;
				while(rowCount1>0)
				{
					table1.deleteRow(0);
					rowCount1--;
				}
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var locCode=$("#cmbLocation").val();
				var propCode=$("#cmbProperty").val();
				var prodCode=$("#txtProdCode").val();
				//funGetStockLedger(fromDate,toDate,locCode,propCode,prodCode);
			
			});
			
			$('a#urlDocCode').click(function() 
			{
			    $(this).attr('target', '_blank');
			});
			
			$("#txtProdCode").blur(function(){
				var code = $('#txtProdCode').val();
				if(code.trim().length > 0 && code !="?" && code !="/"){
					funSetProduct(code);
				}
			})
			
			$("#tdBAtchLabel").hide();
			$("#tdBatchTxt").hide();
		});
		
		
		
		function funGetStockLedger(fromDate,toDate,locCode,propCode,prodCode)
		{
			var batchNo = $("#txtBatch").val();
			var qtyWithUOM=$("#cmbQtyWithUOM").val();
			var param1=locCode+","+propCode+","+prodCode+",detail,"+qtyWithUOM;
			var searchUrl=getContextPath()+"/frmStockLedgerReport.html?param1="+param1+"&fDate="+fromDate+"&tDate="+toDate+"&batchCode="+batchNo;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funShowStockLedger(response);
				    },
					error: function(e)
				    {
				       	alert('Error:=' + e);
				    }
			      });
		}
		
		
		function funShowStockLedger(response)
		{
			var qtyWithUOM=$("#cmbQtyWithUOM").val();
			$("#lblFromDate1").text("From");
			var fd=$("#txtFromDate").val();
			var td=$("#txtToDate").val();
			var openingstockwithUOM=0;
			var closingstockwithUOM=0;
			
			var fromDate=funGetDate(fd,"dd/MM/yyyy");
			var toDate=funGetDate(td,"dd/MM/yyyy");
			
			var table = document.getElementById("tblStockLedger");
			var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    var freeQty=0;
		    
		    var issueConversion = 0.0;
		    
			row.insertCell(0).innerHTML= "<label>Transaction Date</label>";
			row.insertCell(1).innerHTML= "<label>CostCenter/Supplier Name</label>";
			row.insertCell(2).innerHTML= "<label>Transaction Type</label>";
			row.insertCell(3).innerHTML= "<label>Ref No</label>";
			row.insertCell(4).innerHTML= "<label>Receipt</label>";
			row.insertCell(5).innerHTML= "<label>Issue</label>";
			row.insertCell(6).innerHTML= "<label>Balance</label>";
			row.insertCell(7).innerHTML= "<label>Rate</label>";
			row.insertCell(8).innerHTML= "<label>Value</label>";
			//row.insertCell(9).innerHTML= "";
			rowCount=rowCount+1;
			//var records = [];
			   	var currValue='<%=session.getAttribute("currValue").toString()%>';
		    		if(currValue==null)
		    			{
		    				currValue=1;
		    			}
			$.each(response, function(i,item)
			{
				if(qtyWithUOM.includes("Yes"))
				{
					
					issueConversion = parseFloat(item[7].split("!")[0]);	
				}
				
				var row1 = table.insertRow(rowCount);
				if(item[2]!='')
				{
					
					row1.insertCell(0).innerHTML= "<label>"+item[0]+"</label>";
					row1.insertCell(1).innerHTML= "<label>"+item[5]+"</label>";
					row1.insertCell(2).innerHTML= "<label>"+item[1]+"</label>";
					row1.insertCell(3).innerHTML= "<a id=\"urlDocCode\" style=\"text-decoration: underline;\" href=\"openSlip.html?docCode="+item[2]+","+item[1]+"\" target=\"_blank\" >"+item[2]+"</a>";
// 			   		row1.insertCell(4).innerHTML= "<label>"+item[3].toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
// 				   	row1.insertCell(5).innerHTML= "<label>"+item[4].toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
				   		if(qtyWithUOM=='Yes')
			   		{
				   		row1.insertCell(4).innerHTML= "<label>"+item[3]+"</label>";
					   	/* row1.insertCell(5).innerHTML= "<label>"+parseFloat(item[4]).toFixed(maxQuantityDecimalPlaceLimit)+"</label>"; */
					   	row1.insertCell(5).innerHTML= "<label>"+item[4]+"</label>";
					   /* 	if(item[4].includes(".")){
					   		row1.insertCell(5).innerHTML= "<label>"+item[4]+"</label>";	
					   	}else {
					   		if(item[4].includes())
					   	}
				   		 */
			   		}else
			   			{
			   			row1.insertCell(4).innerHTML= "<label>"+item[3].toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					   	row1.insertCell(5).innerHTML= "<label>"+item[4].toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
			   			}
				   	
				   	
				   	row1.insertCell(6).innerHTML= "<label>0</label>";
				   	row1.insertCell(7).innerHTML= "<label>"+item[6]/currValue+"</label>";
				   	row1.insertCell(8).innerHTML= "<label>0</label>";
				   	if(qtyWithUOM=='Yes')
			   		{				   	
				   	    row1.insertCell(9).innerHTML= "<input type=\"hidden\" value='"+item[7]+"'/>";
				   		//row1.insertCell(8).innerHTML= "<label type=\"hidden\">"+item[7]+"</label>";
			   		}
				   	if(item[7].toString().includes("!"))
			   		{
			   		    freeQty += parseFloat(item[8]);
			   		}
				   	else
			   		{
			   			freeQty += parseFloat(item[7]);
			   		}
				 
				}
			});
			
			var bal=0;
			var balInRecipe=0,receiptInRec=0,issueInRec=0;
			var balUOM=0;
			var openingStk=0;
			var totalRec=0,totalIssue=0;
			var rowCount1 = table.rows.length;
		    var tableRows=table.rows;
		    var rateForValue=0;
		
		for (var cnt = 1; cnt < rowCount1; cnt++) {
				var cells1 = tableRows[cnt].cells;
            
				var rec = cells1[4].innerHTML;
				rec = rec.substring(7, rec.lastIndexOf("<"));
				var issue = cells1[5].innerHTML;
				issue = issue.substring(7, issue.lastIndexOf("<"));
				
				var qtyWithUOM = $("#cmbQtyWithUOM").val();
				var transName = cells1[2].innerHTML;
				
				var rate1 = cells1[7].innerHTML;
				var rate = parseFloat(rate1.substring(7, rate1.lastIndexOf("<")));
				var value =0;
				if (qtyWithUOM == 'No') 
				{
					var negtveSign="";
					if(issue.charAt(0)=="-")
					{
					   var issueData=issue.substring(1,issue.length);
					   bal = bal + (parseFloat(rec) + parseFloat(issue));
					
					}
					else
					{
					   bal = bal + (parseFloat(rec) - parseFloat(issue));
					}
					cells1[6].innerHTML = "<label>"+bal.toFixed(maxQuantityDecimalPlaceLimit)+ "</label>";
// 						bal = negtveSign+""+bal;
				} 
				else
				{
					var tempRecipts = 0;
					var tempIssue = 0;
					var totRowBal = 0;
					var uom = cells1[9].innerHTML;
					//alert(uom);

// 					uom = uom.substring(14, uom.lastIndexOf("type") - 2);
					//uom = uom.substring(uom.lastIndexOf("value")+7, uom.length-16);
					//alert(uom);
					var spUOM = funCheckNull(uom.split('!'));
					var recipeConv = funCheckNull(spUOM[0]);
					var spUOM = funCheckNull(uom.split('!'));
					var recipeConv = funCheckNull(spUOM[0]);
					var issueConv = funCheckNull(spUOM[1]);
					var receivedUOM =funCheckNull( spUOM[2]);
					var recipeUOM = funCheckNull(spUOM[3].substring(0, spUOM[3].length - 2));
					
					var convRecipe=funCheckNull(spUOM[0].split('value="')[1]);
					
					
					if (rec == '0') {
						tempRecipts += parseFloat(rec);
					} else {
						var dblReptHigh = 0;
						var dblRectlow = 0;

						if (rec.indexOf(receivedUOM) > -1) {
							var highNLowData = rec.split(".");
							var highNo = highNLowData[0].split(" ");
							dblReptHigh = parseFloat(highNo[0])	* parseFloat(recipeConv.substr(28));
							var lowNo = highNLowData[1].split(" ");
							if(lowNo !="")
							{
								dblRectlow = parseFloat(lowNo[0]);
								var totHighlowRecipt = dblReptHigh + dblRectlow;
								tempRecipts = parseFloat(tempRecipts)+ totHighlowRecipt;
							}else
							{
								tempRecipts = parseFloat(tempRecipts)+ dblReptHigh;
							}
							
						} 
						else 
						{
							if(rec=="")
							{
								
							}
							else
							{
								dblRectlow = rec.split(" ");
								dblRectlow = parseFloat(dblRectlow[0]);
								tempRecipts = parseFloat(tempRecipts) + dblRectlow;
							}
							
						}

					}
					if (transName != '<label>Opening Stk</label>') {
						receiptInRec=receiptInRec+tempRecipts;	
					}
					

					if (issue == '0') {
						tempIssue += parseFloat(issue);
					} else {
						var dblIssHigh = 0;
						var dblIsslow = 0;

						if (issue.indexOf(receivedUOM) > -1) {
							var highNLowData = issue.split(".");
							var highNo = highNLowData[0].split(" ");
							dblIssHigh = parseFloat(highNo[0])* parseFloat(recipeConv.substr(28));

							var lowNo = highNLowData[1].split(" ");
							if(lowNo !="")
							{
								dblIsslow = parseFloat(lowNo[0]);
								var totHighlowIssue = dblIssHigh + dblIsslow;
								tempIssue = parseFloat(tempIssue) + totHighlowIssue;
							}else
								{
									tempIssue = parseFloat(tempIssue) + dblIssHigh;
								}
							
						} else {
							dblIsslow = issue.split(" ");
							dblIsslow = parseFloat(dblIsslow[0]);
							tempIssue = parseFloat(tempIssue) + dblIsslow;
						}

					}
					
					if (transName != '<label>Opening Stk</label>') {
						issueInRec =issueInRec+tempIssue;	
					}
					
					if(tempIssue.toString().includes("-"))
						{
						totRowBal = tempRecipts + tempIssue;
							if(tempRecipts>0 ){
								value = parseFloat((rate * tempRecipts /( convRecipe /issueConv) ) + (rate * tempIssue / (convRecipe  /issueConv))).toFixed(maxAmountDecimalPlaceLimit);
							}else{
								value = parseFloat((rate * tempIssue / convRecipe)).toFixed(maxAmountDecimalPlaceLimit);
							}
						}
					else
						{
							totRowBal = tempRecipts - tempIssue;
							if(tempRecipts>0 ){
								value = parseFloat((rate * tempRecipts / convRecipe) - (rate * tempIssue / convRecipe)).toFixed(maxAmountDecimalPlaceLimit);
							}else{
								value = parseFloat((rate * tempIssue / convRecipe)).toFixed(maxAmountDecimalPlaceLimit);
							}
								
							
						}
					
					balInRecipe =balInRecipe + totRowBal;
					totRowBal = parseFloat(totRowBal) / parseFloat(recipeConv.substr(28));

					bal = bal +parseFloat(totRowBal.toFixed(maxAmountDecimalPlaceLimit));
					
					var restQty = 0;
					var balance = bal + "";
					var spBalance = balance.split('.');

					if ((bal + "").indexOf('.') > -1) {
						restQty = parseFloat(bal)- parseFloat(spBalance[0]);
					}

					var finalBal = "";
					if (spBalance[0] != 'undefined') {
						finalBal = spBalance[0] + ' ' + receivedUOM;
					}
					if (spBalance[1] != "undefined") {
						var balWithUOM = parseFloat(parseFloat(restQty.toFixed(maxAmountDecimalPlaceLimit))* parseFloat(recipeConv.substr(28))).toFixed(0);//mahesh 
						if(qtyWithUOM.includes("Yes"))
							{
							if(recipeUOM!='NOS'){
							finalBal = finalBal + '.' + balWithUOM + ' '+ recipeUOM;
							}
							}
						else
							{
							finalBal = finalBal + '.' + balWithUOM.toFixed(maxAmountDecimalPlaceLimit) + ' '+ recipeUOM;
							}
						
					}

					var highQty = balInRecipe / parseFloat(recipeConv.substr(28));
					
					var tmpHigQty = highQty.toString().split('.');						
					finalBal = tmpHigQty[0] +' ' + receivedUOM;
					if(tmpHigQty.length> 1){
						
						var tmpLowQty = parseFloat('0.'+tmpHigQty[1]) *  parseFloat(recipeConv.substr(28)); 
						tmpLowQty=tmpLowQty.toFixed(0);
						finalBal =finalBal + '.'+ tmpLowQty +' '+recipeUOM;
					}
					
					// 	
					if(cnt== rowCount1-1 )
					{
						closingstockwithUOM=finalBal;
					}
					
					
					cells1[6].innerHTML = "<label>" + finalBal + "</label>";
				}

				cells1[7].innerHTML = "<label>"	+ rate.toFixed(maxAmountDecimalPlaceLimit) + "</label>";
//convRecipe  issueConv
				var issueOrReceipt = parseFloat(rec)  + parseFloat(issue);
				
				if(qtyWithUOM == 'No'){
					value = parseFloat(rate * issueOrReceipt).toFixed(maxAmountDecimalPlaceLimit);
				}
				cells1[8].innerHTML = "<label>" + value + "</label>";				
				var transName = cells1[2].innerHTML;
				if (transName == '<label>Opening Stk</label>') {
					openingStk = bal;
					openingstockwithUOM=finalBal;
				} else {
					if(rec==""){
						
					}
					else
						{
						totalRec = totalRec + parseFloat(rec);
							/* if(qtyWithUOM.includes("Yes")){
								totalRec = totalRec + (tempRecipts / convRecipe);
						}
					*/
						} 
					
					if(parseFloat(issue)>0)
						{
						totalIssue = totalIssue + parseFloat(issue);
						/* if(qtyWithUOM.includes("Yes")){
								totalIssue = totalIssue + (tempIssue / convRecipe);		
							} */
						}
					else
						{
						totalIssue = totalIssue +0;
						}
					
				}

				rateForValue = rate;
			}
			/// for loop end
			//get weighted avg price from product master 
			if(weightedRate>0){
				rateForValue=weightedRate;
			}
			if($("#cmbPriceCalculation").val()=="Last Supplier Rate"){
				if(dblLastSuppRate>0){
					rateForValue=dblLastSuppRate;
				}
			}
			if(qtyWithUOM.includes("Yes")){
				totalRec = receiptInRec / convRecipe;
				totalIssue = issueInRec / convRecipe;
				
			}
			/* if(qtyWithUOM.includes("Yes"))
				{
				totalIssue = totalIssue/issueConversion;
				} */
				/* if(qtyWithUOM.includes("Yes")){
				
					var fromDate=$("#txtFromDate").val();
					var toDate=$("#txtToDate").val();
					var locCode=$("#cmbLocation").val();
					var propCode=$("#cmbProperty").val();
					var prodCode=$("#txtProdCode").val();
					funGetStockLedgerWithUom(fromDate,toDate,locCode,propCode,prodCode);
					totalIssue = totalIssueWithUom;
					totalIssueWithUom=0;
				} */
							
/* 			var closingBalance = parseFloat(openingStk) + parseFloat(totalRec)+parseFloat(freeQty);
*/
			var qtyWithUOM=$("#cmbQtyWithUOM").val();
            
 			var closingBalance = parseFloat(openingStk) + parseFloat(totalRec);
 			closingBalance = closingBalance - parseFloat(totalIssue);

			var table = document.getElementById("tblStockLedgerSummary");
			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);
			row.insertCell(0).innerHTML = "<label>Transaction Type</label>";
			row.insertCell(1).innerHTML = "<label>Quantity</label>";
			row.insertCell(2).innerHTML = "<label>Value</label>";
			rowCount = rowCount + 1;

			var row1 = table.insertRow(rowCount);
			row1.insertCell(0).innerHTML = "<label>Opening Stock</label>";
			if(qtyWithUOM == 'No')
			{
				row1.insertCell(1).innerHTML = "<label>"+ parseFloat(openingStk).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
			}
			else
			{
				row1.insertCell(1).innerHTML = "<label>"+ openingstockwithUOM + "</label>";
			}
			if(openingStk < 0){
				openingStk = openingStk * (-1); 
			}
			row1.insertCell(2).innerHTML = "<label>"+ (parseFloat(openingStk) * parseFloat(rateForValue)).toFixed(maxAmountDecimalPlaceLimit) + "</label>";

			rowCount = rowCount + 1;
			row1 = table.insertRow(rowCount);
			row1.insertCell(0).innerHTML = "<label>Total Receipts</label>";
			row1.insertCell(1).innerHTML = "<label>"+ parseFloat(totalRec).toFixed(maxQuantityDecimalPlaceLimit)+ "</label>";
			row1.insertCell(2).innerHTML = "<label>"+ (parseFloat(totalRec) * parseFloat(rateForValue)).toFixed(maxAmountDecimalPlaceLimit) + "</label>";

			
			if(freeQty > 0 ){
			rowCount = rowCount + 1;
			row1 = table.insertRow(rowCount);
 			row1.insertCell(0).innerHTML = "<label>Free Quantity</label>";
			row1.insertCell(1).innerHTML = "<label>"+ parseFloat(freeQty).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
			row1.insertCell(2).innerHTML = "<label>"+parseFloat(0).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
 		
			}
			rowCount = rowCount + 1;
			row1 = table.insertRow(rowCount);
			row1.insertCell(0).innerHTML = "<label>Total Issues</label>";
			row1.insertCell(1).innerHTML = "<label>"+ parseFloat(totalIssue).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
			row1.insertCell(2).innerHTML = "<label>"+ (parseFloat(totalIssue) * parseFloat(rateForValue)).toFixed(maxAmountDecimalPlaceLimit) + "</label>";

			rowCount = rowCount + 1;
			row1 = table.insertRow(rowCount);
			row1.insertCell(0).innerHTML = "<label>Closing Balance</label>";
			 if(qtyWithUOM == 'No')
			{ 
				row1.insertCell(1).innerHTML = "<label>"+ parseFloat(closingBalance).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
				
		    }
			else
			{
				row1.insertCell(1).innerHTML = "<label>"+ closingstockwithUOM + "</label>";
				
			} 
			row1.insertCell(2).innerHTML = "<label>"+ (parseFloat(closingBalance) * parseFloat(rateForValue)).toFixed(maxAmountDecimalPlaceLimit) + "</label>";
			
			
			
		}
		function funCheckNull(chkValue){
			
			if(chkValue=="null"){
				chkValue="";
			}
			return chkValue;
		}
		
		function sortFunction(a, b) {
			var dateA = getDate(a).getTime();
			var dateB = getDate(b).getTime();
			return dateA < dateB ? 1 : -1;
		}

		function getDate(obj) {
			var parts = obj.tran_date.split('-');
			return new Date(parts[2], parts[1] - 1, parts[0]);
		}
		
		function funLoadLastGRNRate(productCode){
		
			var searchUrl = "";
			var clientCode="${clientCode}";
			searchUrl = getContextPath()
					+ "/loadLastGRNRate.html?prodCode=" + productCode+"&clientCode="+clientCode;
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				async :false,
				success : function(response) {
					dblLastSuppRate=response;
				},
				error : function(e) {
					alert('Error:=' + e);
				}
			});
		}

		function funGetDate(date, format) {
			var retDate = '';
			if (format == 'dd-MM-yyyy') {
				var arr = date.split('-');
				retDate = arr[2] + "-" + arr[1] + "-" + arr[0];
			} else if (format == 'dd/MM/yyyy') {
				var arr = date.split('/');
				retDate = arr[2] + "-" + arr[1] + "-" + arr[0];
			}
			return retDate;
		}

		function funHelp(transactionName) {
			$("#tdBAtchLabel").hide();
			$("#tdBatchTxt").hide();
			$("#txtBatch").val('');
			var locCode=$("#cmbLocation").val();
			fieldName = transactionName;
			//window.open("searchform.html?formname="+transactionName+"&searchText=", 'window', 'width=600,height=600');
			//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
			window.open("searchform.html?formname=" + transactionName+"&locationCode="+locCode+"&searchText=", "",
					"dialogHeight:600px;dialogWidth:1000px;dialogLeft:200px;")
		}

		function funSetData(code) {
			switch (fieldName) {
			case 'productmaster':
				funSetProduct(code);
				break;
				
				
			case 'Batch':
				funSetBatch(code);
				break;
				
				
			}
			
		}

		function funSetProduct(code) {
			var searchUrl = "";

			searchUrl = getContextPath()
					+ "/loadProductMasterData.html?prodCode=" + code;
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				async :false,
				success : function(response) {
					$("#txtProdCode").val(response.strProdCode);
					$("#lblProdName").text(response.strProdName);
					weightedRate = response.dblCostRM;
					dblLastSuppRate=0;
					funBatchCheck(response.strProdCode);
					
				},
				error : function(e) {
					alert('Error:=' + e);
				}
			});
			
			if($("#cmbPriceCalculation").val()=="Last Supplier Rate"){
				funLoadLastGRNRate(code);	
			}
			
		}
		$(document).ready(
				function() {
					$("#btnExport").click(
							function() {
								/* var dtltbl = $('#dvStockLedger').html(); 
								window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#dvStockLedger').html())); 
								 */

								/*var reportType=$("#cmbExportType").val();
								var locName=$("#cmbLocation option:selected").text();
								var strProdName= $('#lblProdName').text();
								var dtFromDate=$("#txtFromDate").val();
								var dtToDate=$("#txtToDate").val();
								var param1=reportType+","+locName+","+strProdName+","+dtFromDate+","+dtToDate;
								window.location.href=getContextPath()+"/frmExportStockLedger.html?param1="+param1;
								 */
								 var batchNo = $("#txtBatch").val();
								var fromDate = $("#txtFromDate").val();
								var toDate = $("#txtToDate").val();
								var locCode = $("#cmbLocation").val();
								var propCode = $("#cmbProperty").val();
								var prodCode = $("#txtProdCode").val();
								var qtyWithUOM = $("#cmbQtyWithUOM").val();
								var ratePickUpFrom = $("#cmbPriceCalculation").val();
								
								//+"&ratePickUpFrom="+ratePickUpFrom
								var param1 = locCode + "," + propCode + ","
										+ prodCode + ",detail," + qtyWithUOM+ ","+ratePickUpFrom;
								window.location.href = getContextPath()
										+ "/frmExportStockLedger.html?param1="
										+ param1 + "&fDate=" + fromDate
										+ "&tDate=" + toDate+"&batchCode="+batchNo;
							});
				});

		$(document).ready(
				function() {
					var flgStkFlash = "${flgStkFlash}";
					if (flgStkFlash == 'true') {
						var param = ("${stkledger}");
						var spParam = param.split(',');
						$("#cmbLocation").val(spParam[1]);
						$("#cmbProperty").val(spParam[2]);
						$("#txtProdCode").val(spParam[0]);
						funSetProduct(spParam[0]);
						$("#txtFromDate").val(spParam[3]);
						$("#txtToDate").val(spParam[4]);

						funGetStockLedger(spParam[3], spParam[4], spParam[1],
								spParam[2], spParam[0]);
					}
				});

		function funChangeLocationCombo() {
			var propCode = $("#cmbProperty").val();
			funFillLocationCombo(propCode);
		}

		function funFillLocationCombo(propCode) {
			var searchUrl = getContextPath()
					+ "/loadForInventryLocationForProperty.html?propCode=" + propCode;
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				success : function(response) {
					var html = '';
					$.each(response, function(key, value) {
						html += '<option value="' + value[1] + '">' + value[0]
								+ '</option>';
					});
					html += '</option>';
					$('#cmbLocation').html(html);
					//$("#cmbLocation").val(loggedInLocation);
				},
				error : function(jqXHR, exception) {
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
		
		function funBatchCheck(code)
		{
			var all = 'ALL';
			var boolBatchCheck;
			var searchUrl = "";

			searchUrl = getContextPath()
					+ "/loadBatchNo.html?prodCode=" + code;
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				async :false,
				success : function(response) {
					boolBatchCheck = response;
					if(boolBatchCheck==true)
						{
						$("#tdBAtchLabel").show();
						$("#tdBatchTxt").show();
						$("#txtBatch").val(all); 
						
						}
					
				},
				error : function(e) {
					alert('Error:=' + e);
				}
			});
		}
		
		function funSetBatch(code)
		{
			$("#txtBatch").val(code);
			
		
		}
		
		function funGetStockLedgerWithUom(fromDate,toDate,locCode,propCode,prodCode)
		{
			var batchNo = $("#txtBatch").val();
			var qtyWithUOM="No";
			var param1=locCode+","+propCode+","+prodCode+",detail,"+qtyWithUOM;
			var searchUrl=getContextPath()+"/frmStockLedgerReport.html?param1="+param1+"&fDate="+fromDate+"&tDate="+toDate+"&batchCode="+batchNo;
			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    async :false,
				    success: function(response)
				    {
				    	funSumOfIssueQty(response);
				    },
					error: function(e)
				    {
				       	alert('Error:=' + e);
				    }
			      });
		}
		var totalIssueWithUom = 0.0;
		function funSumOfIssueQty(response)
		{
			
			$.each(response, function(i,response){
				totalIssueWithUom = totalIssueWithUom + response[4];
				
			})
				
		}
	
		function funValueCalculation(){
			
			if($("#cmbPriceCalculation").val()=="Last Supplier Rate"){
				funLoadLastGRNRate($("#txtProdCode").val());	
			}
		}
		
		function funOnClick()
		{
			if($("#txtProdCode").val()=='')
			{
				alert("Enter Product Code!");
				return false;
			}
			
			var fromDate=$("#txtFromDate").val();
			var toDate=$("#txtToDate").val();
			var table = document.getElementById("tblStockLedger");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
			
			var table1 = document.getElementById("tblStockLedgerSummary");
			var rowCount1 = table1.rows.length;
			while(rowCount1>0)
			{
				table1.deleteRow(0);
				rowCount1--;
			}
			
			var fromDate=$("#txtFromDate").val();
			var toDate=$("#txtToDate").val();
			var locCode=$("#cmbLocation").val();
			var propCode=$("#cmbProperty").val();
			var prodCode=$("#txtProdCode").val();
			funGetStockLedger(fromDate,toDate,locCode,propCode,prodCode);
			
			return false;
		}
		
		
		
	</script>
</head>
<body onload="funOnLoad();">
	<div class="container">
		<label id="formHeading">Stock Ledger</label>
		<s:form action="frmStockLedgerReport.html" method="GET" name="frmStkFlash" id="frmStkFlash">
			<div class="row transTable">
				<div class="col-md-2">
					<label>Property Code</label>
					<s:select id="cmbProperty" name="propCode" path="strPropertyCode" onchange="funChangeLocationCombo();">
			    		<s:options items="${listProperty}"/>
			    	</s:select>
				</div>
				<div class="col-md-2">	
					<label>Location</label>
					<s:select id="cmbLocation" name="locCode" path="strLocationCode">
			    		<s:options items="${listLocation}" />
			    	</s:select>
				</div>	
				<div class="col-md-2">	
					<label>Product</label>
					<input id="txtProdCode" ondblclick="funHelp('productmaster');" class="searchTextBox"/>
			    </div>
			    <div class="col-md-2">	  
			        <label id="lblProdName" style="background-color:#dcdada94; width: 100%; height: 42%; margin: 27px 0px;text-align:center"></label>
			     </div>
			     <div class="col-md-4"></div>
			     <div class="col-md-2">	  
				      <label id="lblFromDate">From Date</label>
			          <s:input id="txtFromDate" name="fromDate" path="dteFromDate" cssClass="calenderTextBox" style="width:80%;"/>
			          <s:errors path="dteFromDate"></s:errors>
			     </div>
			     <div class="col-md-2">	
				      <label id="lblToDate">To Date</label>
			       		<s:input id="txtToDate" name="toDate" path="dteToDate" cssClass="calenderTextBox" style="width:80%;"/>
			        	<s:errors path="dteToDate"></s:errors>
			      </div>
			      <div class="col-md-2">
			        	<label>Quantity With UOM</label>
						<select id="cmbQtyWithUOM" style="width:70%;">
							<option selected="selected">No</option>
							<option>Yes</option>
						</select>
					</div>
			        <div class="col-md-2">
						<label>Value Calculation On </label>
						<select id="cmbPriceCalculation" class="BoxW124px" onchange="funValueCalculation()">
							<option selected="selected">Weighted AVG</option>
							<option>Last Supplier Rate</option>
						</select>
					</div>
					  <div class="col-md-4"></div>
					<div class="col-md-2">
						<s:select path="strExportType" id="cmbExportType" style="margin-top:25px; width:80%;">
<!-- 						<option value="pdf">PDF</option> -->
							<option value="xls">Excel</option>
						</s:select>
					</div>
					<div class="col-md-2">
						<label id="tdBAtchLabel">Batch</label>
					</div>
					<div class="col-md-2">
						<label  id="tdBatchTxt">
			            	<input id="txtBatch" ondblclick="funHelp('Batch');" class="searchTextBox"/>
						</label >
					</div>
				</div>
				<div class="center" style="margin-right:40%;">
					 <a href="#"><button class="btn btn-primary center-block" id="btnExecute" value="Execute" onclick="return funOnClick()" >Execute</button></a>
					 &nbsp;
					  <!-- <a href="#"><button class="btn btn-primary center-block" id="btnExport"  value="Export" >Export</button></a> -->
				      <button type="button" class="btn btn-primary center-block" id="btnExport"  value="Export" >Export</button>
				</div>
			<br>
			
			<!-- 
			<table  class="transTable">
				<tr>
					<td width="100px"><label id="lblFromDate1"></label></td><td>
					<label id="lblFromDate2"></label>
					<label id="lblToDate1"></label>
					<label id="lblToDate2"></label></td>
				</tr>
				
				<tr>
					<td><label id="lblLocName1"></label></td>
					<td><label id="lblLocName2"></label></td>
				</tr>
				
				<tr>
					<td><label id="lblProdCode1"></label></td>
					<td><label id="lblProdCode2"></label></td>
				</tr>
				
				<tr>
					<td><label id="lblProdName1"></label></td>
					<td><label id="lblProdName2"></label></td>
				</tr>
				
				<tr></tr>
				<tr></tr>
				
			</table> -->
			
			<div id="dvStockLedger" style="width: 100% ;height: 100%;border: 1px solid #c0c0c0;background-color: #fafbfb;">
				<table id="tblStockLedger" class="transTable col5-right col6-right col7-right col8-right col9-right"></table>
			</div>
			
			<br><br>
			
			<div id="dvStockLedgerSummary" style="width: 50% ;height:100%;border: 1px solid #c0c0c0;background-color: #fafbfb;margin-left: 15px;">
				<table id="tblStockLedgerSummary"  class="transTable col2-right col3-right">					
				</table>
			</div>
			
	
		<br><br>
	</s:form>
</div>
</body>
</html>

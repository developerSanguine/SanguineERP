<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<title></title>
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 	
	 	<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
<script type="text/javascript">
	
	var fieldName;
	var debtorName='';
	var closingAmt=0.0;
	
	$(function() 
	{
		
		var debtorCode =$("#txtFromDebtorCode").val();
		if(debtorCode!='')
		{
			$("#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtToDate").datepicker({ dateFormat: 'dd-mm-yy' });
			
			funButtonExecute();
			
		}else{
			var startDate="${startDate}";
			var arr = startDate.split("/");
			Dat=arr[0]+"-"+arr[1]+"-"+arr[2];
			$( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtFromDate" ).datepicker('setDate', Dat);
			$("#txtToDate").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtToDate").datepicker('setDate', 'today');
			var glCode = $("#txtGLCode").val();
			
			if(glCode!='')
			{
				funSetGLCode(glCode);
			}	
			
		}
		
		$('#txtGLCode').blur(function() {
			var code = $('#txtGLCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetGLCode(code);
			}
		});

		$('#txtFromDebtorCode').blur(function() {
			var code = $('#txtFromDebtorCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetCreditoMasterData(code);
			}
		});
		
					
	});
	
	function funButtonExecute(){
		var propCode='<%=session.getAttribute("propertyCode").toString()%>';
		if($("#txtGLCode").val()=='')
		{
			alert("Enter GL Code!");
			return false;
		}
		if($("#txtFromDebtorCode").val()=='')
		{
			alert("Enter Creditor Code!");
			return false;
		}
		
		var fromDate=$("#txtFromDate").val();
		var toDate=$("#txtToDate").val();
		var table = document.getElementById("tblCreditorLedgerBill");
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
		
		var table1 = document.getElementById("tblCreditorLedgerBillTot");
		var rowCount1 = table1.rows.length;
		while(rowCount1>0)
		{
			table1.deleteRow(0);
			rowCount1--;
		}
		var glCode = $("#txtGLCode").val();
		var creditorCode =$("#txtFromDebtorCode").val()
		funGetCreditorLedger(fromDate,toDate,glCode,creditorCode,propCode);
		return false;
		
	}
	
	function funButtonExport(){
		var currency=$("#cmbCurrency").val();
		
		var fromDate = $("#txtFromDate").val();
		var toDate = $("#txtToDate").val();
		var glCode = $("#txtGLCode").val();
		var creditorCode = $("#txtFromDebtorCode").val();
		var prodCode = $("#txtProdCode").val();
		var qtyWithUOM = $("#cmbQtyWithUOM").val();
		var param1=glCode+","+creditorCode;
		var reportType = $("#cmbReportType").val();
		var ledgerName = "creditorLedger";
		var glName = $("#lblGLCode").text();
		var creditorName = $("#lblFromDebtorName").text();
		var propCode='<%=session.getAttribute("propertyCode").toString()%>';
		
		var strShowNarration=document.getElementById("chkShowNarration").checked;
		if(reportType=="EXCEL")
		{
			funGetCreditorLedgerDataBeforeExport(fromDate,toDate,glCode,creditorCode,propCode);
			var type=$("#cmbType").val();
		    window.location.href = getContextPath()
				+ "/frmExportLedger.html?param1="
				+ param1 + "&fDate=" + fromDate
				+ "&tDate=" + toDate+"&currency="+currency+"&strShowNarration="+strShowNarration+"&type="+type;
		}
		else
		{
			window.open(getContextPath()+"/rptCreditorReport.html?creditorCode="+creditorCode+"&fromDate="+fromDate+"&toDate="+toDate+"&ledgerName="+ledgerName+"&glCode="+glCode+"&glName="+glName+"&creditorName="+creditorName+"&currency="+currency+"&strShowNarration="+strShowNarration,'_blank');
		}	
		return false;
	}
	
	
	function funGetCreditorLedger(fromDate,toDate,glCode,creditorCode,propCode)
	{
		var currency=$("#cmbCurrency").val();
// 		var currValue=funGetCurrencyCode(currency);
		var currValue=1;
		var param1=glCode+","+creditorCode+","+propCode;
		var type=$("#cmbType").val();
		var searchUrl=getContextPath()+"/getCreditorLedger.html?param1="+param1+"&fDate="+fromDate+"&tDate="+toDate+"&currency="+currency+"&type="+type;
		
 		
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    async:false,
			    success: function(response)
			    {
			    	funShowCreditorLedger(response,currValue);
			    },				
		      });
	}
	
	
	function funShowCreditorLedger(response,currValue)
	{
		if($("#cmbType").val()=="By Account")
		{
		var strShowNarration=document.getElementById("chkShowNarration").checked;
		var table = document.getElementById("tblCreditorLedgerBill");
		var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
		row.insertCell(0).innerHTML= "<label>Transaction Date</label>";
		row.insertCell(1).innerHTML= "<label>Transaction Type</label>";
		row.insertCell(2).innerHTML= "<label>Ref No</label>";
		if(strShowNarration){
			row.insertCell(3).innerHTML= "<label>Narration</label>";
			row.insertCell(4).innerHTML= "<label>Chq/BillNo</label>";
			row.insertCell(5).innerHTML= "<label>BillDate</label>";
			row.insertCell(6).innerHTML= "<label>Dr</label>";
			row.insertCell(7).innerHTML= "<label>Cr</label>";
			row.insertCell(8).innerHTML= "<label>Bal</label>";
				
		}else{
			row.insertCell(3).innerHTML= "<label>Chq/BillNo</label>";
			row.insertCell(4).innerHTML= "<label>BillDate</label>";
			row.insertCell(5).innerHTML= "<label>Dr</label>";
			row.insertCell(6).innerHTML= "<label>Cr</label>";
			row.insertCell(7).innerHTML= "<label>Bal</label>";
			
		}
		
		rowCount=rowCount+1;
		//var records = [];
		var bal=0.00;
		var cr=0.00;
		var dr=0.00;
		var opBal=0.0;
		$.each(response, function(i,item)
		{
			var row1 = table.insertRow(rowCount);
			if(item[2]!='')
			{
				

				var vochDate=item.dteVochDate.split("-");
				vochDate=vochDate[2].split(" ")[0]+"-"+vochDate[1]+"-"+vochDate[0];
			
				var dteBillDate=item.dteBillDate.split("-");
				dteBillDate=dteBillDate[2].split(" ")[0]+"-"+dteBillDate[1]+"-"+dteBillDate[0];
				if(item.strTransType=='Opening')
				{
					dteBillDate='';
					opBal=(parseFloat(item.dblDebitAmt)/currValue)-(parseFloat(item.dblCreditAmt)/currValue);
				}else{
					cr=cr+(parseFloat(item.dblCreditAmt)/currValue);
					dr=dr+(parseFloat(item.dblDebitAmt)/currValue);
					
					
				}
				bal=bal+(parseFloat(item.dblDebitAmt)/currValue)-(parseFloat(item.dblCreditAmt)/currValue);
				var transType="";
				if(item.strChequeBillNo.length<13){
					transType=funCheckBillFrom(item.strChequeBillNo);	
				}
				var strDocNo=item.strChequeBillNo;
				row1.insertCell(0).innerHTML= "<label>"+vochDate+"</label>";
				row1.insertCell(1).innerHTML= "<label>"+item.strTransType+"</label>";
				row1.insertCell(2).innerHTML= "<a id=\"urlDocCode\" href=\"openSlipLedger.html?docCode="+item.strVoucherNo+","+item.strTransType+"\" target=\"_blank\" >"+item.strVoucherNo+"</a>";
				if(strShowNarration){
					row1.insertCell(3).innerHTML= "<label>"+item.strNarration+"</label>";
					if(transType=="GRN"){
						row1.insertCell(4).innerHTML= "<a id=\"urlBillCode\" href=\"openRptGrnSlip.html?rptGRNCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="Payment"){
						row1.insertCell(4).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPaymentReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="Receipt"){
						row1.insertCell(4).innerHTML= "<a id=\"urlBillCode\" href=\"openRptReciptReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="PurReturn"){
						row1.insertCell(4).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPRSlip.html?rptPRCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="JV"){
						row1.insertCell(4).innerHTML= "<a id=\"urlDocCode\" href=\"openSlipLedger.html?docCode="+item.strChequeBillNo+","+item.strTransType+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else{
						row1.insertCell(4).innerHTML= "<label>"+item.strChequeBillNo+"</label>";
					}
					
					row1.insertCell(5).innerHTML= "<label>"+dteBillDate+"</label>";

							
					if(item.dblDebitAmt<0){
					row1.insertCell(6).innerHTML= "<label>("+(item.dblDebitAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)*(-1)+")</label>";
					}else{
						row1.insertCell(6).innerHTML= "<label>"+(item.dblDebitAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}
					if(item.dblCreditAmt<0){
						row1.insertCell(7).innerHTML= "<label>("+(item.dblCreditAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)*(-1)+")</label>";
					}else{
						row1.insertCell(7).innerHTML= "<label>"+(item.dblCreditAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}
					if(bal<0){
					row1.insertCell(8).innerHTML= "<label>("+(bal*(-1)).toFixed(maxQuantityDecimalPlaceLimit)+")</label>";
					}else{
						row1.insertCell(8).innerHTML= "<label>"+bal.toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}
	
					
				}
				else{
					if(transType=="GRN"){
						row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptGrnSlip.html?rptGRNCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="Payment"){
						row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPaymentReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="Receipt"){
						row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptReciptReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="PurReturn"){
						row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPRSlip.html?rptPRCode="+strDocNo+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else if(transType=="JV"){
						row1.insertCell(3).innerHTML= "<a id=\"urlDocCode\" href=\"openSlipLedger.html?docCode="+item.strChequeBillNo+","+item.strTransType+"\" target=\"_blank\" >"+item.strChequeBillNo+"</a>";	
					}else{
						row1.insertCell(3).innerHTML= "<label>"+item.strChequeBillNo+"</label>";
					}
					
					row1.insertCell(4).innerHTML= "<label>"+dteBillDate+"</label>";

							
					if(item.dblDebitAmt<0){
					row1.insertCell(5).innerHTML= "<label>("+(item.dblDebitAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)*(-1)+")</label>";
					}else{
						row1.insertCell(5).innerHTML= "<label>"+(item.dblDebitAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}
					if(item.dblCreditAmt<0){
						row1.insertCell(6).innerHTML= "<label>("+(item.dblCreditAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)*(-1)+")</label>";
					}else{
						row1.insertCell(6).innerHTML= "<label>"+(item.dblCreditAmt/currValue).toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}
					if(bal<0){
					row1.insertCell(7).innerHTML= "<label>("+(bal*(-1)).toFixed(maxQuantityDecimalPlaceLimit)+")</label>";
					}else{
						row1.insertCell(7).innerHTML= "<label>"+bal.toFixed(maxQuantityDecimalPlaceLimit)+"</label>";
					}

				}
				rowCount=rowCount+1;
				
			}	
		});
		
		
		if(rowCount>0)
		{
			table.insertRow(rowCount);
			var rowCount = table.rows.length;
			var row2 = table.insertRow(rowCount);
			row2.insertCell(0).innerHTML= "";
			row2.insertCell(1).innerHTML= "";
			row2.insertCell(2).innerHTML= "";
			if(strShowNarration){
				row2.insertCell(3).innerHTML= "";
				row2.insertCell(4).innerHTML= "";
				row2.insertCell(5).innerHTML= "Total";
				row2.insertCell(6).innerHTML= "<label>"+ parseFloat(dr).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
				row2.insertCell(7).innerHTML=  "<label>"+ parseFloat(cr).toFixed(maxQuantityDecimalPlaceLimit)+ "</label>";
				if(bal<0)
				{
				  bal=(bal)*(-1);
				  row2.insertCell(8).innerHTML = "<label>("+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit) + ")</label>";
				
				}else{
					row2.insertCell(8).innerHTML = "<label>"+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
				}	
			}else{
				row2.insertCell(3).innerHTML= "";
				row2.insertCell(4).innerHTML= "Total";
				row2.insertCell(5).innerHTML= "<label>"+ parseFloat(dr).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
				row2.insertCell(6).innerHTML=  "<label>"+ parseFloat(cr).toFixed(maxQuantityDecimalPlaceLimit)+ "</label>";
				if(bal<0)
				{
				  bal=(bal)*(-1);
				  row2.insertCell(7).innerHTML = "<label>("+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit) + ")</label>";
				
				}else{
					row2.insertCell(7).innerHTML = "<label>"+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
				}
			}
			
		}
		
		var table = document.getElementById("tblCreditorLedgerBillTot");
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		row.insertCell(0).innerHTML = "<label>Transaction Type</label>";
		row.insertCell(1).innerHTML = "<label>Amount</label>";
		rowCount = rowCount + 1;
		
	    var row1 = table.insertRow(rowCount);
		
		row1 = table.insertRow(rowCount);
		row1.insertCell(0).innerHTML = "<label>Opening Balance</label>";
		if(opBal<0)
		{
		row1.insertCell(1).innerHTML = "<label>("+ parseFloat(opBal).toFixed(maxQuantityDecimalPlaceLimit)*(-1) + ")</label>";
		
		}else{
			row1.insertCell(1).innerHTML = "<label>"+ parseFloat(opBal).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
		}
	

		rowCount = rowCount + 1;
		
		row1 = table.insertRow(rowCount);
		row1.insertCell(0).innerHTML = "<label>Total Debit</label>";
		row1.insertCell(1).innerHTML = "<label>"+ parseFloat(dr).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
		
		rowCount = rowCount + 1;
		row1 = table.insertRow(rowCount);
		row1.insertCell(0).innerHTML = "<label>Total Credit</label>";
		row1.insertCell(1).innerHTML = "<label>"+ parseFloat(cr).toFixed(maxQuantityDecimalPlaceLimit)+ "</label>";

		rowCount = rowCount + 1;
		row1 = table.insertRow(rowCount);
		row1.insertCell(0).innerHTML = "<label>Closing Balance</label>";
		if(bal<0){
		row1.insertCell(1).innerHTML = "<label>("+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit)*(-1) + ")</label>";
	    }else{
		row1.insertCell(1).innerHTML = "<label>"+ parseFloat(bal).toFixed(maxQuantityDecimalPlaceLimit) + "</label>";
	    }
		
		closingAmt=bal;
		}
		else
		{
			//var strShowNarration=document.getElementById("chkShowNarration").checked;
			var table = document.getElementById("tblCreditorLedgerBill");
			var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
			row.insertCell(0).innerHTML= "<label>Voucher No</label>";
			row.insertCell(1).innerHTML= "<label>Voucher Date</label>";
			row.insertCell(2).innerHTML= "<label>Bill No</label>";
			
			row.insertCell(3).innerHTML= "<label>GRN No</label>";
			row.insertCell(4).innerHTML= "<label>Due Date</label>";
			row.insertCell(5).innerHTML= "<label>GRN Amount</label>";
			row.insertCell(6).innerHTML= "<label>Payment Amount</label>";
			row.insertCell(7).innerHTML= "<label>Pending Amount</label>";
			row.insertCell(8).innerHTML= "<label>Days Due</label>";
			rowCount=rowCount+1;	
			$.each(response, function(i,item)
					{
					var transType="";
						if(item[3].length<13){
							transType=funCheckBillFrom(item[3]);	
						}
						var row1 = table.insertRow(rowCount);
						row1.insertCell(0).innerHTML= "<a id=\"urlDocCode\" href=\"openSlipLedger.html?docCode="+item[0]+","+item.strTransType+"\" target=\"_blank\" >"+item[0]+"</a>";
							//row1.insertCell(0).innerHTML= "<label>"+item[0]+"</label>";
						row1.insertCell(1).innerHTML= "<label>"+item[1]+"</label>";
						row1.insertCell(2).innerHTML= "<label>"+item[2]+"</label>";
					    //row1.insertCell(3).innerHTML= "<label>"+item[3]+"</label>";
					    var strDocNo=item[3];

					    if(transType=="GRN"){
							row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptGrnSlip.html?rptGRNCode="+strDocNo+"\" target=\"_blank\" >"+item[3]+"</a>";	
						}else if(transType=="Payment"){
							row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPaymentReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item[3]+"</a>";	
						}else if(transType=="Receipt"){
							row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptReciptReport.html?docCode="+strDocNo+"\" target=\"_blank\" >"+item[3]+"</a>";	
						}else if(transType=="PurReturn"){
							row1.insertCell(3).innerHTML= "<a id=\"urlBillCode\" href=\"openRptPRSlip.html?rptPRCode="+strDocNo+"\" target=\"_blank\" >"+item[3]+"</a>";	
						}else if(transType=="JV"){
							row1.insertCell(3).innerHTML= "<a id=\"urlDocCode\" href=\"openSlipLedger.html?docCode="+item[3]+","+item.strTransType+"\" target=\"_blank\" >"+item[3]+"</a>";	
						}else{
							row1.insertCell(3).innerHTML= "<label>"+item[3]+"</label>";
						}
					    row1.insertCell(4).innerHTML= "<label>"+item[4]+"</label>";	
						row1.insertCell(5).innerHTML= "<label>"+item[5]+"</label>";
						row1.insertCell(6).innerHTML= "<label>"+item[6]+"</label>";
						row1.insertCell(7).innerHTML= "<label>"+item[7]+"</label>";
						row1.insertCell(8).innerHTML= "<label>"+item[8]+"</label>";
						rowCount=rowCount+1;
					});
			}

	}

	function funCheckBillFrom(docNo){
		var transType="";
		//var docNo = strNarration.split(":");
		var res = docNo.substring(2, 4);
		 if(res=="IV"){
			 transType="Invoice";
		 }else if(res=="GR"){
			 transType="GRN";
		 }
		 else if(res=="PT"){
			 transType="Payment";
		 }
		 else if(res=="RT"){
			 transType="Receipt";
		 }
		 else if(res=="PR"){
			 transType="PurReturn";
		 }
		 else if(res=="SR"){
			 transType="SalesReturn";
		 }else if(res=="JV"){
			 transType="JV";
		 }
		return transType;
	}
	
	

	
	
	function funSetData(code){

		switch(fieldName){

			case 'creditorAccountCode' : 
				funSetGLCode(code);
				break;
				
			case 'creditorCode' : 
				funSetCreditoMasterData(code);
				break;
				
			case 'ToDebtorCode' : 
				funSetToDebtorCode(code);
				break;
		}
	}
	
	function funSetCreditoMasterData(creditor)
	{
	   
		var searchurl=getContextPath()+"/loadSundryCreditorMasterData.html?creditorCode="+creditor;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strCreditorCode=='Invalid Code')
			        	{
			        		alert("Invalid creditor Code");
			        		$("#txtFromDebtorCode").val('');
			        		$("#lblFromDebtorName").text('');
			        	}
			        	else
			        	{					        	    			        	    
			        	   
			        	    $("#txtFromDebtorCode").val(creditor);
			        	    $("#lblFromDebtorName").text(response.strCreditorFullName);
			        	    funGetCurrencyForCreditor(creditor);
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



	function funSetGLCode(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadAccontCodeAndName.html?accountCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strAccountCode!="Invalid Code")
		    	{
					$("#txtGLCode").val(response.strAccountCode);
					$("#lblGLCode").text(response.strAccountName);
					$("#txtFromDebtorCode").focus();					
		    	}
		    	else
			    {
			    	alert("Invalid Account No");
			    	$("#txtGLCode").val("");
			    	$("#lblGLCode").text("");
			    	$("#txtGLCode").focus();
			    	return false;
			    }
			},
			error : function(e){
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
	
	
// Function to set debtor details from help	
	function funSetMemberDetails(code){
		
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/getDebtorDetails.html?debtorCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strAccountCode=='Invalid Code')
	        	{
	        		alert("Invalid Debtor Code");
	        		$("#txtFromDebtorCode").val('');
	        	}
	        	else
	        	{
	        		$("#txtFromDebtorCode").val(response.strDebtorCode);
	        		$("#lblFromDebtorName").text(response.strDebtorName);
	        	}
			},
			error : function(e){
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
		
	
// Function to set CF Code from help	
	function funSetCFCode(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadAccontCodeAndName.html?accountCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strAccountCode=='Invalid Code')
	        	{
	        		alert("Invalid Account Code");
	        		$("#txtCFCode").val('');
	        	}
	        	else
	        	{
	        		$("#txtCFCode").val(response.strAccountCode);
		        	$("#lblCFDesc").text(response.strAccountName);
		        	$("#txtVouchDate").focus();
	        	}
			},
			error : function(e){
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


// Function to add detail grid rows	
	function funAddDetailsRow(accountCode,debtorCode,description,transType,dimension,debitAmt,creditAmt) 
	{
	    var table = document.getElementById("tblReceiptDetails");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"12%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strAccountCode\" id=\"strAccountCode."+(rowCount)+"\" value='"+accountCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"12%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDebtorCode\" id=\"strDebtorCode."+(rowCount)+"\" value='"+debtorCode+"' />";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"20%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDescription\" id=\"strDescription."+(rowCount)+"\" value='"+description+"' />";
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"5%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDC\" id=\"strDC."+(rowCount)+"\" value='"+transType+"' />";
	    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box debitAmt\" size=\"7%\" name=\"listReceiptBeanDtl["+(rowCount)+"].dblDebitAmt\" id=\"dblDebitAmt."+(rowCount)+"\" value='"+debitAmt+"'/>";
	    row.insertCell(5).innerHTML= "<input readonly=\"readonly\" class=\"Box creditAmt\" size=\"7%\" name=\"listReceiptBeanDtl["+(rowCount)+"].dblCreditAmt\" id=\"dblCreditAmt."+(rowCount)+"\" value='"+creditAmt+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"8%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDimension\" id=\"strDimension."+(rowCount)+"\" value='"+dimension+"'/>";	        
	    row.insertCell(7).innerHTML= "<input type=\"button\" class=\"deletebutton\" size=\"2%\" value = \"Delete\" onClick=\"Javacsript:funDeleteRow(this)\"/>";
	    row.insertCell(8).innerHTML= "<input type=\"hidden\" readonly=\"readonly\" size=\"1%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDebtorName\" id=\"strDebtorName."+(rowCount)+"\" value='"+debtorName+"' />";
	    
	    debtorName='';
	    $("#txtDebtorCode").prop('disabled', true);
	    funCalculateTotalAmt();
	    funResetDetailFields();
	}


//Delete All records from a grid
	function funRemoveProductRows()
	{
		var table = document.getElementById("tblReceiptDetails");
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	

//Function to Delete Selected Row From Grid
	function funDeleteRow(obj)
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblReceiptDetails");
	    table.deleteRow(index);
	    funCalculateTotalAmt();
	}

	
//Calculating total amount
	function funCalculateTotalAmt()
	{
		var totalAmt=0.00;
		var totalDebitAmt=0.00;
		var totalCreditAmt=0.00;
		
		$('#tblReceiptDetails tr').each(function() 
		{
			var debitAmt=parseFloat($(this).find(".debitAmt").val());
		    totalDebitAmt = totalDebitAmt + parseFloat($(this).find(".debitAmt").val());
		    totalCreditAmt = totalCreditAmt + parseFloat($(this).find(".creditAmt").val());
		});

		totalDebitAmt=parseFloat(totalDebitAmt).toFixed(maxAmountDecimalPlaceLimit);
		totalCreditAmt=parseFloat(totalCreditAmt).toFixed(maxAmountDecimalPlaceLimit);
		
		totalAmt=totalDebitAmt-totalCreditAmt;
		totalAmt=parseFloat(totalAmt).toFixed(maxAmountDecimalPlaceLimit);
		
		$("#lblDebitAmt").text(totalDebitAmt);
		$("#lblCreditAmt").text(totalCreditAmt);
		$("#lblDiffAmt").text(totalAmt);
		$("#txtTotalAmt").val(totalAmt);
	}


// Reset Detail Fields
	function funResetDetailFields()
	{
		$("#txtAccCode").val('');
	    $("#txtDebtorCode").val('');
	    $("#txtDescription").val('');
	    $("#cmbDrCr").val('Dr');
	    $("#txtAmount").val('0.00');
	    $("#cmbDimesion").val('No');	    
	}
	
	
// Reset Header Fields
	function funResetHeaderFields()
	{
		$("#txtVouchNo").val('');		
		$("#txtNarration").val('');
		$("#txtVouchDate").datepicker('setDate', 'today');
		$("#txtChequeDate").datepicker('setDate', 'today');
		$("#txtDebtorCode").prop('disabled', true);
	}


	
// Function to Validate Header Fields
	function funValidateHeaderFields()
	{
		/* if($("#txtVouchDate").val()=='')
		{
			alert('Please Select Vouch Date!!!');
			return false;
		}
		if($("#txtCFCode").val()=='')
		{
			alert('Please Enter CF Code!!!');
			return false;
		}
		
		var amt=parseFloat($("#txtAmt").val());
		if(amt<1)
		{
			alert('Please Enter Amount!!!');
			return false;
		} */
	}


	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	function funOpenPaymentForm()			
	 {
		var transactionformName="frmPayment";
		
		var glCode=$("#txtGLCode").val();	
		var creditorCode=$("#txtFromDebtorCode").val();	
		var currCode=$("#cmbCurrency").val();	
		
		if(glCode=="")
		{
			alert("Please select GL Code");
			
		}else{
		if(creditorCode=="")
		{
			alert("Please select Creditor  Code");
			
		}else{
	    response=window.open("frmPaymentCreditorLedger.html?formname="+transactionformName+"&glCode="+glCode+"&creditorCode="+creditorCode+"&closingAmt="+closingAmt+"&currCode="+currCode,"","dialogHeight:500px;dialogWidth:500px;dialogLeft:550px;");
       
		var timer = setInterval(function ()
			    {
				if(response.closed)
					{
						if (response.returnValue != null)
						{
							if(null!=response)
					        {
								response=response.returnValue;
					        	var count=0; 
					        }
		
						}
						clearInterval(timer);
					}
			    }, 500);
		}
		}
	  }
	
	function funGetCurrencyCode(code){

		var amt=1;
		$.ajax({
			type : "POST",
			url : getContextPath()+ "/loadCurrencyCode.html?docCode=" + code,
			dataType : "json",
			async:false,
			success : function(response){ 
				if(response.strCurrencyCode=='Invalid Code')
	        	{
	        		
	        	}
	        	else
	        	{        
	        		amt=response.dblConvToBaseCurr;
		        	
		        	
		        
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
		return amt;
	}
	
	function funGetCurrencyForCreditor(debtor)
	{
		var searchurl=getContextPath()+"/loadCurrencyForCreditor.html?creditorCode="+debtor;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "text",
			        async:false,
			        success: function(response)
			        {
			        	if(response!="")
		        		{
				        	$("#cmbCurrency").val(response);
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
	
	
	function funGetCreditorLedgerDataBeforeExport(fromDate,toDate,glCode,creditorCode,propCode)
	{
		var currency=$("#cmbCurrency").val();
		var currValue=1;
		var param1=glCode+","+creditorCode+","+propCode;
		var type=$("#cmbType").val();
		var searchUrl=getContextPath()+"/getCreditorLedger.html?param1="+param1+"&fDate="+fromDate+"&tDate="+toDate+"&currency="+currency+"&type="+type;
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    async:false,
			    success: function(response)
			    {	
			    },
				error: function(e)
			    {
			       	alert('Error:=' + e);
			    }
		      });
	}
	
</script>

</head>
<body>
	<div class="container masterTable">
		<label id="formHeading">Creditor Ledger</label>
			<s:form name="CreditorLedger" method="POST" action="showCreditorLedger.html">
				<div class="masterTable" style="text-align:center; margin-right:-22%;">
					<a onclick="funOpenPaymentForm()" href="javascript:void(0);" style="text-decoration:underline">Make Payment</a>
				</div>	
						
			<div class="row">
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-5"><label>GL Code</label>
								<s:input  type="text" id="txtGLCode" readonly="true" cssClass="searchTextBox" style="height:50%"
									 	path="strGLCode" ondblclick="funHelp('creditorAccountCode');"/>
							</div>
							<div class="col-md-7">
								<label id="lblGLCode" style="background-color:#dcdada94; width: 100%; height:52.5%; margin-top:13.8%;padding-left: 7px;padding-bottom: 3px;padding-top: 3px;"></label>
							</div>
						</div> 
					</div>
					
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-6"><label>Type</label>
								<s:select id="cmbType" path="strType" class="BoxW124px" >
									<option value="By Account">By Account</option>
									<option value="Bill By Bill">Bill By Bill</option>
								</s:select>
							</div>
							<div class="col-md-6"><label>Change Year</label>
								<s:select id="cmbChangeYear" path="strChangeYear" class="BoxW124px">
									<s:options items="${listChangeYear}"/>
								</s:select>
							</div>
						</div> 
					</div>
					<div class="col-md-5"></div>
					
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-5"><label>Creditor Code</label>
								<s:input  type="text" id="txtFromDebtorCode" readonly="true" cssClass="searchTextBox" style="height:50%"
									 	path="strFromDebtorCode" ondblclick="funHelp('creditorCode');"/>
							</div>
							<div class="col-md-7">
								<label id="lblFromDebtorName" style="background-color:#dcdada94; width: 100%; height: 52.5%; margin-top:13.8%;padding-left: 7px;padding-bottom: 3px;padding-top: 3px;"></label>
							</div>
						</div> 
					</div>
					
					<div class="col-md-2"><label>Status</label>
						<label id="lblStatus" style="background-color:#dcdada94; width: 100%; height: 50%"></label>
					</div>
					
					<div class="col-md-2">
					   <label>Stop Credit Supply</label>
						<label id="lblStopCreditSupply" style="background-color:#dcdada94; width: 100%; height: 50%"></label>
					</div>
					
					<div class="col-md-4"></div>
					
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-6">
							<label>From Date</label>
								<s:input type="text" id="txtFromDate" path="dteFromDate" cssClass="calenderTextBox" style="height:50%" />
							</div>
							<div class="col-md-6">
								<label>To Date</label><br>
								<s:input  type="text" id="txtToDate" path="dteToDate" cssClass="calenderTextBox" style="height:50%" />
							</div>
						</div> 
					</div>
							
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-6">
							<label>Currency</label>
								<s:select id="cmbCurrency" path="currency" items="${currencyList}" cssClass="BoxW124px"></s:select>
							</div>
							<div class="col-md-6">
								<label>Report Type</label><br>
								<s:select id="cmbReportType" path="strReportType" class="BoxW124px" >
									<option value="EXCEL">EXCEL</option>
									<option value="PDF">PDF</option>
								</s:select>
							</div>
						</div> 
					</div>
					
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-6">
							<label>Show Narration</label><br>
								<input type="checkbox" id="chkShowNarration" />
							</div>
							<div class="col-md-6"></div>
						</div> 
					</div>
					
				</div>
				<div id="paraSubmit" class="center" style="text-align:center;  margin-right:-16%;">
					<a href="#"><button class="btn btn-primary center-block" id="btnExecute"   value="Execute" onclick="return funButtonExecute()" 
						class="form_button">Execute</button></a>&nbsp
					<a href="#"><button class="btn btn-primary center-block" value="Export" id="btnExport" onclick="return funButtonExport()"
						class="form_button">Export</button></a>
				</div>
				<div id="dvCreditorLedgerBill" style="width: 100% ;height: 100% ;">
<!-- 				<table id="tblCreditorLedgerBill"  class="transTable col2-right col3-right">					 -->
					<table id="tblCreditorLedgerBill"  class="transTable col5-right col6-right col7-right col8-right col9-right"></table>
				</div>
				<br> <br>
				<div id="dvCreditorLedgerBillTot" style="width: 30% ;height: 100% ;">
					<table id="tblCreditorLedgerBillTot" class="transTable col2-right"></table>
				</div>
			</s:form>
	</div>
</body>
</html>
	
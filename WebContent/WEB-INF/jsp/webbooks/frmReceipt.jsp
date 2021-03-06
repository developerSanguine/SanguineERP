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
	var debtorName='';
	
	$(function() 
	{
		
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
		
		
		$("#txtVouchDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtVouchDate").datepicker('setDate', 'today');
		$("#txtChequeDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtChequeDate").datepicker('setDate', 'today');
	//	$("#txtDebtorCode").prop('disabled', true);
		document.getElementById('txtChequeNo').style.visibility='hidden';
		
		var message='';
		var retval="";
		<%if (session.getAttribute("success") != null) 
		{
			if(session.getAttribute("successMessage") != null)
			{%>
				message='<%=session.getAttribute("successMessage").toString()%>';
			    <%
			    session.removeAttribute("successMessage");
			}
			boolean test = ((Boolean) session.getAttribute("success")).booleanValue();
			session.removeAttribute("success");
			if (test) 
			{
				%> alert("Data Save successfully\n\n"+message); <%
			}
		}%>
		
		
		var code='';
		<%
		if(null!=session.getAttribute("rptVoucherNo"))
		{%>
			code='<%=session.getAttribute("rptVoucherNo").toString()%>';
			<%session.removeAttribute("rptVoucherNo");%>
			var isOk=confirm("Do You Want to Generate Slip?");
			if(isOk)
			{
				window.open(getContextPath()+"/openRptReciptReport.html?docCode="+code,'_blank');
			}
					
			
		<%}%>
		
		$('#txtVouchNo').blur(function() {
			var code = $('#txtVouchNo').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetVouchNo(code);
			}
		});
		
		$('#txtCFCode').blur(function() {
			var code = $('#txtCFCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetCFCode(code);
			}
		});
		
		$('#txtDrawnOn').blur(function() {
			var code = $('#txtDrawnOn').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetBankDetails(code);
			}
		});
		
		$('#txtAccCode').blur(function() {
			var code = $('#txtAccCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetAccountDetails(code);
			}
		});
		
		$('#txtDebtorCode').blur(function() {
			var code = $('#txtDebtorCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				if(code.startsWith("D"))
				{
					funSetDebtorMasterData(code);
				}
				else if(code.startsWith("C"))
				{
					funSetcreditorMasterData(code);
				}
				else if(code.startsWith("E"))
				{
					funSetEmployeeMasterData(code);
				}
			}
		});
		
		var acc ='${accCode}';
		if(!acc=='')
		{
			funRemoveAccountRows("tblInv");
			$("#txtAccCode").val(acc);
			$("#txtDescription").val('${accName}');
			 $("#txtDebtorCode").val('${debtorCode}');
			$("#txtDebtorName").val('${debtorName}');
			   
			var invCode= '${invCode}';
			var debtorCode=$("#txtDebtorCode").val();
			
			funGetUnPayedInv(debtorCode,'');
     	    funSetBalanceAmt("Debtor");
     	    funcheckInvselectFrmInvocie(invCode);
     	    funInvChkOnClick();
		}
		
		
	});
	
	function funcheckInvselectFrmInvocie(invCode)
	{
		var table = document.getElementById("tblInv");
	    var rowCount = table.rows.length;  
	    for(var no=0;no<rowCount;no++)
	    {
	    	var tblInvCode=document.getElementById("txtInvCode."+no).value;
	        if(document.all("txtInvCode."+no).value==invCode)
	        	{
	        	   document.all("cbInvSel."+no).checked = true;	
	        	}
	    }
	  
	 	   
	}

	function funResetFields()
	{
		location.reload(true); 
	}

	function funSetData(code){

		switch(fieldName){

			case 'ReceiptNo' : 
				funSetVouchNo(code);
				break;
				
			case 'cashBankAccNo' : 
				funSetCFCode(code);
				break;
				
			case 'accountCode' : 
				funSetAccountDetails(code);
				break;
				
			case 'debtorCode' : 
			//	funSetMemberDetails(code);
				funSetDebtorMasterData(code)
				break;
				
			case 'bankCode' : 
				funSetBankDetails(code);
				break;
			case 'creditorCode' : 
// 				funSetMemberDetails(code);
				funSetcreditorMasterData(code)
				break;
				
			case 'ReceiptNoslip' : 
				funSetVouchNoSlip(code);
				break;
				
			case 'employeeCode' : 
				funSetEmployeeMasterData(code)
				break;	
				
			 case 'GLCode' :
				 funSetAccountDetails(code);
					break;
				 
		}
	}


	function funSetVouchNo(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadReceipt.html?docCode=" + code,
			dataType : "json",
			success : function(response){ 
				funRemoveProductRows();
				funRemoveAccountRows("tblInv");
				if(response.strVouchNo!="Invalid")
		    	{
		    		funFillHdData(response);
		    	}
		    	else
			    {
			    	alert("Invalid Receipt No");
			    	$("#txtVouchNo").val("");
			    	$("#txtVouchNo").focus();
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

	
// Fill Header Data	
	function funFillHdData(response)
	{
		$("#txtVouchNo").val(response.strVouchNo);
		$("#txtVouchDate").val(response.dteVouchDate);
		$("#txtChequeDate").val(response.dteChequeDate);
		$("#txtCFCode").val(response.strCFCode);
    	$("#lblCFDesc").text(response.strCFDesc);
    	$("#lblCFDesc").text(response.strCFDesc);
    	$("#cmbType").val(response.strType);
    	funSetTypeLabel();
    	$("#txtChequeNo").val(response.strChequeNo);
    	$("#txtAmt").val(response.dblAmt);
    	$("#txtDrawnOn").val(response.strDrawnOn);
    	$("#lblDrawnOnDesc").text(response.strBankName);
    	$("#txtBranch").val(response.strBranch);
    	$("#txtDrCr").val(response.strCrDr);
    	$("#txtReceivedFrom").val(response.strReceivedFrom);
    	$("#txtNarration").val(response.strNarration);	
    	$("#txtDebtorCode").val(response.strDebtorCode);	
    	$("#txtDebtorName").val(response.strDebtorName);	
    	$("#cmbCurrency").val(response.strCurrency);
    	$("#txtDblConversion").val(response.dblConversion);
		funFillDtlGrid(response.listReceiptBeanDtl,response.strDebtorCode,response.strDebtorName);
		funFillInvTable(response.listReceiptInvDtlModel)
	}
	
	
// Fill Account details and Debtor Details Grid	
	function funFillDtlGrid(resListRecDtlBean,strDebtorCode,strDebtorName)
	{
		funRemoveProductRows();
		$.each(resListRecDtlBean, function(i,item)
        {
			debtorYN=resListRecDtlBean[i].strDebtorYN;
			debtorName=strDebtorName;
			funAddDetailsRow(resListRecDtlBean[i].strAccountCode,resListRecDtlBean[i].strDebtorCode
				,resListRecDtlBean[i].strDescription,resListRecDtlBean[i].strDC,''
				,resListRecDtlBean[i].dblDebitAmt,resListRecDtlBean[i].dblCreditAmt,strDebtorName);
        });
	}
	
	// Fill Invoice details Grid	
	function funFillInvTable(resListInvDtlModel)
	{
		 funRemoveAccountRows("tblInv");
		$.each(resListInvDtlModel, function(i,item)
        {
			funLoadInvTable(resListInvDtlModel[i].strInvCode,resListInvDtlModel[i].strInvBIllNo,resListInvDtlModel[i].dblInvAmt,resListInvDtlModel[i].dteInvDate,resListInvDtlModel[i].dteBillDate,resListInvDtlModel[i].dteInvDueDate,resListInvDtlModel[i].strSelected);
        });
	}
	
	
//Delete a All record from a grid
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
	        		$("#lblCFDesc").text('');
	        		$("#lblBankBalAmt").text('');
	        	}
	        	else
	        	{
	        		$("#txtCFCode").val(response.strAccountCode);
		        	$("#lblCFDesc").text(response.strAccountName);
// 		        	$("#txtVouchDate").focus();
		        	$("#txtChequeNo").focus();
		        	if(response.strType=="Bank")
		        	{
		        		$("#cmbType").val("Cheque");
		        		funSetTypeLabel();
		        		
		        	}
		        	else
		        	{
		        		$("#cmbType").val("Cash");
		        		funSetTypeLabel();
		        		
		        		
		        	}
		        	funSetBankBalanceAmt(response.strType);
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


// Function to set account details from help	
	function funSetAccountDetails(code){
		
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadAccontCodeAndName.html?accountCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strAccountCode=='Invalid Code')
	        	{
	        		alert("Invalid Account Code");
	        		$("#txtAccCode").val('');
	        		$("#txtDescription").val('');
	        	}
	        	else
	        	{
	        		$("#txtAccCode").val(response.strAccountCode);
		        	$("#txtDescription").val(response.strAccountName);
		        	if(response.strDebtor=='Yes' || response.strCreditor=='Yes' || response.strEmployee=='Yes')
		        	{
		        		if(response.strDebtor=='Yes')
	        			{
	        			$("#lblCrdDebCode").text("Debtor Code");
	        			$("#hidSundryType").val("Debtor Code"); 
	        			
	        			}
		        		else if(response.strCreditor=='Yes')
	        			{
	        				$("#lblCrdDebCode").text("Creditor Code");
	        				$("#hidSundryType").val("Creditor Code");
	        			}
		        		else
	        			{
	        				$("#lblCrdDebCode").text("Employee Code");
		        			$("#hidSundryType").val("Employee Code"); 
	        			}
		        	
		        		$("#txtDebtorCode").prop('disabled', false);
 		        		$("#txtDebtorCode").prop('disabled', false);
 		        		
		        	}
		        	else
		        	{
		        		$("#txtDebtorCode").val('');
 		        		$("#txtDebtorCode").prop('disabled', true);
 		        		$("#txtDebtorCode").focus();
 		        		
		        	}
		        //	$("#txtDebtorCode").focus();
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
			url : getContextPath()+ "/loadMemberDetails.html?debtorCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strAccountCode=='Invalid Code')
	        	{
	        		alert("Invalid Debtor Code");
	        		$("#txtDebtorCode").val('');
	        	}
	        	else
	        	{
	        		$("#txtDebtorCode").val(response.strDebtorCode);
	        		debtorName=response.strDebtorName;
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


// Function to set Bank details from help	
	function funSetBankDetails(code){
	
		$.ajax({
			type : "GET",
			url : getContextPath()+"/loadBankMasterData.html?bankCode="+code,
			dataType : "json",
			success : function(response){ 
				if(response.strBankCode=='Invalid Code')
	        	{
	        		alert("Invalid Bank Code");
	        		$("#txtDrawnOn").val('');
	        		$("#lblDrawnOnDesc").text('');
	        	}
	        	else
	        	{
	        		$("#txtDrawnOn").val(response.strBankCode);
	        		$("#lblDrawnOnDesc").text(response.strBankName);
	        		$("#txtBranch").focus();
	        		$("#txtBranch").val(response.strBranch);
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


// Get Detail Info From detail fields and pass them to function to add into detail grid
	function funGetDetailsRow() 
	{
      var accountCode =$("#txtAccCode").val().trim();
		
		var accountName =$("#lblCFDesc").text().trim();
		var transAmt=parseFloat($("#txtAmount").val());
		var bankCode =$("#txtCFCode").val();
		var chequeData = $("#txtChequeNo").val();
		
		if(accountCode=='')
		{
			alert('Select Account Code!!!');
			return;
		}
		if(transAmt<1)
		{
			alert('Enter Transaction Amt!!!');
			return;
		}
		if(bankCode=='')
		{
			alert('Select Bank Code!!!');
			return;
		}
		
		var type=$("#cmbType").val();
		switch(type)
		{
			case "Cash":
				break;
				
			case "Credit Card":
				if(chequeData=='')
			 		{
			 			alert('Please Enter Credit Card Number!!!');
			 			$("#txtChequeNo").focus();
			 			return;
			 		}
				break;

			case "Cheque":
				if(chequeData=='')
		 		{
		 			alert('Please Enter Cheque Number!!!');
		 			$("#txtChequeNo").focus();
		 			return;
		 		}
				break;
	
			case "NEFT":
				if(chequeData=='')
		 		{
		 			alert('Please Enter Account Number!!!');
		 			$("#txtChequeNo").focus();
		 			return;
		 		}
				break;
		}
		
	    var debtorCode=$("#txtDebtorCode").val();
	    var debtorName=$("#txtDebtorName").val();
	    var description=$("#txtDescription").val();
	    var transType=$("#cmbDrCr").val();
	    var dimension=$("#cmbDimesion").val();
	    var debitAmt=0;
	    var creditAmt=0;
	    

	    
	    creditAmt=parseFloat(transAmt).toFixed(maxQuantityDecimalPlaceLimit);	
    	funAddDetailsRow(accountCode,debtorCode,description,'Cr',dimension,0,creditAmt,'0');

   		debitAmt=parseFloat(transAmt).toFixed(maxQuantityDecimalPlaceLimit);	    
    	funAddDetailsRow(bankCode,'',accountName,'Dr',dimension,debitAmt,0,'0');

	    $("#txtDebtorCode").val('');
	}
	
	
// Function to add detail grid rows	
	function funAddDetailsRow(accountCode,debtorCode,description,transType,dimension,debitAmt,creditAmt,debtorName) 
	{
	    var table = document.getElementById("tblReceiptDetails");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"12%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strAccountCode\" id=\"strAccountCode."+(rowCount)+"\" value='"+accountCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"11%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDebtorCode\" id=\"strDebtorCode."+(rowCount)+"\" value='"+debtorCode+"' />";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"48%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDescription\" id=\"strDescription."+(rowCount)+"\" value='"+description+"' />";
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"3%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDC\" id=\"strDC."+(rowCount)+"\" value='"+transType+"' />";
	    row.insertCell(4).innerHTML= "<input type=\"text\" class=\" debitAmt\"  onblur=\"Javacsript:funUpdateDebitAmount(this)\"size=\"8%\"  style=\"text-align: right;\" name=\"listReceiptBeanDtl["+(rowCount)+"].dblDebitAmt\" id=\"dblDebitAmt."+(rowCount)+"\" value='"+debitAmt+"'/>";
	    row.insertCell(5).innerHTML= "<input type=\"text\" class=\" creditAmt\" onblur=\"Javacsript:funUpdateCreditAmount(this)\" size=\"8%\" style=\"text-align: right;\" name=\"listReceiptBeanDtl["+(rowCount)+"].dblCreditAmt\" id=\"dblCreditAmt."+(rowCount)+"\" value='"+creditAmt+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"8%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDimension\" id=\"strDimension."+(rowCount)+"\" value='"+dimension+"'/>";	        
	    row.insertCell(7).innerHTML= "<input type=\"button\" class=\"deletebutton\" size=\"2%\" value = \"Delete\" onClick=\"Javacsript:funDeleteRow(this)\"/>";
  	    row.insertCell(8).innerHTML= "<input type=\"hidden\" readonly=\"readonly\" size=\"1%\" name=\"listReceiptBeanDtl["+(rowCount)+"].strDebtorName\" id=\"strDebtorName."+(rowCount)+"\" value='"+debtorName+"' />";
	    
	    
	 //   $("#txtDebtorCode").prop('disabled', true);
	    funCalculateTotalAmt();
	    funResetDetailFieldsButNotAmount();
	}



	function funUpdateDebitAmount(object)
	{
		var index=object.parentNode.parentNode.rowIndex;
		document.getElementById("strDC."+index).value="Dr";
		document.getElementById("dblCreditAmt."+index).value=parseFloat(0).toFixed(maxQuantityDecimalPlaceLimit);	;
		//funGetTotal();
		funCalculateTotalAmt();
		
	}
	
	function funUpdateCreditAmount(object)
	{
		var index=object.parentNode.parentNode.rowIndex;
		
		document.getElementById("strDC."+index).value="Cr";
		document.getElementById("dblDebitAmt."+index).value=parseFloat(0).toFixed(maxQuantityDecimalPlaceLimit);	;
		//funGetTotal();
		funCalculateTotalAmt();
		
	}

//Delete a All record from a grid
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
	 //   $("#txtDebtorCode").val('');
	    $("#txtDescription").val('');
	    $("#cmbDrCr").val('Dr');
	    $("#txtAmount").val('0.00');
	    $("#cmbDimesion").val('No');	    
	}
	
	function funResetDetailFieldsButNotAmount()
	{
		$("#txtAccCode").val('');
	    $("#txtDebtorCode").val('');
	    $("#txtDescription").val('');
	    $("#cmbDrCr").val('Dr');
	    $("#txtDebtorName").val('');
	    $("#cmbDimesion").val('No');	    
	}
	
	
// Reset Header Fields
	function funResetHeaderFields()
	{
		$("#txtVouchNo").val('');		
		$("#txtNarration").val('');
		$("#txtVouchDate").datepicker('setDate', 'today');
		$("#txtChequeDate").datepicker('setDate', 'today');
	//	$("#txtDebtorCode").prop('disabled', true);
	}


	
// Function invoked on change value event on select tag.	
	function funSetTypeLabel()
	{
		var type=$("#cmbType").val();
		switch(type)
		{
			case "Cash":
				$("#lblTypeName").text("Cash");
				document.getElementById('txtChequeNo').style.visibility='hidden';
				break;
				
			case "Credit Card":
				$("#lblTypeName").text("Credit Card");	
				document.getElementById('txtChequeNo').style.visibility='visible';
				break;

			case "Cheque":
				$("#lblTypeName").text("Cheque No");
				document.getElementById('txtChequeNo').style.visibility='visible';
				break;
	
			case "NEFT":
				$("#lblTypeName").text("NEFT No");
				document.getElementById('txtChequeNo').style.visibility='visible';
				break;
		}
	}


// Function to Validate Header Fields
	function funValidateHeaderFields()
	{
		if($("#txtVouchDate").val()=='')
		{
			alert('Please Select Vouch Date!!!');
			return false;
		}
		

		 if($("#txtChequeDate").val()=='')
				{
					alert('Please Select Cheque Date!!!');
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
		}
		
		var debitAmt =parseFloat($("#lblDebitAmt").text())
		var creditAmt =parseFloat($("#lblCreditAmt").text())
		if(debitAmt>0 && creditAmt>0 && (debitAmt - creditAmt)==0  )
			{
			  return true;
			}else
				{
				  alert("Balance must be Zero");
				  return false;
				}
		
		
	}


	function funHelp(transactionName)
	{
		$("#lblBalanceAmt").text('');
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	function funHelp1()
	{ 
		if($("#hidSundryType").val()=="Debtor Code")
		{
			 funHelp('debtorCode');
		}
		if($("#hidSundryType").val()=="Creditor Code")
		{
			 funHelp('creditorCode');
		}
		if($("#hidSundryType").val()=="Employee Code")
		{
			 funHelp('employeeCode');
		}
		
	}
	function funSetcreditorMasterData(creditorCode)
	{
	   
		var searchurl=getContextPath()+"/loadSundryCreditorMasterData.html?creditorCode="+creditorCode;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strCreditorCode=='Invalid Code')
			        	{
			        		alert("Invalid Creditor Code");
			        		$("#txtDebtorCode").val('');
			        		$("#txtDebtorName").val('');
			        	}
			        	else
			        	{					        	    			        	    
			        	    /* Debtor Details */
			        	 
			        	    $("#txtDebtorCode").val(response.strCreditorCode);
			        	    $("#txtDebtorName").val(response.strFirstName);
			        	  
			        	    funSetBalanceAmt("Creditor");
				    	
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
	function funSetDebtorMasterData(debtorCode)
	{
	   
		var searchurl=getContextPath()+"/loadSundryDebtorMasterData.html?debtorCode="+debtorCode;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strDebtorCode=='Invalid Code')
			        	{
			        		alert("Invalid Debtor Code");
			        		$("#txtDebtorCode").val('');
			        		$("#txtDebtorName").val('');
			        	}
			        	else
			        	{					        	    			        	    
			        	    /* Debtor Details */
			        	     funRemoveAccountRows("tblInv");
			        	    $("#txtDebtorCode").val(response.strDebtorCode);
			        	    $("#txtDebtorName").val(response.strDebtorFullName);
			        	    $("#cmbCurrency").val(response.strCurrencyType);
			        	    $("#txtDblConversion").val(response.dblConversion);

			        	    $("#txtInvGetAmount").val('0.0');
			    		   $("#txtTotalInvAmount").val('0.0');
			        	    
			        	    funGetUnPayedInv(debtorCode,response.strClientCode);
			        	    funSetBalanceAmt("Debtor");
			        	    
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
	
	function funSetBalanceAmt(CredDebType)
	{
 		var debtorCode=$("#txtDebtorCode").val();
 		var invDate=$("#txtVouchDate").val();
 		var type1="";
 		if(CredDebType=="Debtor")
 		{
 			type1="Debtor";
 		}else{
 			type1="Creditor";
 		}
 		var currencyCode=$("#cmbCurrency").val();
// 		var currValue=funGetCurrencyCode(currencyCode);
// 		if(currencyCode==null)
// 		{
// 			currencyCode="";
// 		}
		var currValue=$("#txtDblConversion").val();
   		if(currValue==null ||currValue==''||currValue==0)
   		{
   		  currValue=1;
   		}
  		var gurl1=getContextPath()+"/loadBalanceAmtCreditorDetor.html?type="+type1+"&custSuppCode="+debtorCode+"&toDate="+invDate+"&currency="+currencyCode;
  				
		$.ajax({
	        type: "GET",
	        url: gurl1,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        	
	        	var amount = (response).toFixed(maxAmountDecimalPlaceLimit);
		    	if(amount<0)
		    	{
		    		amount="("+amount*-1+")";
		    	}
		    	
		    	$("#lblBalanceAmt").text("Balance Amt:"+amount);
	        	
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


	
	function funGetUnPayedInv(strDebtor,strClientCode)
	{
		var abc="";
		var strCurrency = $("#cmbCurrency").val();
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadUnPayedInv.html?strDebtorCode="+strDebtor+"&strCurrency="+strCurrency,
			dataType : "json",
		    async: false ,
			success : function(response){ 
				$.each(response, function(i, item) {
					
						funLoadInvTable(response[i].strInvCode,response[i].strInvBIllNo,response[i].dblInvAmt,response[i].dteInvDate,response[i].dteBillDate,response[i].dteInvDueDate,"No");
				});	
	        
			},
			error : function(jqXHR, exception){
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
	
	
	function funLoadInvTable(strInvCode,strInvBIllNo,dblInvAmt,dteInvDate,dteBillDate,dteInvDueDate,isSelected)
	{
		var totalInvAmt = parseFloat(dblInvAmt);
		 var table = document.getElementById("tblInv");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    if(isSelected=="Tick")
		    	{
		    	 row.insertCell(0).innerHTML= "<input id=\"cbInvSel."+(rowCount)+"\" name=\"listReceiptInvDtlModel["+(rowCount)+"].strSelected\" type=\"checkbox\" class=\"PropCheckBoxClass\" checked=\"checked\"   value='Tick' onclick=\"funInvChkOnClick()\" />";
		    	}else
		    	{
		    		 row.insertCell(0).innerHTML= "<input id=\"cbInvSel."+(rowCount)+"\" name=\"listReceiptInvDtlModel["+(rowCount)+"].strSelected\" type=\"checkbox\" class=\"PropCheckBoxClass\"   value='Tick' onclick=\"funInvChkOnClick()\" />";	
		    	}
		   
		    row.insertCell(1).innerHTML= "<input class=\"Box\" readonly = \"readonly\" size=\"24%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].strInvCode\" id=\"txtInvCode."+(rowCount)+"\" value='"+strInvCode+"' >";
		    row.insertCell(2).innerHTML= "<input class=\"Box\" readonly = \"readonly\" size=\"8%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].strInvBIllNo\"  id=\"txtInvBIllNo."+(rowCount)+"\" value='"+strInvBIllNo+"'>";		    	    
		    row.insertCell(3).innerHTML= "<input class=\"Box totalinvAmtCell\" size=\"8%\" readonly = \"readonly\" style=\"text-align: right;\" size=\"8%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].dblInvAmt\" id=\"txtInvAmt."+(rowCount)+"\" value='"+dblInvAmt.toFixed(maxAmountDecimalPlaceLimit)+"'>";
		    row.insertCell(4).innerHTML= "<input class=\"Box\"  readonly = \"readonly\"  size=\"10%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].dteInvDate\" id=\"txtInvDate."+(rowCount)+"\" value="+dteInvDate+">";
		    row.insertCell(5).innerHTML= "<input class=\"Box\"  readonly = \"readonly\"  size=\"10%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].dteBillDate\" id=\"txtBillDate."+(rowCount)+"\" value="+dteBillDate+">";		    
		    row.insertCell(6).innerHTML= "<input class=\"Box\" readonly = \"readonly\"  size=\"10%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].dteInvDueDate\" id=\"txtInvDueDate."+(rowCount)+"\" value="+dteInvDueDate+">";
		    row.insertCell(7).innerHTML= "<input class=\"text\" required = \"required\" style=\"text-align: right;\" size=\"8%\" name=\"listReceiptInvDtlModel["+(rowCount)+"].dblPayedAmt\" id=\"txtPayedAmt."+(rowCount)+"\" value='0' onblur=\"funUpdateAmount(this);\" >";
	
		    var invAmt =$("#txtTotalInvAmount").val()
		   	totalInvAmt= parseFloat(invAmt) + totalInvAmt;
		     $("#txtTotalInvAmount").val(totalInvAmt.toFixed(maxAmountDecimalPlaceLimit) );
	
	
	}
	
	
	function funInvChkOnClick()
	{
		var table = document.getElementById("tblInv");
	    var rowCount = table.rows.length;  
	    var strInvCodes="";
	    var invAmt=0.0;
	    for(no=0;no<rowCount;no++)
	    {
	        if(document.all("cbInvSel."+no).checked==true)
	        	{
	        		if(strInvCodes.length>0)
	        			{
	        				strInvCodes=strInvCodes+","+document.all("txtInvCode."+no).value;
	        				var tempAmt = document.all("txtInvAmt."+no).value;
	        				invAmt=parseFloat(invAmt)+parseFloat(tempAmt);
	        				document.all("txtPayedAmt."+no).value=tempAmt;
	        			    
	        			}
	        		else
	        			{
	        				strInvCodes=document.all("txtInvCode."+no).value;
	        				var tempAmt = document.all("txtInvAmt."+no).value;
	        				document.all("txtPayedAmt."+no).value=tempAmt;
	        				invAmt=parseFloat(tempAmt)
	        			}
	        	}
	    }
	    $("#txtAmt").val(invAmt.toFixed(maxAmountDecimalPlaceLimit));
	    $("#txtAmount").val(invAmt.toFixed(maxAmountDecimalPlaceLimit));
	 	   
	}
	
	function funUpdateAmount(object)
	{
		var table = document.getElementById("tblInv");
	    var rowCount = table.rows.length;  
	    var strInvCodes="";
	    var invAmt=0.0;
	    var actualpayedAmt=0.0;
	    
	    for(no=0;no<rowCount;no++)
	    {
	        if(document.all("cbInvSel."+no).checked==true)
	        	{
	        		if(strInvCodes.length>0)
	        			{
	        				strInvCodes=strInvCodes+","+document.all("txtInvCode."+no).value;
	        				var tempAmt = document.all("txtPayedAmt."+no).value;
		        			actualpayedAmt=parseFloat(actualpayedAmt)+parseFloat(tempAmt);
	        			}
	        		else
	        			{
	        				strInvCodes=document.all("txtInvCode."+no).value;
	        				var tempAmt = document.all("txtPayedAmt."+no).value;
    						actualpayedAmt=parseFloat(actualpayedAmt)+parseFloat(tempAmt);
	        			}
	        	}
	    }
	    $("#txtAmt").val(actualpayedAmt.toFixed(maxAmountDecimalPlaceLimit));
	    $("#txtAmount").val(actualpayedAmt.toFixed(maxAmountDecimalPlaceLimit));
	    $("#hidInvYN").val("Y");
	   
	}
	
	function funTotalCrInv()
	{
		var finalCr=0.00;
		var table = document.getElementById("tblInv");
	    var rowCount = table.rows.length; 
		var no=0;
				$('#tblInv tr').each(function() {

					if(document.all("cbInvSel."+no).checked==true)
			    	{
				    var totalCrCell = $(this).find(".totalInvAmtCell").val();
				    finalCr+=parseFloat(totalCrCell);
			    	}
					no++;
				 });
	    	
		$("#txtAmt").val(finalCr);
		$("#txtAmount").val(finalCr);
	}
	
	function funRemoveAccountRows(tblID)
	{
		var table = document.getElementById(tblID);
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	
	
	 function funSetInvPayAmt()
		{
			var table = document.getElementById("tblInv");
		    var rowCount = table.rows.length; 
		    var payInvAmt = $("#txtInvGetAmount").val();
		    var totalInvAmt = $("#txtTotalInvAmount").val();
		    
		     		    
		    
		    $("#txtAmt").val(payInvAmt);
			$("#txtAmount").val(payInvAmt);
		    
		    
		    var restAmt =parseFloat(payInvAmt);
		      
		    for(no=0;no<rowCount;no++)
		    {
		    	var invCrCell = document.all("txtInvAmt."+no).value;
		    	restAmt = parseFloat(restAmt) - parseFloat(invCrCell);
		    	
		    	if(restAmt>0)
		    		{
		    		$('#tblInv tr').each(function() {
			    		document.getElementById("txtPayedAmt."+no).value=invCrCell;
			    		document.getElementById("cbInvSel."+no).checked=true;
		    		});
		    		}
		    	if(restAmt<0)
		    		{
		    		$('#tblInv tr').each(function() {
			    		document.getElementById("txtPayedAmt."+no).value=restAmt+parseFloat(invCrCell);
			    		document.getElementById("cbInvSel."+no).checked=true;
		    		});
		    		break;
		    		}
		    	
		    	
		    }
			
		}
	 
	 function funFillAmount(){
			
		 var hdAmt=$("#txtAmt").val();
		 if(hdAmt!=""){
			
			 $("#txtAmount").val(hdAmt); 
			 
		 }
	 }
	
	 function funSetEmployeeMasterData(employeeCode)
		{
		   
			var searchurl=getContextPath()+"/loadEmployeeMasterData.html?employeeCode="+employeeCode;
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	if(response.strEmployeeCode=='Invalid Code')
				        	{
				        		alert("Invalid Employee Code");
				        		$("#txtDebtorCode").val('');
				        		$("#txtDebtorName").val('');
				        	}
				        	else
				        	{					        	    			        	    
				        	    /* Employee Details */
				        	   
				        		   
					        	    $("#txtDebtorCode").val(response.strEmployeeCode);
					        	    $("#txtDebtorName").val(response.strEmployeeName);
					        	  
//	 				        	    funSetBalanceAmt("Employee");
				        	
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

	 function funSetBankBalanceAmt(accType){
			var accCode=$("#txtCFCode").val();
			var invDate=$("#txtVouchDate").val();
			
			var currencyCode=$("#cmbCurrency").val();
// 			var currValue=funGetCurrencyCode(currencyCode);
// 			if(currencyCode==null)
// 			{
// 				currencyCode="";
// 			}
		var currValue=$("#txtDblConversion").val();
   		if(currValue==null ||currValue==''||currValue==0)
   		{
   		  currValue=1;
   		}
			
				var gurl1=getContextPath()+"/loadBankBalanceAmt.html?accType="+accType+"&accCode="+accCode+"&toDate="+invDate+"&currency="+currencyCode;
				$.ajax({
				    type: "GET",
				    url: gurl1,
				    dataType: "json",
				    success: function(response)
				    {		
				    	var amount = (response/currValue).toFixed(maxAmountDecimalPlaceLimit);
				    	if(amount<0)
				    	{
				    		amount="("+amount*-1+")";
				    	}
				    	
				    	$("#lblBankBalAmt").text("Balance Amt:"+amount);
				    	
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
	 

		function funOnChangeCurrency(){
			var cmbCurrency=$("#cmbCurrency").val();
			var currValue=funGetCurrencyCode(cmbCurrency);
			$("#txtDblConversion").val(currValue);
		}	
</script>

</head>
<body>
<div class="container transTable">
	<label id="formHeading">Receipt</label>
	<s:form name="Receipt" method="POST" action="saveReceipt.html">

	  <div class="row">
		   <div class="col-md-2"><label>Voucher No</label>
				<s:input colspan="3" type="text" id="txtVouchNo" readonly="true" path="strVouchNo" cssClass="searchTextBox" ondblclick="funHelp('ReceiptNo');"/>
		    </div>
			
			<div class="col-md-2"><label>Voucher Date</label>
				<s:input colspan="3" type="text" id="txtVouchDate" path="dteVouchDate" style="width:75%" cssClass="calenderTextBox" />
			</div>
			<div class="col-md-2"><label>Amt</label> <br>
				<s:input  type="number" step="0.0001" id="txtAmt" path="dblAmt" class="decimal-places numberField" onChange="funFillAmount()" value="0.00"/>
			</div>
			<div class="col-md-1"><label>Dr/Cr</label>
				<s:input colspan="3" type="text" id="txtCrDr" value="Dr" path="strCrDr" readonly="true"/>
			</div>
			<div class="col-md-5"></div>
				
			<div class="col-md-2"><label>CF Code</label>
				<s:input colspan="3" type="text" id="txtCFCode" readonly="true" path="strCFCode" cssClass="searchTextBox" ondblclick="funHelp('cashBankAccNo');"/>
			</div>
				
			<div class="col-md-2"><br><br><label id="lblCFDesc" style="margin-top: -10px;"></label>
			       <label id="lblBankBalAmt"  style="color:blue; font:bold; font-size:115%; background-color:#dcdada94; width: 80%; height: 38%; margin-top: 1px;"></label>
			</div>
			<div class="col-md-2"><label>Type</label>
				<!-- <s:select id="txtType" path="strType" cssClass="BoxW124px"/> -->
				<s:select id="cmbType" path="strType" class="BoxW124px" onchange="funSetTypeLabel()">
						  <option value="Cash">Cash</option>
						  <option value="Cheque">Cheque</option>
						  <option value="Credit Card">Credit Card</option>
						  <option value="NEFT">NEFT</option>
				</s:select>
			</div>
			
			<div class="col-md-2"><label id="lblTypeName"></label>
			        <s:input colspan="3" type="text" id="txtChequeNo" path="strChequeNo" cssClass="longTextBox" />
		     </div>
			   
			<div class="col-md-2"><label id="lblChequeDate">Cheque Date</label>
			       <s:input colspan="3" type="text" id="txtChequeDate" path="dteChequeDate" style="width:75%" cssClass="calenderTextBox" />
			 </div>
			 <div class="col-md-2"></div>
			<div class="col-md-2"><label>Drawn On</label>
				     <s:input type="text" id="txtDrawnOn" readonly="true" path="strDrawnOn" cssClass="searchTextBox" ondblclick="funHelp('bankCode');"/>
		     </div>
		     
		     <div class="col-md-2"><label id="lblDrawnOnDesc" style="background-color:#dcdada94; width: 100%; height: 42%; margin: 27px 0px;"></label>
			</div>
			
		    <div class="col-md-2"><label>Branch</label>
			         <s:input  type="text" id="txtBranch" path="strBranch"/>
			</div>
				
			<div class="col-md-2"><label>Received From</label>
				     <s:input  type="text" id="txtReceivedFrom" path="strReceivedFrom" cssClass="BoxW124px" />
			</div>
				
			<div class="col-md-2"><label>Narration</label><br>
				     <s:textarea id="txtNarration" path="strNarration" style="width: 100%; height:27px;"/>
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-2"><label>Currency</label>
			      <div class="row">
			      	<div class="col-md-7"><s:select id="cmbCurrency" path="strCurrency" items="${currencyList}"  onchange="funOnChangeCurrency()"></s:select></div>
			        <div class="col-md-5"><s:input id="txtDblConversion" value ="1" path="dblConversion" type="text" class="decimal-places numberField" style="width:40px"></s:input></div>
		          </div>
		    </div>	
				
		</div>
       <br>
		
	<!-- 	<table class="transTable">
		</table> -->
                 <div>
	                 <ul class="tabs">
							<li class="active" data-state="tab1">Details</li>
							<li data-state="tab2" style="width: 100px; padding-left: 45px">Invoice</li>
						</ul><br><br>
		<div id="tab1" class="tab_content" style="height: 470px; margin-bottom:20px;">
	        <div class="row" style="margin-top: 15px;">
				<div class="col-md-5"><label>Account Code</label>
					<div class="row">
			            <div class="col-md-5"><input id="txtAccCode" readonly="true" name="txtAccCode" ondblclick="funHelp('GLCode')" class="searchTextBox" /></div>
								<!-- <td width="10%">Description</td> -->
		                 <div class="col-md-7"><input id="txtDescription" name="txtDescription" type="text" /></div>
			   		</div>
			 	</div>
			 	<div class="col-md-2"><label>Amount</label>
				      <input type="text" id="txtAmount" value="" class="decimal-places numberField"/>
				</div>
				 <div class="col-md-1"><label>Dr/Cr</label>
				      <select id="cmbDrCr"  class="BoxW124px">
						  <option value="Cr">Cr</option>
						  <option value="Dr">Dr</option>
						  
					</select>
				</div>
			 	<div class="col-md-4"></div>
				<div class="col-md-5">
					<label id="lblCrdDebCode">Debtor Code</label>
					 	<div class="row">
			                <div class="col-md-5"><s:input id="txtDebtorCode" readonly="true" name="txtDebtorCode" ondblclick="funHelp1()" class="searchTextBox" path="strDebtorCode"/></div>
					        <div class="col-md-7"><s:input id="txtDebtorName" name="txtDebtorName" readonly="true" cssClass="longTextBox" path="strDebtorName"></s:input></div>
			  			</div>
			  	</div>     
			    <div class="col-md-2"><label id="lblBalanceAmt"  style="color:blue; font:bold;font-size: 115%;  background-color:#dcdada94; width: 100%; height: 42%; margin: 27px 0px;"></label>
			    </div>
		      <div class="col-md-1"><label>Dimension</label>
				     <select id="cmbDimesion" class="BoxW124px">
						  <option value="No">No</option>
						  <option value="Yes">Yes</option>
					</select>
				</div>
			
			<div class="col-md-2" align="right">
					<input type="Button" value="Add" onclick="return funGetDetailsRow()" class="btn btn-primary center-block" class="smallButton" style="margin-top:24px;" />
	     	</div>
	    </div>
	
	 <div class="dynamicTableContainer" style="height: 300px;">
		<table
			style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
			<tr bgcolor="#c0c0c0">
				<td style="width:5.8%;">Account Code</td>
				<td style="width:5.6%;">Debtor Code</td>
				<td style="width:18.7%;">Description</td>
				<td style="width:2%;">D/C</td>
				<td style="width:7.2%;" align ="right">Debit Amt</td>
				<td style="width:7.3%;" align ="right">Credit Amt</td>
				<td style="width:1.5%;">Dimension</td>
				<td style="width:2%;">Delete</td>
				
			</tr>
		</table>
		
		<div style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
			<table id="tblReceiptDetails"
				style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
				class="transTablex col8-center">
				<tbody>
					<col style="width:10%">
					<col style="width:11%">
					<col style="width:35%">
					<col style="width:5%">
					<col style="width:11%">
					<col style="width:15%">
					<col style="width:8%">
					<col style="width:3%">
					<col style="width:0%">
				</tbody>
			</table>
		</div>
	</div>

	<div >
			
		<table class="transTable">
			<tr>
				<td width="2%" ><label>Difference</label></td>
				<td style="width:7.3%;" align ="right"><label id ="lblDiffAmt">0.00</label></td>
				<td><label>Total</label></td>
				<td align="right"><label id ="lblDebitAmt">0.00</label></td>
				<td align="right"><label id ="lblCreditAmt">0.00</label></td>
			</tr>
			
			<tr>
				<td>
					<s:input type="hidden" id="txtTotalAmt" path="dblAmt"  readonly="true" cssClass="decimal-places-amt numberField"/>
				</td>
			</tr>
		</table>
	</div>	
		
	</div>	
		
		<div id="tab2" class="tab_content" style="height: 470px">
			<div class="row" style="margin-top: 15px;">
				 <div class="col-md-2"><label>Total Invoice Amount</label>
				      <input type="text" id="txtTotalInvAmount" readonly="readonly" value="0.00" class="decimal-places numberField"/>
				 </div>
				 <div class="col-md-2"><label>Get Amount</label>
				      <input type="text" id="txtInvGetAmount" value="0.00" class="decimal-places numberField"/>
				 </div>
				
				<div class="col-md-2"><input type="Button" value="Add" onclick="funSetInvPayAmt()" class="btn btn-primary center-block" style="margin-top:24px;" />
				</div>
		  </div>
			<br>
				<div style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 350px; overflow-x: hidden; overflow-y: scroll;">
					<table id="" class="masterTable"
										style="width: 100%; border-collapse: separate;">
										<thead>
											<tr bgcolor="#c0c0c0">
												<td width="5%"><input type="checkbox" checked="checked" 
												id="chkInvALL"/>Select</td>
												<td width="18%">Inv Code</td>
												<td width="8%">Bill No</td>
												<td width="8%">Amount</td>
												<td width="10%">Inv Date</td>
												<td width="10%">Bill Date</td>
												<td width="10%">Due Date</td>
												<td width="10%">Paying Amt</td>
		
											</tr>
										</thead>
									</table>
									<table id="tblInv" class="masterTable"
										style="width: 100%; border-collapse: separate;">
		
										<tr bgcolor="#fafbfb">
											
		
										</tr>
									</table>
								</div>
				
		</div>
		
	</div>
<input type="hidden" id="hidInvYN" value="N"></input>
<input type="hidden" id="hidSundryType" ></input>

		<p align="right">
			<input type="submit" value="Submit" onclick="return funValidateHeaderFields()" tabindex="3" class="btn btn-primary center-block"  class="form_button" />&nbsp
			<input type="reset" value="Reset" class="btn btn-primary center-block"  class="form_button" onclick="funResetFields()"/>
		</p>
 
<br />
	<br />
	</s:form>
	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Invoice</title>
	 	
<style type="text/css">

.transTable td{
	border-left: none;
	padding-left: 0px;
}


</style>

<script type="text/javascript">


		var QtyTol=0.00,list=0,listSettle=0;	
		var discType="", settlementCodeMulti="";
		
	
		
		$(document).ready(function() 
		{	
			discType="";
			var sgData ;
			var prodData;
			funLoadSettlementData();
			
			var clientCode='<%=session.getAttribute("clientCode").toString()%>';
			
			$(".tab_content").hide();
			$(".tab_content:first").show();
	
			$("ul.tabs li").click(function() {
				$("ul.tabs li").removeClass("active");
				$(this).addClass("active");
				$(".tab_content").hide();
				var activeTab = $(this).attr("data-state");
				$("#" + activeTab).fadeIn();
			});
		
	 		var currencyCode=$("#cmbCurrency").val();
 		    var currValue=funGetCurrencyCode(currencyCode);
			if(currValue==null)
			{
				currValue=1.0;
			}
			$("#txtDblCurrencyConv").val(currValue);
			
			var code='<%=session.getAttribute("locationCode").toString()%>';
			funSetLocation(code);
		  	$("#txtDCDate").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtDCDate" ).datepicker('setDate', 'today');
			$("#txtDCDate").datepicker(); 
				
			$("#txtAginst").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtAginst" ).datepicker('setDate', 'today');
			$("#txtAginst").datepicker();
					
			$("#txtWarrPeriod").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtWarrPeriod" ).datepicker('setDate', 'today');
			$("#txtWarrPeriod").datepicker();
						
			$("#txtWarraValidity").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtWarraValidity" ).datepicker('setDate', 'today');
			$("#txtWarraValidity").datepicker();	
			
			$("#txtBuyerOrderNoDated").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtBuyerOrderNoDated" ).datepicker('setDate', 'today');
			$("#txtBuyerOrderNoDated").datepicker(); 
							
			$("#txtDispatchDocNoDated").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtDispatchDocNoDated" ).datepicker('setDate', 'today');
			$("#txtDispatchDocNoDated").datepicker(); 
				
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
				}
			}%>
			
			<%if (session.getAttribute("JVGen") != null) 
			{
				if(session.getAttribute("JVGenMessage") != null)
				{%>
					message='<%=session.getAttribute("JVGenMessage").toString()%>';
					<% session.removeAttribute("JVGenMessage");
				}
				boolean test = ((Boolean) session.getAttribute("JVGen")).booleanValue();
				session.removeAttribute("JVGen");
				if (!test)
				{%>
					alert("Problem in JV Posting\n\n"+message);
				<%}
			}%>
						
			<%if(null!=session.getAttribute("rptInvCode")){%>
							
				code='<%=session.getAttribute("rptInvCode").toString()%>';
				dccode='';
							<%if(null!=session.getAttribute("rptInvDate")){%>
							invDate='<%=session.getAttribute("rptInvDate").toString()%>';
							invoiceformat='<%=session.getAttribute("invoieFormat").toString()%>';
<%-- 							invoiceformat='<%=session.getAttribute("invoieFormat").toString()%>'; --%>
							<%session.removeAttribute("rptInvCode");%>
							<%session.removeAttribute("rptInvDate");%>
							<%session.removeAttribute("rptDcCode");%>
							//var isOk=confirm("Do You Want to Generate Slip?");
							//var Ok=confirm("Do You Want to Generate Receipt?");
							//if(isOk){
								var strIndustryType='<%=session.getAttribute("selectedModuleName").toString()%>';
								if(strIndustryType=='7-WebBanquet') 
		   						{
									if(invoiceformat=="Format 1")
		 							{
				 						window.open(getContextPath()+"/rptProFormaInvoiceSlipFormat5Report.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
				 						
									}
		   						}
								else
								{
									
									
								
								if(invoiceformat=="Format 1")
	 							{
			 						window.open(getContextPath()+"/openRptInvoiceSlip.html?rptInvCode="+code,'_blank');
			 						window.open(getContextPath()+"/openRptInvoiceProductSlip.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
			 						window.open(getContextPath()+"/rptTradingInvoiceSlip.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
								}
								else
								{
									if(invoiceformat=="Format 2")
									{
										window.open(getContextPath()+"/rptInvoiceSlipFromat2.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
										window.open(getContextPath()+"/rptInvoiceSlipNonExcisableFromat2.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
										window.open(getContextPath()+"/rptDeliveryChallanInvoiceSlip.html?strDocCode="+dccode,'_blank');
									}
									else if(invoiceformat=="Format 5")
									{
										
										window.open(getContextPath()+"/rptInvoiceSlipFormat5Report.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
									}
									else if(invoiceformat=="RetailNonGSTA4")
									{
										window.open(getContextPath()+"/openRptInvoiceRetailNonGSTReport.html?rptInvCode="+code,'_blank');
								    }
									else if(invoiceformat=="Format 6")
									{
										window.open(getContextPath()+"/rptInvoiceSlipFormat6Report.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
									}
									else if(invoiceformat=="Format 7")
									{
										window.open(getContextPath()+"/rptInvoiceSlipFormat7Report.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
									}
									else if(invoiceformat=="Format 8")
									{
										window.open(getContextPath()+"/rptInvoiceSlipFormat8Report.html?rptInvCode="+code+"&rptInvDate="+invDate,'_blank');
									}
									else
								    {
								    	window.open(getContextPath()+"/openRptInvoiceRetailReport.html?rptInvCode="+code,'_blank');
								    }
								//}

						         }
							}
							
							/* 
							if(Ok){
						
									window.open(getContextPath()+"/frmReceiptInvoice.html?invCode="+code);
								
							} */

			<%}%><%}%>
							
			$('a#baseUrl').click(function() 
			{
				if($("#txtDCCode").val().trim() == "")
				{
					alert("Please Select Invoice Code");
					return false;
				}
				window.open('attachDoc.html?transName=frmInovice.jsp&formName=Invoice&code='+$("#txtDCCode").val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			});
			
			$("#hidstrInvoiceEditableYN").val("${prodPriceEditable}");
		});
		
		
		function funHelp(transactionName)
		{
			var strIndustryType='<%=session.getAttribute("selectedModuleName").toString()%>';
			if(strIndustryType=='7-WebBanquet') 
	   		{
				if(transactionName.includes('deliveryChallan'))
					{
					transactionName='BookingNo';	
					}
				else if(transactionName.includes('custMasterActive'))
				{
					transactionName='CustomerInfo';
				}
				
				else if(transactionName.includes('proformaInvoice'))
				{
					transactionName='proformaInvoice';
				}
			}
																	
			fieldName = transactionName;
		//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;top=500,left=500")	
		}

		 	function funSetData(code)
			{
				switch (fieldName)
				{
				 	case 'locationmaster':
				    	funSetLocation(code);
				        break;
				        
				 	case 'custMasterActive' :
				    	funSetCuster(code,"Y");
				    	break;
				    	
				 	case 'productProduced':
					 	var cust=$("#txtCustCode").val();
					 	if(cust.length>0)
						{
				    		funSetProduct(code);
						}else{
							alert("Please Select customer code");
						}
					 	break;
				        
				 	case 'deliveryChallan':   
						//funSetDeliveryChallanData(code);
					 	$('#txtSOCode').val(code);
					 	break;
					 
				 	case 'invoice':
						funSetInvoiceData(code)
					  	break;
				        
				 	case 'OpenTaxesForSales':
				    	funSetTax(code);
				       	break;
				       
				 	case 'VehCode' : 
						funSetVehCode(code);
						break;
						
				  	case 'subgroup':
				    	funSetSubGroup(code);
				        break;
				        
				  	case 'invoiceslip':
					   	funSetInvoiceSlipData(code)
					  	break;
					   	
				  	 case 'CustomerInfo':
					    	funSetCustNo(code);
					        break;  
				}
			}
		 	
		 	function funSetCustNo(code)
		 	{
		 		$("#txtCustCode").val(code);
		 	}
		 	
		 	function funSetSubGroup(code)
			{
				$("#hidSubGroupCode").val(code);
				gurl=getContextPath()+"/loadSubGroupMasterData.html?subGroupCode="+code;
				$.ajax({
				        type: "GET",
				        url: gurl,
				        dataType: "json",
				        success: function(response)
				        {
					        	$("#txtSubGroup").val(response.strSGName);
						},
				        error: function(e)
				        {				        	
				        	alert("Invalid SubGroup Code");
			        		$("#txtSubgroupCode").val('');
				        }
			      });
			}
		 	
	
				
	function funSetLocation(code) {
		var searchUrl = "";
		searchUrl = getContextPath()+ "/loadLocationMasterData.html?locCode=" + code;

		$.ajax({
			type : "GET",
			url : searchUrl,
			dataType : "json",
			success : function(response) {
				if (response.strLocCode == 'Invalid Code') {
					alert("Invalid Location Code");
					$("#txtLocCode").val('');
					$("#lblLocName").text("");
					$("#txtLocCode").focus();
				} else {
					$("#txtLocCode").val(response.strLocCode);						
					$("#lblLocName").text(response.strLocName);
					//$("#txtCustCode").focus();
				}
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
	
	

 	function funSetCuster(code,updateCurrency)
	{
		gurl=getContextPath()+"/loadPartyMasterData.html?partyCode=";
		$.ajax({
	        type: "GET",
	        url: gurl+code,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        		if('Invalid Code' == response.strPCode){
	        			alert("Invalid Customer Code");
	        			$("#txtCustCode").val('');
	        			$("#txtCustCode").focus();
	        			$("#lblCustomerName").text('');
	        		}else{			   
	        			$("#txtCustCode").val(response.strPCode);
						$("#lblCustomerName").text(response.strPName);
						$("#txtSAddress1").val(response.strSAdd1);
						$("#txtSAddress2").val(response.strSAdd2);
						$("#txtSCity").val(response.strSCity);
						$("#txtSState").val(response.strSState);
						$("#txtSPin").val(response.strSPin);
						$("#txtSCountry").val(response.strSCountry);
						$("#hidcustDiscount").val(response.dblDiscount);
						$("#txtDiscountPer").val(response.dblDiscount);
						$("#txtMobileNoForSettlement").val(response.strMobile);
						
						
						//$("#txtLocCode").focus();
						$("#hidCreditLimit").val(response.dblCreditLimit);
						if(updateCurrency=='Y')
						{
						$("#cmbCurrency").val(response.strCurrency);
				 		var currencyCode=$("#cmbCurrency").val();
		     	  		var currValue=funGetCurrencyCode(currencyCode);
		     	  		$("#txtDblCurrencyConv").val(currValue);
						}
						
						funSetBalanceAmt();
						
						
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
	
 	
 	
 	function funSetBalanceAmt()
	{
 		var custcode=$("#txtCustCode").val();
 		var invDate=$("#txtDCDate").val();
 		var type1="Customer";
 		var date= invDate.split("-");
 		invDate=date[2]+"-"+date[1]+"-"+date[0];
 		var currencyCode=$("#cmbCurrency").val();
//  		var currValue=funGetCurrencyCode(currencyCode);
		if(currencyCode==null)
		{
			currencyCode="";
		}
  		var gurl1=getContextPath()+"/loadBalanceAmtCreditorDetor.html?type="+type1+"&custSuppCode="+custcode+"&toDate="+invDate+"&currency="+currencyCode;
  				
		$.ajax({
	        type: "GET",
	        url: gurl1,
	        dataType: "json",
	        async:false,
	        success: function(response)
	        {		        	
	        	
	        	$("#lblBalanceAmt").text("Balance Amt:"+(response).toFixed(maxAmountDecimalPlaceLimit));
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
	
 	
 	
 	
	function funCalculateBalAmt()
	{
		gurl=getContextPath()+"/loadPartyMasterData.html?partyCode=";
		$.ajax({
	        type: "GET",
	        url: gurl+code,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        		if('Invalid Code' == response.strPCode){
	        			alert("Invalid Customer Code");
	        			$("#txtPartyCode").val('');
	        			$("#txtPartyCode").focus();
	        		}else{			   
	        			$("#txtCustCode").val(response.strPCode);
						$("#lblCustomerName").text(response.strPName);
						$("#txtSAddress1").val(response.strSAdd1);
						$("#txtSAddress2").val(response.strSAdd2);
						$("#txtSCity").val(response.strSCity);
						$("#txtSState").val(response.strSState);
						$("#txtSPin").val(response.strSPin);
						$("#txtSCountry").val(response.strSCountry);
						$("#hidcustDiscount").val(response.dblDiscount);
						$("#txtDiscountPer").val(response.dblDiscount);
						
						$("#txtLocCode").focus();
						
						funSetDalanceAmt();
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
	
	
	function funSetProduct(code)
	{
		var clientCode='<%=session.getAttribute("clientCode").toString()%>';
		var searchUrl="";
		var locCode = $("#txtLocCode").val();
		var custCode=$("#txtCustCode").val();
		var currCode=$("#cmbCurrency").val();
// 		var currValue=funGetCurrencyCode(currCode);
		var currValue=$("#txtDblCurrencyConv").val();
		if(currValue==0)
		{
		 currValue=1.0;
		}
		searchUrl=getContextPath()+"/loadProductDataForInvoice.html?prodCode="+code+"&suppCode="+custCode+"&locCode="+locCode;
		$.ajax({
			type: "GET",
		    url: searchUrl,
			dataType: "json",
			success: function(response)
			{
			    if(response!="Invalid Product Code")
			    {
			    
			    	var dblStock=funGetProductStock(response[0][0]);
			    	$("#spStock").text(dblStock);
					$("#hidProdCode").val(response[0][0]);
					$("#txtProdName").val(response[0][1]);
					$("#txtPrice").val(parseFloat((response[0][3])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit));
					$("#hidUnitPrice").val(parseFloat((response[0][3])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit));
					if(clientCode=='141.001'){
						$("#hidUnitPrice").val(parseFloat((response[0][9])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit));
					}
					
					$("#txtWeight").val(response[0][7]);
					$("#hidProdType").val(response[0][6]);
					$("#hidPrevInvCode").val(response[0][8]);
					$("#hidPreInvPrice").val(response[0][9]);
					if($("#hidstrInvoiceEditableYN").val()=="Yes")
					{
						$("#hidUnitPrice").attr('readonly', false);	
					}else{
						$("#hidUnitPrice").attr('readonly',true);
					}
					
					if(parseFloat(response[0][11])==0)
					{
						$("#txtPurchasePrice").val(parseFloat((response[0][10])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit));
					}else
					{
						$("#txtPurchasePrice").val(parseFloat((response[0][11])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit));
					}
					$("#txtQty").focus();
				}
			    else
				{
			    	alert("Invalid Product Code");
			    	$("#txtProdName").val('') 
			    	$("#txtProdName").focus();
			    	return false;
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
	
	
	function funSetDeliveryChallanData(code)
	{
		gurl=getContextPath()+"/loadDeliveryChallanHdData.html?dcCode="+code;
		$.ajax({
	        type: "GET",
	        url: gurl,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        		if('Invalid Code' == response.strDCCode){
	        			alert("Invalid Delivery Challan Code");
	        			$("#txtSOCode").val('');
	        			$("#txtSOCode").focus();
	        			
	        		}else{	
	        			funRemoveAllRows();
	        			$('#txtDCCode').val(response.strInvCode);
	        			$('#txtDCDate').val(response.dteInvDate);
	        		//	$('#txtAginst').val(response.strAgainst);
	        			$('#cmbAgainst').val(response.strAgainst);
	        			if(response.strAgainst=="Delivery Challan")
	        			{
	        			document.all["txtSOCode"].style.display = 'block';
	        			document.all["btnFill"].style.display = 'block';
	        			
	        			}else
	        				{
	        				document.all["txtSOCode"].style.display = 'none';
	        				document.all["btnFill"].style.display = 'none';
	        				}
	        			$('#txtPONo').val(response.strPONo);
	        			$('#txtLocCode').val(response.strLocCode);
	        			$('#lblLocName').text(response.strLocName);
	        			$('#txtVehNo').val(response.strVehNo);
	        			$('#txtWarrPeriod').val(response.strWarrPeriod);
	        			$('#txtWarraValidity').val(response.strWarraValidity);
	        			$('#txtNarration').val(response.strNarration);
	        			$('#txtPackNo').val(response.strPackNo);
	        			$('#txtDktNo').val(response.strDktNo);
	        			$('#txtMInBy').val(response.strMInBy);
	        			$('#txtTimeOut').val(response.strTimeInOut);
	        			$('#txtReaCode').val(response.strReaCode);
	        			$("#txtSOCode").val(response.strSOCode);
						$("#txtSODate").val(response.dteSODate);
						$("#txtCustCode").val(response.strCustCode);
						$("#lblCustomerName").text(response.strCustName);
						$("#txtSAddress1").val(response.strSAdd1);
						$("#txtSAddress2").val(response.strSAdd2);
						$("#txtSCity").val(response.strSCity);
						$("#txtSState").val(response.strSState);
						$("#txtSPin").val(response.strSPin);
						$("#txtSCountry").val(response.strSCountry);
						QtyTol=0.00;
						$.each(response.listclsDeliveryChallanModelDtl, function(i,item)
		       	       	    	 {
		       	       	    	    funfillDCDataRow(response.listclsDeliveryChallanModelDtl[i]);
		       	       	    		$("#txtQtyTotl").val(QtyTol);
		       	       	    	 });
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
 	
	
	
	function funSetInvoiceData(code)
	{
		gurl=getContextPath()+"/loadInvoiceHdData.html?invCode="+code;
		$.ajax({
	        type: "GET",
	        url: gurl,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        		if(null == response.strInvCode){
	        			alert("Invalid  Invoice Code");
	        			$('#txtDCCode').val('');
	        			$("#txtDCCode").focus();
	        			funRemoveAllRows();
	        			
	        		}else{	
	        			funRemoveAllRows();
	        			$('#txtDCCode').val(code);
	        			$('#txtDCDate').val(response.dteInvDate);
	        	//		$('#txtAginst').val(response.strAgainst);
	        			$('#cmbAgainst').val(response.strAgainst);
	        			if(response.strAgainst=="Delivery Challan")
	        			{
	        			document.all["txtSOCode"].style.display = 'block';
	        			document.all["btnFill"].style.display = 'block';
	        			
	        			}else
	        				{
	        				document.all["txtSOCode"].style.display = 'none';
	        				document.all["btnFill"].style.display = 'none';
	        				}
	        			$('#txtPONo').val(response.strPONo);
	        			$('#txtLocCode').val(response.strLocCode);
	        			$('#lblLocName').text(response.strLocName);
	        			$('#txtVehNo').val(response.strVehNo);
	        			$('#txtWarrPeriod').val(response.strWarrPeriod);
	        			$('#txtWarraValidity').val(response.strWarraValidity);
	        			$('#txtNarration').val(response.strNarration);
	        			$('#txtPackNo').val(response.strPackNo);
	        			$('#txtDktNo').val(response.strDktNo);
	        			$('#txtMInBy').val(response.strMInBy);
	        			$('#txtTimeOut').val(response.strTimeInOut);
	        			$('#txtReaCode').val(response.strReaCode);
	        			$("#txtSOCode").val(response.strSOCode);
						$("#txtSODate").val(response.dteSODate);
						$("#txtCustCode").val(response.strCustCode);
						$("#lblCustomerName").text(response.strCustName);
						$("#txtSAddress1").val(response.strSAdd1);
						$("#txtSAddress2").val(response.strSAdd2);
						$("#txtSCity").val(response.strSCity);
						$("#txtSState").val(response.strSState);
						$("#txtSPin").val(response.strSPin);
						$("#txtSCountry").val(response.strSCountry);
						$("#txtSubTotlAmt").val(response.dblSubTotalAmt.toFixed(maxQuantityDecimalPlaceLimit));
						//$("#txtFinalAmt").val(response.dblTotalAmt.toFixed(maxQuantityDecimalPlaceLimit));
						
						$("#txtDiscount").val(response.dblDiscountAmt.toFixed(maxQuantityDecimalPlaceLimit));
						$("#txtDiscountPer").val(response.dblDiscount);
						
						$('#cmbSettlement').val(response.strSettlementCode);
						$('#txtMobileNoForSettlement').val(response.strMobileNoForSettlement);
						$("#hidcustDiscount").val(response.dblDiscountAmt);
						
						$("#txtDeliveryNote").val(response.strDeliveryNote);
						$("#txtSupplierRef").val(response.strSupplierRef);
						$("#txtOtherRef").val(response.strOtherRef);
						$("#txtBuyersOrderNo").val(response.strBuyersOrderNo);
						$("#txtBuyerOrderNoDated").val(response.dteBuyerOrderNoDated);
						$("#txtDispatchDocNo").val(response.strDispatchDocNo);
						$("#txtDispatchDocNoDated").val(response.dteDispatchDocNoDated);
						$("#txtDispatchThrough").val(response.strDispatchThrough);
						$("#txtDestination").val(response.strDestination);
						$("#txtExtraCharges").val(response.dblExtraCharges);
						
						$("#cmbCurrency").val(response.strCurrencyCode);
						$("#txtDblCurrencyConv").val(response.dblCurrencyConv);
						funSetCuster(response.strCustCode,"N");
						
						funChangeCombo();
						QtyTol=0.00;
						$.each(response.listclsInvoiceModelDtl, function(i,item)
		       	       	{
							var prevData="loadInvData";					
		       	       	  	funfillDCDataRow(response.listclsInvoiceModelDtl[i],prevData);
		       	       		$("#txtQtyTotl").val(QtyTol);
		       	       	});
						
						funRemoveTaxRows();
						$.each(response.listInvoiceTaxDtl, function(i,item)
			            {
							funFillTaxRow(response.listInvoiceTaxDtl[i]);
			            });
						$("#txtFinalAmt").val(response.dblGrandTotal.toFixed(maxQuantityDecimalPlaceLimit));	
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
 	



 	///////////////////////////////////////////////////////




 	function funCallFormAction(actionName,object) 
	{
		var flg=true;
		var table = document.getElementById("tblProdDet");
		var rowCount = table.rows.length;	

		if ($("#txtCPODate").val()=="") 
		{
			alert('Invalid Date');
			$("#txtCPODate").focus();
			return false;  
		}
	    
		
		if($("#txtSettlementType").val()=="Online Payment")
		{
	 		if($("#txtMobileNoForSettlement").val()=="")
	 		{
	 			alert('Mobile No. Not found ');
	 			return false;
	 		}
		}
		
		var bal = $("#lblBalanceAmt").text();
		var balAmount = bal.split(":");	
		
// 		if($("#hidCreditLimit").val()!=0)
// 		{
		if($("#txtSettlementType").val()=="Credit" && parseFloat($("#hidCreditLimit").val())>0)
		{	
			if(parseFloat(balAmount[1])+parseFloat($("#txtFinalAmt").val()) > parseFloat($("#hidCreditLimit").val()))
			{
				alert("Credit Limit Exceeded");
				return false;
			}
		}
// 		}
	  	if(rowCount<1)
		{
			alert("Please Add Product in Grid");
			return false;
		}
		else
		{
			var clientCode='<%=session.getAttribute("clientCode").toString()%>';
			if(clientCode!='226.001')
			{
			  	//var isOk=confirm("Do You Want to Settle in Cash?");
				//if(isOk)
				//{
					//$('#cmbSettlement').val();
					//$('#cmbSettlement').val("S000001");
				//}else
				//{
				    //$('#cmbSettlement').val();
					//$('#cmbSettlement').val("S000002");
				//}
			}
	
			return true;
		}
	}
 	
	
	function funFillTaxRow(taxDtl) 
	{
	
	    var table = document.getElementById("tblTax");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var taxCode=taxDtl.strTaxCode;
	    var taxDesc=taxDtl.strTaxDesc;
	    var taxableAmt=(taxDtl.strTaxableAmt).toFixed(maxQuantityDecimalPlaceLimit);
	    var taxAmt=(taxDtl.strTaxAmt).toFixed(maxQuantityDecimalPlaceLimit);
		
	    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxCode\" id=\"txtTaxCode."+(rowCount)+"\" value='"+taxCode+"' >";
	    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxDesc\" id=\"txtTaxDesc."+(rowCount)+"\" value='"+taxDesc+"'>";		    	    
	    row.insertCell(2).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxableAmt\" id=\"txtTaxableAmt."+(rowCount)+"\" value="+taxableAmt+">";
	    row.insertCell(3).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxAmt\" id=\"txtTaxAmt."+(rowCount)+"\" value="+taxAmt+">";		    
	    row.insertCell(4).innerHTML= '<input type="button" size=\"6%\" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteTaxRow(this)" >';
	    
	    funCalTaxTotal();
	    funClearFieldsOnTaxTab();
	    
	    return false;
	}
	function funLoadSettlementData()
	{

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/LoadSettlementData.html",
			dataType : "json",
			success : function(response){ 

		       	$.each(response, function(i,item)
			    {
		       		
		       		funFillSettlementRow(item,i,0);
		       		
			    });
				
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
	function funFillSettlementRow(values, key,Amt) 
	{
	    
		if(values!='MultiSettle')
		{
			settlementCodeMulti=key;
			
		    var table = document.getElementById("tblSettlement");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    rowCount=listSettle;
			
		    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"25%\" name=\"listInvsettlementdtlModel["+(rowCount)+"].strSettlementCode\" id=\"txtSettlementCode."+(rowCount)+"\" value='"+key+"' >";
		    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"25%\" name=\"listInvsettlementdtlModel["+(rowCount)+"].strSettlementName\" id=\"txtSettlementName."+(rowCount)+"\" value='"+values+"'>";		    	    
		    row.insertCell(2).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvsettlementdtlModel["+(rowCount)+"].dblSettlementAmt\" id=\"txtSettlementAmt."+(rowCount)+"\" onblur =\"Javacsript:funCalSettlementTotal()\" value='"+Amt+"' >";
		    row.insertCell(3).innerHTML= '<input type="button" size=\"6%\" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteSettlementRow(this)" >';
		    listSettle++;
		    funCalSettlementTotal();
		    		    
	
			
		}	
	    
	}
	
	function funCalSettlementTotal()
	{
		
		var table = document.getElementById("tblSettlement");
	    var rowCount = table.rows.length;
	    var finalAmt=0;
	    if(rowCount > 0)
	    {
			    $('#tblSettlement tr').each(function()
			    {
				    var amt =$(this).find('input')[2].value;// `this` is TR DOM element
				    if(amt != "")
			    	{
				    	finalAmt =parseFloat(amt) + finalAmt ;
				    	if( finalAmt > $("#lblPaymentAmt").text() )
			    		{
			    		  alert("You have Exceeded The Total Payment Amount")
			    		}
				    	else
				    	{
				    		 $("#lblSettlementAmt").text(finalAmt.toFixed(maxQuantityDecimalPlaceLimit));
				    	}	
					   
			    	}
				    
				});
			    
	   }
	  
		
		
	}
	
	function funDeleteSettlementRow(obj) 
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblSettlement");
		table.deleteRow(index);
		//funCalSettlementTotal();
	}
	

	function btnAdd_onclick()
	{
		if($("#hidProdCode").val().length<=0)
		{
			$("#txtProdName").focus();
			alert("Please Enter Product Name Or Search");
			return false;
		}
		if($("#txtDiscount").val().length<=0)
		{
			$("#txtDiscount").focus();
			alert("Please Enter Discount");
			return false;
		}
	    if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0)
	    {		
	    	alert("Please Enter Quantity");
	        $("#txtQty").focus();
	        return false;
	    }
	    var negStock='<%=session.getAttribute("strNegStock").toString()%>';
	    var flgStockChk=false;
	    if(negStock=='N')
	    {
	    	flgStockChk=true;
	    }
	    if(flgStockChk==true && parseFloat($("#spStock").text())<= 0)
        {
        	alert("Please Add Stock");
          	$("#txtQty").focus();
          	return false;
       	}
	    else
	    {
	    	var strProdCode=$("#hidProdCode").val();
	    	var dblWeight=$("#txtWeight").val();
	    	if(funDuplicateProductForUpdate(strProdCode,dblWeight))//function change
	    	{
	    		funAddProductRow();
			}
		}
	}
	
	function funDuplicateProduct(strProdCode,dblWeight)
	{
	    var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;		   
	    var flag=true;
	    if(rowCount > 0)

	    for(var i=0;i<rowCount;i++)
		{
	    		if(strProdCode==document.getElementById("txtProdCode."+i).value && dblWeight==parseFloat(document.getElementById("txtWeight."+i).value))
			    {
			    		alert("Already added Product "+ strProdCode +" of Weight "+dblWeight+"Kg" );
						flag=false;
			    }
    		
    		
	    		
	    	
		}
	    	
    		
		    		
	    return flag;
	}
	
	function funAddProductRow()
	{
		
		
		var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    //rowCount=list;
	    var strProdCode = $("#hidProdCode").val().trim();
		var strProdName=$("#txtProdName").val().trim();
		var strProdType=$("#hidProdType").val();	
	    var dblQty = $("#txtQty").val();
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=$("#txtWeight").val();
	    var dblTotalWeight=dblQty*dblWeight;
	  	var packingNo= $("#txtPackingNo").val();
	    var strSerialNo = $("#txtSerialNo").val();
	    var strInvoiceable = $("#cmbInvoiceable").val();
	    var strRemarks=$("#txtRemarks").val();
	    var prodDisPer=$("#txtProdDisper").val();
	    if(prodDisPer > 0)
	    {
	    	if(	discType == "Total Disc")
			{
				
				alert('You have already  given Total Discount');
	 			return false;  
				
			}
	    	else
	    	{
	    		discType="";
		    	discType="Item Wise disc";
		    	$("#hidDiscType").val(discType);
	    	}	
	    	
	    }	
	    
	    var prevInvCode=$("#hidPrevInvCode").val();
	    var prevProdrice=$("#hidPreInvPrice").val();
        var unitprice=$("#hidUnitPrice").val();
        unitprice=parseFloat(unitprice).toFixed(maxQuantityDecimalPlaceLimit);
	  
       var totalPrice=unitprice*dblQty;
	   if(dblTotalWeight>0){
		   totalPrice=unitprice*dblQty*dblWeight;
	   }
	   var disAmt=0;
	   if($("#cmbDiscType").val() =='Per')
	   {
		   disAmt=(prodDisPer*totalPrice)/100;
	   }
	   else
	   {
		   disAmt=prodDisPer;	   
	   }	   
	 
	   var grandtotalPrice=totalPrice- disAmt;
	   
    
       var strCustCode=$("#txtCustCode").val();
       var strSOCode="";
      
	    row.insertCell(0).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" size=\"8%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"40%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"2%\"  class=\"decimal-places inputText-Auto  txtQty\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"2%\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblTotalWeight\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;\" size=\"12%\" id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box txtUnitprice\" style=\"text-align: right;\" \size=\"12.9%\" id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;\" \size=\"12%\" id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    
	    row.insertCell(7).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblDisAmt\" readonly=\"readonly\" class=\"Box dblDisAmt\" style=\"text-align: right;\" \size=\"6.9%\" id=\"dblDisAmt."+(rowCount)+"\"   value='"+disAmt+"'/>";
	    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box grandtotalPrice\" style=\"text-align: right;\" \size=\"11%\" id=\"grandtotalPrice."+(rowCount)+"\"   value='"+grandtotalPrice+"'/>";
	    
	    row.insertCell(9).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strPktNo\" type=\"text\"    class=\"Box\" \size=\"5%\" id=\"txtPktNo."+(rowCount)+"\" value="+packingNo+" >";
		row.insertCell(10).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strRemarks\" size=\"7%\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	    row.insertCell(11).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strInvoiceable\" readonly=\"readonly\" class=\"Box\"  size=\"6%\" id=\"txtInvoiceable."+(rowCount)+"\" value="+strInvoiceable+" >";
	    row.insertCell(12).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSerialNo\" type=\"text\"    class=\"Box\" size=\"5%\" id=\"txtSerialNo."+(rowCount)+"\" value="+strSerialNo+" >";	    
	 	row.insertCell(13).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	 	row.insertCell(14).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strCustCode\" type=\"text\"    class=\"Box\" size=\"7%\" id=\"txtCustCode."+(rowCount)+"\" value="+strCustCode+" >";
	 	row.insertCell(15).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSOCode\" type=\"text\"    class=\"Box\" size=\"13%\" id=\"txtSOCOde."+(rowCount)+"\" value="+strSOCode+" >";
	 	row.insertCell(16).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInvCode\" style=\"text-align: right;\" \size=\"3.9%\" id=\"prevInvCode."+(rowCount)+"\"   value='"+prevInvCode+"'/>";
	 	row.insertCell(17).innerHTML= "<input readonly=\"readonly\" class=\"Box prevProdrice\" style=\"text-align: right;\" \size=\"3.9%\" id=\"prevProdrice."+(rowCount)+"\"   value='"+prevProdrice+"'/>";
// 	 	 row.insertCell(18).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdType\" type=\"hidden\" size=\"0%\" id=\"txtProdTpye."+(rowCount)+"\" value='"+strProdType+"'/>";
		     list++; 
		     funSetTotalQty(); 
	 	// QtyTol+=parseFloat(dblQty);
	 	//$("#txtQtyTotl").val(QtyTol);
	 	
	  //  $("#txtSubGroup").focus();
	    funCalculateTotalAmt();
	    funClearProduct();
	   // funGetTotal();
	 
	    return false;
	}
	
	function funSeProductUnitPrice(code)
	{
		var strCustCode = $("#txtCustCode").val();
		var discount= $("#txtDiscount").val();
		var searchUrl="";
		searchUrl=getContextPath()+"/loadInvoiceProductDetail.html?prodCode="+code+"&strCustCode="+strCustCode+"&discount="+discount;
		$.ajax
		({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    success: function(response)
		    {
		     $("#hidbillRate").val(response);
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
	
	
	
	
	function funUpdatePrice(object)
	{
		var index=object.parentNode.parentNode.rowIndex;
		var Qty=document.getElementById("txtQty."+index).value;
		var price=document.getElementById("unitprice."+index).value;
		var discount=document.getElementById("dblDisAmt."+index).value;
		var ItemPrice;
		ItemPrice=(parseFloat(Qty)*parseFloat(price))-parseFloat(discount);
		document.getElementById("totalPrice."+index).value=(parseFloat(Qty)*parseFloat(price));
		document.getElementById("grandtotalPrice."+index).value=parseFloat(ItemPrice);
		//funGetTotal();
		funCalculateTotalAmt();
	}
	
	
	
	function funDeleteRow(obj) 
	{
		var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblProdDet");
	    table.deleteRow(index);
		var discAmt=0;
		var count=0;
		$('#tblProdDet tr').each(function()
	    {
		    if(discAmt=$(this).find('input')[4].value > 0)// `this` is TR DOM element
			{
		    	count++; 
			}
		});
		if(!(count >= 1))
		{
			
		   discType=""; 
		   $("#txtDiscount").val(0);
		}
		funSetTotalQty();
		
		
		
		
	}
	
	
	
	function funfillDeliveryChallanDataRow(DCDtl,prevInvData,currValue)
	{
		var table = document.getElementById("tblProdDet");
	
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = DCDtl.strProdCode;
		var strProdName=DCDtl.strProdName;
		var strProdType=DCDtl.strProdType;	
	    var dblQty = DCDtl.dblQty;
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=DCDtl.dblWeight;
	    var dblTotalWeight=dblQty*dblWeight;
	    
	  	var packingNo= DCDtl.strPktNo;
	    var strSerialNo = DCDtl.strSerialNo;
	    var strInvoiceable = DCDtl.strInvoiceable;
	    var strRemarks=DCDtl.strRemarks;

	    var disAmt=DCDtl.dblDisAmt;
	    disAmt=0;
	    var unitprice="";
	   
	    var CustCode=$("#txtCustCode").val();
	    var SOCode=$("#txtSOCode").val();
	    var precode="";
	    var preAmt="";
	    
	    if(prevInvData=="loadInvData")
	    {
	    	precode=DCDtl.prevInvCode;
	    	preAmt=DCDtl.prevUnitPrice;
	    	unitprice=DCDtl.dblUnitPrice;
	    }
	    else
	    {
	 		precode=prevInvData.strInvCode;
	 		preAmt=prevInvData.dblUnitPrice;
	 		unitprice=DCDtl.dblPrice;
		}
	   
	    var totalPrice=unitprice*dblQty;
	    var grandtotalPrice=totalPrice-disAmt;
	    
	    /*unitprice=unitprice/currValue;
	    totalPrice=totalPrice/currValue;
	    
	    grandtotalPrice=grandtotalPrice/currValue;
	    preAmt=preAmt/currValue;*/
	    unitprice=unitprice;
	    totalPrice=totalPrice;
	    
	    grandtotalPrice=grandtotalPrice;
	    preAmt=preAmt;
	    row.insertCell(0).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" size=\"7%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"35%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\"  class=\"decimal-places inputText-Auto  txtQty\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblTotalWeight\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;\" size=\"11%\" id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box txtUnitprice\" style=\"text-align: right;\" \size=\"8.9%\" id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;\" \size=\"11%\" id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    
	    row.insertCell(7).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblDisAmt\" readonly=\"readonly\" class=\"Box dblDisAmt\" style=\"text-align: right;\" \size=\"4.9%\" id=\"dblDisAmt."+(rowCount)+"\"   value='"+disAmt+"'/>";
	    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box grandtotalPrice\" style=\"text-align: right;\" \size=\"11%\" id=\"grandtotalPrice."+(rowCount)+"\"   value='"+grandtotalPrice+"'/>";
	    
	    row.insertCell(9).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strPktNo\" type=\"text\"    class=\"Box\" \size=\"5%\" id=\"txtPktNo."+(rowCount)+"\" value="+packingNo+" >";
	    row.insertCell(10).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strRemarks\" size=\"7%\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	    row.insertCell(11).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strInvoiceable\" readonly=\"readonly\" class=\"Box\"  size=\"6%\" id=\"txtInvoiceable."+(rowCount)+"\" value="+strInvoiceable+" >";
	    row.insertCell(12).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSerialNo\" type=\"text\"    class=\"Box\" size=\"5%\" id=\"txtSerialNo."+(rowCount)+"\" value="+strSerialNo+" >";	    
	 	row.insertCell(13).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';	    
	 	row.insertCell(14).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strCustCode\" type=\"text\"    class=\"Box\" size=\"7%\" id=\"txtCustCode."+(rowCount)+"\" value="+CustCode+" >";
	 	row.insertCell(15).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSOCode\" type=\"text\"    class=\"Box\" size=\"13%\" id=\"txtSOCOde."+(rowCount)+"\" value="+SOCode+" >";
	 	row.insertCell(16).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInCode\" style=\"text-align: right;\" \size=\"11%\" id=\"prevInCode."+(rowCount)+"\"   value='"+precode+"'/>";
	 	row.insertCell(17).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInvPrice\" style=\"text-align: right;\" \size=\"3.9%\" id=\"prevInvPrice."+(rowCount)+"\"   value='"+preAmt+"'/>";
	 	row.insertCell(18).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdType\" style=\"text-align: right;\" id=\"txtProdTpye."+(rowCount)+"\" value='"+strProdType+"' type=\"hidden\"/>";
	    
	 	
	 	//$("#txtSubGroup").focus();
		funClearProduct();
		funCalculateTotalAmt();
		
		QtyTol+=dblQty;
		
		return false;
	}
	
	
	
	function funfillDCDataRow(DCDtl,prevInvData)
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = DCDtl.strProdCode;
		var strProdName=DCDtl.strProdName;
		var strProdType=DCDtl.strProdType;	
	    var dblQty = DCDtl.dblQty;
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=DCDtl.dblWeight;
	    var dblTotalWeight=dblQty*dblWeight;	    
	  	var packingNo= DCDtl.strPktNo;
	    var strSerialNo = DCDtl.strSerialNo;
	    var strInvoiceable = DCDtl.strInvoiceable;
	    var strRemarks=DCDtl.strRemarks;

	    var disAmt=DCDtl.dblDisAmt;
	    var unitprice="";
	    var dblAssValue=DCDtl.dblAssValue;
	    var CustCode=$("#txtCustCode").val();
	    var SOCode=DCDtl.strSOCode//$("#txtSOCode").val();
	    var precode="";
	    var preAmt="";
	    
	    if(prevInvData=="loadInvData")
	    {
	    	precode=DCDtl.prevInvCode;
	    	preAmt=DCDtl.prevUnitPrice;
	    	unitprice=DCDtl.dblUnitPrice;
	    }
	    else
	    {
	 		precode=prevInvData.strInvCode;
	 		preAmt=prevInvData.dblUnitPrice;
	 		unitprice=DCDtl.dblPrice;
		}
	   
	    var totalPrice=unitprice*dblQty;
	    if(dblAssValue>0){
	    	totalPrice=dblAssValue;	
	    }
	    var grandtotalPrice=totalPrice-disAmt;
	    row.insertCell(0).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" size=\"7%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"35%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\"  class=\"decimal-places inputText-Auto  txtQty\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblTotalWeight\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;\" size=\"12%\" id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box txtUnitprice\" style=\"text-align: right;\" \size=\"12%\" id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;\" \size=\"12%\" id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    
	    row.insertCell(7).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblDisAmt\" readonly=\"readonly\" class=\"Box dblDisAmt\" style=\"text-align: right;\" \size=\"4.9%\" id=\"dblDisAmt."+(rowCount)+"\"   value='"+disAmt+"'/>";
	    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box grandtotalPrice\" style=\"text-align: right;\" \size=\"11%\" id=\"grandtotalPrice."+(rowCount)+"\"   value='"+grandtotalPrice+"'/>";
	    
	    row.insertCell(9).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strPktNo\" type=\"text\"    class=\"Box\" \size=\"5%\" id=\"txtPktNo."+(rowCount)+"\" value="+packingNo+" >";
	    row.insertCell(10).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strRemarks\" size=\"7%\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	    row.insertCell(11).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strInvoiceable\" readonly=\"readonly\" class=\"Box\"  size=\"6%\" id=\"txtInvoiceable."+(rowCount)+"\" value="+strInvoiceable+" >";
	    row.insertCell(12).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSerialNo\" type=\"text\"    class=\"Box\" size=\"5%\" id=\"txtSerialNo."+(rowCount)+"\" value="+strSerialNo+" >";	    
	 	row.insertCell(13).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';			    
	 	row.insertCell(14).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strCustCode\" type=\"text\"    class=\"Box\" size=\"7%\" id=\"txtCustCode."+(rowCount)+"\" value="+CustCode+" >";
	 	row.insertCell(15).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSOCode\" type=\"text\"    class=\"Box\" size=\"13%\" id=\"txtSOCOde."+(rowCount)+"\" value="+SOCode+" >";
	 	row.insertCell(16).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInCode\" style=\"text-align: right;\" \size=\"11%\" id=\"prevInCode."+(rowCount)+"\"   value='"+precode+"'/>";
	 	row.insertCell(17).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInvPrice\" style=\"text-align: right;\" \size=\"3.9%\" id=\"prevInvPrice."+(rowCount)+"\"   value='"+preAmt+"'/>";
	 	row.insertCell(18).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdType\" id=\"txtProdTpye."+(rowCount)+"\" value='"+strProdType+"' type=\"hidden\"/>";
	    
	 	
	 	//$("#txtSubGroup").focus();
		funClearProduct();
		funCalculateTotalAmt();
		
		QtyTol+=dblQty;
		
		return false;
	}
	
	

// 	function funCallFormAction(actionName,object) 
// 	{
// 		var flg=true;
// 		var table = document.getElementById("tblProdDet");
// 		var rowCount = table.rows.length;	

// 		if ($("#txtCPODate").val()=="") 
// 		{
// 			alert('Invalid Date');
// 			$("#txtCPODate").focus();
// 			return false;  
// 		}
	
// 		if($("#txtSettlementType").val()=="Online Payment")
// 		{
// 	 		if($("#txtMobileNoForSettlement").val()=="")
// 	 		{
// 	 			alert('Mobile No. Not found ');
// 	 			return false;
// 	 		}
// 		}
		
// 		var bal = $("#lblBalanceAmt").text();
// 		var balAmount = bal.split(":");
// 		var balAmt=parseFloat(balAmount[1]);
// 		if($("#txtSettlementType").val()=="Credit")
// 		{	
// 			if(balAmount[1]+parseFloat($("#txtFinalAmt").val())>parseFloat($("#hidCreditLimit").val()))
// 			{
// 				alert("Credit Limit Exceeded");
// 				return false;
// 			}
// 		}
// 	  	if(rowCount<1)
// 		{
// 			alert("Please Add Product in Grid");
// 			return false;
// 		}
// 		else
// 		{
<%-- 			var clientCode='<%=session.getAttribute("clientCode").toString()%>'; --%>
// 			if(clientCode!='226.001')
// 			{
// 			  	var isOk=confirm("Do You Want to Settle in Cash?");
// 				if(isOk)
// 				{
// 					$('#cmbSettlement').val();
// 					$('#cmbSettlement').val("S000001");
// 				}else
// 				{
// 				    $('#cmbSettlement').val();
// 					$('#cmbSettlement').val("S000002");
// 				}
// 			}
	
// 			return true;
// 		}
// 	}
	
	
	function funClearProduct()
	{
		$("#txtSubGroup").val("");
		$("#txtProdName").val("");
		$("#lblUOM").text("");
		$("#lblProdName").text("");
		$("#txtQty").val("");
		$("#txtPrice").val("");
		
		$("#txtRemarks").val("");
		$("#txtWeight").val("");
// 		$("#txtDiscount").val(0);
	}
	
	function funApplyNumberValidation(){
		$(".numeric").numeric();
		$(".integer").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
		$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
		$(".positive-integer").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	    $(".decimal-places").numeric({ decimalPlaces: maxQuantityDecimalPlaceLimit, negative: false });
	}
	function funResetFields()
	{
		location.reload(true); 
	}
	
	function funRemoveAllRows() 
    {
		 var table = document.getElementById("tblProdDet");
		 var rowCount = table.rows.length;			   
		//alert("rowCount\t"+rowCount);
		for(var i=rowCount-1;i>=0;i--)
		{
			table.deleteRow(i);						
		} 
    }
	
	function funShowSOFieled()
	{
		
		var agianst = $("#cmbAgainst").val();
		if(agianst=="Direct")
			{
			document.all["txtSOCode"].style.display = 'none';
			document.all["btnFill"].style.display = 'none'; 		
			}if(agianst=="Sales Order")
			{
				document.all["txtSOCode"].style.display = 'block';
				document.all["btnFill"].style.display = 'none'; 		
				}
			
			if(agianst=="Banquet")
			{
			document.all["txtSOCode"].style.display = 'block';
			document.all["btnFill"].style.display = 'block'; 		
			}
				else{
					document.all["txtSOCode"].style.display = 'block';
					document.all["btnFill"].style.display = 'block';
					}
			}
	
	
	function btnFill_onclick()
	{
		var code =$('#txtSOCode').val();
		 var  cmbAgainst=$('#cmbAgainst').val();
		if(cmbAgainst="Delivery Challan")
		{
		if(code.toString.lenght!=0 || code==null)
			{
		
				gurl=getContextPath()+"/loadDeliveryChallanHdData.html?dcCode="+code;
				$.ajax({
			        type: "GET",
			        url: gurl,
			        dataType: "json",
			        success: function(response)
			        {		        	
			        		if('Invalid Code' == response.strDCCode){
			        			alert("Invalid Customer Code");
			        			$("#txtSOCode").val('');
			        			$("#txtSOCode").focus();
			        			
			        		}else{	
			        			funRemoveAllRows();
			        		 	$('#txtSOCode').val(code); 
// 			        			$('#txtAginst').val(response.strAgainst);
// 			        			$('#cmbAgainst').val(cmbAgainst);
// 			        			if(response.strAgainst=="Delivery Challan")
// 			        			document.all["txtSOCode"].style.display = 'block';
// 			        			document.all["btnFill"].style.display = 'block';
			        			
			        			$('#txtPONo').val(response.strPONo);
			        			$('#txtPONo').val(response.strPONo);
			        			$('#txtLocCode').val(response.strLocCode);
			        			$('#lblLocName').text(response.strLocName);
			        			$('#txtVehNo').val(response.strVehNo);
			        			$('#txtWarrPeriod').val(response.strWarrPeriod);
			        			$('#txtWarraValidity').val(response.strWarraValidity);
			        			$('#txtNarration').val(response.strNarration);
			        			$('#txtPackNo').val(response.strPackNo);
			        			$('#txtDktNo').val(response.strDktNo);
			        			$('#txtMInBy').val(response.strMInBy);
			        			$('#txtTimeOut').val(response.strTimeInOut);
			        			$('#txtReaCode').val(response.strReaCode);
 			        			
								$("#txtSODate").val(response.dteSODate);
								$("#txtCustCode").val(response.strCustCode);
								$("#lblCustomerName").text(response.strCustName);
								$("#txtSAddress1").val(response.strSAdd1);
								$("#txtSAddress2").val(response.strSAdd2);
								$("#txtSCity").val(response.strSCity);
								$("#txtSState").val(response.strSState);
								$("#txtSPin").val(response.strSPin);
								$("#txtSCountry").val(response.strSCountry);
								$("#txtSubTotlAmt").val(response.dblSubTotalAmt);
								//$("#txtFinalAmt").val(response.dblTotalAmt.toFixed(maxQuantityDecimalPlaceLimit));
								$("#txtFinalAmt").val(response.dblTotalAmt);
								//$('#cmbSettlement').val(response.strSettlementCode);
								$('#cmbCurrency').val(response.strCurrency);
								//$('#txtDblCurrencyConv').val(response.dblConversion);
								
// 								var cmbCurrency=$("#cmbCurrency").val();
// 								var currValue=funGetCurrencyCode(cmbCurrency);
								var currValue=parseFloat(response.dblConversion);
								QtyTol=0.00;
			        			$.each(response.listclsDeliveryChallanModelDtl, function(i,item)
				       	        {
			        				funfillDeliveryChallanDataRow(response.listclsDeliveryChallanModelDtl[i],response.listclsInvoiceBean[i],currValue);
				       	     	 $("#txtQtyTotl").val(QtyTol);
				       	       	});
			        			
			        		
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
	}

	$(function()
			{
				$("#txtDCCode").blur(function() 
						{
							var code=$('#txtDCCode').val();
							if(code.trim().length > 0 && code !="?" && code !="/")
							{
								funSetInvoiceData(code);
							}
						});
				$('#txtProdName').blur(function () {
					var code=$('#hidProdCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
						funSetProduct(code);
					   }
					});
				
				$('#txtCustCode').blur(function () {
					var code=$('#txtCustCode').val();
					var cstName=$('#lblCustomerName').text();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
					if(cstName.trim().length<0)
					 {
						funSetCuster(code,"Y");
				     }
					}
					});
				
				$('#txtLocCode').blur(function () {
					var code=$('#txtLocCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
						funSetLocation(code);
					   }
					});
				
				$('#txtSubGroup').blur(function () {
					var code=$('#hidSubGroupCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
						funSetSubGroup(code);
					   }
					});
				
				$('#txtTaxCode').blur(function () {
					var code=$('#txtTaxCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
						funSetTax(code);
					   }
					});
				
				
				$('#txtVehCode').blur(function () {
					var code=$('#txtVehCode').val();
					if (code.trim().length > 0 && code !="?" && code !="/"){								  
						funSetVehCode(code);
					   }
					});
			 	
				
				/**
				 * Checking Authorization
				**/
				var flagOpenFromAuthorization="${flagOpenFromAuthorization}";
				if(flagOpenFromAuthorization == 'true'){
					funSetInvoiceData("${authorizationInvoiceCode}");
				}
			 
				
				
			});
	
	
	/**
	 * Calculate Total Amount
	 */
	function funCalculateTotalAmt()
	{
		var totalAmt=0;
		var dblDisAmt=0;
		var table = document.getElementById("tblProdDet");
		var rowCount = table.rows.length;
		
		for(var i=0;i<rowCount;i++)
		{
			totalAmt=parseFloat(document.getElementById("totalPrice."+i).value)+totalAmt;
			dblDisAmt=parseFloat(document.getElementById("dblDisAmt."+i).value)+dblDisAmt;
		}
		
		$("#txtSubTotlAmt").val(totalAmt.toFixed(maxQuantityDecimalPlaceLimit));
		
		/* var discount=(totalAmt*parseFloat($("#txtDiscountPer").val()))/100;
		dblDisAmt=dblDisAmt+parseFloat(discount); */
		$("#txtDiscount").val(dblDisAmt.toFixed(maxQuantityDecimalPlaceLimit));
		var disc=$("#txtDiscount").val();
		var extraCharge = $('#txtExtraCharges').val();   
		var finalAmt=parseFloat(totalAmt)+parseFloat(extraCharge)-parseFloat(disc);
		$("#txtFinalAmt").val(finalAmt.toFixed(maxQuantityDecimalPlaceLimit));
	}
	
	
	
	/**
	 * Ready Function for Tax
	 */
	$(function()
	{
		$("#btnAddTax").click(function()
		{
			if($("#txtTaxCode").val()=='')
		    {
				alert("Please Enter Tax Code");
		   		$("#txtTaxCode").focus();
		       	return false;
			}
			else
			{
				funAddTaxRow();
			}
		});
		
		$("#btnGenTax").click(function()
		{
			
 			funCalculateIndicatorTax();
		});
		
		$('#txtTaxableAmt').blur(function () 
		{
			funCalculateTaxForSubTotal(parseFloat($("#txtTaxableAmt").val()),taxPer);
		});
	});
	
	
	
	/**
	 * Calculating Tax per Tax indicator 
	 */
	function funCalculateIndicatorTax()
	{
		var prodCodeForTax="";
		funRemoveTaxRows();
		var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;
		var currValue='<%=session.getAttribute("currValue").toString()%>';
		if(currValue==null)
		{
		  currValue=1;
		}
	    var cnt=0;
	    for(var cnt=0;cnt<rowCount;cnt++)
	    {
	    	
// 	    	var prodCode= $(this).find(".txtProdCode").val();
	    	var prodCode=document.getElementById("txtProdCode."+cnt).value;
	    	var discAmt=0;
	    	var suppCode=$("#txtCustCode").val();
         	var discPer=0;
	    	if($("#txtDiscPer").val()!='')
	    	{	
	    		discPer=parseFloat($("#txtDiscPer").val());
	    		discAmt=(taxableAmount*discPer)/100
	    	}
 	    	var vari=document.getElementById("totalPrice." + cnt).value;
			//var taxableAmount= parseFloat($(this).find(".totalValueCell").val());
			var taxableAmount=parseFloat(vari);
			
	    	var discAmt=(taxableAmount*discPer)/100;
// 	    	taxableAmount=taxableAmount-discAmt;
	    	
	    	var qty=parseFloat(document.getElementById("txtQty."+cnt).value);		    	
	    	var unitPrice=parseFloat(document.getElementById("unitprice."+cnt).value);
	    	//var discAmt1=parseFloat(document.getElementById("txtDiscount").value);
	    	
	    	var discAmt1=parseFloat(document.getElementById("dblDisAmt."+cnt).value);
	    	var dblWeight=parseFloat(document.getElementById("dblTotalWeight."+cnt).value);
	    	
	    	prodCodeForTax=prodCodeForTax+"!"+prodCode+","+unitPrice+","+suppCode+","+qty+","+discAmt1+","+dblWeight;
	    }
		
	    prodCodeForTax=prodCodeForTax.substring(1,prodCodeForTax.length).trim();
	    forTax(prodCodeForTax);
	}
	
	
	function forTax(prodCodeForTax)
	{
		var invDate =$('#txtDCDate').val();
		var date= invDate.split("-");
		var dteInv=date[2]+"-"+date[1]+"-"+date[0];  
		var CIFAmt=0;
		var settleCode=$("#cmbSettlement").val();
		if($("#cmbSettlement").val() == "MultiSettle")
		{
			settleCode=settlementCodeMulti;
		}
		
		var taxType = "";
		var strIndustryType='<%=session.getAttribute("selectedModuleName").toString()%>';
		if(strIndustryType=='7-WebBanquet') 
   		{
			taxType = "Banquet";
   		}
		else
		{
			taxType = "Sales";
		}
	    gurl=getContextPath()+"/getTaxDtlForProduct.html?prodCode="+prodCodeForTax+"&taxType="+taxType+"&transDate="+dteInv+"&CIFAmt="+CIFAmt+"&strSettlement="+settleCode,
	    $.ajax({
			type: "GET",
		    url:gurl,
			dataType: "json",
		    success: function(response)
		    {
		       	$.each(response, function(i,item)
			    {
		       		var spItem=item.split('#');
		       		if(spItem[1]=='null')
		       		{
		       		}
		       		else
			    	{
		       			var dblExtraCharge="0.0";
		       			var taxableAmt=parseFloat(spItem[0]);
		        		var taxCode=spItem[1];
			        	var taxDesc=spItem[2];
			        	var taxPer1=parseFloat(spItem[4]);
			        	var taxAmt=parseFloat(spItem[5]);
			        	taxAmt=taxAmt.toFixed(2);
			        	taxableAmt=taxableAmt.toFixed(2);
			        	funAddTaxRow1(taxCode,taxDesc,taxableAmt,taxAmt);
			    	}
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
	
	
	
	
	/**
	 * Calculating Tax subtotal amount
	 */
	function funCalculateTaxForSubTotal(taxableAmt,taxPercent)
	{
		var taxAmt=(taxableAmt*taxPercent/100);
		taxAmt=taxAmt.toFixed(2);
		$("#txtTaxAmt").val(taxAmt);
	}
	
	/**
	 * Remove all tax form grid 
	 */
	function funRemoveTaxRows()
	{
		var table = document.getElementById("tblTax");
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	
	/**
	 * Filling Tax in Grid
	 */
	function funAddTaxRow1(taxCode,taxDesc,taxableAmt,taxAmt) 
	{	
	    var table = document.getElementById("tblTax");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	
    
	    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxCode\" id=\"txtTaxCode."+(rowCount)+"\" value='"+taxCode+"' >";
	    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxDesc\" id=\"txtTaxDesc."+(rowCount)+"\" value='"+taxDesc+"'>";		    	    
	    row.insertCell(2).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxableAmt\" id=\"txtTaxableAmt."+(rowCount)+"\" value="+taxableAmt+">";
	    row.insertCell(3).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxAmt\" id=\"txtTaxAmt."+(rowCount)+"\" value="+taxAmt+">";		    
	    row.insertCell(4).innerHTML= '<input type="button" size=\"6%\" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteTaxRow(this)" >';
	    funCalTaxTotal();
	    funClearFieldsOnTaxTab();
	    
	    return false;
	}
	
	/**
	 * Delete a particular tax form grid
	 */
	function funDeleteTaxRow(obj) 
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblTax");
		table.deleteRow(index);
		funCalTaxTotal();
	}
	
	/**
	 * Calculating Total Tax 
	 */
	function funCalTaxTotal()
	{
		var totalTaxAmt=0,totalTaxableAmt=0;
		var table = document.getElementById("tblTax");
		var rowCount = table.rows.length;
		var subTotal=parseFloat($("#txtSubTotlAmt").val());
		totalTaxableAmt=parseFloat(document.getElementById("txtTaxableAmt."+0).value);
		for(var i=0;i<rowCount;i++)
		{
			
			//totalTaxableAmt=parseFloat(document.getElementById("txtTaxableAmt."+i).value)+totalTaxableAmt;
			totalTaxAmt=parseFloat(document.getElementById("txtTaxAmt."+i).value)+totalTaxAmt;
		}
		
		totalTaxableAmt=totalTaxableAmt.toFixed(2);
		totalTaxAmt=totalTaxAmt.toFixed(2);
		var grandTotal=parseFloat(subTotal)+parseFloat(totalTaxAmt);
		grandTotal=grandTotal.toFixed(2);
		$("#lblTaxableAmt").text(totalTaxableAmt);
		$("#lblTaxTotal").text(totalTaxAmt);			
// 		$("#lblPOGrandTotal").text(grandTotal);
// 		var taxAmt=$("#txtPOTaxAmt").val();
		var disAmt = $('#txtDiscount').val();
		var extraCharge = $('#txtExtraCharges').val();
		var finalAmt=parseFloat(subTotal)+parseFloat(extraCharge)+parseFloat(totalTaxAmt)-disAmt;
		$("#txtFinalAmt").val(finalAmt.toFixed(maxQuantityDecimalPlaceLimit));
		var code=$("#cmbSettlement").val();
		if(code == "MultiSettle")
		{
			document.getElementsByName("tab4")[0].style.display = "block";
			document.getElementById('tab4').style.visibility='visible';
		}
	}
	
		/**
		 * Reset Tax field
		 */
		function funClearFieldsOnTaxTab()
		{
			$("#txtTaxCode").val("");
			$("#lblTaxDesc").text("");
			$("#txtTaxableAmt").val("");
			$("#txtTaxAmt").val("");
			$("#txtTaxCode").focus();
		
		}
		function funAddTaxRow() 
		{
			var taxCode = $("#txtTaxCode").val();
			var taxDesc=$("#lblTaxDesc").text();
		    var taxableAmt = $("#txtTaxableAmt").val();
		    var taxAmt=$("#txtTaxAmt").val();
		    var table = document.getElementById("tblTax");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxCode\" id=\"txtTaxCode."+(rowCount)+"\" value='"+taxCode+"' >";
		    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxDesc\" id=\"txtTaxDesc."+(rowCount)+"\" value='"+taxDesc+"'>";		    	    
		    row.insertCell(2).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxableAmt\" id=\"txtTaxableAmt."+(rowCount)+"\" value="+taxableAmt+">";
		    row.insertCell(3).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;\" size=\"15.5%\" name=\"listInvoiceTaxDtl["+(rowCount)+"].strTaxAmt\" id=\"txtTaxAmt."+(rowCount)+"\" value="+taxAmt+">";		    
		    row.insertCell(4).innerHTML= '<input type="button" size=\"6%\" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteTaxRow(this)" >';
		    funCalTaxTotal();
		    funClearFieldsOnTaxTab();
		    return false;
		}
	
		
		function funSetVehCode(code){

			$.ajax({
				type : "GET",
				url : getContextPath()+ "/LoadVehicleMaster.html?docCode=" + code,
				dataType : "json",
				success : function(response){ 
					
					if('Invalid Code' == response.strVehCode){
	        			alert("Invalid Vehicle Code");
	        			$("#txtVehCode").val('');
	        			$("#txtVehCode").focus();
	        		}else{
	        			$("#txtVehNo").val(response.strVehNo);
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
	
		
		
		//Open Against Form


		function funOpenAgainst() 
		{
			if ($("#cmbAgainst").val() == "Sales Order") 
			{
				if($("#txtLocCode").val()=="")
				{
					alert("Please Enter LocationCode");
					$("#txtLocCode").focus();
					return false;
				}
				if($("#txtCustCode").val()=="")
				{
					alert("Please Customer");
					$("#txtCustCode").focus();
					return false;
				}
				if ($("#txtSODate").val()=="") 
			    {
				 	alert('Invalid Date');
				 	$("#txtSODate").focus();
				 	return false;  
			    }
				var date = $('#txtDCDate').val();
				var array = new Array();
			//split string and store it into array
				array = date.split('-');

			//from array concatenate into new date string format: "DD.MM.YYYY"
				var dtFullfilled = (array[2] + "-" + array[1] + "-" + array[0]);
				var locCode = $('#txtLocCode').val();
				var custCode = $('#txtCustCode').val();
				funOpenInvoiceHelp(locCode,dtFullfilled,custCode);
				return false;
			}
			else if ($("#cmbAgainst").val() == "Banquet") 
			{
				if($("#txtCustCode").val()=="")
				{
					alert("Please Customer");
					$("#txtCustCode").focus();
					return false;
				}
				var date = $('#txtDCDate').val();
				var array = new Array();
			
				array = date.split('-');

			
				var dtFullfilled = (array[2] + "-" + array[1] + "-" + array[0]);
				var locCode = $('#txtLocCode').val();
				var custCode = $('#txtCustCode').val();
				funOpenInvoiceHelpForBanquet(locCode,dtFullfilled,custCode);
				return false;
			}
			else{
				if($("#txtCustCode").val()=="")
				{
					alert("Please Customer");
					$("#txtCustCode").focus();
					return false;
				}
				var custCode = $('#txtCustCode').val();
				funOpenDCForInvoiceHelp(custCode);
				//funHelp('deliveryChallan');
			}
		}
		
		function funOpenInvoiceHelpForBanquet(locCode,dtFullfilled,custCode) {

			var retval = window.open("frmInvoiceSale.html?strlocCode="+locCode+"&dtFullFilled="+dtFullfilled+"&strCustCode="+custCode,"",
					"dialogHeight:600px;dialogWidth:500px;dialogLeft:400px;");
				
			var timer = setInterval(function ()
			    {
				if(retval.closed)
					{
						if (retval.returnValue != null)
						{
							strVal = retval.returnValue.split("#")
							$("#txtSOCode").val(strVal[0]);
							funRemRows();
							funSetSalesOrderDtl();
							var SOCodes=strVal[0].split(",");
						}
						clearInterval(timer);
					}
			    }, 500);
			
			
		
			
		}
		
		//Open Against  From and Set  Code in combo box
		function funOpenInvoiceHelp(locCode,dtFullfilled,custCode) {

			var retval = window.open("frmInvoiceSale.html?strlocCode="+locCode+"&dtFullFilled="+dtFullfilled+"&strCustCode="+custCode,"",
					"dialogHeight:600px;dialogWidth:500px;dialogLeft:400px;");
				
			var timer = setInterval(function ()
			    {
				if(retval.closed)
					{
						if (retval.returnValue != null)
						{
							strVal = retval.returnValue.split("#")
							$("#txtSOCode").val(strVal[0]);
							funRemRows();
							funSetSalesOrderDtl();
							var SOCodes=strVal[0].split(",");
						}
						clearInterval(timer);
					}
			    }, 500);
			
			
		
			
		}
		function funRemRows() {
			var table = document.getElementById("tblProdDet");
			var rowCount = table.rows.length;

			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		
		function funSetSalesOrderTaxDtl()
		{
		    strCodes = $('#txtSOCode').val();
			strSOCodes = strCodes.split(",")
						
			var searchUrl=getContextPath()+ "/loadSOTaxDtlforInvoice.html?SOCode=" + strCodes ;
			$.ajax({
				type: "GET",
				url: searchUrl,
				dataType: "json",
				success: function(response)
				{
					$.each(response, function(cnt,item)
					{
			    		funAddTaxRow1(response[cnt][0], response[cnt][1], response[cnt][2], response[cnt][3]);
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
		
		
		
		function funSetSalesOrderDtl()
		{
		    strCodes = $('#txtSOCode').val();
			strSOCodes = strCodes.split(",")

		   	var searchUrl=getContextPath()+ "/loadAgainstSOForInvoice.html?SOCode=" + strCodes ;
			$.ajax({
				type: "GET",
				url: searchUrl,
				dataType: "json",
				async:false,
				success: function(response)
				{	
					QtyTol=0.00;				    	
					$.each(response, function(cnt,item)
					{
			    		funfillProdRow(response[cnt].strProdCode,response[cnt].strProdName,response[cnt].dblUnitPrice,response[cnt].dblAcceptQty
					   		,response[cnt].dblWeight,"",response[cnt].strCustCode,response[cnt].strSOCode,response[cnt].PrevUnitPrice
					   		,response[cnt].PrevInvCode,response[cnt].dblDiscount,response[cnt].dblConversion);
			    		 $("#txtQtyTotl").val(QtyTol);
			    			$("#cmbCurrency").val(response[cnt].strCurrency);
			    	    	$("#txtDblCurrencyConv").val(response[cnt].dblConversion);
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
		
			funSetSalesOrderTaxDtl();
		}
		
		
		
		/**
		 * Filling Grid
		 */
		 function funfillProdRow(strProdCode, strProdName, dblUnitPrice, dblAcceptQty,dblWeight, strSpCode,strCustCode,strSOCode
					,prevUnitPrice,prevInvCode,disAmt,currValue) {

					if(currValue==0){
						currValue=1;
					}
			    
					var table = document.getElementById("tblProdDet");
					var rowCount = table.rows.length;
					var row = table.insertRow(rowCount);
						
					dblUnitPrice=parseFloat(dblUnitPrice).toFixed(maxAmountDecimalPlaceLimit);
					dblWeight=parseFloat(dblWeight).toFixed(maxQuantityDecimalPlaceLimit);
					var dblTotalPrice = parseFloat(dblAcceptQty).toFixed(maxQuantityDecimalPlaceLimit) * dblUnitPrice;
					if(dblWeight>0){
						dblTotalPrice = parseFloat(dblAcceptQty).toFixed(maxQuantityDecimalPlaceLimit)* dblWeight* dblUnitPrice;
					}	
					
					dblTotalPrice=parseFloat(dblTotalPrice).toFixed(maxAmountDecimalPlaceLimit);
					var strProdType="";	
						 
					dblAcceptQty=parseFloat(dblAcceptQty).toFixed(maxQuantityDecimalPlaceLimit);
					var dblTotalWeight=dblAcceptQty*dblWeight;
					var packingNo= $("#txtPackingNo").val();
					var strSerialNo = $("#txtSerialNo").val();
					var strInvoiceable = $("#cmbInvoiceable").val();
					var strRemarks=$("#txtRemarks").val();
					var grandtotalPrice=dblTotalPrice-disAmt;
					dblUnitPrice=dblUnitPrice/currValue;
					dblTotalPrice=dblTotalPrice/currValue;
					disAmt=disAmt/currValue;
					grandtotalPrice=grandtotalPrice/currValue;
					row.insertCell(0).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" size=\"8%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
					row.insertCell(1).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"40%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
					row.insertCell(2).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\"  class=\"decimal-places inputText-Auto  txtQty\" id=\"txtQty."+(rowCount)+"\" value="+dblAcceptQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
					row.insertCell(3).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;\" size=\"3.9%\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
					row.insertCell(4).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblTotalWeight\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;\" size=\"12%\" id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
					row.insertCell(5).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box txtUnitprice\" style=\"text-align: right;\" \size=\"12%\" id=\"unitprice."+(rowCount)+"\"   value='"+dblUnitPrice+"'/>";
					row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;\" \size=\"12%\" id=\"totalPrice."+(rowCount)+"\"   value='"+dblTotalPrice+"'/>";
					row.insertCell(7).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].dblDisAmt\" readonly=\"readonly\" class=\"Box dblDisAmt\" style=\"text-align: right;\" \size=\"4.9%\" id=\"dblDisAmt."+(rowCount)+"\"   value='"+disAmt+"'/>";
					row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box grandtotalPrice\" style=\"text-align: right;\" \size=\"11%\" id=\"grandtotalPrice."+(rowCount)+"\"   value='"+grandtotalPrice+"'/>";
						    
					row.insertCell(9).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strPktNo\" type=\"text\"    class=\"Box\" \size=\"5%\" id=\"txtPktNo."+(rowCount)+"\" value="+packingNo+" >";
					row.insertCell(10).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strRemarks\" size=\"7%\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
					row.insertCell(11).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strInvoiceable\" readonly=\"readonly\" class=\"Box\"  size=\"6%\" id=\"txtInvoiceable."+(rowCount)+"\" value="+strInvoiceable+" >";
					row.insertCell(12).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSerialNo\" type=\"text\"    class=\"Box\" size=\"5%\" id=\"txtSerialNo."+(rowCount)+"\" value="+strSerialNo+" >";	    
					row.insertCell(13).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
					row.insertCell(14).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strCustCode\" type=\"text\"    class=\"Box\" size=\"7%\" id=\"txtCustCode."+(rowCount)+"\" value="+strCustCode+" >";
					row.insertCell(15).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strSOCode\" type=\"text\"    class=\"Box\" size=\"13%\" id=\"txtSOCOde."+(rowCount)+"\" value="+strSOCode+" >";
					row.insertCell(16).innerHTML= "<input readonly=\"readonly\" class=\"Box prevInvCode\" style=\"text-align: right;\" \size=\"11%\" id=\"prevInvCode."+(rowCount)+"\"   value='"+prevInvCode+"'/>";
					row.insertCell(17).innerHTML= "<input readonly=\"readonly\" class=\"Box prevUnitPrice\" style=\"text-align: right;\" \size=\"12%\" id=\"prevUnitPrice."+(rowCount)+"\"   value='"+prevUnitPrice+"'/>";
					row.insertCell(18).innerHTML= "<input name=\"listclsInvoiceModelDtl["+(rowCount)+"].strProdType\"  id=\"txtProdTpye."+(rowCount)+"\" value='"+strProdType+"' type=\"hidden\"/>";
						 	
					QtyTol+=parseFloat(dblAcceptQty);
					//$("#txtSubGroup").focus();
					funCalculateTotalAmt();
					funClearProduct();
					
					return false;
				}
		
	
		function btnUpdate_onclick()
		{
			var strProdCode=$("#hidProdCode").val();
			if(funDuplicateProductForUpdate(strProdCode))
				{
				 funUpdateProductDtl(strProdCode);
				}else
				{
					 alert("Product Not Found !");
				}
		}
		
		function funUpdateProductDtl(strProdCode)
		{
		    var table = document.getElementById("tblProdDet");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    	{
				    $('#tblProdDet tr').each(function()
				    {
					    if(strProdCode==$(this).find('input').val())// `this` is TR DOM element
	    				{
					    	var qty= $('#txtQty').val();
					    	qty=parseFloat(qty);
					    	if(qty>0)
					    		{
					    		    var txtFinalAmt=$('#txtFinalAmt').val();
					    		    txtFinalAmt = parseFloat(txtFinalAmt);
					    		    var txtSubTotlAmt=$('#txtSubTotlAmt').val();
					    		    txtSubTotlAmt = parseFloat(txtSubTotlAmt);
					    		    
					    		    var oldProdValue=$(this).closest("tr").find(".totalValueCell").val();
					    		    oldProdValue = parseFloat(oldProdValue);
					    		    txtFinalAmt = txtFinalAmt-oldProdValue;
					    		    txtSubTotlAmt = txtSubTotlAmt-oldProdValue;
					    		    
					    		    
							    	$(this).closest("tr").find(".txtQty").val(qty);  
							    	var untiprice =$(this).closest("tr").find(".txtUnitprice").val();
							    	untiprice = parseFloat(untiprice).toFixed(maxQuantityDecimalPlaceLimit);
							    	var total= qty*untiprice;
							    	$(this).closest("tr").find(".totalValueCell").val(total);
							    	
							    	 txtFinalAmt = txtFinalAmt + qty*untiprice;
							    	 txtSubTotlAmt = txtSubTotlAmt + qty*untiprice;
							    	 $('#txtFinalAmt').val(txtFinalAmt.toFixed(maxQuantityDecimalPlaceLimit));
							    	 $('#txtSubTotlAmt').val(txtSubTotlAmt.toFixed(maxQuantityDecimalPlaceLimit));
					    		}
	    				}
					});
				    
		    	}
		    return flag;
		}
		
		
	function funDuplicateProductForUpdate(strProdCode,dblWeight)
		{
		 var table = document.getElementById("tblProdDet");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    {
				    $('#tblProdDet tr').each(function()
				    {
					    if(strProdCode==$(this).find('input').val() && dblWeight==$(this).find('input')[4].value)// `this` is TR DOM element
	    				{
					    	alert("Already added Product "+ strProdCode +" of Weight "+dblWeight+"Kg" );
					    	flag=false; 
					    	
		    			
	    				}
					});
				    
		   }
		    return flag;
		}
		
	$(document).ready(function()
			{
				$(function() {
					
					$("#txtSubGroup").autocomplete({
					source: function(request, response)
					{
						var searchUrl=getContextPath()+"/AutoCompletGetSubgroupNameForInv.html";
						$.ajax({
						url: searchUrl,
						type: "POST",
						data: { term: request.term },
						dataType: "json",
						 
							success: function(data) 
							{
								sgData=data;
								response($.map(data, function(v,i)
								{
								//	$('#hidSubGroupCode').val(   );
									return {
										label: v.strSGName,
										value: v.strSGName
										
										};
										
										
								}));
								
							}
						});
					},
					minLength: 0,
				    minChars: 0,
				    max: 12,
				    autoFill: true,
				    mustMatch: true,
				    matchContains: false,
				    scrollHeight: 220,
				}).on('focus', function(event) {
				    var self = this;
					  //  var sgName= $("#txtSubGroup").val();
					    $(self).autocomplete( "search", '');
					});
					 
					 
				});
			});
		
		/* $(document).ready(function()
				{
					$(function() {
						
						
						$("#txtProdName").autocomplete({
						source: function(request, response)
						{
							var sgName= $("#txtSubGroup").val();
							var custCode=$("#txtCustCode").val();
							var searchUrl=getContextPath()+"/AutoCompletGetProdNamewithSubgroup.html";
							$.ajax({
							url: searchUrl,
							type: "POST",
							data: { term: request.term,sgName:sgName,custcode:custCode },
							dataType: "json",
							 
								success: function(data) 
								{
									prodData=data;
									response($.map(data, function(v,i)
									{
										return {
											label: v.strProdName,
											value: v.strProdName
											
											};
											
									}));
									
								}
							});
						},
						minLength: 0,
					    minChars: 0,
					    max: 12,
					    autoFill: true,
					    mustMatch: true,
					    matchContains: false,
					    scrollHeight: 220,
					}).on('focus', function(event) {
					    var self = this;
						  //  var sgName= $("#txtSubGroup").val();
						    $(self).autocomplete( "search", '');
						});
						 
						 
					});
				}); */
		
		
function funGetKeyCode(event,controller) {
		
	    var key = event.keyCode;
	    
	  /*   if(controller=='Location' && key==13 || controller=='Location' && key==9)
	    {
	    	if($("#txtLocCode").val().trim().length==0 || $("#txtLocCode").val()== 0)
	        {		
		          alert("Please Select Location");
		          $("#txtLocCode").focus();
	          return false;
	       	}else
	       		{
	    			$('#cmbSettlement').focus();
	       		}
	    } */
	    
	    if(controller=='Settlement' && key==13 || controller=='Settlement' && key==9)
	    {
	    	$('#txtSubGroup').focus();
	    }
	    
	    
	    if(controller=='SubGroup' && key==13 || controller=='SubGroup' && key==9)
	    {
	    	$.each(sgData, function(i,item)
			    	{
				var sgName = $("#txtSubGroup").val();
						if(sgName==item.strSGName)
							{
							$('#hidSubGroupCode').val(item.strSGCode);
							$('#txtProdName').focus();
							
							}
			    	});
	    	
	    }
	    
	    if(controller=='Product' && key==13 || controller=='Product' && key==9)
	    {
	    
	    	var custCode = $("#txtCustCode").val();
	    	//var prodName = $("#txtProdName").val();
	    	var strProdCode=$("#hidProdCode").val();
	    	var dblWeight=$("#txtWeight").val();
	    	if(funDuplicateProduct(strProdCode,dblWeight))
	    	{
	    		funAddProductRow();
			}
	    	//funSetProduct(prodName);
	 	    	/* $.each(prodData, function(i,item)
	 			    	{
	 				var prodName = $("#txtProdName").val();
	 						if(prodName==item.strProdName)
	 							{
	 							$('#hidProdCode').val(item.strProdCode);
	 							$('#hidUnitPrice').val(item.dblUnitPrice);
	 							$('#txtWeight').val(item.dblWeight);
	 							
	 							$('#lblUOM').text(item.strUOM);
	 							$('#txtRemarks').val(item.strRemark);
	 							$('#txtQty').focus();	
	 							$('#hidPreInvPrice').val(item.prevUnitPrice);
	 							$('#hidPrevInvCode').val(item.prevInvCode);
	 							
	 							}
	 			    	}); */
	    		}
	    
	  
	   
		    if(controller=='Qty' && key==13 || controller=='Qty' && key==9)
		    {
		    	$('#btnAdd').focus();
		    }
		    
		    if(controller=='AddBtn' && key==13)
		    {
			    	if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0)
			        {		
			          alert("Please Enter Quantity");
			          $("#txtQty").focus();
			          return false;
			       	}else{
			       		var strProdCode=$("#hidProdCode").val();
				    	var dblWeight=$("#txtWeight").val();
				    	if(funDuplicateProductForUpdate(strProdCode,dblWeight))
				    	{
				    		funAddProductRow();
						}
				    	//$("#txtSubGroup").focus();
		    }
	    }
	}
/* 
function funChangeCombo() {
	$("#txtSubGroup").focus();
	} */
	
$(document).keypress(function(e) {
	  if(e.keyCode == 120) {
		  if(funCallFormAction())
			  {
			  var isOk=confirm("Do You Want to Settle in Cash?");
				if(isOk)
				{
						$('#cmbSettlement').val();
						$('#cmbSettlement').val("S000001");
						document.forms["InvForm"].submit();
				}else
					{
					    $('#cmbSettlement').val();
						$('#cmbSettlement').val("S000002");
						document.forms["InvForm"].submit();
					}
			   }
		 
	  }
	});
	
function funGetProductStock(strProdCode)
{
	var searchUrl="";	
	var locCode=$("#txtLocCode").val();
	var dblStock="0";
	var strInvDate=$("#txtDCDate").val();
	strInvDate=strInvDate.split("-")[2]+"-"+strInvDate.split("-")[1]+"-"+strInvDate.split("-")[0];
	searchUrl=getContextPath()+"/getProductStockInUOM.html?prodCode="+strProdCode+"&locCode="+locCode+"&strTransDate="+strInvDate+"&strUOM=RecUOM";
	//alert(searchUrl);		
	$.ajax({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    async: false,
		    success: function(response)
		    {
		    	dblStock= response;
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
	return Math.round(dblStock * 100) / 100;
}
	
	
function funSetTax(code)
{
	$.ajax({
	   		type: "GET",
	        url: getContextPath()+"/loadTaxMasterData.html?taxCode="+code,
	        dataType: "json",
	        success: function(response)
	        {
	         	var currValue='<%=session.getAttribute("currValue").toString()%>';
	    		if(currValue==null)
	    		{
	    		  currValue=1;
	    		}
	        	taxOnTax='N';
	        	$("#txtTaxCode").val(code);
	        	$("#lblTaxDesc").text(response.strTaxDesc);
	        	$("#txtTaxableAmt").val($("#txtSubTotlAmt").val());
	        	$("#txtTaxableAmt").focus();
	        	taxPer=parseFloat(response.dblPercent);
	        	funCalculateTaxForSubTotal(parseFloat($("#txtTaxableAmt").val()),taxPer);
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

	function funCalculateDiscount()
	{
		
		if($("#txtDiscountPer").val() > 0)
		{
			if(	discType=="Item Wise disc")
			{
				
				alert('You have already  given ItemWise Discount ');
				$("#txtDiscountPer").val(0);
	 			return false;  
				
			}
			else
			{
				discType="";
				var subtotal=$("#txtSubTotlAmt").val();
				var discPer=$("#txtDiscountPer").val();
				var discAmount=((subtotal * discPer)/100).toFixed(maxQuantityDecimalPlaceLimit);
				$("#txtDiscount").val(discAmount);
				discType="Total Disc";
				$("#hidDiscType").val(discType);
			}	
			
		}	
		
	}
	function funCalculatePerDiscount()
	{
		
		if($("#txtDiscount").val() > 0)
		{
			if(	discType=="Item Wise disc")
			{
				alert('You have already  given ItemWise Discount ');
	 			return false;  
				
			}
			else
			{
				discType="";
				var subtotal=$("#txtSubTotlAmt").val();
				var discAmount=$("#txtDiscount").val();
				var discPer=((discAmount / subtotal)*100).toFixed(5);
				$("#txtDiscountPer").val(discPer);
				discType="Total Disc";
				$("#hidDiscType").val(discType);
				
			}
			
		}	
		
	}
	
function funChangeCombo() {
		
		// Ajax call loadSettlementMasterData  --> pass settlement code
		var code=$("#cmbSettlement").val();
		if(code!="MultiSettle")
		{
		
		 
			document.getElementsByName("tab4")[0].style.display = "none";
			var searchurl=getContextPath()+"/loadSettlementMasterData.html?code="+code;
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	if(response.strSettlementCode=='Invalid Code')
				        	{
				        		alert("Settlement type not found");
				        	}
				        	else
				        	{
					        	$("#txtSettlementType").val(response.strSettlementType);
					        	//alert($("#txtSettlementType").val());
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
		else
		{
			
			document.getElementsByName("tab4")[0].style.display = "block";
			//document.getElementsByName("tab4").style.display = "block";
			 
			$("#txtSettlementType").val("MultiSettle");
		}	
	}
	
	function funOnChangeCurrency()
	{
		
		var currencyCode=$("#cmbCurrency").val();
		   var currValue=funGetCurrencyCode(currencyCode);
			if(currValue==null)
			{
				currValue=1.0;
			}
			$("#txtDblCurrencyConv").val(currValue);
	
	}
	function funcheckTaxCalculation()
	{
		if(!($("#lblTaxTotal").text() >0))
		{
			alert("Please Do Tax Calculation");
			document.getElementsByName("tab4")[0].style.display = "none";
			document.getElementById('tab4').style.visibility='hidden';
			return false;
		}
		else
		{
			
		   $("#lblPaymentAmt").text($("#txtFinalAmt").val());
		   var amount= Math.round($("#lblPaymentAmt").text())
		   $("#lblPaymentAmt").text(amount);
		}	
	}
	
	//Caculating Total Quantity
	function funSetTotalQty()
	{
	var totalQty=0.00;		   
	$('#tblProdDet tr').each(function() {
			   
			    var qty = $(this).find('input')[2].value;
			    
			    totalQty=parseFloat(qty)+totalQty;
			   
			 });
	        totalQty=parseFloat(totalQty).toFixed(maxAmountDecimalPlaceLimit);
	        $("#txtQtyTotl").val(totalQty);
	  }
	
	//Open Against  From and Set  Code in combo box
	function funOpenDCForInvoiceHelp(custCode) {

		var retval = window.open("frmDCForInvoice.html?strCustCode="+custCode,"",
				"dialogHeight:600px;dialogWidth:500px;dialogLeft:400px;");
			
		var timer = setInterval(function ()
		    {
			if(retval.closed)
				{
					if (retval.returnValue != null)
					{
						strVal = retval.returnValue.split("#")
						$("#txtSOCode").val(strVal[0]);
						funRemRows();
						funSetSalesOrderDtl();
						var SOCodes=strVal[0].split(",");
					}
					clearInterval(timer);
				}
		    }, 500);
		
		
	
		
	}
	
</script>
</head>
<body >
	<div class="container transTable">
	<label id="formHeading"> Invoice </label>
	 <s:form name="InvForm" method="POST" action="saveInvoice.html?saddr=${urlHits}">
		<input type="hidden" value="${urlHits}" name="saddr">
		<input type="hidden" id="authorizePer" value="${authorizePer}">
		
		<%-- <s:form name="InvForm" method="POST" action="saveInvoice.html?saddr=${urlHits}" >
		   <input type="hidden" value="${urlHits}" name="saddr">
		   <input type="hidden" id="authorizePer" value="${authorizePer}"> --%>
		<br>
	      <div id="tab_container" style="margin-bottom: 15px;" >
						<ul class="tabs">
							<li class="active" data-state="tab1"
								style="width: 100px; padding-left: 25px">Invoice</li>
							<li data-state="tab2" style="width: 100px; padding-left: 25px">Address</li>
							<li data-state="tab3" style="width: 100px; padding-left: 25px">Taxes</li>
							<li data-state="tab4" name="tab4" style="width: 100px; padding-left:15px;" display: none  onclick="funcheckTaxCalculation()">Settlement</li><!-- -->
						</ul>

				<!-- <tr><th align="right" colspan="9"><a id="baseUrl" href="#">Attach Documents </a></th></tr> -->
	   
	    <div id="tab1" class="tab_content" style="margin-top:50px;">
				 <div class="row">
		
				<div class="col-md-2"><label>Invoice Code</label>
					    <s:input path="strInvCode" id="txtDCCode" ondblclick="funHelp('invoice')" cssClass="searchTextBox" />
				</div>

				<div class="col-md-2"><label>Invoice Date</label>
						<s:input path="dteInvDate" id="txtDCDate"
						required="required" readonly="true" cssClass="calenderTextBox" style="width:70%"/>
				</div>
				
				<div class="col-md-8"></div>
				
				<div class="col-md-2"><label>Against</label> 
					 <s:select id="cmbAgainst" path="strAgainst" items="${againstList}" onchange="funShowSOFieled()" style="width:auto"/>
				</div>
				
				
				<div class="col-md-2"><br><br>
			         <s:input id="txtSOCode" path="strSOCode" ondblclick="funOpenAgainst()" style="display:none" class="searchTextBox"></s:input>
			    </div>
				
				<div class="col-md-2"><br><br>
				     <input type="Button" id="btnFill" value="Fill" onclick="return btnFill_onclick()" style="display:none"
				          class="btn btn-primary center-block" />
			     </div>

				<div class="col-md-2"><label>Date</label>
						<s:input path="" id="txtAginst" cssClass="calenderTextBox" style="width:70%"/>
				</div>
                 <div class="col-md-4"></div>
                 
				<div class="col-md-2"><label>Customer Code</label>
						<s:input path="strCustCode" id="txtCustCode" ondblclick="funHelp('custMasterActive')" cssClass="searchTextBox" />
				</div>
				
				<div class="col-md-2">
				         <label id="lblCustomerName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 17%;padding:2px;"></label>
				</div>
									
				<div class="col-md-2">
				          <label id="lblBalanceAmt" style="color:blue; font:bold;background-color:#dcdada94; width: 100%; height: 50%; margin-top: 17%;padding:2px;"></label>
			    </div>
				
				<div class="col-md-2"><label>PO NO</label>
						<s:input id="txtPONo" type="text" path="strPONo" />
				</div>
                 <div class="col-md-4"></div>
                 
				<div class="col-md-2"><label>Location Code</label>
						<s:input type="text" id="txtLocCode" path="strLocCode" cssClass="searchTextBox" readonly="true" ondblclick="funHelp('locationmaster');"/>
				</div>
											  
				<div class="col-md-2"><label id="lblLocName" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 17%;padding:2px;"></label>
			     </div>

				<div class="col-md-2"><label>Vehicle No</label>
						<s:input id="txtVehNo" type="text" path="strVehNo"
							cssClass="searchTextBox" ondblclick="funHelp('VehCode');" />
				</div>
				<div class="col-md-6"></div>
								
				<div class="col-md-2"><label>Settlement</label>
						<s:select id="cmbSettlement" path="strSettlementCode" items="${settlementList}" 
							onkeypress="funGetKeyCode(event,'Settlement')" onclick="funChangeCombo()" style="width:70%;"/>
				</div>
								
				<div class="col-md-2"><label>Currency </label>
						<s:select id="cmbCurrency" items="${currencyList}" path="strCurrencyCode" onclick="funOnChangeCurrency()" style="width:70%;">
						</s:select>
				</div>
				
				<div class="col-md-2"><br>
				       <s:input  type="text" id="txtDblCurrencyConv" style="text-align:right;width:50%;" name="txtDblCurrencyConv" path="dblCurrencyConv" class="decimal-places numberField"/>
				</div>
				
				<div class="col-md-2"><label>Stock</label><br>
				           <label id="spStock" style="color:blue; font:bold;background-color: #c0c0c0c0;width: 50%;height: 25px;" class="namelabel"></label><span id="spStockUOM"></span>
				</div>
				
				<div class="col-md-2">
						 <input type="hidden" id="txtSettlementType"> 
				</div>	
				<div class="col-md-2"></div>	
					
				<div class="col-md-2"><label>Mobile No.</label>
						<s:input  type="text"  id="txtMobileNoForSettlement" name="txtMobileNoForSettlement" path="strMobileNoForSettlement" class="numeric"/>
				</div>
				
				<div class="col-md-2"><label>Warrenty Start Date</label>
						<s:input path="strWarrPeriod" id="txtWarrPeriod" cssClass="calenderTextBox" style="width:70%"/>
				</div>

				<div class="col-md-2"><label>Warranty Validity</label>
						<s:input path="strWarraValidity" id="txtWarraValidity" cssClass="calenderTextBox" style="width:70%"/>
				</div>
                 <div class="col-md-6"></div>
                 
				<div class="col-md-2"><label for="a">Sub-Group</label>
						<input id="txtSubGroup" style="width:80%;text-transform: uppercase;"  name="SubgroupName" class="searchTextBox" 
										onkeypress="funGetKeyCode(event,'SubGroup')" ondblclick="funHelp('subgroup')"/>
				</div>
					<input type="hidden" id="hidSubGroupCode"/>
				
				<div class="col-md-2"><label>Product</label>
						<input id="txtProdName" class="searchTextBox" onkeypress="funGetKeyCode(event,'Product')" ondblclick="funHelp('productProduced')" style="width:100%;"/>
						<input type="hidden" id="hidProdCode"/>	
				</div>
				 <div class="col-md-8"></div>
				 
				 <div class="col-md-2"><label>Purchase price</label>
							<input id="txtPurchasePrice" readonly="readonly" type="text" step="any" class="decimal-places numberField" />
				</div>
				
				<div class="col-md-2"><label>Sale price</label>
						   <input id="hidUnitPrice"  type="text" step="any" class="decimal-places numberField" />
				</div>
				
				<div class="col-md-2"><label>Batch No</label>
						   <s:input id="txtSerialNo" path="strSerialNo" type="text" />
				</div>
				<div class="col-md-6"></div>
								
				<div class="col-md-2"><label>Wt/Unit</label>
						 <input type="text" id="txtWeight" step="any" class="decimal-places numberField" />
				</div>
				
				<div class="col-md-2"><label>Quantity</label>
						<input id="txtQty" type="text" step="any" class="decimal-places numberField" style="width: 60%" onkeypress="funGetKeyCode(event,'AddBtn')" />	
					    <label id="lblUOM"></label>
				</div>
 								
				<div class="col-md-2"><label>Invoiceable</label>
						<s:select id="cmbInvoiceable" name="cmbInvoiceable" path="" style="width:auto">
								<option value="N">No</option>
								<option value="Y">Yes</option>
						</s:select>
					
				</div>
				<div class="col-md-2"><label>Disc Type</label>
						<s:select id="cmbDiscType" name="cmbDiscType" path="" style="width:auto">
								<option value="Per">Per</option>
								<option value="Amt">Amt</option>
						</s:select>
				 </div>
                  <div class="col-md-4"></div>
                  
				<div class="col-md-2"><label>Packing No</label>
						<input id="txtPackingNo" type="text" />
				</div>

				<div class="col-md-2"><label>Remarks</label>
						<input id="txtRemarks" type="text" />
				</div>
				
				<div class="col-md-1"><label>Discount %</label>
						 <input type="text" id="txtProdDisper" style="text-align:right;value="0" class="decimal-places-amt numberField"  />
				</div>
				
				<div class="col-md-1"><br><br>
                        <input type="button" value="Add" class="btn btn-primary center-block" 
                           class="smallButton" onclick="return btnAdd_onclick()" />
			    </div>
			
				<div class="col-md-1"><br><br>
				        <input type="button" value="Update" class="btn btn-primary center-block" 
				          class="smallButton" onclick="return btnUpdate_onclick()" />
				</div>	
			  </div>
					

			<div class="dynamicTableContainer" style="height: 300px; ">
								<table
									style="width: 150%; border: #0F0; table-layout: fixed;"
										class="transTablex col15-center">
									<tr bgcolor="#c0c0c0">
										
										<td style="width:11%;"> Code</td>
									<!--  COl1   -->
										<td style="width:28%;">Product  Name</td>
									<!--  COl2   -->
										<td style="width:6%;">Qty</td>
									<!--  COl3   -->
								        <td style="width:6%;">Wt/Unit</td> 
									<!-- COl4   -->
										<td style="width:11%;">Total Wt</td> 
									<!-- COl5   -->
 										<td style="width:11%;">Unit Price</td> 
									<!--  COl6   -->
										<td style="width:11%;">Total Amt</td>
									<!--  COl7   -->
										
									
 										<td style="width:8%;">Disc Amt</td> 
									<!--  COl8   -->
										<td style="width:10%;"> Grand Amt</td>
									<!--  COl9   -->
									  	<td style="width:9%;">Packing No</td>
									<!--  COl10   -->
										<td style="width:12%;">Remarks</td>
									<!--COl11   -->
										<td style="width:7%;">Invoice</td> 
									<!--  COl12   -->
										<td style="width:7%;">Serial No</td>
									<!-- COl13   -->
										<td style="width:5%;">Delete</td> 
									<!--  COl14   -->
                                        <td style="width:9%;">Customer Code</td> 
									<!-- COl15   -->
                                        <td style="width:9%;">SOCode</td> 
									<!-- COl16   -->
									    <td style="width:9%;">Pre Bill</td> 
									<!-- COl17   -->
									    <td style="width:9%;">Pre Price</td> 
									<!-- COl18   -->
									
									</tr>
								</table>
										<div style="background-color:  	#fafbfb;
					                                 border: 1px solid #ccc;
					                                 display: block;
					                                 height: 238px;
					                                 margin: auto;
					                                 overflow-x: hidden;
					                                 overflow-y: scroll;
					                                 width: 150%;">
									<table id="tblProdDet"
										style="width: 100%; border: #0F0; table-layout: fixed;"
										class="transTablex col15-center">
										<tbody>
										<col style="width: 10%">
										<!--  COl1   -->
										<col style="width: 28%">
										<!--  COl2   -->
										<col style="width: 6%">
										<!--  COl3   -->
										<col style="width: 6%"> 
										<!--COl4   -->
										<col style="width: 11%"> 
										<!--COl5   -->
 										<col style="width: 11%"> 
										<!-- COl6   -->
										<col style="width: 11%"> 
										<!-- COl7   -->
										<col style="width: 8%"> 
										<!-- COl8   -->
										<col style="width: 10%"> 
										<!--  COl9   -->
										<col style="width: 9%"> 
										<!--  COl10   -->
										<col style="width: 12%"> 
										<!--  COl11  -->
										<col style="width:7%">
								    	<!--COl12  -->
										<col style="width: 7%"> 
										<!--  COl13   -->
										<col style="width: 5%"> 
										<!--COl14   -->
										<col style="width: 9%">
										<!--  COl15   -->
										<col style="width: 9%">
										<!--  COl16   -->
										<col style="width: 9%">
										<!--  COl17   -->
										<col style="width: 9%">
										<!--  COl18   -->

										</tbody>

									</table>
								</div>

							</div>

             <div class="row">
					<div class="col-md-4"><label>Narration</label><br>
							<s:textarea id="txtNarration" path="strNarration" style="width: 350px;"/>
				    </div>
				    
				    <div class="col-md-2"><label>Pack No</label>
							<s:input id="txtPackNo" path="strPackNo" type="text"/>
					</div>
					<div class="col-md-6"></div>
							
					<div class="col-md-2"><label>Docket No of Courier</label>
							<s:input id="txtDktNo" path="strDktNo" type="text" readonly="true"/>
					</div>
                    
					<div class="col-md-2"><label>Material Sent Out By</label>
							<s:input id="txtMInBy" path="strMInBy" type="text" />
					</div>
					
					<div class="col-md-2"><label id="lblQtyTotl">Total Qty</label>
							<input type="text" id="txtQtyTotl" value="0.00" readonly="true" style="text-align:right;width:50%;"/>
					</div>
					
					<div class="col-md-6"></div>
											
					<div class="col-md-2"><label>Reason Code</label>
							<s:input id="txtReaCode" path="strReaCode" type="text" />
					</div>
				
				    <div class="col-md-2"><label>Time Out</label>
							<s:input id="txtTimeOut" path="strTimeInOut" type="text"/>
					</div>
					
							
					<div class="col-md-2"><label id="lblsubTotlAmt">Sub Total Amount </label>
							<s:input type="number" id="txtSubTotlAmt" path="dblSubTotalAmt" readonly="true" cssClass="decimal-places-amt numberField" />
					</div>
					
					
					<div class="col-md-6"></div>
							
					<div class="col-md-4"><label>Delivery Note</label>
							<s:textarea id="txtDeliveryNote" path="strDeliveryNote" style="width: 350px;" />
					</div>
					
					<div class="col-md-2"><label >Discount Per</label>
							<s:input type="text" id="txtDiscountPer" path="dblDiscount" value="0" cssClass="decimal-places-amt numberField" style="text-align:right;width:50%;" onblur="funCalculateDiscount();"/>
					</div>
					<div class="col-md-6"></div>
							
					<div class="col-md-2"><label>Supplier's Ref.</label>
							<s:input id="txtSupplierRef" path="strSupplierRef" type="text"/>
					</div>
					
					<div class="col-md-2"><label>Other Ref.</label>
							<s:input id="txtOtherRef" path="strOtherRef" type="text"/>
					</div>
					
					<div class="col-md-2"><label>Extra Charges</label>
							<s:input type="text" id="txtExtraCharges" path="dblExtraCharges" value="0" cssClass="decimal-places-amt numberField" style="text-align:right;width:50%;" onblur="funCalTaxTotal();"/>
					</div>
							
					<div class="col-md-2"><label>Discount Amount</label>
							<s:input type="text" id="txtDiscount" path="dblDiscountAmt" value="0" cssClass="decimal-places-amt numberField"  style="text-align:right;width:50%;" onblur="funCalculatePerDiscount();"/>
					</div>
						
					<div class="col-md-4"></div>
																	
					<div class="col-md-2"><label>Buyer's Order No.</label>
							<s:input id="txtBuyersOrderNo" path="strBuyersOrderNo" type="text"/>
					</div>		
						
					<div class="col-md-2"><label>Dated</label>
							<s:input path="dteBuyerOrderNoDated" id="txtBuyerOrderNoDated"  readonly="true" cssClass="calenderTextBox" style="width:80%"/>
					</div>
						
					<div class="col-md-2"><label>Dated</label>
							<s:input path="dteDispatchDocNoDated" id="txtDispatchDocNoDated"  readonly="true" cssClass="calenderTextBox" style="width:80%"/>
					</div>								
					
					
					<div class="col-md-2"><label id="lblFinalAmt">Final Amount</label>
							<s:input type="number" id="txtFinalAmt" path="dblTotalAmt" readonly="true" cssClass="decimal-places-amt numberField" />
					</div>	
					<div class="col-md-4"></div>
					
					<div class="col-md-2"><label>Dispatch Doc No.</label>
							<s:input id="txtDispatchDocNo" path="strDispatchDocNo" type="text" />
					</div>
															
					<div class="col-md-2"><label>Dispatch Through</label>
							<s:input id="txtDispatchThrough" path="strDispatchThrough" type="text"/>
					</div>
				
					<div class="col-md-2"><label>Destination</label>
							<s:input id="txtDestination" path="strDestination" type="text"/>
					</div>				
			  </div>
			</div>
					
		<div id="tab2" class="tab_content" style="margin-top:50px;">
			    <div class="row">
			
							<div class="col-md-12" align="left"><label>Ship To</label>
							</div>

							<div class="col-md-6"><label>Address Line 1</label>
								<s:input path="strSAdd1" id="txtSAddress1"/>
							</div>
                            <div class="col-md-6"></div>
                            
							<div class="col-md-6"><label>Address Line 2</label>
								<s:input path="strSAdd2" id="txtSAddress2"/>
							</div>
                            <div class="col-md-6"></div>
                            
							<div class="col-md-3"><label>City</label>
								<s:input path="strSCity" id="txtSCity"/>
							</div>

							<div class="col-md-3"><label>State</label>
								<s:input path="strSState" id="txtSState"/>
							</div>
                            <div class="col-md-6"></div>
                            
							<div class="col-md-3"><label>Country</label>
								<s:input path="strSCtry" id="txtSCountry"/>
							</div>

							<div class="col-md-3"><label>Pin Code</label>
								<s:input path="strSPin" id="txtSPin" class="positive-integer" />
							</div>
				</div>
		</div>
						
		<div id="tab3" class="tab_content" style="margin-top:50px;">
							<br>
							<br>
			<div class="row">
			
						<div class="col-md-12"><input type="button" id="btnGenTax" value="Calculate Tax" class="btn btn-primary center-block" class="form_button">
								<label id="tx"></label>
						</div>
								
						<div class="col-md-2"><label>Tax Code</label>
								<input type="text" id="txtTaxCode" ondblclick="funHelp('OpenTaxesForSales');" class="searchTextBox"/>
						</div>
									
						<div class="col-md-2"><label>Tax Description</label>
								<label id="lblTaxDesc" style="background-color:#dcdada94; width: 100%; height: 50%;padding:2px;"></label>
						</div>
						<div class="col-md-8"></div>
								
						<div class="col-md-2"><label>Taxable Amount</label>
								<input type="number" style="text-align: right;" step="any" id="txtTaxableAmt" />
						</div>
									
						<div class="col-md-2"><label>Tax Amount</label>
							   <input type="number" style="text-align: right;" step="any" id="txtTaxAmt" />
						</div>
															
					    <div class="col-md-2"><br>
						       <input type="button" id="btnAddTax" value="Add" class="btn btn-primary center-block" class="smallButton"/>
					    </div>
					    
					</div>
						
						<br>
							<table style="width: 70%;margin:0px;background:#c0c0c0;" class="transTablex col5-center">
								<tr>
									<td style="width:10%">Tax Code</td>
									<td style="width:10%">Description</td>
									<td style="width:10%">Taxable Amount</td>
									<td style="width:10%">Tax Amount</td>
									<td style="width:5%">Delete</td>
								</tr>							
							</table>
							<div style="background-color: #fafbfb;border: 1px solid #ccc;display: block; height: 150px;
			    				overflow-x: hidden; overflow-y: scroll;width: 70%;">
									<table id="tblTax" class="transTablex col5-center" style="width: 100%;">
									<tbody>    
											<col style="width:10%"><!--  COl1   -->
											<col style="width:10%"><!--  COl2   -->
											<col style="width:10%"><!--  COl3   -->
											<col style="width:10%"><!--  COl4   -->
											<col style="width:5%"><!--  COl5   -->									
									</tbody>							
									</table>
							</div>			
						<br>
						<div id="tblTaxTotal" class="row masterTable">
							
							<div class="col-md-2"><label>Taxable Amt Total</label>
								  <label id="lblTaxableAmt" style="background-color:#dcdada94; width: 100%;padding:8px;"></label>
						    </div>
								
							<div class="col-md-2"><label>Tax</label>
								    <label id="lblTaxTotal" style="background-color:#dcdada94; width: 100%;padding:8px;"></label>
							</div>	    
							
							<div class="col-md-2"><label>Grand Total</label>
								      <label id="lblPOGrandTotal" style="background-color:#dcdada94; width: 100%;padding:12px;"></label>
							</div>
								    
							<div class="col-md-2"><s:input type="hidden" id="txtPOTaxAmt" path="dblTaxAmt" style="background-color:#dcdada94; width: 100%;padding:12px;"/>
							</div>
							
						
						
					</div>
				</div>
			</div>
					
			<div id="tab4" class="tab_content" style="margin-top:50px;">
						
						
							<%-- <table class="transTable">
								<tr>									
									<td style="width:100px"><label>Settlement</label>
								<td><s:select id="cmbPartSettlement" path=""
											items="${settleListWithoutMultiSettle}" 
											 /></td>
								<td><label>Settlement Amount</label></td>
									<td>
										<input type="number" style="text-align: right;" step="any" id="txtSettlementAmt" class="BoxW116px"/>
									</td>
															
									<td>
										<input type="button" id="btnAddSettlement" value="Add" class="smallButton" onclick="funFillSettlementRow()"/>
									</td>
								</tr>
							</table> --%>
						
							<table style="width: 80%;margin:0px;background:#c0c0c0;" class="transTablex col5-center">
								<tr>
									<td style="width:10%">Settlement Code</td>
									<td style="width:10%">Settlement Name</td>
									<td style="width:10%">Settlement Amount</td>
							<!-- 		<td style="width:10%">Tax Amount</td> -->
									<td style="width:5%">Delete</td>
								</tr>							
							</table>
							<div style="background-color: #fafbfb;border: 1px solid #ccc;display: block; height: 250px;
			    				overflow-x: hidden; overflow-y: scroll;width: 80%;">
									<table id="tblSettlement" class="transTablex col5-center" style="width: 100%;">
									<tbody>    
											<col style="width:10%"><!--  COl1   -->
											<col style="width:10%"><!--  COl2   -->
											<col style="width:10%"><!--  COl3   -->
										<%--<col style="width:10%"><!--  COl4   --> --%>
											<col style="width:6%"><!--  COl5   -->									
									</tbody>							
									</table>
							</div>			
						<br>
						<div id="tblSettlementTotal" class=" row masterTable">
							
							<div class="col-md-2">
							     <label>Settlement Amt Total</label>
								 <label id="lblSettlementAmt" style="background-color:#dcdada94; width: 100%; height: 70%;padding:2px;"></label>
							</div>
							
							<div class="col-md-2"><label>Total Payment</label>
								   <label id="lblPaymentAmt" style="background-color:#dcdada94; width: 100%; height: 70%;padding:2px;"></label>
							</div>
						</div>
						
						
					</div>
					<p align="center">
						<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button"  onclick="return funCallFormAction('submit',this)"/>
						&nbsp;
						<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields();" />
			        </p>
				</div>
		
	<br>

		
		<br><br>
		<s:input type="hidden" id="hidProdType" path="strProdType"></s:input>
	 <s:input type="hidden" id="hidDiscType" path="strDiscType"></s:input> 
		
		<input type="hidden" id="hidPrevInvCode" ></input>	
			<input type="hidden" id="hidPreInvPrice" ></input>
		
		<br> 
		<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
				<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
			
			
			</div>
			<input type="hidden" id="hidbillRate" ></input>	
			<input type="hidden" id="hidcustDiscount" ></input>	
	<input type="hidden" id="hidCreditLimit" ></input>
<!-- 			<input type="hidden" id="hidUnitPrice" ><input> -->
<%-- 			<s:input type="hidden" id="hidSettlementCode" path="strSettlementCode"></s:input> --%>
	
	<input id="hidstrInvoiceEditableYN"  value=""  type="hidden"  ></input>
	  </s:form>
	  </div>
	
	<script type="text/javascript">
	funApplyNumberValidation();
//	funOnChange();
	</script>
	
	
	
</body>
</html>

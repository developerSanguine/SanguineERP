<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Order Return</title>
     
</head>
<style type="text/css">

.transTable td {
	border-left:none;
	padding-left:0px;
}

</style>

<script type="text/javascript">

var unitprice="";

$(document).ready(function()
{	
	$(".tab_content").hide();
	$(".tab_content:first").show();

	$("ul.tabs li").click(function() {
		$("ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".tab_content").hide();
		var activeTab = $(this).attr("data-state");
		$("#" + activeTab).fadeIn();
	});
	var code='<%=session.getAttribute("locationCode").toString()%>';
	funSetLocation(code);
	$("#txtSRDate").datepicker({ dateFormat: 'dd-mm-yy' });
	$("#txtSRDate" ).datepicker('setDate', 'today');
	$("#txtSRDate").datepicker();

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
	

//Open GRN Slip 
	var code='';
	<%
	if(null!=session.getAttribute("rptSRCode"))
	{%>
		code='<%=session.getAttribute("rptSRCode").toString()%>';
		<%session.removeAttribute("rptSRCode");%>;
		var currencyCode='<%=session.getAttribute("rptSRCurrencyCode").toString()%>';
		<%session.removeAttribute("rptSRCurrencyCode");%>;
		
		var isOk=confirm("Do You Want to Generate Slip?");
		if(isOk)
		{
			window.open(getContextPath()+"/openRptSalesReturnSlip.html?rptSRCode="+code+"&currency="+currencyCode,'_blank');
		}
	<%}%>
	
	$('a#baseUrl').click(function() 
	{
		if($("#txtSRCode").val().trim()=="")
		{
			alert("Please Select Sales Return Code");
			return false;
		}
		window.open('attachDoc.html?transName=frmSalesReturn.jsp&formName=Sales Return&code='+$('#txtSRCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
	});
});
		
function funHelp1(){
	
	var agianst = $("#cmbAgainst").val();
	if(agianst=="Delivery Challan")
		{
		funHelp('deliveryChallan');
		}
	else if(agianst=="Retail Billing")
	   {
		funHelp('invoiceRetail')
	   }
	else if(agianst=="Invoice")
	   {
		funHelp('invoiceForSR')
	   }	
	
	
}

 function funHelp(transactionName)
	{
		fieldName = transactionName;
		if(transactionName=='invoiceForSR'){
			var strCustCode=$("#txtCustCode").val();
			window.open("searchform.html?formname="+transactionName+"&custCode="+strCustCode+"&searchText=","","dialogHeight:600px;dialogWidth:600px;top=500,left=500");
		}else{
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;top=500,left=500");
		}
	}

 	function funSetData(code)
	{
		switch (fieldName)
		{
		
		 case 'locationmaster':
		    	funSetLocation(code);
		        break;
		        
		    case 'productmaster':
		    	funSetProduct(code);
		        break;
		        
		    case 'custMasterActive' :
		    	funSetCuster(code);
		    	break;
		    	
		    	
		    case 'salesReturn':
		    	funSetSalesReturnData(code);
		    	break;
		    	
		    case'invoiceForSR':
		    	$('#txtCode').val(code);
		    	break;
		    	
		    case'deliveryChallan':
		    	$('#txtCode').val(code);
		    	break;
		    
		    case'invoiceRetail':
		    	$('#txtCode').val(code);
		    	break;
		    	
		    case 'salesReturnslip':
		    	funSetSalesReturnSlipData(code);
		    	break;
		        
		}
	}
 	
 	function funSetLocation(code) {
 		var searchUrl = "";
 		searchUrl = getContextPath()
 				+ "/loadLocationMasterData.html?locCode=" + code;

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
//  					$("#txtProdCode").focus();
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
 	
 	
 	function funSetProduct(code)
	{
			var searchUrl="";
			//var supp="";
			var supp= $("#txtCustCode").val();
			searchUrl=getContextPath()+"/loadProductDataForTrans.html?prodCode="+code+"&suppCode="+supp;
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	if(response!="Invalid Product Code")
				    	{
							$("#txtProdCode").val(response[0][0]);
							$("#lblProdName").text(response[0][1]);
// 							var currValue=funGetCurrencyCode($("#cmbCurrency").val());
							var currValue=$("#txtDblConversion").val();
					   		if(currValue==null ||currValue==''||currValue==0)
					   		{
					   		  currValue=1;
					   		}
					   		$("#txtPrice").val(response[0][3]/currValue);	
							
							//$("#cmbUOM").val(response[0][2]);
							$("#txtWeight").val(response[0][7]);
						//	$("#hidProdType").val(response[0][6]);
							$("#txtQty").focus();
					     }
				    	else
				    		{
				    		  alert("Invalid Product Code");
				    		  $("#txtProdCode").val('') 
				    		  $("#txtProdCode").focus();
				    		  $("#lblProdName").text('');
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
 	
 	
 	
 	
 	
 	function funSetCuster(code)
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
						$("#txtDiscPer").val('');
	        			
	        		}else{			   
	        			$("#txtCustCode").val(response.strPCode);
						$("#lblCustomerName").text(response.strPName);
						$("#txtDiscPer").val(response.dblReturnDiscount);
						 
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
 	
 	function funShowSOFieled()
	{
		
		var agianst = $("#cmbAgainst").val();
		if(agianst=="Direct")
			{
			document.all["txtCode"].style.display = 'none';
			document.all["btnFill"].style.display = 'none';
			
			
			}else
				{
				document.all["txtCode"].style.display = 'block';
				
				document.all["btnFill"].style.display = 'block';
				}
	}
	
 	
	function btnFill_onclick()
	{
<%-- 		var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
//         var currValue=funGetCurrencyCode($("#cmbCurrency").val());
		var currValue=$("#txtDblConversion").val();
   		if(currValue==null ||currValue==''||currValue==0)
   		{
   		  currValue=1;
   		}
		var code =$('#txtCode').val();
		 var  cmbAgainst=$('#cmbAgainst').val();
		if( cmbAgainst=="Delivery Challan")
		{
			funRemoveAllRows();
		if(code.toString.lenght!=0 || code==null)
			{
		
				gurl=getContextPath()+"/loadDeliveryChallanHdData.html?dcCode="+code;
				alert(gurl);
				$.ajax({
			        type: "GET",
			        url: gurl,
			        dataType: "json",
			        success: function(response)
			        {		        	
			        		if('Invalid Code' == response.strDCCode){
			        			alert("Invalid Customer Code");
			        			$("#txtSRCode").val('');
			        			$("#txtSRCode").focus();
			        			
			        		}else{	
			        			//funRemoveAllRows();
			        		
			        			$('#txtLocCode').val(response.strLocCode);
			        			$('#lblLocName').text(response.strLocName);
								/* $("#txtSRDate").val(response.dteSRDate); */
								$("#txtCustCode").val(response.strCustCode);
								$("#lblCustomerName").text(response.strCustName);
								
			        			$.each(response.listclsDeliveryChallanModelDtl, function(i,item)
				       	       	    	 {
				       	        			
				       	       	    	    funfillProductRowDC(response.listclsDeliveryChallanModelDtl[i]);
				       	       	    	                                           
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
	  else if( cmbAgainst=="Retail Billing")
	   {
		  
		  funRemoveAllRows();
		 $("#txtInvCode").val(code);
			gurl=getContextPath()+"/loadSalesReturnRetailInvoiceHdData.html?invCode="+code;
			$.ajax({
		        type: "GET",
		        url: gurl,
		        dataType: "json",
		        success: function(response)
		        {		        	
					if('Invalid Code' == response.strInvCode)
		        	{
		        		alert("Invalid  Invoice Code");
		        		$("#txtCode").val('');
		        		$("#txtCode").focus();
		        	}else{	
		        		$('#txtLocCode').val(response.strLocCode);
		        		$('#lblLocName').text(response.strLocName);
						$("#txtCustCode").val(response.strCustCode);
						$("#lblCustomerName").text(response.strCustName);
						
						$.each(response.listSalesReturn, function(i,item)
			       	   	{
							funfillProductRowDC(response.listSalesReturn[i],currValue);
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
				
	   }if( cmbAgainst=="Purchase Return")
		{
<%-- 		   		var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
// 				var currValue=funGetCurrencyCode($("#cmbCurrency").val());
				var currValue=$("#txtDblConversion").val();
		   		if(currValue==null ||currValue==''||currValue==0)
		   		{
		   		  currValue=1;
		   		}
				var searchUrl="";
				searchUrl=getContextPath()+"/loadPurchaseReturnDtlData.html?PRCode="+code;
				$.ajax({
				        type: "GET",
				        url: searchUrl,
					    dataType: "json",
					    success: function(response)
					    {
					    	var count=0;
					    	funRemoveAllRows();
				        	$.each(response, function(i,item)
				       	    {
				        		count=i;
				        	//	funfillProductRowPurReturn(response[i].strProdCode,strProdName,dblQty,dblWeight,dblUnitPrice,strRemarks,currValue)
				        		funfillProductRowPurReturn(response[i].strProdCode,response[i].strProdName,response[i].dblQty,response[i].dblWeight,response[i].dblUnitPrice,'',currValue);
				       	    });
				        	listRow=count+1;
				        	//funGetTotal();
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
			
		}else
		{
		  	funRemoveAllRows();
<%-- 		  	var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
// 			    var currValue=funGetCurrencyCode($("#cmbCurrency").val());
				var currValue=$("#txtDblConversion").val();
		   		if(currValue==null ||currValue==''||currValue==0)
		   		{
		   		  currValue=1;
		   		}
			gurl=getContextPath()+"/loadInvoiceHdData.html?invCode="+code;
			
			$.ajax({
		        type: "GET",
		        url: gurl,
		        dataType: "json",
		        success: function(response)
		        {		        	
		       		if('Invalid Code' == response.strInvCode){
		       			alert("Invalid  Invoice Code");
		       			$("#txtCode").val('');
		       			$("#txtCode").focus();
		       			
		       		}else{	
		       			$('#txtLocCode').val(response.strLocCode);
		       			$('#lblLocName').text(response.strLocName);
						$("#txtCustCode").val(response.strCustCode);
						$("#lblCustomerName").text(response.strCustName);
						$("#txtDiscPer").val(response.dblDiscount);
						
						if(response.dblCurrencyConv!=null || response.dblCurrencyConv!=0){
							currValue=response.dblCurrencyConv;
						}
						funLoadInvoiceDtl(code,currValue);
						/*  $.each(response.listclsInvoiceModelDtl, function(i,item)
						{
							funfillProductRowInvoiceReturn(response.listclsInvoiceModelDtl[i],currValue);
       	        	 	});  */
						funRemoveAllTaxRows();
						
						$.each(response.listInvoiceTaxDtl, function(i,item)
			            {
							funAddTaxRow1(response.listInvoiceTaxDtl[i].strTaxCode,response.listInvoiceTaxDtl[i].strTaxDesc
								,response.listInvoiceTaxDtl[i].strTaxableAmt,response.listInvoiceTaxDtl[i].strTaxAmt);
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
	
	function funLoadInvoiceDtl(invCode,currValue){
		var searchUrl="";
		searchUrl=getContextPath()+"/loadInvoiceDtlForSR.html?invCode="+invCode+"&currValue="+currValue;
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    async:false,
			    success: function(response)
			    {
			    	$.each(response, function(i,item)
						{
							funfillProductRowInvoiceReturn(response[i],currValue);
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
	
	
	function btnAdd_onclick()
	{
		if($("#txtCustCode").val()=="")
		{
			alert("Please Select Customer");
			$("#txtCustCode").focus();
			return false;
		}
		
		if($("#txtProdCode").val().length<=0)
			{
				$("#txtProdCode").focus();
				alert("Please Enter Product Code Or Search");
				return false;
			}			
	    if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0)
	        {		
	          alert("Please Enter Quantity");
	          $("#txtQty").focus();
	          return false;
	       } 
	    else
	    	{
	    	 var strProdCode=$("#txtProdCode").val();
	    	 var dblWeight=$("#txtWeight").val();
	    	 if(funDuplicateProduct(strProdCode,dblWeight))
	    		 {
	    		 funAddProductRow();
	    		 }
	    	}
	}
	
	
	function funAddProductRow() 
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = $("#txtProdCode").val();
		var strProdName=$("#lblProdName").text();
		//var strProdType=$("#hidProdType").val();	
	    var dblQty = $("#txtQty").val();
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=$("#txtWeight").val();
	    var dblTotalWeight=dblQty*dblWeight;
	    
	  	//var packingNo= $("#txtPackingNo").val();
	    //var strSerialNo = $("#txtSerialNo").val();
	    //var strInvoiceable = $("#cmbInvoiceable").val();
	    var strRemarks=$("#txtRemarks").val();
	   
	    unitprice=funSeProductUnitPrice(strProdCode);
	    // unitprice = $("#txtPrice").val();
	   
	    var totalPrice=unitprice*dblQty;
	    

	    if(dblWeight>0){
	    	totalPrice=(unitprice*dblQty*dblWeight).toFixed(maxAmountDecimalPlaceLimit);
	    }
	  	// var unitprice1= totalPrice/dblQty;
	    row.insertCell(0).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" style=\"width:99%;\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" style=\"width:99%;\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" class=\"Box1 totalValueCell\"  id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    row.insertCell(7).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strRemarks\" style=\"width:99%;\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(8).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	    
	    
	    $("#txtProdCode").focus();
	    funCalculateTotalAmt();
	    funClearProduct();
	   // funGetTotal();
	    return false;
	}
	
	function funfillProductRowPurReturn(strProdCode,strProdName,dblQty,dblWeight,dblUnitPrice,strRemarks,currValue)
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	   	
	
	    dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	   
	    var dblTotalWeight=dblQty*dblWeight;
	    unitprice=(dblUnitPrice/currValue).toFixed(maxAmountDecimalPlaceLimit);
	    	    
	    unitprice=funSeProductUnitPrice(strProdCode);
	    
	    var totalPrice=(unitprice*dblQty).toFixed(maxAmountDecimalPlaceLimit);
	    if(dblWeight>0){
	    	totalPrice=(unitprice*dblQty*dblWeight).toFixed(maxAmountDecimalPlaceLimit);
	    }
	    
	 	row.insertCell(0).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" style=\"width:99%;\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" style=\"width:99%;\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" class=\"Box1 totalValueCell\"  id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    row.insertCell(7).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strRemarks\" style=\"width:99%;\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(8).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	  
	    
	 	 $("#txtProdCode").focus();
		    funClearProduct();
		    funCalculateTotalAmt();
//		    funGetTotal();
		    return false;
	}
	
	function funfillProductRowInvoiceReturn(prductDtl)
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = prductDtl.strProdCode;
		var strProdName=prductDtl.strProdName;
		//var strProdType=prductDtl.strProdType;	
	    var dblQty = prductDtl.dblQty;
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=prductDtl.dblWeight;
	    var dblTotalWeight=dblQty*dblWeight;
	   
	    unitprice=(prductDtl.dblUnitPrice).toFixed(maxAmountDecimalPlaceLimit);
	    unitprice= funSeProductUnitPrice(strProdCode);
	    
	    var strRemarks=prductDtl.strRemarks;
	    
	    var totalPrice=unitprice*dblQty;
	    var dblAssValue=prductDtl.dblAssValue;
	    if(dblAssValue>0){
	    	totalPrice=dblAssValue;	
	    }
	 	row.insertCell(0).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" style=\"width:99%;\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" style=\"width:99%;\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblPrice\" \"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" class=\"Box1 totalValueCell\"  id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    row.insertCell(7).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strRemarks\" style=\"width:99%;\"  id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(8).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	    
	 	
	 	 $("#txtProdCode").focus();
		    funClearProduct();
		    funCalculateTotalAmt();
//		    funGetTotal();
		    return false;
	}
	
	
	function funfillProductRowInvoice(prductDtl,currValue)
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = prductDtl.strProdCode;
		var strProdName=prductDtl.strProdName;
		//var strProdType=prductDtl.strProdType;	
	    var dblQty = prductDtl.dblQty;
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=prductDtl.dblWeight;
	    var dblTotalWeight=dblQty*dblWeight;
	    unitprice=(prductDtl.dblUnitPrice/currValue).toFixed(maxAmountDecimalPlaceLimit);
	    
	  
	    var strRemarks=prductDtl.strRemarks;
	    
	    unitprice=funSeProductUnitPrice(strProdCode);
	    
	    var totalPrice=unitprice*dblQty;
	    if(dblWeight>0){
	    	totalPrice=(unitprice*dblQty*dblWeight).toFixed(maxAmountDecimalPlaceLimit);
	    }
	    
	 	row.insertCell(0).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" style=\"width:99%;\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" style=\"width:99%;\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align:right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align:right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"unitprice."+(rowCount)+"\"   value='"+unitprice+"'/>";
	    row.insertCell(6).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" class=\"Box1 totalValueCell\"  id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    row.insertCell(7).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strRemarks\" style=\"width:99%;\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(8).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	    
	    
	 	 $("#txtProdCode").focus();
		    funClearProduct();
		    funCalculateTotalAmt();
//		    funGetTotal();
		    return false;
	}
	
	function funfillProductRowDC(prductDtl,currValue)
	{
		var table = document.getElementById("tblProdDet");
		
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var strProdCode = prductDtl.strProdCode;
		var strProdName=prductDtl.strProdName;
		//var strProdType=prductDtl.strProdType;	
	    var dblQty = prductDtl.dblQty;
	    parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblWeight=prductDtl.dblWeight;
	    var dblTotalWeight=dblQty*dblWeight;
	    //(prductDtl.dblPrice/currValue).toFixed(maxAmountDecimalPlaceLimit);
	    
	  
	    var strRemarks=prductDtl.strRemarks;
	    
	    unitprice= funSeProductUnitPrice(strProdCode);
	    
	    var totalPrice=(prductDtl.dblPrice/currValue).toFixed(maxAmountDecimalPlaceLimit);
	   var unitprice1 = totalPrice/dblQty;
	  //  if(dblWeight>0){
	 //  	totalPrice=(unitprice*dblQty*dblWeight).toFixed(maxAmountDecimalPlaceLimit);
	  ///  }
	 	row.insertCell(0).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode\" style=\"width:99%;\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" style=\"width:99%;\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right; width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtQty."+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\">";
	    row.insertCell(3).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;width:99%; border:1px solid #c0c0c0;\" class=\"decimal-places inputText-Auto\" id=\"txtWeight."+(rowCount)+"\" value="+dblWeight+" >";
	    row.insertCell(4).innerHTML= "<input name=\"\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" id=\"dblTotalWeight."+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblUnitPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\"  id=\"unitprice1."+(rowCount)+"\"   value='"+unitprice1+"'/>";
	    row.insertCell(6).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].dblPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:99%;\" class=\"Box1 totalValueCell\"  id=\"totalPrice."+(rowCount)+"\"   value='"+totalPrice+"'/>";
	    row.insertCell(7).innerHTML= "<input name=\"listSalesReturn["+(rowCount)+"].strRemarks\" style=\"width:99%;\" id=\"txtRemarks."+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(8).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	    
	    
	 	 $("#txtProdCode").focus();
		    funClearProduct();
		    funCalculateTotalAmt();
//		    funGetTotal();
		    return false;
	}
	
	function funDeleteRow(obj) 
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblProdDet");
	    table.deleteRow(index);
	}
	

	function funDuplicateProduct(strProdCode,dblWeight)
	{
	    var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;		   
	    var flag=true;
	    if(rowCount > 0)
       {
	    	  for(var i=0;i<rowCount;i++)
	  		{
	  	    	if(strProdCode==document.getElementById("txtProdCode."+i).value && dblWeight==parseFloat(document.getElementById("txtWeight."+i).value))
	  	        {
	  	    		alert("Already added Product "+ strProdCode +" of Weight "+dblWeight+"Kg" );
	  				flag=false;
	  	        }		
	  	    	
	  		}
    	
    	}
	    	  /* {
			    $('#tblProdDet tr').each(function()
			    {
				    if(strProdCode==$(this).find('input').val())// `this` is TR DOM element
    				{
				    	alert("Already added "+ strProdCode);
	    				flag=false;
    				}
				});
			    
			    
	    	}  */
	    return flag;
	}
	function funSeProductUnitPrice(code)
	{
		var unitprice=0;
		var searchUrl="";
		var custCode = $("#txtCustCode").val();
		var locCode = $("#txtLocCode").val();
		  
	//	searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
		searchUrl=getContextPath()+"/loadProductDataForInvoice.html?prodCode="+code+"&suppCode="+custCode+"&locCode="+locCode;
		$.ajax
		({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    async:false,
		    success: function(response)
		    {
<%-- 		    var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
// 				var currValue=funGetCurrencyCode($("#cmbCurrency").val());
				var currValue=$("#txtDblConversion").val();
		   		if(currValue==null ||currValue==''||currValue==0)
		   		{
		   		  currValue=1;
		   		}
		   		//unitprice=$("#txtPrice").val(response[0][3]/currValue);	
				
		    	//unitprice=parseFloat((response[0][3])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit);
		   		unitprice=parseFloat((response[0][3])/parseFloat(currValue)).toFixed(maxQuantityDecimalPlaceLimit);
		    	
		    	
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
		unitprice=$("#txtPrice").val();
		return unitprice;
	}
	
	/**
	 * Calculate Total Amount
	 */
	 function funCalculateTotalAmt()
		{
			var totalAmt=0;
			var table = document.getElementById("tblProdDet");
			var rowCount = table.rows.length;
			for(var i=0;i<rowCount;i++)
			{
				totalAmt=parseFloat(document.getElementById("totalPrice."+i).value)+parseFloat(totalAmt);
				totalAmt=(totalAmt).toFixed(maxQuantityDecimalPlaceLimit);
			}
			
			
			var disper=$("#txtDiscPer").val();
			var disAmt=(totalAmt*disper)/100;
			$("#txtSubTotlAmt").val(parseFloat(totalAmt));
			$("#txtDiscAmt").val(disAmt);
			var finalAmt=totalAmt-disAmt;
			$("#txtFinalAmt").val(finalAmt);
		}

	
	function funClearProduct()
	{
		$("#txtProdCode").val("");
		//$("#strUOM").val("");
		$("#lblProdName").text("");
		$("#txtQty").val("");
		//$("#txtPrice").val("");
		
		$("#txtRemarks").val("");
		$("#txtWeight").val("");
	//	$("#txtDiscount").val(0);
	}
	
	function funUpdatePrice(object)
	{
		var index=object.parentNode.parentNode.rowIndex;
		var Qty=document.getElementById("txtQty."+index).value;
		if(Qty<=0)
			{
			 alert("please check quantity ");
			 document.getElementById("txtQty."+index).value=1;
			 document.getElementById("txtQty."+index).focus();
			}else
			{
					var price=document.getElementById("unitprice."+index).value;
					//	var discount=document.getElementById("txtDiscount."+index).value;
					var ItemPrice;
					ItemPrice=(parseFloat(Qty)*parseFloat(price));
					
					document.getElementById("totalPrice."+index).value=parseFloat(ItemPrice);
					funCalculateTotalAmt();
				
			}
		
	}
	
	
	
	function funSetSalesReturnData(code)
	{
<%-- 		var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
		gurl=getContextPath()+"/loadSalesHdData.html?srCode="+code;
	
		$.ajax({
	        type: "GET",
	        url: gurl,
	        dataType: "json",
	        success: function(response)
	        {		        	
	        		if(null == response.strSRCode){
	        			alert("Invalid  Invoice Code");
	        			$("#txtSRCode").val('');
	        			$("#txtSRCode").focus();
	        			funRemoveAllRows();
	        			
	        		}else{	
<%-- 	        			var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
	        			var currValue=response.dblConversion;
	        			
	        			funRemoveAllRows();
	        			$('#txtSRCode').val(code);
	        			
	        			$('#cmbAgainst').val(response.strAgainst);
	        			
	        			if(response.strAgainst=="Direct")
	        			{
	        				document.all["txtCode"].style.display = 'none';
	        				document.all["btnFill"].style.display = 'none';
	        			
	        			}else
	        				{
	        				
	        				document.all["txtCode"].style.display = 'block';
	        				$('#txtCode').val(response.strDCCode);
		        			document.all["btnFill"].style.display = 'block';
	        				
	        				}
	        			
	        			$('#txtLocCode').val(response.strLocCode);
	        			$('#lblLocName').text(response.strLocName);
	        			
	        			$("#txtSOCode").val(response.strSOCode);
						

						$("#txtCustCode").val(response.strCustCode);
						$("#lblCustomerName").text(response.strCustName);
						
					
						$("#txtFinalAmt").val(response.dblTotalAmt/currValue);
						
						$("#txtDiscPer").val(response.dblDiscPer);
						
						$("#txtDiscAmt").val(response.dblDiscAmt/currValue);
						$("#cmbCurrency").val(response.strCurrency);
						$("#txtDblConversion").val(response.dblConversion);
						$.each(response.listSalesReturn, function(i,item)
		       	       	    	 {
							funfillProductRowDC(response.listSalesReturn[i],currValue);
		       	       	    	                                           
		       	       	    	 });
						funRemoveAllTaxRows();
					//	alert(response.listSalesRetrunTaxModel);
						$.each(response.listSalesRetrunTaxModel, function(k,item)
			            {
							funAddTaxRow1(item.strTaxCode,item.strTaxDesc
								,item.strTaxableAmt/currValue,item.strTaxAmt/currValue);
			            });
			//			funSetInvoiceTaxDtl(response.listInvTaxDtl,currValue);
											
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
	
	
	
	
	/**
	 * Set Invoice tax Data
	 */
	function funSetInvoiceTaxDtl(respInvTaxDtl,currValue)
	{
		funRemoveAllTaxRows();
		$.each(respInvTaxDtl, function(i,item)
        {
			
			funAddTaxRow1(respInvTaxDtl[i].strTaxCode,respInvTaxDtl[i].strTaxDesc
				,respInvTaxDtl[i].strTaxableAmt/currValue,respInvTaxDtl[i].strTaxAmt/currValue);
        });
	}
	
	/**
	 * Filling Tax in Grid
	 */
	function funAddTaxRow1(taxCode,taxDesc,taxableAmt,taxAmt) 
	{	
	    var table = document.getElementById("tblTax");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input class=\"Box\" style=\"width:99%;\" name=\"listSalesRetrunTaxModel["+(rowCount)+"].strTaxCode\" id=\"txtTaxCode."+(rowCount)+"\" value='"+taxCode+"' >";
	    row.insertCell(1).innerHTML= "<input class=\"Box\" style=\"width:99%;\" name=\"listSalesRetrunTaxModel["+(rowCount)+"].strTaxDesc\" id=\"txtTaxDesc."+(rowCount)+"\" value='"+taxDesc+"'>";		    	    
	    row.insertCell(2).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:99%;border:1px solid #c0c0c0;\"  name=\"listSalesRetrunTaxModel["+(rowCount)+"].strTaxableAmt\" id=\"txtTaxableAmt."+(rowCount)+"\" value="+taxableAmt+">";
	    row.insertCell(3).innerHTML= "<input type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:99%;border:1px solid #c0c0c0;\"  name=\"listSalesRetrunTaxModel["+(rowCount)+"].strTaxAmt\" id=\"txtTaxAmt."+(rowCount)+"\" value="+taxAmt+">";		    
	    row.insertCell(4).innerHTML= '<input type="button" style=\"width:99%;\" class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteTaxRow(this)" >';
	    
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
		for(var i=0;i<rowCount;i++)
		{
			totalTaxableAmt=parseFloat(document.getElementById("txtTaxableAmt."+i).value)+totalTaxableAmt;
			totalTaxAmt=parseFloat(document.getElementById("txtTaxAmt."+i).value)+totalTaxAmt;
		}
		
		
		
		totalTaxableAmt=totalTaxableAmt.toFixed(2);
		
		
		
		totalTaxAmt=totalTaxAmt.toFixed(2);
		var grandTotal=parseFloat(totalTaxableAmt)+parseFloat(totalTaxAmt);
		grandTotal=grandTotal.toFixed(2);
		$("#lblTaxableAmt").text(totalTaxableAmt);
		$("#lblTaxTotal").text(totalTaxAmt);			
		$("#lblPOGrandTotal").text(grandTotal);
		$("#txtPOTaxAmt").val(totalTaxAmt);
		
		
		var subTotal=parseFloat($("#txtSubTotlAmt").val());
		var totSubTotal = parseFloat(subTotal) + parseFloat(totalTaxAmt);
		var disper=$("#txtDiscPer").val();
		var disAmt=(parseFloat(totSubTotal)*parseFloat(disper))/100;
		//var extCharge = $('#txtExtraCharges').val();
		//var finalAmt=totSubTotal-parseFloat(disAmt);
		var finalAmt=totSubTotal-parseFloat(disAmt);
		$("#txtFinalAmt").val(finalAmt);
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
	
	function funRemoveAllTaxRows() 
    {
		 var table = document.getElementById("tblTax");
		 var rowCount = table.rows.length;			   
		//alert("rowCount\t"+rowCount);
		for(var i=rowCount-1;i>=0;i--)
		{
			table.deleteRow(i);						
		} 
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
	
	
	$(function()
	{
		$('#txtSRCode').blur(function() {
			var code = $('#txtSRCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetSalesReturnData(code);
			}
		});
		
		$('#txtLocCode').blur(function() {
			var code = $('#txtLocCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetLocation(code);
			}
		});
		
		$('#txtProdCode').blur(function() {
			var code = $('#txtProdCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetProduct(code);
			}
		});
		
		$('#txtCustCode').blur(function() {
			var code = $('#txtCustCode').val();
			if(code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetCuster(code);
			}
		});
		
		
	//Generate tax
		$("#btnGenTax").click(function()
		{
			if($("#txtCustCode").val().trim()=='')
			{
				alert('Please Select Customer!!!');
				return false;
			}
			funCalculateIndicatorTax();
		});
	});
	
	//calculating tax based on Tax Indicator 
	function funCalculateIndicatorTax()
	{
		var prodCodeForTax="";
<%-- 		var currValue='<%=session.getAttribute("currValue").toString()%>'; --%>
// 		var currValue=funGetCurrencyCode($("#cmbCurrency").val());
// 		if(currValue==null)
// 		{
// 		  currValue=1;
// 		}
		var currValue=$("#txtDblConversion").val();
   		if(currValue==null ||currValue==''||currValue==0)
   		{
   		  currValue=1;
   		}
		funRemoveAllTaxRows();
		var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;
	    //for(var cnt=0;cnt<rowCount;cnt++)
	   // {
	    $('#tblProdDet tr').each(function()
		{	
	    	var id=$(this).find('input');
	    	var cnt= id[0].id.split('.')[1]
	    	var prodCode=document.getElementById("txtProdCode."+cnt).value;
	    	var custCode=$("#txtCustCode").val();
	    	var discamt=$("#txtDiscAmt").val();
	    	var discPer=0;
	    	
	    	var taxableAmount=parseFloat(document.getElementById("totalPrice."+cnt).value);
	    	var discAmt=(taxableAmount*discPer)/100;
 	    	taxableAmount=taxableAmount-discAmt;
	    	
	    	var qty=parseFloat(document.getElementById("txtQty."+cnt).value);		    	
	    	var unitPrice=parseFloat(document.getElementById("unitprice."+cnt).value)/currValue-discamt/currValue;
	    	var discAmt1=0.00;
	    	
	    	var dblWeight=parseFloat(document.getElementById("txtWeight."+cnt).value);
	    	
	    	prodCodeForTax=prodCodeForTax+"!"+prodCode+","+unitPrice+","+custCode+","+qty+","+discAmt1+","+dblWeight;
	    	//alert(prodCodeForTax);
		});
	    prodCodeForTax=prodCodeForTax.substring(1,prodCodeForTax.length).trim();
	    var dteSR =$("#txtSRDate").val();
	    var CIFAmt=0;
	    var settlement=$("#cmbSettlement").val();
	    
	    $.ajax({
			type: "GET",
		    url: getContextPath()+"/getTaxDtlForProduct.html?prodCode="+prodCodeForTax+"&taxType=Sales&transDate="+dteSR+"&CIFAmt="+CIFAmt+"&strSettlement="+settlement,
		    dataType: "json",
		    success: function(response)
		    {
		    	$.each(response, function(i,item)
			    {
		    		var spItem=item.split('#');
		       		if(spItem[1]=='null')
		       		{}
		       		else
			    	{
		       			var taxableAmt=parseFloat(spItem[0]);
			       		var taxCode=spItem[1];
			        	var taxDesc=spItem[2];
			        	var taxPer1=parseFloat(spItem[4]);
			        	var taxAmt=parseFloat(spItem[5]);
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
	 * Calcutating discount
	 */
	function funCalDiscountAmt()
	{  
		var dicPer=0;
		if($("#txtDiscPer").val()!="")
		{
			dicPer=$("#txtDiscPer").val();
		}
		var subtotal=$("#txtSubTotlAmt").val();
		var discountAmt=parseFloat(dicPer)*(parseFloat(subtotal)/100);
		$("#txtDiscAmt").val(parseFloat(discountAmt).toFixed(maxAmountDecimalPlaceLimit));
		
		var finalAmt=subtotal-discountAmt;
		$("#txtFinalAmt").val(finalAmt);
		//funCalculateTotal();
	}
	
	function funResetFields() 
	{
		$("#txtSRCode").val("");
		$("#txtCustCode").val("");
		$("#lblCustomerName").text("");
		$("#txtLocCode").val("");						
		$("#lblLocName").text("");
		$('#tblProdDet tbody').empty();
		$('#tblTax tbody').empty();
		$('#tblTaxTotal tbody').empty();
		$("#txtSubTotlAmt").val("0.0");
		$("#txtDiscPer").val("0.0");
		$("#txtDiscAmt").val("0.0");
		$("#txtFinalAmt").val("0.0");
		$("#txtPrice").val("");
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
<body onload="funOnLoad();">
	<div class="container transTable">
	  <label id="formHeading">Sales Return</label>
	    <s:form name="SalesREturnForm" method="POST" action="saveSalesReturnData.html?saddr=${urlHits}">
		  <input type="hidden" value="${urlHits}" name="saddr">
		<br>
	
	  <div id="tab_container">
				<div>
						<ul class="tabs">
							<li class="active" data-state="tab1"
								style="width: 100px; padding-left: -25px">Sales Return</li>
							
							<li data-state="tab2" style="width: 50px; padding-left: 6px">Taxes</li>
						</ul>
                 </div>
		  <div id="tab1" class="tab_content" style="margin-top:50px;height: 640px;"> 
							
		                        <!-- <tr>
									<th align="right" colspan="9"><a id="baseUrl" href="#">
											Attach Documents </a></th>
								</tr> -->
             <div class="row">
	                <div class="col-md-2"><label>SR Code</label>
						<s:input path="strSRCode" id="txtSRCode" ondblclick="funHelp('salesReturn')" cssClass="searchTextBox" />
 					</div> 
 					
 					<div class="col-md-2"><label id="lblLocName1" style="background-color:#dcdada94; width: 100%; height: 55%; margin-top: 17%;padding-top: 2px"></label></div>
					
					<div class="col-md-2"><label>SR Date</label>
						<s:input path="dteSRDate" id="txtSRDate" required="required" cssClass="calenderTextBox" style="width: 70%"/>
					</div> 
					
					<div class="col-md-6"></div>
								
					<div class="col-md-2"><label>Customer Code</label>
						<s:input path="strCustCode" id="txtCustCode" ondblclick="funHelp('custMasterActive')" cssClass="searchTextBox" />
					</div>
					
					<div class="col-md-2"><br><label id="lblCustomerName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 45%; margin-top: 8%;padding-top: 2px"></label>
					</div>
								
					<div class="col-md-2"><label>Location Code</label>
						<s:input type="text" id="txtLocCode" path="strLocCode" cssClass="searchTextBox" ondblclick="funHelp('locationmaster');" />
					</div> 
					
					<div class="col-md-2"><br><label id="lblLocName" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 6%;padding-top: 2px"></label>
					</div>
					<div class="col-md-4"></div>
									
					<div class="col-md-2"><label>Against</label>
						<s:select id="cmbAgainst" path="strAgainst" items="${againstList}" onchange="funShowSOFieled()" style="width:auto;"/> 
					</div>
					
					<div class="col-md-2">
					   <s:input id="txtCode" path="strDCCode" style="display:none;height:40%; margin-top:26px;" ondblclick="funHelp1('')" class="searchTextBox"></s:input>		 
					</div>
					
					<div class="col-md-2"><br><br>
				        <input type="Button" id="btnFill" value="Fill" onclick="return btnFill_onclick()" style="display:none" class="btn btn-primary center-block" class="smallButton" />
					</div> 
					
					
					<div class="col-md-2"><label>Currency</label>
							<s:select id="cmbCurrency" path="strCurrency" items="${currencyList}"  onchange="funOnChangeCurrency()" style="width:60%;"></s:select>
					</div>
					
					<div class="col-md-2"><br><s:input id="txtDblConversion" value ="1" path="dblConversion" type="text" class="decimal-places numberField" style="width:60px;margin-top: 6%;"></s:input>
					</div>	
					
					<div class="col-md-2"></div>
								
					<div class="col-md-2">
						<label>Settlement</label>
						<s:select id="cmbSettlement" path="strSettlementCode" items="${settlementList}" style="width: auto;"/>
					</div>
								
					<div class="col-md-2"><label>Product</label>
						<input id="txtProdCode" ondblclick="funHelp('productmaster')" class="searchTextBox" />
	                </div>
	                
	                <div class="col-md-2"><label id="lblProdName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 17%; padding-top: 2px"></label></div>

					<div class="col-md-2"><label>Wt/Unit</label>
							<input type="text" id="txtWeight" class="decimal-places numberField" />
					</div>
					
					<div class="col-md-2"><label>Quantity</label>
							<input id="txtQty" type="text" class="decimal-places numberField" style="width: 60%" />
					</div>
					<div class="col-md-2"></div>
					
					<div class="col-md-2"><label>Unit Price</label>
							<input id="txtPrice" type="text" class="decimal-places numberField" style="width: 60%" />
					</div>	
					
					<div class="col-md-2"><label>Remarks</label>
							<input id="txtRemarks" type="text"/>
					</div>
					
					<div class="col-md-2"><br>
					    <input type="button" value="Add" class="btn btn-primary center-block" class="smallButton" onclick="return btnAdd_onclick()"/>
					</div>
			
				<div class="col-md-12 dynamicTableContainer" style="height:300px; width:100%; padding:0px;">
					<table style="height: 20px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
							<tr bgcolor="#c0c0c0">
										<td width="4%">Product Code</td>
										<%--  COl1 --%>
										<td width="9%">Product Name</td>
										<%--  COl2 --%>
										<td width="3%">Qty</td>
										<%--  COl3 --%>
										<td width="2%">Wt/Unit</td>
										<%--  COl4 --%>
										<td width="3%">Total Wt</td>
										<%-- 	 COl5 --%>
										<td width="3%">Unit Price</td>
										<%-- 	 COl6 --%>
										<td width="4%">Total Amt</td>
									   	<%-- 	 COl7  --%>
											<td width="5%">Remarks</td>
										<%-- 	 COl8  --%>
										 	<td width="3.5%">Delete</td>
										<%-- 	 COl9  --%>
								</tr>
							</table>
				<div style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
					<table id="tblProdDet" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"	class="transTablex col15-center">
							<tbody>
										<col style="width: 4%">
										<%-- COl1  --%> 
										<col style="width: 10%">
										<%-- COl2  --%> 
										<col style="width: 3%">
										<%-- COl3  --%>
										<col style="width: 3%">
										<%-- COl4  --%>
										<col style="width: 3%">
										<%-- COl5  --%>
								
										<col style="width: 3%">
										<%-- COl6  --%>
										<col style="width: 5%">
										<%-- COl7 --%>
										<col style="width: 5%">
										 <%--COl8 --%>
										<col style="width: 3%">
										<%-- COl9  --%>
									

										</tbody>

									</table>
								</div>

					</div>
						
					<div class="col-md-2"><label id="lblsubTotlAmt">SubTotal Amount</label>
							<s:input type="text" id="txtSubTotlAmt" path="" readonly="true" cssClass="decimal-places-amt numberField" style="text-align:right;width: 70%;"/>
					</div>
								
					<div class="col-md-2"><label>Discount %</label>
							<s:input type="text" id="txtDiscPer" path="dblDiscPer" cssClass="decimal-places-amt numberField" onblur="funCalDiscountAmt()" style="text-align:right;width: 70%;"/> 
					</div>
									
					<div class="col-md-2"><label>Discount Amount</label>
						   <s:input type="text" id="txtDiscAmt" path="dblDiscAmt" cssClass="decimal-places-amt numberField" onblur="funCalDiscountAmt()" style="text-align:right;width: 70%;"/>
					</div>
									
					<div class="col-md-2"><label id="lblFinalAmt">Final Amount</label>
						<s:input type="text" id="txtFinalAmt" path="dblTotalAmt" readonly="true" cssClass="decimal-places-amt numberField" style="text-align:right;width: 70%;"/>
				    </div>
			</div>
		</div>
			
		<div id="tab2" class="tab_content" style="margin-top:30px;height: 475px;">
							<br>
							<br>
		   <div class="row">
				
				<div class="col-md-2">
				      <input type="button" id="btnGenTax" value="Calculate Tax" class="btn btn-primary center-block" class="form_button">
					   <label id="tx"></label>
				</div>
				<div class="col-md-10"></div>		
				
				<div class="col-md-2"><label>Tax Code</label>
					<input type="text" id="txtTaxCode" ondblclick="funHelp('nonindicatortax');" class="searchTextBox"/>
				</div>
									
				<div class="col-md-2"><label>Tax Description</label>
					<label id="lblTaxDesc" style="background-color:#dcdada94; width: 100%; height: 50%;"></label>
				</div>
				<div class="col-md-8"></div>
				
				<div class="col-md-2"><label>Taxable Amount</label>
					<input type="number" style="text-align: right;" step="any" id="txtTaxableAmt"/>
				</div>
									
				<div class="col-md-2"><label>Tax Amount</label>
					<input type="number" style="text-align: right;" step="any" id="txtTaxAmt"/>
				</div>
															
				<div class="col-md-2"><br>
				      <input type="button" id="btnAddTax" value="Add" class="btn btn-primary center-block" class="smallButton"/>
				</div>
			</div>
						
			<br>
			<table style="width: 60%; margin:0px; background:#c0c0c0;" class="transTablex col5-center">
					<tr>
						<td style="width:10%">Tax Code</td>
						<td style="width:10%">Description</td>
						<td style="width:10%">Taxable Amount</td>
						<td style="width:10%">Tax Amount</td>
						<td style="width:5%">Delete</td>
					</tr>							
					</table>
						<div style="background-color: #fafbfb;border: 1px solid #ccc;display: block; height: 150px;
 			    				overflow-x: hidden; overflow-y: scroll;width: 60%;"> 
									<table id="tblTax" class="transTablex col5-center" style="width: 100%;">
									<tbody>    
											<col style="width:10%"><!--  COl1   -->
											<col style="width:10%"><!--  COl2   -->
											<col style="width:10%"><!--  COl3   -->
											<col style="width:10%"><!--  COl4   -->
											<col style="width:4%"><!--  COl5   -->									
									</tbody>							
									</table>
							</div>			
						<br>
				<div id="tblTaxTotal" class="row masterTable">
						<div class="col-md-2"><label>Taxable Amt Total</label>
								<label id="lblTaxableAmt" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 11%;"></label>
						</div>
								
						<div class="col-md-2"><label>Tax</label>
								<label id="lblTaxTotal" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 11%;"></label>
								<s:input type="hidden" id="txtPOTaxAmt" path="dblTaxAmt"/>
						</div>
							
						<div class="col-md-2"><label>Grand Total</label>
								<label id="lblPOGrandTotal" style="background-color:#dcdada94; width: 100%; height: 50%; margin-top: 11%;"></label>
						</div>
				</div>
              </div>
		</div>
	    <br>
        <br>
		<div align="center">
			<input type="submit" value="Submit" onclick="return funCallFormAction('submit',this)" class="btn btn-primary center-block" class="form_button" /> 
			&nbsp; 
			<input type="button" id="reset" name="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</div>
		<br><br>
<%-- 		<s:input type="hidden" id="hidProdType" path="strProdType"></s:input> --%>
	
	
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
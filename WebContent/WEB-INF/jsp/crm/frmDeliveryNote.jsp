<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=8">
<title></title>

<style type="text/css">
.transTable td {
 padding-left: 0px;
 border-left:none;
}

</style>

<script type="text/javascript">
	var fieldName,transactionName;
	var explistRow,listRow=0;
	$(document).ready(function(){

		$(document).ajaxStart(function() {
			$("#wait").css("display", "block");
		});
		
		$(document).ajaxComplete(function() {
			$("#wait").css("display", "none");
		});
		
		$( "#txtDNDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
		$( "#txtDNDate" ).datepicker('setDate','today');
		
		$( "#txtExpDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
		$( "#txtExpDate" ).datepicker('setDate','today');
		
		//Start Expected Details Div Displaying Functionality
			$("#txtExpDet").change(function(){
				var expDtl1 = $("#txtExpDet").val();
				
				if(expDtl1 == "Yes"){
					$("#divExpDtl").css({"display":"block"});
				}else if(expDtl1 == "No"){
					$("#divExpDtl").css({"display":"none"});
				}
			});
			
			var expDtl = $("#txtExpDet").val();
			
			if(expDtl == "Yes"){
				$("#divExpDtl").css({"display":"block"});
			}else if(expDtl == "No"){
				$("#divExpDtl").css({"display":"none"});
			}
		//End Expected Details Div Displaying Functionality
		
			$("#txtFrom").change(function(){
				funClearFromData();
			});
		
		//On Form Submit
		
		$("form").submit(function() {

			if ($("#txtSCCode").val() == '') {
				alert("Please Enter Sub Contractor Or Search");
				return false;
			}
			
			if ($("#txtLocCode").val() == '') {
				alert("Please Select Location Or Search");
				return false;
			}
			
			var table = document.getElementById("tblProdDet");
			var rowCount = table.rows.length;
			if (rowCount <= 0) {
				alert("Please Add Product in Grid");
				return false;
			}

		});
			
		
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
		}}%>
		
		$('#txtDNCode').blur(function() {
			var code = $('#txtDNCode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetDNData(code);
			}
		});
		
		$('#txtJACode').blur(function() {
			var code = $('#txtJACode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetJACode(code);
			}
		});
		
		$('#txtSCCode').blur(function() {
			var code = $('#txtSCCode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetSubContractorData(code);
			}
		});
		
		$('#txtProdCode').blur(function() {
			var code = $('#txtProdCode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetProductData(code);
			}
		});
		
		$('#txtProcessCode').blur(function() {
			var code = $('#txtProcessCode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetProcessCode(code);
			}
		});
		
		$('#txtLocCode').blur(function() {
			var code = $('#txtLocCode').val();
			if (code.trim().length > 0 && code != "?" && code != "/") {
				funSetLocationData(code);
			}
		});
		
		
		
		
	});

	function funSetData(code){

		switch(fieldName){

			case 'DNCode' : 
				funSetDNData(code);
				break;
				
			case 'TypeCode' : 
				funSetTypeCode(code);
				break;
				
			case 'JACode' : 
				funSetJACode(code);
				break;
				
			case 'RawProduct' : 
				funSetProductData(code);
		        break;
		        
			case 'processcode' : 
				funSetProcessCode(code);
		        break;
				
			case 'subContractor' : 
				funSetSubContractorData(code);
				break;
				
			case 'locationmaster' : 
				funSetLocationData(code);
				break;
				
			case 'suppcode' : 
				funSeSupplierData(code);
				break;
				
			case 'expProductmaster' : 
				funSetExpProductData(code);
		        break;
		}
	}


	function funSetDNData(code){
		
		funClearFromData();
		funClearSCData();
		funClearExpDetailRow();
		funClearProductRows();
		funClearDeliveryNoteHd();
		
		$("#txtProdCode").focus();
		searchUrl = getContextPath() + "/loadDNData.html?DNCode=" +code;
		$.ajax({
			type : "GET",
			url : searchUrl,
			dataType : "json",
			success : function(response) {
				if (response.strDNCode == 'Invalid Code') {
						alert("Invalid Delivary Note Code");
						$("#txtDNCode").val("");
						$("#txtDNCode").focus();
					} else {
						$("#txtDNCode").val(response.strDNCode);
						$("#txtDNDate").val(response.dteDNDate);
						$("#txtDNType").val(response.strDNType);
						$("#txtJACode").val(response.strJACode);
						
						/* $("#txtSCCode").val(response.strSCCode);
						$("#txtSCName").text(response.strSCName); */
						$("#txtSCAdd1").val(response.strSCAdd1);
						$("#txtSCAdd2").val(response.strSCAdd2);
						$("#txtSCCity").val(response.strSCCity);
						$("#txtSCState").val(response.strSCState);
						$("#txtSCCountry").val(response.strSCCountry);
						$("#txtSCPin").val(response.strSCPin);
						
						$("#txtFrom").val(response.strFrom);
						$("#txtLocCode").val(response.strLocCode);
						$("#txtLocName").text(response.strLocName);
						$("#txtFAdd1").val(response.strFAdd1);
						$("#txtFAdd2").val(response.strFAdd2);
						$("#txtFCity").val(response.strFCity);
						$("#txtFState").val(response.strFState);
						$("#txtFCountry").val(response.strFCountry);
						$("#txtFPin").val(response.strFPin);
						$("#cmbTransport").val(response.strTransportType);
						
				$.each(response.listDNDtl, function(i,item){
						var objDltModel = response.listDNDtl[i];
							
						var dblQty= objDltModel.dblQty;
						var dblWeight= objDltModel.dblWeight
						var dblPrice=objDltModel.dblRate
						
						if(!(isNumber(dblQty))){
							dblQty=0;
						}	
						
					    if(!(isNumber(dblWeight))){	
					    	dblWeight=0;
				      	 }
					    
					    if(!(isNumber(dblPrice))){	
					    	dblPrice=0;
				      	 }
					    
						var dblTotalWeight=dblQty*dblWeight;
					    var dblTotalPrice=(dblQty*dblPrice);	
					    
						funAddProductRow(objDltModel.strProdCode,objDltModel.strProdName,objDltModel.strProdUOM,
									objDltModel.strProcessCode,objDltModel.strProcessName,
									dblQty,dblWeight,dblTotalWeight,dblPrice,dblTotalPrice,
									objDltModel.strRemarks);

 	       	    	 });
						
						$("#txtExpDate").val(response.dteExpDate);
						$("#txtVehNo").val(response.strVehNo);
						$("#txtNarration").val(response.strNarration);
						$("#txtMInBy").val(response.strMInBy);
						$("#txtTimeInOut").val(response.strTimeInOut);
						$("#txtExpDet").val(response.strExpDet);
						
						if(response.strExpDet== "Yes"){
							funFetchJADtls();
						}
					  	funCalculateTotalAmt();
					  	funApplyNumberValidation();
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
	
	function isNumber(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
	function funSetLocationData(code){

		funClearFromData();
		$("#txtVehNo").focus();
		searchUrl = getContextPath() + "/loadLocationMasterData.html?locCode=" + code;
		$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				success : function(response) {
					if (response.strLocCode == 'Invalid Code') {
						alert("Invalid Location Code");
						$("#txtLocCode").val('');
						$("#txtLocName").text("");
						$("#txtLocCode").focus();
					} else {
						$("#txtLocCode").val(response.strLocCode);
						$("#txtLocName").text(response.strLocName);
						
						$("#txtFAdd1").val("");
						$("#txtFAdd2").val("");
						$("#txtFCity").val("");
						$("#txtFState").val("");
						$("#txtFCountry").val("");
						$("#txtFPin").val("");
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
	

	function funSeSupplierData(code) {

		$("#txtFrom").focus();
		gurl = getContextPath() + "/loadSupplierMasterData.html?partyCode=";
		$.ajax({
			type : "GET",
			url : gurl + code,
			dataType : "json",
			success : function(response) {

				if ('Invalid Code' == response.strPCode) {
					alert("Invalid Supplier Code");
					$("#txtLocCode").val('');
					$("#txtLocCode").focus();

				} else {
					$("#txtLocCode").val(response.strPCode);
					$("#txtLocName").val(response.strPName);
					$("#txtFAdd1").val(response.strSAdd1);
					$("#txtFAdd2").val(response.strSAdd2);
					$("#txtFCity").val(response.strSCity);
					$("#txtFState").val(response.strSState);
					$("#txtFCountry").val(response.strSCountry);
					$("#txtFPin").val(response.strSPin);
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
	
	function funFetchJADtls(){
		
		funClearExpDetailRow();
		var code = $("#txtJACode").val();
		var searchURL = getContextPath()+ "/loadJAData.html?JACode=" + code;
		$.ajax({
			type : "GET",
			url : searchURL,
			dataType : "json",
			success : function(response) {
				if (response.strJACode == 'Invalid Code') {
					alert("Invalid JA Code Please Select Again");
					$("#txtJACode").val('');
					$("#txtJACode").focus();
				} else {
					
					$("#txtJACode").focus();
					$("#txtJACode").val(response.strJACode);
				
					$("#txtExpDet").val("Yes");
					$("#divExpDtl").css({"display":"block"});
					
					funSetSubContractorData(response.strSCCode);
					
// 					$("#txtJANo").val(response.strJANo);
// 					$("#txtJADate").val(response.dteJADate);
// 					$("#txtSCCode").val(response.strSCCode);
// 					$("#txtSCName").text(response.strSCName);
// 	        		$("#txtRef").val(response.strRef);		
// 	        		$("#txtRefDate").val(response.dteRefDate)
// 					$("#txtDispatchMode").val(response.strDispatchMode);
// 					$("#txtPayment").val(response.strPayment);
// 					$("#txtTaxes").val(response.strTaxes);
// 					$("#txtTotQty").val(response.dbltotQty);

					$.each(response.objJOList, function(i,item){
						var objModel = response.objJOList[i];
						funAddJORow(objModel.strProdCode,objModel.strProdName,
								objModel.dblQty,objModel.dblRate,objModel.dblTotalPrice);
 	       	    	 });
					funApplyNumberValidation();
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

	function funSetSubContractorData(code) {

		funClearSCData();
		$("#txtSCAdd1").focus();
		gurl = getContextPath()
				+ "/loadSubContractorMasterData.html?partyCode=";
		$.ajax({
			type : "GET",
			url : gurl + code,
			dataType : "json",
			success : function(response) {

				if ('Invalid Code' == response.strPCode) {
					alert("Invalid Sub Contractor Code");
					$("#txtSCCode").val('');
					$("#txtSCCode").focus();

				} else {

					$("#txtSCCode").val(response.strPCode);
					$("#txtSCName").text(response.strPName);

					$("#txtSCAdd1").val(response.strSAdd1);
					$("#txtSCAdd2").val(response.strSAdd2);
					$("#txtSCCity").val(response.strSCity);
					$("#txtSCState").val(response.strSState);
					$("#txtSCCountry").val(response.strSCountry);
					$("#txtSCPin").val(response.strSPin);

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
	
	function funSetProductData(code) {
		
			$("#txtQty").focus();
			var searchUrl="";
			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
			$.ajax
			({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	if('Invalid Code' == response.strProdCode){
			    		alert('Invalid Product Code');
				    	$("#txtProdCode").val('');
				    	$("#txtProdName").val('');
				    	$("#txtProdCode").focus();
			    	}
			    	else{
				    	$("#txtProdCode").val(response.strProdCode);
				    	$("#lblProdName").text(response.strProdName);
				    	
// 				    	$("#txtPrice").val(response.dblUnitPrice);
			    		$("#txtPrice").val(response.dblCostRM);
				    		
				    	$("#lblProdUOM").val(response.strWtUOM);
				    	$("#txtWeight").val(response.dblWeight);
				    	
// 				    	funSetProdProcessData(code);
// 				    	$("#txtCostRM").val(response.dblCostRM);
// 				    	$("#txtCostManu").val(response.dblCostManu);
// 				    	$("#txtLocCode").val(response.strLocCode);
// 				    	$("#txtOrderUptoLvl").val(response.dblOrduptoLvl);
// 				    	$("#txtReorderLvl").val(response.dblReorderLvl);
// 				    	$("#txtProdType").val(response.strProdType);
// 				    	$("#cmbCalAmtOn").val(response.strCalAmtOn);
// 				    	$("#txtWeight").val(response.dblWeight);
// 				    	$("#txtWtUOM").val(response.strWtUOM);
// 				    	$("#txtBatchQty").val(response.dblBatchQty);
// 				    	$("#txtMaxLvl").val(response.dblMaxLvl);
// 				    	$("#txtBinNo").val(response.strBinNo);
// 				    	$("#cmbClass").val(response.strClass);
// 				    	$("#txtTariffNo").val(response.strTariffNo);
// 				    	$("#txtListPrice").val(response.dblListPrice);
// 				    	$("#cmbTaxIndicator").val(response.strTaxIndicator);
// 				    	$("#txtDelPeriod").val(response.intDelPeriod);			    	
// 				    	$("#txtBomCal").val(response.strBomCal);
// 				    	$("#txtDesc").val(response.strDesc);
// 				    	$("#txtSpecification").val(response.strSpecification);
// 				    	$("#txtRecievedUOM").val(response.strReceivedUOM);
// 				    	$("#txtRecievedConversionRatio").val(response.dblReceiveConversion);
// 				    	$("#txtIssueUOM").val(response.strIssueUOM);
// 				    	$("#txtIssueConversionRatio").val(response.dblIssueConversion);
// 				    	$("#txtRecipeUOM").val(response.strRecipeUOM);
// 				    	$("#txtRecipeConversionRatio").val(response.dblRecipeConversion);
// 				    	$("#txtCustItemCode").val(response.dblRecipeConversion);
			    	
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
	
	function funSetProcessCode(code){
		$("#txtQty").focus();
		var searchUrl=getContextPath()+"/loadProcessData1.html?processCode="+code;
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	if('Invalid Code' == response.strProcessCode)
			    	{
			    		alert('Invalid Process Code');
			    		$("#txtProcessCode").val('');
				    	$("#lblprocessName").text('');
			    	}
			    	else
			    	{
			    		$("#txtProcessCode").val(response.strProcessCode);
				    	$("#lblprocessName").text(response.strProcessName);
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
	
	function funClearFromData(){
		
		$("#txtLocCode").val("");
		$("#txtLocName").text("");
		$("#txtFAdd1").val("");
		$("#txtFAdd2").val("");
		$("#txtFCity").val("");
		$("#txtFState").val("");
		$("#txtFCountry").val("");
		$("#txtFPin").val("");
	}
	
	function funClearSCData(){
		
		$("#txtSCCode").val('');
		$("#txtSCName").text('');

		$("#txtSCAdd1").val('');
		$("#txtSCAdd2").val('');
		$("#txtSCCity").val('');
		$("#txtSCState").val('');
		$("#txtSCCountry").val('');
		$("#txtSCPin").val('');
	}
	
	function funClearProductRows(){
		 $('#tblProdDet tr').remove();
	}
	
	function funClearDeliveryNoteHd(){
		
		$("#txtJACode").val('');
		$("#txtExpDate").val('');
		$("#txtVehNo").val('');
		$("#txtNarration").val('');
		$("#txtMInBy").val('');
		$("#txtTimeInOut").val('');
		$("#txtExpDet").val('No');
		$("#divExpDtl").css({"display":"none"});
	  	funCalculateTotalAmt();
	}
	
	
	function btnAdd_onclick()
	{
		
		if($("#txtProdCode").val().length<=0){
				$("#txtProdCode").focus();
				alert("Please Enter Product Code Or Search");
				return false;
		}	
		
		if($("#txtProcessCode").val().length<=0){
			$("#txtProcessCode").focus();
			alert("Please Enter Process Code Or Search");
			return false;
		}	
		
		if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0){
			$("#txtWeight").val("0");
// 			return false;
		}	
		
	    if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0){		
	          alert("Please Enter Quantity");
	          $("#txtQty").focus();
	          return false;
	       } else{
		    	 var strProdCode=$("#txtProdCode").val();
		    	 if(funDuplicateProduct(strProdCode)) {
		    		 funFetchProductRowData();
	    		 }
   			}
	}
	
	function funDuplicateProduct(strProdCode)
	{
	    var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;		   
	    var flag=true;
	    if(rowCount > 0)
	    	{
			    $('#tblProdDet tr').each(function()
			    {
				    if(strProdCode==$(this).find('input').val())
    				{
				    	alert("Already added "+ strProdCode);
	    				flag=false;
    				}
				});
			    
	    	}
	    return flag;
	}
	
	function funFetchProductRowData() 
	{
	    var strProdCode = $("#txtProdCode").val().trim();
		var strProdName=$("#lblProdName").text();
		var strUOM=$("#lblProdUOM").val();	
		
	 	var strProcessCode = $("#txtProcessCode").val().trim();
		var strProcessName=$("#lblprocessName").text();
	
		var dblQty = $("#txtQty").val();
		var dblWeight=$("#txtWeight").val();
		
		if (dblWeight == '' || !($.isNumeric(dblWeight))) {
			dblWeight = 0;
		}
		
		var dblTotalWeight=dblQty*dblWeight;
		
	  	var dblPrice=$("#txtPrice").val();
	    dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblTotalPrice=(dblQty*dblPrice);	    
	    var strRemarks=$("#txtRemarks").val();
	    
	    funAddProductRow(strProdCode,strProdName,strUOM,strProcessCode,strProcessName,dblQty,dblWeight,dblTotalWeight,dblPrice,dblTotalPrice,strRemarks);
	   
	    funClearProduct();
	    $("#txtProdCode").focus();
	    funCalculateTotalAmt();
	    funApplyNumberValidation();
	    return false;
	}
	
	function funClearProduct(){

		$("#txtProdCode").val("");
		$("#lblProdName").text("");
		$("#lblProdUOM").val("");	
		$("#txtProcessCode").val("");
		$("#lblprocessName").text("");
		$("#txtQty").val("");
		$("#txtWeight").val(0);
		$("#txtPrice").val("");
	 	$("#txtRemarks").val("");
	}
	
	 function funAddProductRow(strProdCode,strProdName,strUOM,strProcessCode,strProcessName,dblQty,dblWeight,dblTotalWeight,dblPrice,dblTotalPrice,strRemarks){
		
		var table = document.getElementById("tblProdDet");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    var rowCount = listRow;
	    
	 	row.insertCell(0).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box txtProdCode \" size=\"8%\" id=\"txtProdCode."
	 										+(rowCount)+"\" value='"+strProdCode+"' />";		  		   	  
	    row.insertCell(1).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box txtProdName\" size=\"27%\" id=\"txtProdName."
   										 	+(rowCount)+"\" value='"+strProdName+"'/>";
	    row.insertCell(2).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strProdUOM\" readonly=\"readonly\" class=\"Box txtUOM\" size=\"2%\" id=\"txtUOM."
	   									 	+(rowCount)+"\" value='"+strUOM+"'/>";
	    row.insertCell(3).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strProcessCode\" readonly=\"readonly\" class=\"Box txtProcessCode\" size=\"8%\" id=\"txtProcessCode."
						  				 	+(rowCount)+"\" value='"+strProcessCode+"' />";		  		   	  
	    row.insertCell(4).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strProcessName\" readonly=\"readonly\" class=\"Box txtProcessName\" size=\"27%\" id=\"txtProcessName."
										 	+(rowCount)+"\" value='"+strProcessName+"'/>";
	    row.insertCell(5).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].dblQty\" type=\"text\"  required = \"required\" style=\"text-align: right;\" class=\"decimal-places inputText-Auto txtQty\" id=\"txtQty."
	   	 									+(rowCount)+"\" value="+dblQty+" onblur=\"Javacsript:funUpdatePrice(this)\" >";
	    row.insertCell(6).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].dblWeight\" type=\"text\"  required = \"required\" style=\"text-align: right;\" class=\"decimal-places inputText-Auto txtWeight\" id=\"txtWeight."
	   										+(rowCount)+"\" value="+dblWeight+" onblur=\"Javacsript:funUpdatePrice(this)\" >";
	    row.insertCell(7).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].dblTotalWt\" readonly=\"readonly\" class=\"Box dblTotalWt\" style=\"text-align: right;\" \size=\"3.9%\" id=\"dblTotalWt."
	   										+(rowCount)+"\"   value='"+dblTotalWeight+"'/>";
	    row.insertCell(8).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].dblRate\" type=\"text\"  required = \"required\" style=\"text-align: right;\" class=\"decimal-places-amt inputText-Auto txtRate\" id=\"txtRate."
	    									+(rowCount)+"\" value="+dblPrice+" onblur=\"Javacsript:funUpdatePrice(this)\" >";
	    row.insertCell(9).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].dblTotalPrice\" readonly=\"readonly\" class=\"Box txtTotalPrice\" style=\"text-align: right;\" size=\"6%\" id=\"txtTotalPrice."
	    									+(rowCount)+"\" value="+dblTotalPrice+" >";
	    row.insertCell(10).innerHTML= "<input name=\"listDNDtl["+(rowCount)+"].strRemarks\"  readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"txtRemarks."
	   										+(rowCount)+"\" value='"+strRemarks+"'/>";
	 	row.insertCell(11).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';		    
	 	 
	 	listRow++;
	}
	 
	 function funUpdatePrice(object) {

			var dblQty ="";
			var dblWeight ="";
			var dblRate ="";
			
			var $row = $(object).closest("tr");
			
			if ($row.find(".txtQty").val() != '') {
				dblQty = parseFloat($row.find(".txtQty").val());
			}
			
			if ($row.find(".txtWeight").val() != '') {
				dblWeight = parseFloat($row.find(".txtWeight").val());
			}
			
			if ($row.find(".txtRate").val() != '') {
				dblRate = parseFloat($row.find(".txtRate").val());
			}
			
// 			alert(dblQty+""+dblWeight+""+dblRate);

			 if(!(isNumber(dblQty))){
				dblQty=0;
				$row.find(".dblQty").val("0");
			}
			
			if(!(isNumber(dblWeight))){
				dblWeight=0;
				$row.find(".txtWeight").val("0");
			}
			
			if(!(isNumber(dblRate))){
				dblRate=0;
				$row.find(".txtRate").val("0");
			} 
			
			var dblTotalWeight=dblQty * dblWeight;
		    var dblTotalPrice= dblQty * dblRate;	    
		    
			$row.find(".dblTotalWt").val(dblTotalWeight);
			$row.find(".txtTotalPrice").val(dblTotalPrice);
			
			funCalculateTotalAmt();
	}
	 
	 
	 function funCalculateTotalAmt() {
		 
			var totalQty = 0;
			var totalWeight = 0;
			var totalPrice = 0;
			
			$('#tblProdDet tr').each(function() {
				
				var Qty = 0;
	 			var Weight = 0;
	 			var Price = 0

				if ($(this).find(".txtQty").val() != '') {
					Qty = parseFloat($(this).find(".txtQty").val());
				}
				if ($(this).find(".txtWeight").val() != '') {
					Weight = parseFloat($(this).find(".txtWeight").val());
				}
				if ($(this).find(".txtTotalPrice").val() != '') {
					Price = parseFloat($(this).find(".txtTotalPrice").val())
				}
				
				totalQty = totalQty + Qty;
				totalWeight = totalWeight + Weight;
				totalPrice = totalPrice + Price;
			});

			$("#txtTotalQty").val(totalQty);
			$("#txtTotalWt").val(totalWeight);
			$("#txtTotalAmt").val(totalPrice);
	}
	 
 	function funDeleteRow(obj) {
		var index = obj.parentNode.parentNode.rowIndex;
		var table = document.getElementById("tblProdDet");
		table.deleteRow(index);
		
		funCalculateTotalAmt();
	}
	
	function funSetJACode(code) {
		$("#txtJACode").val(code);
	}
	
	

	function funHelpForLocation() {
		txtAgainst = $("#txtFrom").val();
		funSetLocCodeHelp(txtAgainst);
// 		window.showModalDialog("searchform.html?formname=" + transactionName
// 					+ "&searchText=", "","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname=" + transactionName
				+ "&searchText=", "","dialogHeight:600px;dialogWidth:600px;top=500,left=500");
	}

	function funSetLocCodeHelp(txtAgainst) {
		switch (txtAgainst) {
		case 'Company':
			reportName = "loadLocationMasterData.html";
			transactionName = 'locationmaster';
			break;

		case 'Supplier':
			reportName = "loadSupplierMasterData.html";
			transactionName = 'suppcode';
			break;

		}
		fieldName = transactionName;
	}

	function funHelp(transactionName) {
		fieldName = transactionName;
// 		window.showModalDialog("searchform.html?formname=" + transactionName
// 				+ "&searchText=", "","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname=" + transactionName
				+ "&searchText=", "","dialogHeight:600px;dialogWidth:600px;top=500,left=500");
	}
	
	function funSetExpProductData(code) {
		var searchUrl="";
		searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
		$.ajax
		({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    success: function(response)
		    {
		    	if('Invalid Code' == response.strProdCode){
		    		alert('Invalid Product Code');
			    	$("#txtExpProdCode").val('');
			    	$("#lblExpProdName").val('');
			    	$("#txtExpProdCode").focus();
		    	}
		    	else{
			    	$("#txtExpProdCode").val(response.strProdCode);
			    	$("#lblExpProdName").text(response.strProdName);
			    	
			    	$("#txtExpPrice").val(response.dblCostRM);
			    	$("#txtExpWeight").val(response.dblWeight);
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
	
	function funAddExpDtl()
	{
		
		if($("#txtExpProdCode").val().length<=0){
				$("#txtExpProdCode").focus();
				alert("Please Enter Product Code Or Search");
				return false;
		}	
		
		if($("#txtExpWeight").val().trim().length==0 || $("#txtxtExpWeighttQty").val()== 0){
			$("#txtExpWeight").val("0");
// 			return false;
		}	
		
	    if($("#txtExpQty").val().trim().length==0 || $("#txtExpQty").val()== 0){		
	          alert("Please Enter Quantity");
	          $("#txtExpQty").focus();
	          return false;
	       } else{
		    	 var strProdCode=$("#txtProdCode").val();
		    	 if(funDuplicateExpProduct(strProdCode)) {
		    		 funFetchExpProductRowData();
	    		 }
   			}
	}
	
	function funDuplicateExpProduct(strProdCode)
	{
	    var table = document.getElementById("tblExpProdDet");
	    var rowCount = table.rows.length;		   
	    var flag=true;
	    if(rowCount > 0)
	    	{
			    $('#tblExpProdDet tr').each(function()
			    {
				    if(strProdCode==$(this).find('input').val())
    				{
				    	alert("Already added "+ strProdCode);
	    				flag=false;
    				}
				});
			    
	    	}
	    return flag;
	}
	
	function funFetchExpProductRowData() 
	{
	    var strProdCode = $("#txtExpProdCode").val().trim();
		var strProdName=$("#lblExpProdName").text();
		
		var dblPrice=$("#txtExpPrice").val();
		var dblQty = $("#txtExpQty").val();
		var dblWeight=$("#txtExpWeight").val();
		
		if (dblWeight == '' || !($.isNumeric(dblWeight))) {
			dblWeight = 0;
		}
		
	    dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
	    var dblTotalPrice=(dblQty*dblPrice);	    
	    
	    funAddJORow(strProdCode,strProdName,dblQty,dblPrice,dblTotalPrice)
	    
	    funClearExpProduct();
	    $("#txtExpProdCode").focus();
	    funApplyNumberValidation();
	    return false;
	}
	
	function funClearExpProduct(){

		$("#txtExpProdCode").val("");
		$("#lblExpProdName").text("");
		$("#txtExpPrice").val("");	
		$("#txtExpQty").val("");
		$("#txtExpWeight").val("");
	}
	
	 function funDeleteExpDetailRow(obj) {
			var index = obj.parentNode.parentNode.rowIndex;
			var table = document.getElementById("tblExpProdDet");
			table.deleteRow(index);
			
			funCalculateTotalAmt();
		}
	
	 function funClearExpDetailRow(){
			$("#tblExpProdDet tr").remove();
		}
	function funAddJORow(strProductCode,strProductName,dblQty,dblPrice,dblTotalPrice) {
		
		var table = document.getElementById("tblExpProdDet");
		var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
		
		var rowCount = explistRow;

		row.insertCell(0).innerHTML = "<input style=\"width:99%;\"  readonly=\"readonly\"  class=\"Box\" id=\"txtProductCode."
											+ (rowCount) + "\" value='" + strProductCode + "' />";

		row.insertCell(1).innerHTML = "<input style=\"width:99%;\" readonly=\"readonly\"  class=\"Box\" id=\"txtProductName."
											+ (rowCount) + "\" value='" + strProductName + "' />";

		row.insertCell(2).innerHTML = "<input style=\"width:99%;\" readonly=\"readonly\" class=\"Box decimal-places dblQty\" id=\"dblQty."
											+ (rowCount)+ "\" value='"+ dblQty + "' onchange=\"funUpdatePrice(this)\" />";

		row.insertCell(3).innerHTML = "<input style=\"width:99%;\"  readonly=\"readonly\" class=\"Box decimal-places dblPrice\" id=\"dblPrice."
											+ (rowCount)+ "\" value='"+ dblPrice + "' onchange=\"funUpdatePrice(this)\" />";

		row.insertCell(4).innerHTML = "<input style=\"width:99%;\" readonly=\"readonly\" class=\"Box dblTotalPrice\" id=\"dblTotalPrice."
											+ (rowCount)+ "\" value='"+ dblTotalPrice+ "' />";

		row.insertCell(5).innerHTML = '<input style=\"width:99%;\" type="button" value = "Delete"  class="deletebutton" onClick="Javacsript:funDeleteExpDetailRow(this)">';

		explistRow++;

	}

	function funApplyNumberValidation(){
		$(".numeric").numeric();
		$(".integer").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
		$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
		$(".positive-integer").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	    $(".decimal-places").numeric({ decimalPlaces: maxQuantityDecimalPlaceLimit, negative: false });
	}
	
</script>

</head>
<body>
	<div class="container">
		<label id="formHeading">Delivery Note</label>
	<s:form name="DeliveryNote" method="POST" action="saveDeliveryNote.html">
		<div class="row transTable">
			<div class="col-md-2">
				<label>DN Code</label>
				<s:input type="text" id="txtDNCode" path="strDNCode" cssClass="searchTextBox" ondblclick="funHelp('DNCode');"/>
			</div>
				<%-- <td>
					<label>Type Against</label>
				</td>
				
				<td>
					<s:select id="txtTypeAgainst" path="strTypeAgainst"  cssClass="BoxW124px">
						<s:option value="EQUIRY">EQUIRY</s:option>
						<s:option value="PROJECT REVIEW">PROJECT REVIEW</s:option>
						<s:option value="PURCHASE ORDER">PURCHASE ORDER</s:option>
						<s:option value="DATABASE">DATABASE</s:option>
						<s:option value="CMR">CMR</s:option>
						<s:option value="BARCHARTS">BARCHARTS</s:option>
					</s:select>
				</td>
				
				<td>
					<label>Type Code</label>
				</td>
				<td>
					<s:input type="text" id="txtTypeCode" path="strTypeCode" cssClass="BoxW124px" ondblclick="funHelp('TypeCode');"/>
				</td> --%>
				<div class="col-md-2">
					<label>DN Date</label>
					<s:input type="text" required="true" id="txtDNDate" path="dteDNDate" cssClass="calenderTextBox" style="width:80%;" />
				</div>
				<div class="col-md-2">
					<label>DN Against</label>
					<s:select id="txtDNType" path="strDNType"  cssClass="BoxW124px" style="width:80%;">
						<s:option value="Direct">Direct</s:option>
						<s:option value="JA">JA</s:option>
					</s:select>
				</div>
			
				<%-- <td colspan="3">
					<s:input type="text" id="txtGRNCode" path="strGRNCode" cssClass="searchTextBox" ondblclick="funHelp1();"/>
				</td> --%>
				<div class="col-md-2">
					<label>JA Code</label>
					<s:input type="text" id="txtJACode" path="strJACode" cssClass="searchTextBox" ondblclick="funHelp('JACode');"/>
				</div>
				<div class="col-md-2">
					<input type="Button" value="Add" onclick="return funFetchJADtls()" class="btn btn-primary center-block" style="margin-top:20px;" />
				</div>
				<div class="col-md-2"></div>
				<div class="col-md-2">
					<label>SC Code</label>
					<s:input type="text" id="txtSCCode"  required="true" path="strSCCode" cssClass="searchTextBox" ondblclick="funHelp('subContractor');" />
				</div>
				<div class="col-md-2">
					<label id="txtSCName" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
					></label>
				</div>
				<div class="col-md-2">
					<label>From</label>
					<s:select id="txtFrom" path="strFrom" cssClass="BoxW124px" style="width:80%;">
						<s:option value="Company">Company</s:option>
						<s:option value="Supplier">Supplier</s:option>
					</s:select>
				</div>
				<div class="col-md-2">
					<label>Loc Code</label>
					<s:input id="txtLocCode" path="strLocCode" cssClass="searchTextBox" ondblclick="funHelpForLocation();" />
				</div>
				<div class="col-md-2">
					<label id="txtLocName" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
					></label>
				</div>
					<div class="col-md-2"></div>
				<div class="col-md-2">
					<label>Transort Type</label>
					<s:select id="cmbTransport" name="cmbTransport" path="strTransportType" cssClass="BoxW124px">
							<option selected="selected"value="By Vehicle">By Vehicle</option>
							<option value="By Air">By Air</option>
							<option value="By Rail">By Rail</option>
							<option value="By Motor Cycle">By Motor Cycle</option>
					</s:select>
				</div>
			</div>
			
				<div class="row" style="width: 100%;">
					<div id="leftDiv" class="col-md-6">
						<div class="row masterTable">
								<div class="col-md-8">
									<label>SC Address1</label>
									<s:input type="text" id="txtSCAdd1" path="strSCAdd1" />
								</div>
								<div class="col-md-8">
									<label>SC Address2</label>
									<s:input type="text" id="txtSCAdd2" path="strSCAdd2"/>
								</div><div class="col-md-4"></div>
								<div class="col-md-4">
									<label>SC City</label>
									<s:input type="text" id="txtSCCity" path="strSCCity"  />
								</div>
								<div class="col-md-4">
									<label>SC State</label>
									<s:input type="text" id="txtSCState" path="strSCState"/>
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-4">
									<label>SC Country</label>
									<s:input type="text" id="txtSCCountry" path="strSCCountry"/>
								</div>
								<div class="col-md-4">
									<label>SC Pin</label>
									<s:input type="text" id="txtSCPin" path="strSCPin" />
							  </div>
							</div>
						</div>
						<div id="rightDiv" class="col-md-6">
							<div class="row masterTable">
								<div class="col-md-8">
									<label>From Address1</label>
									<s:input type="text" id="txtFAdd1" path="strFAdd1"/>
								</div>
								<div class="col-md-8">
									<label>From Address2</label>
									<s:input type="text" id="txtFAdd2" path="strFAdd2"/>
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-4">
									<label>From City</label>
									<s:input type="text" id="txtFCity" path="strFCity"/>
								</div>
								<div class="col-md-4">
									<label>From State</label>
									<s:input type="text" id="txtFState" path="strFState" />
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-4">
									<label>From Country</label>
									<s:input type="text" id="txtFCountry" path="strFCountry" />
								</div>
								<div class="col-md-4">
									<label>From Pin</label>
									<s:input type="text" id="txtFPin" path="strFPin" />
								</div>
							</div>
						</div>
					</div>
				<div class="row transTable">
					<div class="col-md-2">
						<label>Expected Date</label>
						<s:input type="text" id="txtExpDate" path="dteExpDate" cssClass="calenderTextBox" style="width:80%;" />
					</div>
					<div class="col-md-2">
						<label>Vehicle No</label>
						<s:input type="text" id="txtVehNo" path="strVehNo" cssClass="BoxW124px" />
					</div>
			   </div>

		<div class="row transTable">
			<div class="col-md-2">
				<label>Product Code</label>
				<input id="txtProdCode" ondblclick="funHelp('RawProduct')" class="searchTextBox" />
			</div>	
			<div class="col-md-2">
				<label id="lblProdName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
				></label>
				<input type="hidden" id="lblProdUOM" class="searchTextBox" />
			</div>
			<div class="col-md-2">
				<label>Process Code</label>
				<input id="txtProcessCode" ondblclick="funHelp('processcode')" class="searchTextBox" />
			</div>
			<div class="col-md-2">
				<label id="lblprocessName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
				></label>
			</div>
			<div class="col-md-2">	
				<label>Price/Unit</label>
				<input id="txtPrice" type="text" class="decimal-places numberField" />
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-2">	
				<label>Wt/Unit</label>
				<input type="text" id="txtWeight" class="decimal-places numberField" />
			</div>
			<div class="col-md-2">	
				<label>Quantity</label>
				<input id="txtQty" type="text" class="decimal-places numberField" style="width: 60%" />
			</div>
			<div class="col-md-2">	
				<label>Stock</label>
				<input id="txtStock" type="text" readonly="readonly"
					class="decimal-places-amt numberField" value="0" class="BoxW116px" />
			</div>
			<div class="col-md-2">	
				<label>Remarks</label>
				<input id="txtRemarks" type="text" />
			</div>
			<div class="col-md-2">	
				<input type="button" value="Add" class="btn btn-primary center-block" onclick="return btnAdd_onclick()" style="margin-top:20px;"/>
			</div>
		</div>
		<br/>
		<div class="dynamicTableContainer" style="height: 300px;">
			<table
				style="height: 20px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
				<tr bgcolor="#c0c0c0">
					<td width="5%">Product Code</td>
					<td width="18%">Product Name</td>
					<td width="4%">UOM</td>
					<td width="5%">Process Code</td>
					<td width="10%">Process Name</td>
					<td width="5%">Quantity</td>
					<td width="5%">Wt./Unit</td>
					<td width="5%">Total Wt.</td>
					<td width="5%">Price/Unit</td>
					<td width="6%">Total Price</td>
					<td width="11%">Remarks</td>
					<td width="3%">Delete</td>
				</tr>
			</table>
			<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
				<table id="tblProdDet"
					style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
					class="transTablex col15-center">
					<tbody>
						<col style="width: 5%">
						<col style="width: 19%">
						<col style="width: 4%">										
						<col style="width: 5%">
						<col style="width: 11%">
						<col style="width: 5%">
						<col style="width: 5%">
						<col style="width: 5%">
						<col style="width: 5%">
						<col style="width: 6%">
						<col style="width: 12%">
						<col style="width: 3%">
					</tbody>
				</table>
			</div>
		</div>
		<br />
	<div class="row transTable">
		<div class="col-md-2">
			<label>Total Quantity</label>
			<s:input type="text" readonly="true" id="txtTotalQty" path="dblTotal" 
						cssClass="BoxW124px" />
		</div>
		<div class="col-md-2">
			<label>Total Weight</label>
			<s:input type="text" readonly="true" id="txtTotalWt" path="dblTotalWt" 
						cssClass="BoxW124px" />
		</div>
		<div class="col-md-2">	
			<label>Total Amount</label>
			<s:input type="text" readonly="true" id="txtTotalAmt" path="dblTotalAmt" 
						cssClass="BoxW124px" />
		</div>
		<div class="col-md-2">	
			<label>Narration</label>
			<s:input type="text" id="txtNarration" path="strNarration" />
		</div>
		<div class="col-md-2">	
			<label>Material Send By</label>
			<s:input type="text" id="txtMInBy" path="strMInBy" cssClass="BoxW124px" />
		</div>
		<div class="col-md-2">		
			<label>Time In Out</label>
			<s:input type="text" id="txtTimeInOut" path="strTimeInOut" cssClass="BoxW124px" />
		</div>
		<div class="col-md-2">			
			<label>Expected Details</label>
			<s:select id="txtExpDet" class="BoxW124px" path="strExpDet" style="width:80%;">
				<s:option value="No">No</s:option>
				<s:option value="Yes">Yes</s:option>
			</s:select>
		</div>
	</div>
		<br/>
	<div id="divExpDtl" class="transTable" style="display:none; ">
		<br/>
			<h6 style="margin: 1%;">Expected Details</h6>
		<br>

		<div class="row transTable">
			<div class="col-md-2">
				<label>Product Code</label>
				<input id="txtExpProdCode" ondblclick="funHelp('expProductmaster')" class="searchTextBox" />
			</div>
			<div class="col-md-2">
				<label id="lblExpProdName" class="namelabel" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
				></label>
			</div>	
				
				<!-- <td><label>Process Code</label></td>
				<td>
					<input id="txtExpProcessCode" ondblclick="funHelp('processmaster')" class="searchTextBox" />
				</td>
				<td colspan="2">
					<label id="lblExpprocessName" class="namelabel"></label>
				</td> -->
				<div class="col-md-2">
					<label>Price/Unit</label>
					<input id="txtExpPrice" type="text" class="decimal-places numberField" />
				</div>
				<div class="col-md-2">
					<label>Wt/Unit</label>
					<input type="text" id="txtExpWeight" readonly="readonly" class="decimal-places numberField" />
				</div>
				<div class="col-md-2">
					<label>Quantity</label>
					<input id="txtExpQty" type="text" class="decimal-places numberField" style="width: 60%" />
				</div>
				<div class="col-md-2">
					<input type="button" value="Save" class="btn btn-primary center-block"  onclick="return funAddExpDtl()" style="margin-top:20px;"/>
				</div>
			</div>
		<br/>
		<div class="dynamicTableContainer" style="height: 300px;">
			<table style="height: 20px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
				<tr bgcolor="#c0c0c0">
					
					<td width="8%">Product Code</td>
					<td width="18%">Product Name</td>
					<!-- <td width="2%">UOM</td>
					<td width="5%">Process Code</td>
					<td width="18%">Process Name</td> -->
					<td width="8%">Quantity</td>
	<!-- 				<td width="8%">Wt./Unit</td>
					<td width="8%">Total Wt.</td> -->
					<td width="8%">Price/Unit</td>
					<td width="8%">Total Price</td>
					<td width="4%">Delete</td>
				</tr>
			</table>
			<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
				<table id="tblExpProdDet"
					style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
					class="transTablex col15-center">
					<tbody>
						<col style="width: 8%">
						<col style="width: 18%">
					<%--	<col style="width: 2%">										
						<col style="width: 5%">
						<col style="width: 18%"> --%>
						<col style="width: 8%">
	<%-- 					<col style="width: 8%">
						<col style="width: 3%"> --%>
						<col style="width: 8%">
						<col style="width: 8%">
						<col style="width: 4%">
										
					</tbody>

				</table>
			</div>
		</div>
		<br />
	</div>
	<div class="center" style="text-align:center;">
		<a href="#"><button class="btn btn-primary center-block" value="Submit" 
			class="form_button">Submit</button></a> &nbsp;
		<a href="#"><button class="btn btn-primary center-block" value="Reset" onclick="funResetFields()"
			class="form_button">Reset</button></a>
	</div>
	<div id="wait"
		style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
	<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif"
		width="60px" height="60px" />
	</div>
	</s:form>
</div>
	<script type="text/javascript">
		funApplyNumberValidation();
	</script>
	
</body>
</html>
		
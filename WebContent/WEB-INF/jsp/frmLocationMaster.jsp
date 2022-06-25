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
	
<title>LOCATION MASTER</title>	
<style>
.ui-autocomplete {
    max-height: 200px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
    /* add padding to account for vertical scrollbar */
    padding-right: 20px;
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* html .ui-autocomplete {
    height: 200px;
}
</style>
<script type="text/javascript">
//Set Focus on Location Name
$(document).ready(function(){
	resetForms("locationForm");
	$("#txtlocName").focus();
});
</script>
	<script type="text/javascript">
	var fieldName;
	var clickCount =0.0;
	//Initialize tab Index or which tab is Active
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
				
				$(document).ajaxStart(function(){
				    $("#wait").css("display","block");
				});
				$(document).ajaxComplete(function(){
				   	$("#wait").css("display","none");
				});


 				var todayDate=new Date();
				//var twoDigitMonth = ((todayDate.getMonth().length+1) === 1)? (todayDate.getMonth()+1) : '0' + (todayDate.getMonth()+1);
				var month =todayDate.getMonth();
				month=month+1;
				var len=month.toString().length;
				if(len==1)
					{
					month="0"+month;
					}
				var currentDate = todayDate.getDate() + "-" + month + "-" + todayDate.getFullYear();
     			$("#txtMonthEnd" ).val(currentDate);
     		
				
			});
	
	//Get Existed Location Name When User Type Name in Location Name Textfield
	 $(document).ready(function()
				{
					$(function() {
						
						$("#txtlocName").autocomplete({
						source: function(request, response)
						{
							var searchUrl=getContextPath()+"/AutoCompletGetLocationName.html";
							$.ajax({
							url: searchUrl,
							type: "POST",
							data: { term: request.term },
							dataType: "json",
							 
								success: function(data) 
								{
									response($.map(data, function(v,i)
									{
										return {
											label: v,
											value: v
											};
									}));
								}
							});
						}
					});
					});
				});


		
		
		//Reset Field
		function funResetFields()
		{			
			$("#chkAvlForSale").attr('checked', false);
			$("#chkActive").attr('checked', false);
			$("#chkPickable").attr('checked', false);
			$("#chkReceivable").attr('checked', false);
			$("#txtlocName").val('');
			$("#txtLocDesc").val('');
			$("#txtPropertyCode").val('');
			$("#txtLocDesc").val('');
			$("#txtExciseNo").val('');
			$("#txtExternalCode").val('');
			$("#txtlocName").focus();
			$("#lblPropertyName").text("");
			$("#lblUnderlocName").text("");
	    }
		
		//Open Help
		function funHelp(transactionName)
		{
			fieldName=transactionName;
			if(fieldName=='locationmaster')
			{
				gurl=getContextPath()+"/loadLocationMasterData.html?locCode=";
			}
			if(transactionName=='underlocationmaster'){
				
				window.open("searchform.html?formname=locationmaster&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
			}else{
				window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")	
			}
	         
	    }
		
		//Get and Set Location Data based on Passing Parameter(Location Code)
		function funSetLocation(code)
		{
			$.ajax({
			        type: "GET",
			        url: getContextPath()+"/loadLocationMasterData.html?locCode="+code,
			        dataType: "json",
			        success: function(response)
			        {
				       	if(response.strLocCode=='Invalid Code')
				       	{
				       		alert("Invalid Location Code");
				       		$("#txtLocCode").val('');
				       	}
				       	else
				       	{
				       		$("#txtLocCode").val(response.strLocCode);
					       	$("#txtlocName").val(response.strLocName);
					       	
					       	$("#txtLocCode1").val(response.strLocCode);
					       	$("#txtlocName1").val(response.strLocName);
					       	
					       	$("#txtLocDesc").val(response.strLocDesc);					       	
					       	$("#txtExciseNo").val(response.strExciseNo);
					       	$("#txtExternalCode").val(response.strExternalCode);
					       	
					       	if(response.strAvlForSale=='Y')
				        	{
				        		$("#chkAvlForSale").attr('checked', true);
				        	}else{
				        		
				        		$("#chkAvlForSale").attr('checked', false);
				        	}
					       	if(response.strActive=='Y')
				        	{
				        		$("#chkActive").attr('checked', true);
				        	}	
					       	else{
				        		$("#chkActive").attr('checked', false);
				        	}	
					       	if(response.strPickable=='Y')
				        	{
				        		$("#chkPickable").attr('checked', true);
				        	}	
					       	else
					       	if(response.strReceivable=='Y')
				        	{
				        		$("#chkReceivable").attr('checked', true);
				        	}
					       	$("#cmbType").val(response.strType);	
					       	$("#txtlocName").focus();
					       	
					       	$("#txtUnderLocCode").val(response.strUnderLocCode);
					       	
					       	funSetPropertyData(response.strPropertyCode);
					       	funSetReOrderLevelData(response.strLocCode);
					       	funSetLocCustData(response.strLocCode);
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
		
		//Get and set Property Data based on passing Value(Property Code) 
		function funSetPropertyData(code)
		{
			
			$("#txtPropertyCode").val(code);
			$.ajax({
					type : "GET",
					url : getContextPath()+ "/loadPropertyMasterData.html?Code=" + code,
					dataType : "json",
					success : function(resp) 
					{
						// we have the response
						$("#txtPropertyCode").val(resp.propertyCode);
						$("#lblPropertyName").text(resp.propertyName);
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
		
		//Get and Set Reorder Level Data based on Passing Value(Location Code)
		function funSetReOrderLevelData(strLocCode)
		{
			var searchurl=getContextPath()+ "/loadReorderLvlMasterData.html?strLocCode=" + strLocCode;
			$.ajax({
					type : "GET",
					url : searchurl,
					dataType : "json",
					success : function(resp) 
					{
						funRemoveProductRows();
						$.each(resp, function(i,item)
						{
							funAddReorderLevelRow(resp[i][0],resp[i][1],resp[i][2],resp[i][3],resp[i][4])
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
		
		//Set Data on selection on help
		function funSetData(code)
		{			
			switch (fieldName) 
			{			   
			   case 'locationmaster':
			    	funSetLocation(code);
			        break;
			        
			   case 'property':
				   funSetPropertyData(code);
			        break;
			        
			   case 'SundryDebtorWeb-Service':
			    	funSetSundryDebtor(code);
			        break;       
			        
			   case 'underlocationmaster' :
				    funSetUnderLocation(code);
			        break;
			        
			   case 'customerMaster' :
				   funSetCustomer(code);
			        break;  
			        
			   case 'suppcode' :
				   funSetSupplier(code);
			        break;       
			}
		}
		
		//Attached Document Link
		$(function()
		{
			$('a#baseUrl').click(function() 
			{
				if($("#txtLocCode").val().trim()=="")
				{
					alert("Please Select Location Code");
					return false;
				}
				window.open('attachDoc.html?transName=frmLocationMaster.jsp&formName=Location Master&code='+$('#txtLocCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			});
			
			//On Blur Text Field Event
			$('#txtLocCode').blur(function () {
				 var code=$('#txtLocCode').val();				   
				      if (code.trim().length > 0 && code !="?" && code !="/") {
				      funSetLocation(code);
				      }
				});
			
			$('#txtlocName').blur(function () {
				 var strLocName=$('#txtlocName').val();
			      var st = strLocName.replace(/\s{2,}/g, ' ');
			      $('#txtlocName').val(st);
				});
			
			
		});
		
		
	
	
		//After Saving Display Success Message
		$(document).ready(function() 
				{	
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
      });
		
		
		//Check Validation Submit on Click
		function funCallFormAction(actionName,object) 
		{
			var flg=true;
			
			if($('#txtlocName').val().trim()=="")
				{
					alert("Please Enter Location Name");
					$('#txtlocName').focus();
					return false;
				}
			if($('#txtPropertyCode').val().trim()=="")
			{
				alert("Please Select Property Code");
				return false;
			}
			
			if(clickCount==0){
				clickCount=clickCount+1;
			if($('#txtLocCode').val()=='')
			{
				var code = $('#txtlocName').val();
				 $.ajax({
				        type: "GET",
				        url: getContextPath()+"/checklocName.html?locName="+code,
				        async: false,
				        dataType: "text",
				        success: function(response)
				        {
				        	if(response=="true")
				        		{
				        			alert("Location Name Already Exist!");
				        			$('#txtlocName').focus();
				        			flg= false;
					    		}
					    	else
					    		{
					    			flg=true;
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
		else
		{
			return false;
		}
// 			if($('#txtLocCode').val()==$('#txtUnderLocCode').val())
// 				{
// 					alert("Location and Under Location Are Same");
// 	    			flg= false;
// 				}
// 			return flg;
		}
		
		//Remove All Row from Grid
		function funRemoveProductRows()
		{
			var table = document.getElementById("tblProdDet");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		//Open Excel Export/Impoert From
		function funOpenExportImport()			
		{
			if($('#txtLocCode').val()!='')
				{
					var transactionformName="frmLocationMaster";
					var locCode=$('#txtLocCode').val();
			     //   response=window.showModalDialog("frmExcelExportImport.html?formname="+transactionformName+"&locCode="+locCode,"","dialogHeight:500px;dialogWidth:500px;dialogLeft:500px;");
			        response=window.open("frmExcelExportImport.html?formname="+transactionformName+"&locCode="+locCode,"","dialogHeight:500px;dialogWidth:500px;dialogLeft:500px;");
			        var timer = setInterval(function ()
			   			    {
			   				if(response.closed)
			   					{
			   						if (response.returnValue != null)
			   						{
			   							
			   							response=response.returnValue;
				   						 funRemoveProductRows();
				 				    	$.each(response, function(i,item)
				 						{			    		
				 				    		if(response[i][0]!=0 && response[i][1]!=0)
				 				    			{
				 				    				funAddReorderLevelRow(response[i][0],response[i][1],response[i][2],response[i][3],0.0);
				 				    			}
				 				    		
				 					  	}); 
			   						} clearInterval(timer);
			   					}
			   			  }, 500); 
			        
			        /*   if(null!=response)
			        {
				        funRemoveProductRows();
				    	$.each(response, function(i,item)
						{			    		
				    		funAddReorderLevelRow(response[i][0],response[i][1],response[i][2],response[i][3],response[i][4]);
					  	}); 
			        } */
				}
			else
				{
					alert("Please Select Location");
					return false;
				}
		}
		
		//After Excel Import Fill Data in Grid
		function funAddReorderLevelRow(strProdCode,strProdName,dblReorderLvl,dblReorderQty,dblPrice)
		{
			 var table = document.getElementById("tblProdDet");
			    var rowCount = table.rows.length;
			    var row = table.insertRow(rowCount);
			    
			    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"7%\" name=\"listReorderLvl["+(rowCount)+"].strProdCode\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"'>";
			    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"35%\"  id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"' >";
			    row.insertCell(2).innerHTML= "<input type=\"text\"  size=\"10%\"  required = \"required\" style=\"text-align: right;border:1px solid #a2a2a2;padding:1px;\" class=\"decimal-places inputText-Auto\" name=\"listReorderLvl["+(rowCount)+"].dblReOrderLevel\" id=\"txtReOrderLevel."+(rowCount)+"\" value='"+dblReorderLvl+"' >";		    
			    row.insertCell(3).innerHTML= "<input type=\"text\" size=\"10%\"  required = \"required\" style=\"text-align: right;border:1px solid #a2a2a2;padding:1px;\" class=\"decimal-places inputText-Auto\" name=\"listReorderLvl["+(rowCount)+"].dblReOrderQty\"  id=\"txtReOrderQty."+(rowCount)+"\" value='"+dblReorderQty+"' >";
			    row.insertCell(4).innerHTML= "<input type=\"text\" size=\"10%\"  required = \"required\" style=\"text-align: right;border:1px solid #a2a2a2;padding:1px;\" class=\"decimal-places inputText-Auto\" name=\"listReorderLvl["+(rowCount)+"].dblPrice\"  id=\"txtPrice."+(rowCount)+"\" value='"+dblPrice+"' >";
			    row.insertCell(5).innerHTML= '<input type="button" size=\"10%\"  value = "Delete"  class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';
			    return false;
		}
		
		//Delete a Particular Row
		function funDeleteRow(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblProdDet");
		    table.deleteRow(index);
		}
		
		
		function funSetSundryDebtor(code)
		{	
		 $.ajax({
				type : "GET",
				url : getContextPath()+ "/loadSundryDataFormWebService.html?strAccountCode=" + code,
				dataType : "json",
				success : function(response){ 
					
					$('#txtAcCode').val(response.strDebtorCode);
					$('#txtAcName').val(response.strFirstName);

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
		
		//Get and Set Under Location Data based on Passing Parameter(Location Code)
		function funSetUnderLocation(code)
		{
			$.ajax({
			        type: "GET",
			        url: getContextPath()+"/loadLocationMasterData.html?locCode="+code,
			        dataType: "json",
			        success: function(response)
			        {
				       	if(response.strLocCode=='Invalid Code')
				       	{
				       		//alert("Invalid Location Code");
				       		$("#txtUnderLocCode").val('');
				       	}
				       	else
				       	{
				       		$("#txtUnderLocCode").val(response.strLocCode);
					       	$("#lblUnderlocName").text(response.strLocName);
					       	
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
		
		
		function funSetCustomer(code)
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
							$("#lblCustomerName").val(response.strPName);
							
						
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
		
		function btnCustomerAdd_onclick() 
	    {	
			var strCustomerCode=$("#txtCustCode").val();
		   	 if(funDuplicateCustomer(strCustomerCode))
			 {
		   		funAddCustRow();
			 }
	    }
		
		function funDuplicateCustomer(strCustomerCode)
		{
		    var table = document.getElementById("tblLocCust");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    	{
				    $('#tblLocCust tr').each(function()
				    {
					    if(strCustomerCode==$(this).find('input').val())// `this` is TR DOM element
	    				{
					    	alert("Customer Allready added "+ strCustomerCode);
		    				flag=false;
	    				}
					});
				    
		    	}
		    return flag;
		}
		
		function funAddCustRow() 
		{
			var customerId = $("#txtCustCode").val();
			if(customerId=='')
		    {
		    	alert("Please select Customer Id");
		    	$("#txtCustCode").focus();
		    	return false;
		    }
		    var customerName = $("#lblCustomerName").val();
		   
		    
		    var table = document.getElementById("tblLocCust");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input type=\"text\" readonly=\"readonly\" style=\"border:1px solid #a2a2a2;padding:1px;\" class=\"Box\" name=\"listLocCust["+(rowCount)+"].strCustCode\" id=\"txtCustCode."+(rowCount)+"\" value="+customerId+">";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"38%\" name=\"listLocCust["+(rowCount)+"].strCustName\" id=\"lblCustomerName."+(rowCount)+"\" value='"+customerName+"'>";
		    row.insertCell(2).innerHTML= '<input type="button"  value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRowForCustomer(this)">';
		    funResetCustomerFields();
		    return false;
		}
		
		function funResetCustomerFields()
		{
			$("#txtSupplierId").val('');
		    $("#txtSupplierName").val('');
		    
		}
		
		function funDeleteRowForCustomer(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblLocCust");
		    table.deleteRow(index);
		}
		
		function funSetLocCustData(locCode)
		{
			searchUrl=getContextPath()+"/loadCustomerForLocationData.html?locCode="+locCode;
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	funRemLocCustRows();
				    	$.each(response, function(i,item)
				    	{
				    		
				    		if(response[i].strCustCode.startsWith("C"))
				    				{
				    			     funAddCustRow1(response[i].strCustCode,response[i].strCustName);  
				    				}
				    		
				    	});
				    	funRemLocSuppRows();
				    	$.each(response, function(i,item)
				    	{
				    		if(response[i].strCustCode.startsWith("S"))
		    				{
				    			funAddSuppRow1(response[i].strCustCode,response[i].strCustName);
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
		function funRemLocCustRows()
	    {
		$('#tblLocCust tbody > tr').remove();
	    }
		
		function funAddCustRow1(customerId,customerName) 
		{
		    var table = document.getElementById("tblLocCust");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    row.insertCell(0).innerHTML= "<input type=\"text\" readonly=\"readonly\" style=\"border:1px solid #a2a2a2;padding:1px;\" class=\"Box\" name=\"listLocCust["+(rowCount)+"].strCustCode\" id=\"txtCustCode."+(rowCount)+"\" value="+customerId+">";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"38%\" name=\"listLocCust["+(rowCount)+"].strCustName\" id=\"lblCustomerName."+(rowCount)+"\" value='"+customerName+"'>";
		    row.insertCell(2).innerHTML= '<input type="button"  value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRowForCustomer(this)">';
		    
		    return false;
		}
		
		function btnCust_Click()
	    {
	    	var searchUrl = "";
			searchUrl = getContextPath()+ "/loadAllCustomer.html";
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				beforeSend : function(){
					 $("#wait").css("display","block");
			    },
			    complete: function(){
			    	 $("#wait").css("display","none");
			    },
				success : function(response) {
					if (response.strPCode == 'Invalid Code') {
						alert("Invalid Customer Code");
						
					} else
					{
						$.each(response, function(i,item)
						 		{
							funAddCustRow1(response[i].strPCode,response[i].strPName);
								});
						
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
		
		
		
		function btnSupp_Click()
	    {
	    	var searchUrl = "";
			searchUrl = getContextPath()+ "/loadAllSupplier.html";
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				beforeSend : function(){
					 $("#wait").css("display","block");
			    },
			    complete: function(){
			    	 $("#wait").css("display","none");
			    },
				success : function(response) {
					if (response.strPCode == 'Invalid Code') {
						alert("Invalid Customer Code");
						
					} else
					{
						$.each(response, function(i,item)
						 		{
							funAddSuppRow1(response[i].strPCode,response[i].strPName);
								});
						
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
		
		
		function funRemLocSuppRows()
	    {
		$('#tblLocSupp tbody > tr').remove();
	    }
		
		
		
		function funAddSuppRow1(supplierId,supplierName) 
		{
		    var table = document.getElementById("tblLocSupp");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    row.insertCell(0).innerHTML= "<input type=\"text\" readonly=\"readonly\" style=\"border:1px solid #a2a2a2;padding:1px;\" class=\"Box\" name=\"listLocSupp["+(rowCount)+"].strCustCode\" id=\"txtCustCode."+(rowCount)+"\" value="+supplierId+">";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"38%\" name=\"listLocSupp["+(rowCount)+"].strCustName\" id=\"lblCustomerName."+(rowCount)+"\" value='"+supplierName+"'>";
		    row.insertCell(2).innerHTML= '<input type="button"  value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRowForSupplier(this)">';
		    
		    return false;
		}
		
		function funSetSupplier(code)
		{
			gurl=getContextPath()+"/loadSupplierMasterData.html?partyCode=";
			$.ajax({
		        type: "GET",
		        url: gurl+code,
		        dataType: "json",
		        success: function(response)
		        {		        	
		        		if('Invalid Code' == response.strPCode){
		        			alert("Invalid Customer Code");
		        			$("#txtSuppCode").val('');
		        			$("#txtSuppCode").focus();
		        			$("#lblSuppName").text('');
		        		}else{			   
		        			$("#txtSuppCode").val(response.strPCode);
							$("#lblSuppName").val(response.strPName);
							
						
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
		
		function btnSupplierAdd_onclick() 
	    {	
			var strSuppCode=$("#txtSuppCode").val();
		   	 if(funDuplicateSupplier(strSuppCode))
			 {
		   		funAddSuppRow();
			 }
	    }
		
		
		
		function funAddSuppRow() 
		{
			var supplierId = $("#txtSuppCode").val();
			if(supplierId=='')
		    {
		    	alert("Please select Supplier Id");
		    	$("#txtSuppCode").focus();
		    	return false;
		    }
		    var supplierrName = $("#lblSuppName").val();
		   
		    
		    var table = document.getElementById("tblLocSupp");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input type=\"text\" readonly=\"readonly\" style=\"border:1px solid #a2a2a2;padding:1px;\" class=\"Box\" name=\"listLocSupp["+(rowCount)+"].strCustCode\" id=\"txtCustCode."+(rowCount)+"\" value="+supplierId+">";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"38%\" name=\"listLocSupp["+(rowCount)+"].strCustName\" id=\"lblCustomerName."+(rowCount)+"\" value='"+supplierrName+"'>";
		    row.insertCell(2).innerHTML= '<input type="button"  value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRowForSupplier(this)">';
		    funResetSupplierFields();
		    return false;
		}
		
		function funResetSupplierFields()
		{
			$("#txtSuppCode").val('');
		    $("#lblSuppName").val('');
		    
		}
		
		function funDeleteRowForSupplier(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblLocSupp");
		    table.deleteRow(index);
		}
		
		function funDuplicateSupplier(strSuppCode)
		{
		    var table = document.getElementById("tblLocSupp");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    	{
				    $('#tblLocSupp tr').each(function()
				    {
					    if(strSuppCode==$(this).find('input').val())// `this` is TR DOM element
	    				{
					    	alert("Supplier Allready added "+ strSuppCode);
		    				flag=false;
	    				}
					});
				    
		    	}
		    return flag;
		}
	    		 
	</script>

</head>
<body>
<div class="container">
		<label id="formHeading">Location Master</label>

		<s:form name="locationForm" method="POST" action="saveLocationMaster.html?saddr=${urlHits}">
		<br />
		<input type="hidden" name="saddr" value="${urlHits}">
		<div id="tab_container" class="masterTable">
			<ul class="tabs">
				<li class="active" data-state="tab1">General</li>
				<li data-state="tab2">ReOrdel Level</li>
				<li data-state="tab3">Linkup</li>
				<li data-state="tab4">Customer</li>
				<li data-state="tab5">Supplier</li>
			</ul>
			<div id="tab1" class="tab_content" style="height: 300px; margin-top: 46px;">
				<div class="row masterTable">
					<!--  <a id="baseUrl" href="#"> Attach Documents</a> -->
					<div class="col-md-2">
				        <label>Location Code </label>
				        <s:input id="txtLocCode" name="txtLocCode" path="strLocCode" readOnly="true" ondblclick="funHelp('locationmaster')"  cssClass="searchTextBox"/>
				    </div>
				    <div class="col-md-3">
				     	<label>Location Name</label>
				        <s:input type="text" id="txtlocName" name="txtlocName" size="80px"  path="strLocName" cssStyle="text-transform: uppercase;" required="true"/>
				        <s:errors path="strLocName"></s:errors>
				    </div>  
				    <div class="col-md-2">
					 	<label>Description</label>
					   	<s:input id="txtLocDesc" size="80px" name="txtLocDesc" path="strLocDesc" autocomplete="off" cssStyle="text-transform: uppercase;" />
					    <s:errors path="strLocDesc"></s:errors>
					 </div>
					  <div class="col-md-4"></div>
					 <div class="col-md-2">
					    <label>Property Code</label>
					    <s:input id="txtPropertyCode" readOnly="true" name="txtPropertyCode" path="strPropertyCode" readonly="true"  cssClass="searchTextBox" ondblclick="funHelp('property');"/>
					    <s:errors path="strPropertyCode"></s:errors>
					 </div>
					 <div class="col-md-3">  
					    <label id="lblPropertyName" class="namelebel" style="background-color:#dcdada94; width: 100%; height: 51%; margin-top: 26px; text-align: center;"></label>
					 </div>  
					   <!--  <td><label id="lblPropertyName"></label></td> -->
					 <div class="col-md-2">  
					  	<label>Excise No</label>
					   	<s:input id="txtExciseNo" name="txtExciseNo" path="strExciseNo" cssClass="BoxW116px" />
					    <s:errors path="strExciseNo"></s:errors>
					 </div>
					 <div class="col-md-5"></div>
					 <div class="col-md-2">  
					  	 <label>External Code</label>
						 <s:input id="txtExternalCode" name="txtExternalCode" path="strExternalCode"  autocomplete="off" cssClass="BoxW116px"/>
						 <s:errors path="strExternalCode"></s:errors>
					 </div>
					 <div class="col-md-2">  
					   	<label>Available for Sale</label><br>
						<s:checkbox id="chkAvlForSale" name="chkAvlForSale" path="strAvlForSale" value="" />
						<s:errors path="strAvlForSale"></s:errors>
					 </div>
					 <div class="col-md-1">  
					  	<label>Active</label><br>
						<s:checkbox id="chkActive" name="chkActive" path="strActive" value="" />
						<s:errors path="strActive"></s:errors>
					 </div>
					 <div class="col-md-1">  
					  	 <label>Receivable</label><br>
						 <s:checkbox id="chkReceivable" name="chkReceivable" path="strReceivable" value="" />
						 <s:errors path="strReceivable"></s:errors>
					 </div>	 
					 <div class="col-md-1">  
					     <label>Pickable</label><br>
						 <s:checkbox id="chkPickable" name="chkPickable" path="strPickable" value=""  />
						 <s:errors path="strPickable"></s:errors>
					 </div>
					 <div class="col-md-5"></div>
					 <div class="col-md-2">	     
				    		<label>Under Location </label>
				       		<s:input id="txtUnderLocCode" name="txtUnderLocCode" path="strUnderLocCode" ondblclick="funHelp('underlocationmaster')" readOnly="true" cssClass="searchTextBox"/>
				  	 </div>
				  	 <div class="col-md-3">	
				        <label id="lblUnderlocName" class="namelebel" style="background-color:#dcdada94; width: 100%; height: 51%; margin-top: 26px; text-align: center;"></label>
				     </div>
				     <div class="col-md-2">
					  	 <label>Type </label>
					     <s:select id="cmbType" name="cmbType" path="strType" items="${listType}" cssClass="BoxW124px" />
					</div> 
					 <div class="col-md-5"></div>
				     <div class="col-md-2">	
						<label>Month End Date</label>
						<s:input id="txtMonthEnd" path="strMonthEnd" required="true" readonly="true" class="BoxW116px" />
					</div>  
					
				</div>
			</div>
			<div id="tab2" class="tab_content" style="height: 400px">
				<div class="row transTable">
				 	<div class="col-md-2">	
						<a onclick="return funOpenExportImport()" href="javascript:void(0);">Export/Import</a>
					</div>
					<div class="col-md-2">
				        <label>Like Location Code </label>
				        <s:input id="txtLocCode1" name="txtLocCode1" path="strLocCode1" readOnly="true" ondblclick="funHelp('locationmaster')"  cssClass="searchTextBox"/>
				    </div>
				    <div class="col-md-3">
				     	<label>Like Location Name</label>
				        <s:input type="text" id="txtlocName1" name="txtlocName1" size="80px"  path="strLocName1" cssStyle="text-transform: uppercase;" required="true"/>
				        <s:errors path="strLocName1"></s:errors>
				    </div> <div class="col-md-1"> 
				</div>
				<br>
					<table class="masterTable" style="width:70%; background:#c0c0c0;">
						<tr>
							<th style="width: 11%"><label>Product Code</label></th>
							<th style="width: 30%"><label>Product Name</label></th>
							<th style="width: 11%"><label>Reorder Level</label></th>
							<th style="width: 13%"><label>Reorder Qty</label></th>
							<th style="width: 11%"><label>Price</label></th>
							<th style="width: 11%"><label>Delete</label></th>									
						</tr>	
					</table>
					<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 291px;width:70%; overflow-x: hidden; overflow-y: scroll;">
						<table id="tblProdDet" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col5-center">
							<tbody>
								<col style="width: 3%"><!-- col1   -->
								<col style="width: 12%"><!-- col2   -->
								<col style="width: 5%"><!-- col3   -->
								<col style="width: 5%"><!-- col4   -->
								<col style="width: 5%"><!-- col5   -->
								<col style="width: 4%">	<!-- col6   -->
							
							</table>
					</div>
				</div>
				<div id="tab3" class="tab_content"><br>
					<div class="row transTable">
						<div class="col-md-2">	
							<label>Account Code</label>
							<s:input id="txtAcCode"   path="strAcCode" ondblclick="funHelp('SundryDebtorWeb-Service')"  cssClass="searchTextBox"/> 
						</div>
						<div class="col-md-2">
							<label>Account Name</label> 
							<s:input id="txtAcName"   path="strAcName" class="BoxW116px"/>
						</div>
					</div>
				</div>
				
				<div id="tab4" class="tab_content"><br>
				<div class="row transTable">
						
				<div class="col-md-2"><label>Customer ID</label>
					<input type="text" id="txtCustCode" name="customerId" ondblclick="funHelp('customerMaster')"  class="searchTextBox"/>
			    </div>
			    
				<div class="col-md-3"><label>Customer Name</label>
					<input type="text" id="lblCustomerName" class="namelabel" name="customerName" style="width: 110%;" readonly="readonly"/>
				</div>     
				 <div class="col-md-2"><br><input id="btnAddCustomer" type="button" class="btn btn-primary center-block" value="Add" onclick="return btnCustomerAdd_onclick()" class="smallButton"/>
				</div>	
				
				 <div class="col-md-2">	      <br>  			
				 <input id="btnAddAllCust" type="button" value="Add All Customer" onclick="return btnCust_Click()" class="btn btn-primary center-block"
				   style="height:30px;width :100%" ></input>
			    </div>
					     
				</div>
				
					<div class="dynamicTableContainer" >
					<table  style="height:20px;border:#0F0;width:100%;font-size:11px;font-weight: bold;">	
		
							<tr bgcolor="#c0c0c0" >
							<td width="4%">Customer Code</td><!--  COl1   -->
							<td width="15%">Customer Name</td><!--  COl2   -->
							<td width="4%">Delete</td><!--  COl3   -->
		
							</tr>
						</table>
						
				  <div style="background-color:#fafbfb;border: 1px solid #ccc;display: block;height: 150px;
					    margin: auto;overflow-x: hidden;overflow-y: scroll;width: 100%;">
					 <table id="tblLocCust" style="width:100%;border:
						#0F0;table-layout:fixed;overflow:scroll" class="transTablex ">
							<tbody>    
							<col style="width:4.5%"><!--  COl1   -->
							<col style="width:14.5%"><!--  COl2   -->
							<col style="width:3%"><!--  COl3   -->
					
							</tbody>
							</table>
							</div>
						
						</div>
			   
				</div>
				<div id="tab5" class="tab_content"><br>
				<div class="row transTable">
						
				<div class="col-md-2"><label>Supplier ID</label>
					<input type="text" id="txtSuppCode" name="customerId" ondblclick="funHelp('suppcode')"  class="searchTextBox"/>
			    </div>
			    
				<div class="col-md-3"><label>Supplier Name</label>
					<input type="text" id="lblSuppName" class="namelabel" name="customerName" style="width: 110%;" readonly="readonly"/>
				</div>     
				 <div class="col-md-2"><br><input id="btnAddSupplier" type="button" class="btn btn-primary center-block" value="Add" onclick="return btnSupplierAdd_onclick()" class="smallButton"/>
				</div>	
				
				 <div class="col-md-2">	      <br>  			
				 <input id="btnAddAllSupp" type="button" value="Add All Supplier" onclick="return btnSupp_Click()" class="btn btn-primary center-block"
				   style="height:30px;width :100%" ></input>
			    </div>
					     
				</div>
				
					<div class="dynamicTableContainer" >
					<table  style="height:20px;border:#0F0;width:100%;font-size:11px;font-weight: bold;">	
		
							<tr bgcolor="#c0c0c0" >
							<td width="4%">Supplier Code</td><!--  COl1   -->
							<td width="15%">Supplier Name</td><!--  COl2   -->
							<td width="4%">Delete</td><!--  COl3   -->
		
							</tr>
						</table>
						
				  <div style="background-color:#fafbfb;border: 1px solid #ccc;display: block;height: 150px;
					    margin: auto;overflow-x: hidden;overflow-y: scroll;width: 100%;">
					 <table id="tblLocSupp" style="width:100%;border:
						#0F0;table-layout:fixed;overflow:scroll" class="transTablex ">
							<tbody>    
							<col style="width:4.5%"><!--  COl1   -->
							<col style="width:14.5%"><!--  COl2   -->
							<col style="width:3%"><!--  COl3   -->
					
							</tbody>
							</table>
							</div>
						
						</div>
			   
				</div>
			</div>
		<br />
		<div class="center" style="text-align:center;">
		   <a href="#"><button class="btn btn-primary center-block"  value="Submit" onclick="return funCallFormAction('submit',this);">Submit</button></a>
		   &nbsp;
		   <a href="#"><button class="btn btn-primary center-block"  value="reset" onclick="funResetFields()">Reset</button></a>
		</div>
		
		<div id="wait"
			style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
			<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif"
				width="60px" height="60px" />
		</div>
		<br><br>
	</s:form>
	</div>
</body>
</html>
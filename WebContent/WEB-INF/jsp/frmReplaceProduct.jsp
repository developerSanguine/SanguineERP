<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	
	    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />

		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	
<title>REPLACE RECIPE PRODUCT</title>
<style>
#lblFormName  {
	font-family: 'trebuchet ms';
	font-size: 20px;
	color: #646777;
	font-weight: bold;
	padding:0px;
}
</style>

<script type="text/javascript">
				
		var fieldName,listRow=0; 
	
		 $(document).ready(function () 
		 {
			 $("#lblFormName").text("Replace Receipe Product");
		    	
			 if($("#txtFromDate").val()=='')
			 {
			 $( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			 $("#txtFromDate" ).datepicker('setDate', 'today');
			 }
			 //To Set ToDate By Default
			 var date=$("#txtFromDate").val().split('-');
			 var year=parseFloat(date[2])+parseFloat(100);
			 var todate=date[0]+"-"+date[1]+"-"+year;
			 $( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			 $("#txtToDate" ).datepicker('setDate', todate);
			/*  if($("#txtToDate").val()=='')
			 {
			 $( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			 $("#txtToDate" ).datepicker('setDate', 'today');
			 } */
			 $(document).ajaxStart(function(){
				    $("#wait").css("display","block");
				  });
				  $(document).ajaxComplete(function(){
				    $("#wait").css("display","none");
				  });
				  
				  $("#chkReceipeALL").click(function ()
					{
					    $(".SuppCheckBoxClass").prop('checked', $(this).prop('checked'));
					});	  
			 
		});
		
		function funResetFields()
		{
			location.reload(true); 	
	    }
		
		function funHelp(transactionName)
		{
			fieldName=transactionName;
			if(transactionName=='childcode')
			{
				if($("#txtParentCode").val()=='')
				{
					alert('Please Select parent item Code');
					return false;
				}
						
			}
	          window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;dialogLeft:300px;")
		}
		
	 	
		
		function funSetChild(code)
		{
			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
			
			$.ajax({
		        type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strProdCode!="Invalid Code")
		        		{
				        	$("#txtChildCode").val(response.strProdCode);	        		
			        		$("#lblItemName").text(response.strProdName);
			        		
		        		}
		        	else
		        		{
		        			alert("Invalid Child Code");
		        			$("#txtChildCode").val('');
		        			$("#txtChildCode").focus();
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
		
		function funSetReplaceChild(code)
		{
			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
			$.ajax({
		        type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strProdCode!="Invalid Code")
		        		{
				        	$("#txtReplaceCode").val(response.strProdCode);	        		
			        		$("#lblReplaceItemName").text(response.strProdName);
			        		
		        		}
		        	else
		        		{
		        			alert("Invalid Child Code");
		        			$("#txtReplaceCode").val('');
		        			$("#txtReplaceCode").focus();
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
		
		
		function funSetProduct(code)
		{
			searchUrl=getContextPath()+"/loadProductData.html?prodCode="+code;
			//alert(searchUrl);
			$.ajax({
		        type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strParentCode!="Invalid Product Code")
		        		{
		        		
		        			if(response.strBOMCode.length>0)
		        				{
		        					alert("BOM already created :"+response.strBOMCode);
		        				}else
		        					{
		        					$("#txtParentCode").val(response.strParentCode);
					        		$("#txtParentCodeName").val(response.strParentName);
					        		$("#txtPOSItemCode").val(response.strPartNo);
					        		$("#txtType").val(response.strProdType);
					        		$("#txtSGCode").val(response.strSGCode);
					        		$("#txtSGName").val(response.strSGName);			        		
					        		$("#cmbProcessName").val(response.strProcessName);
					        		$("#txtUOM").val(response.strUOM);
					        		//$("#txtParentQty").focus();
					        		funGetImage(code);
		        					}
		        		
				        	
		        		}
		        	else
		        		{
		        			alert("Invalid Parent Product Code");
		        			$("#txtParentCode").val("");
		        			$("#txtParentCode").focus();
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
		
		
		function funSetData(code)
		{			
			switch (fieldName) 
			{			   
			  
			   case 'replacecode':
			    	funSetChild(code);
			        break;
			        
			   case 'replacechildcode':
			    	funSetReplaceChild(code);
			        break;     
			        
			  
			}
		}
		
		
		 
		
		 
		
		
		function funResetProductFields()
		{
			$("#txtChildCode").val('');
		    $("#txtQty").val('');
		    document.getElementById("lblUOM").innerHTML='';
		    document.getElementById("lblItemName").innerHTML='';
		   
		}
		
		
		function funValidateFields() {
			if (!fun_isDate($("#txtFromDate").val())) {
				alert('Invalid Date');
				$("#txtFromDate").focus();
				return false;
			}
			if (!fun_isDate($("#txtToDate").val())) {
				alert('Invalid Date');
				$("#txtToDate").focus();
				return false;
			}

			var table = document.getElementById("tblChild");
			var rowCount = table.rows.length;
			if (rowCount == 0) {
				alert('Please Add Child Products');
				return false;
			}else {
				return true;
			}

		}
		$(function()
		{
			$('#txtChildCode').blur(function ()
			{
				var code=$("#txtChildCode").val();
				if (code.trim().length > 0 && code !="?" && code !="/")
				{					   
					funSetChild(code);
				}
			});
			$('#txtParentCode').blur(function ()
			{
				var code=$('#txtParentCode').val();			
				if (code.trim().length > 0 && code !="?" && code !="/")
				{
					
					funSetProduct(code);
				}
			});
		});
		
		
		function funApplyNumberValidation(){
			$(".numeric").numeric();
			$(".integer").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
			$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
			$(".positive-integer").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
		    $(".decimal-places").numeric({ decimalPlaces: maxQuantityDecimalPlaceLimit,negative: false});
		}
		
		
		
		$(function()
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
		
		function funRemoveProductRows()
		{
			var table = document.getElementById("tblChild");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		
		
		function btnExecute_onclick() 
	    {
			var strProdCode=$("#txtChildCode").val();
			
			if($("#txtChildCode").val().trim().length == 0 && document.getElementById("lblItemName").innerHTML.trim().length == 0){
				alert("Please Enter Product Code Or Search");
				$("#txtChildCode").focus()
				 return false;
			}
			funGetReceipes() ;
		}
		
		
		function funGetReceipes()
		{
			var strProdCode=$("#txtChildCode").val();
			searchUrl=getContextPath()+"/loadProductReceipeData.html?prodCode="+strProdCode;
			//alert(searchUrl);
			$.ajax({
		        type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        success: function(response)
		        {
		        	funRemProdRows();
		        	var listdata=response.listReplaceProduct
					var count=0;
					$.each(listdata, function(i, item) {
						count=i;
						funAddProduct(listdata[i].strBOMCode,listdata[i].strParentCode,listdata[i].strParentName,listdata[i].dblQty,listdata[i].strUOM,listdata[i].dblYieldPer,listdata[i].dtValidFrom,listdata[i].dtValidTo);
						
					});
					listRow=count+1;
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
		
		function funAddProduct(strBOMCode,strParentCode,strParentName,dblQty,strUOM,dblYieldPer,dtValidFrom,dtValidTo)
		{
			
			 	
			      var table = document.getElementById("tblChild");
			      var rowCount = table.rows.length;
			      var row = table.insertRow(rowCount);
			     
			      
		        row.insertCell(0).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].strBOMCode\" readonly=\"readonly\"  class=\"Box\" size=\"15%\" id=\"strBOMCode."+(rowCount)+"\" value='"+strBOMCode+"'>";		    
			    row.insertCell(1).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].strParentCode\" readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"strParentCode."+(rowCount)+"\" value='"+strParentCode+"'>";
			    row.insertCell(2).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].strParentName\" readonly=\"readonly\"   size=\"48%\" class=\"Box\" id=\"strParentName."+(rowCount)+"\" value='"+strParentName+"'>";
			    row.insertCell(3).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].dblQty\"  style=\"text-align: right;\" id=\"dblQty."+(rowCount)+"\" readonly=\"readonly\"  size=\"10%\" class=\"Box\" value="+dblQty+">";
			    row.insertCell(4).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].strUOM\" readonly=\"readonly\"  class=\"Box\" size=\"11%\" id=\"strUOM."+(rowCount)+"\" value='"+strUOM+"'>";
			    row.insertCell(5).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].dblYieldPer\"  style=\"text-align: right;\" id=\"dblYieldPer."+(rowCount)+"\" readonly=\"readonly\"   size=\"11%\" class=\"Box\" value="+dblYieldPer+">";		    	   
			    row.insertCell(6).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].dtValidFrom\" id=\"dtValidFrom."+(rowCount)+"\" readonly=\"readonly\"  size=\"11%\" class=\"Box\" value="+dtValidFrom+">";
			    row.insertCell(7).innerHTML= "<input name=\"listReplaceProduct["+(rowCount)+"].dtValidTo\" id=\"dtValidTo."+(rowCount)+"\" readonly=\"readonly\" size=\"11%\" class=\"Box\" value="+dtValidTo+">";
			   // row.insertCell(8).innerHTML= "<input readonly=\"readonly\" type=\"checkbox\"  class=\"Box \"  style=\"padding-left: 5px;width: 100%;\" name=\"listReplaceProduct["+(rowCount)+"].strRecipeSelected\" onClick=\"Javacsript:funCheckRecipeSelected("+rowCount+")\"  id=\"strRecipeSelected."+rowCount+"\" value='N' >";
			    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" type=\"checkbox\"  class=\"Box \"  style=\"padding-left: 5px;width: 100%;\" name=\"listReplaceProduct["+(rowCount)+"].strRecipeSelected\" onClick=\"Javacsript:funCheckRecipeSelected("+rowCount+")\"  id=\"strRecipeSelected."+rowCount+"\" >";
			    listRow++;
			    return false;
			 	
		}
		
		
		function funCheckRecipeSelected(count)
		{
			
			var no=0;
			$('#tblChild tr').each(function() {
				
				if(document.getElementById("strRecipeSelected."+no).checked == true)
				{
					document.getElementById("strRecipeSelected."+no).value='Y';
				}
				else
				{
				 document.getElementById("strRecipeSelected."+no).value='N';
				}
				no++;
			});

			
			
		}
		
		
		function funRemProdRows()
		{
			var table = document.getElementById("tblChild");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		function funCheckboxAllRecipe()
		{
			var table = document.getElementById("tblChild");
			var rowCount = table.rows.length;	
			if ($('#chkReceipeALL').is(":checked"))
			{
			 	//check all			
				for(var i=0;i<rowCount;i++)
				{		
					document.getElementById("strRecipeSelected."+i).checked=1;
		    	}
			}
			else
			{				
				for(var i=0;i<rowCount;i++)
				{		
					document.getElementById("strRecipeSelected."+i).checked=0;
		    	}			
			}	   
		}
		
	</script>
</head>

<body id="bodyMain">
	<div class="container">
		<!-- <label>Recipe Master</label> -->
		<label id="lblFormName"></label>
	
		<s:form name="recipeForm" method="POST" action="saveReplaceRecipeProductInMaster.html?saddr=${urlHits}">
		<input type="hidden" value="${urlHits}" name="saddr">
		
			<div class="row transTable">
							<div class="col-md-2">
								<label>Product Code</label>
								<s:input id="txtChildCode" required="true" path="strChildCode" ondblclick="funHelp('replacecode')" class="searchTextBox" style="height: 25px;"/></input>
							</div>
							<div class="col-md-2">
								<label id="lblItemName" style="background-color:#dcdada94; width: 100%; height: 51%;margin-top: 26px;text-align: center;"></label>
							</div>
							
							<div class="col-md-2">
							<br> <input id="btnExecute" type="button" value="Execute"
								onclick="return btnExecute_onclick();"
								class="btn btn-primary center-block">
							</input></div>
					</div>
					<div class="row">
					</div>
					
					
			
					<div class="dynamicTableContainer"  style="height: 400px">
						<table style="height:20px;border:#0F0;width:100%;font-size:11px;">
							<tr bgcolor="#c0c0c0" >
							   
								<td width="4%">BOM Code</td><!--  COl1   -->				
								<td width="4%">Parent Product</td><!--  COl2   -->
								<td width="11%">Product Name</td><!--  COl3   -->
								<td width="3%">Qty</td><!--  COl4   -->
								<td width="3%">UOM</td><!--  COl5   -->
								<td width="3%">Yeild Per</td><!--  COl6   -->
								<td width="3%">From Date</td><!--  COl7   -->
								<td width="3%">To Date</td><!--  COl8   -->
								<td width="2%" col align="left"><input type="checkbox" id="chkReceipeALL" onclick="funCheckboxAllRecipe()" />Select</td>
							    <!-- <td width="2%"><input type="checkbox" id="chkReceipeALL" />Select</td> -->
							    
								
							</tr>
						</table>
					<div style="background-color: #fbfafa;border: 1px solid #ccc; display: block; height: 360px;
					   	 margin: auto; overflow-x: hidden;  overflow-y: scroll; width: 100%;">
						<table id="tblChild" style="width:100%;border: #0F0;table-layout:fixed;overflow:scroll" class="transTablex col7-center">
						<tbody>
						    <col style="width:4%"><!--  COl1   -->		
							<col style="width:4%"><!--  COl2   -->
							<col style="width:11%"><!--  COl3   -->
							<col style="width:3%"><!--  COl4   -->
							<col style="width:3%"><!--  COl5   -->
							<col style="width:3%"><!--  COl6   -->
							<col style="width:3%"><!--  COl7   -->
							<col style="width:3%"><!--  COl8   -->
							<colgroup><col style="width: 5%"><!--  COl9   -->
						   <%--  <col style="width=2%"> --%><!--  COl9   -->
						</tbody>
					</table>
				</div>				
			</div>	
		
		<div class="row">
			<div class="col-md-2">
				<label>Replace Product Code</label>
				<s:input id="txtReplaceCode"  required="true" path="strReplaceChildCode" ondblclick="funHelp('replacechildcode')" class="searchTextBox" style="height: 25px;"/></input>
			</div>
			<div class="col-md-3">
				<label id="lblReplaceItemName" style="background-color:#dcdada94; width: 100%; height: 51%;margin-top: 26px;text-align: center;"></label>
			</div>
			
			<div class="col-md-2">
				<label>Date Valid From</label>	
				<s:input id="txtFromDate" required="true" name="txtDtFromDate" path="dtValidFrom" cssClass="calenderTextBox"/>
			</div>	
		  <div class="col-md-2">
				<s:label path="dtValidTo">Date Valid To</s:label>	
				<s:input id="txtToDate" required="true" name="txtToDate" path="dtValidTo" cssClass="calenderTextBox" />					    
		 </div>
		</div>
		<div class="center" style="text-align: center">
		   <a href="#"><button class="btn btn-primary center-block" id="formsubmit"  value="Submit" onclick="return funValidateFields()">Submit</button></a>
		   <a href="#"><button class="btn btn-primary center-block" type="button"  value="Reset" onclick="funResetFields();">Reset</button></a>
		</div>
		<br><br>
		<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
			<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
		</div>
</s:form>
</div>

	<script type="text/javascript">funApplyNumberValidation();</script>
</body>
</html>
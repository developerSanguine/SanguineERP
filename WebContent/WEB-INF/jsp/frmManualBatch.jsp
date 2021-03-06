<%@ page language="java" contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
       <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
       <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
        <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>	
<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
	
<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" /> 	
 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/jquery-ui.css"/>" />
<title>Web Stocks</title>

<script type="text/javascript">

	/**
	 * Getting Session value(Quantity Decimal Place and Amount Decimal Place)
	 */
	var maxQuantityDecimalPlaceLimit=parseInt('<%=session.getAttribute("qtyDecPlace").toString()%>');
	var maxAmountDecimalPlaceLimit=parseInt('<%=session.getAttribute("amtDecPlace").toString()%>');
	
	var RowNo="";
	var str=null;
	
	/**
	 *	Get Project path
	**/
	function getContextPath() 
	{
		return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	}
	
	/**
	 *	Get Data when Form is loading
	**/
	function funOnLoad()
	{
		strMISCode='<%=request.getParameter("rptMISCode") %>'
		<%-- strMISCode='<%=session.getAttribute("rptMISCode").toString()%>'; --%>
		$("#txtMISCode").val(strMISCode);
		'<%session.removeAttribute("BatchList");%>'
	}
	
	/**
	 * 	Open Product Batch Help Form
	**/
	function funHelp(transactionName,index)
	{
		RowNo=index;
		fieldName = transactionName;
		
		var prodcode="";
		if("Batch"==transactionName)
		{
			transactionName="ProdBatchCode";
			if(document.all("txtProdCode."+RowNo).value!="")
			{
				prodcode=document.all("txtProdCode."+RowNo).value;
			}
			
		}
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=&prodCode="+prodcode,"","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		window.open("searchform.html?formname="+transactionName+"&searchText=&prodCode="+prodcode,"","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	}
	
	/**
	 * 	Open MIS Product Help Form
	**/
	function funHelp1(transactionName)
	{
		fieldName = transactionName;
		RowNo=index;
		var prodcode="";
		var strMISCode=$("#txtMISCode").val();
		if("ProdBatchCode"==transactionName)
		{
			if($("#txtProdcode").val()!="")
			{
				prodcode=$("#txtProdcode").val();
			}
			else
			{
				alert("Please Select Product");
				$("#txtProdcode").focus();
				return false;
			}
			
		}
		
		//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=&prodCode="+prodcode+"&MISCode="+strMISCode,"","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=&prodCode="+prodcode+"&MISCode="+strMISCode,"","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}

	/**
	 * Get and Set Data from Help Form
	**/
	function funSetData(code)
	{
		//alert(code);
		switch (fieldName)
		{
		    case 'Batch':
		    	funBatchData(code);
		        break;
		    case 'BatchHelpForMIS':
		    	funGetMISProductData(code);
		    	break;
		    case 'ProdBatchCode':
		    	funProdBatchData(code);
		        break;
		}
	}
	
	/**
	 * 	Get Product Data Passing Value(Product Code)
	**/
	function funGetMISProductData(code)
	{
		var searchUrl="";		
		searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
		$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",			   
			    success: function(response)
			    {
			    	if('Invalid Code' == response.strProdCode){
			    		alert('Invalid Product Code');
				    	$("#txtProdcode").val('');
				    	$("#spProdName").text('');
				    	$("#txtProdCode").focus();
			    	}else
			    	{
			    		
				    	$("#txtProdcode").val(response.strProdCode);
				    	$("#spProdName").text(response.strProdName);
				    	document.all("txtBatchCode").focus();
			    	}
			    },
				error: function(e)
			    {
			       	alert('Invalid Product Code');
			       	$("#txtProdCode").val('');
			    	$("#spProdName").text('');
			    	document.all("txtProdCode").focus();
			    }
		      });
	}
	
	/**
	 * 	Get and Set Batch Code Passing value(Batch Code)
	**/
	function funProdBatchData(code)
	{
		var searchUrl="";
		searchUrl=getContextPath()+"/loadBatchData.html?BatchCode="+code;
		//alert(searchUrl);
		$.ajax({
			 type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	document.all("txtBatchCode").value=code;
			    	document.all("dtExpDate").value=response.dtExpiryDate ;
			    	document.all("txtManuCode").value=response.strManuBatchCode;
			    	document.all("txtTransCode").value=response.strTransCode;
			    	document.all("txtBatchQty").value=response.dblPendingQty; 
			    	document.all("txtQty").focus();
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
	 * 	Get and Set Batch Code Passing value(Batch Code)
	**/
	function funBatchData(code)
	{
		var searchUrl="";
		searchUrl=getContextPath()+"/loadBatchData.html?BatchCode="+code;
		$.ajax({
			 type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	document.getElementById("txtBatchCode."+RowNo).value=code;
			    	document.getElementById("txtExpiryDate."+RowNo).value=response.dtExpiryDate ;
			    	document.getElementById("txtManuBatchCode."+RowNo).value=response.strManuBatchCode;
			    	document.getElementById("txtBatchQty."+RowNo).value=(response.dblQty).toFixed(maxQuantityDecimalPlaceLimit);
			    	var dblMISQty= document.getElementById("txtQty."+RowNo).value;
			    	var balQty=parseFloat(response.dblQty)-parseFloat(dblMISQty);
			    	document.getElementById("txtBalQty."+RowNo).value=balQty.toFixed(maxQuantityDecimalPlaceLimit);
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
	 * 	Check validation When User Add Records in Grid
	**/
	function btnAdd_onclick() 
	{	    
		if($("#txtProdcode").val().length<=0)
		{
			$("#txtProdcode").focus();
			alert("Please Enter Product Code Or Search");
			return false;
		}	
		if($("#txtBatchCode").val().length<=0)
		{
			$("#txtBatchCode").focus();
			alert("Please Enter Batch Code Or Search");
			return false;
		}	
		
	    if($("#txtQty").val().trim().length==0 || $("#txtQty").val()== 0)
	        {		
	          alert("Please Enter Quantity");
	          $("#txtQty").focus();
	          return false;
	       } 
	    var dblQty=parseFloat($("#txtQty").val());
	    var dblBatchQty= parseFloat($("#txtBatchQty").val());
	    if(dblQty > dblBatchQty)
	    	{
	    		alert("Quantity > Batch Qty");
	    		$("#txtQty").focus();
	    		return false;
	    	}
	    else
	    	{
	    	    var strProdCode=$("#txtProdCode").val();
	    		funAddProductRow();
	    		 
	    	}
	}
	
	/**
	 * 	Insert Record in Grid
	**/
	function funAddProductRow() 
	{			
		var strProdCode =$("#txtProdcode").val().trim();
		var strProdName=$("#spProdName").text();
	    var dblProdQty = $("#txtQty").val();
	    var dbBatchQty = $("#txtBatchQty").val();
	    var dblBalQty= dbBatchQty - dblProdQty;
	    
	    var dtExpDate=$("#dtExpDate").val();
	    var strBatchCode=$("#txtBatchCode").val();
	    var strManuCode=$("#txtManuCode").val();
	   
	    
	    var table = document.getElementById("tblBatch");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"5%\" name=\"listBatchDtl["+(rowCount)+"].strProdCode\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"33%\" name=\"listBatchDtl["+(rowCount)+"].strProdName\" id=\"strProdName."+(rowCount)+"\" value='"+strProdName+"' />";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" required=\"required\" style=\"text-align: right;\" size=\"6%\" name=\"listBatchDtl["+(rowCount)+"].dblQty\" id=\"txtQty."+(rowCount)+"\" value='"+dblProdQty+"' onblur=\"Javacsript:funCheckIssueQty(this)\" >";		    
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" style=\"text-align: right;\" class=\"Box\" size=\"6%\"  id=\"txtBatchQty."+(rowCount)+"\" value='"+dbBatchQty+"'/>";
	    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"6%\" style=\"text-align: right;\" class=\"decimal-places\" name=\"listMISDtl["+(rowCount)+"].dblPendingQty\" id=\"txtBalQty."+(rowCount)+"\" value="+dblBalQty+" >";		    
	    row.insertCell(5).innerHTML= "<input readonly=\"readonly\" required=\"required\" size=\"10%\"  class=\"Box\"  name=\"listBatchDtl["+(rowCount)+"].dtExpiryDate\" id=\"txtExpDate."+(rowCount)+"\" value='"+dtExpDate+"'/>";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" required=\"required\" size=\"13%\" name=\"listBatchDtl["+(rowCount)+"].strBatchCode\" id=\"txtBatchCode."+(rowCount)+"\" value='"+strBatchCode+"' ondblclick=\"funHelp('Batch',"+(rowCount)+")\"/>";
	    row.insertCell(7).innerHTML= "<input class=\"Box\"  readonly=\"readonly\" size=\"14%\" name=\"listBatchDtl["+(rowCount)+"].strManuBatchCode\" id=\"textManuCode."+(rowCount)+"\" value='"+strManuCode+"' />"; 
	    funClearProdData();
	}
	
	/**
	 * 	Validation Check Issue Qty 
	**/
	var index=0;
	function funCheckIssueQty(object)
	{
		
		index=object.parentNode.parentNode.rowIndex;
		var dblMISQty=document.all("txtQty."+index).value;
		var dblBatchQty=document.all("txtBatchQty."+index).value;
		if(dblBatchQty!=0)
			{
				if(parseFloat(dblMISQty) > parseFloat(dblBatchQty) )
				{
					document.all("txtQty."+index).value="";
				 	alert("Issue Quantity Can not be Greater than Batch Qty");
				 	return false;
				}
			}
			
	}
	
	/**
	 * 	Clear Data from TextField
	**/
	function funClearProdData()
	{
		document.all("txtBatchCode").value="";
		document.all("dtExpDate").value="";
		document.all("txtManuCode").value="";
		document.all("txtTransCode").value="";
		document.all("txtBatchQty").value=""; 
		document.all("txtProdcode").value="";
		document.all("txtQty").value="";
		document.all("txtProdcode").focus();
		
	}
	
	/**
	 * 	Submit Data and Display Message After Record Inserted in Data Base
	**/
	function btnSubmit_onclick() 
	{
				$.ajax({				
					 	type: "POST",
					    url: $("#frmManualBatch").attr("action"),
					    data:$("#frmManualBatch").serialize(),
					    async: false,
					    context: document.body,
					    dataType: "text",
					    success: function(response)
					    {	
								str=response;
								alert(str);
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
	
	/**
	 * 	Reset Form
	**/
	function funResetFields()
	{
		location.reload(true); 
	}

</script>

</head>
<body onload="funOnLoad();"  >
<div class="container">
<div style="width: 100%; height: 40px; background-color: #a2a2a2;">
		<p align="center" style="padding-top: 5px;color: white">Manual Batch</p>
	</div>

	<s:form id="frmManualBatch" name="frmManualBatch" method="POST" action="saveManualBatch.html" modelAttribute="setManualBatch" target="_self">
	<br>
			<div class="row transTable">
					<div class="col-md-2"><label>MIS Code</label>
				           <s:input path="strMISCode" id="txtMISCode" type="text"  disabled="disabled" />
					</div>
					
					<div class="col-md-2"><label>Product Code<label>
						<input id="txtProdcode" type="text" readonly="readonly" style="width:100%"  ondblclick="funHelp1('BatchHelpForMIS');" />
							<span class="spans" id="spProdName" ></span>
					</div>
				
					<div class="col-md-2"><label>Batch Code<label>
						<s:input id="txtBatchCode" path="strBatchCode" readonly="readonly" ondblclick="funHelp1('ProdBatchCode')"  type="text"/>
					</div>
				   	
				   	<div class="col-md-2"><label>Quantity<label>
				    	<input id="txtQty" type=text />
				    </div>
				    
				    <div class="col-md-4"></div>
				    
				    <div class="col-md-2"><label>Batch Qty<label>
				    	<input id="txtBatchQty" disabled="disabled" type=text />
				    </div>
					
					<div class="col-md-2"><label>Transaction Code<label>
						<input id="txtTransCode" disabled="disabled"  type="text"/>
					</div>
					
					<div class="col-md-2"><label>Expiry Date<label>
						 <input id="dtExpDate"  disabled="disabled" type="text" />
					</div> 
					
					<div class="col-md-2"><label>Manufacture Code<label>
					     <input type="text" id="txtManuCode" disabled="disabled" size="15"/>
					</div>     
					     
					<div class="col-md-2"><br><br>
					     <input id="btnAdd"  type="button" value="Add" class="btn btn-primary center-block"  class="smallButton" onclick="return btnAdd_onclick();" />
					</div>
					
			</div>
	<div class="dynamicTableContainer" style="height: 300px;">
							<table style="height:25px;border:#0F0;width:100%;font-size:11px;
								font-weight: bold;">	
								<tr style="background-color:#c0c0c0">
									<td style="width: 6%; height: 16px;" align="left">Product Code</td>
									<td style="width: 28%; height: 16px;" align="left">Product Name</td>
									<td style="width: 7%; height: 16px;" align="left">MIS Qty</td>
									<td style="width: 7%; height: 16px;" align="left">Batch Qty</td>
									<td style="width: 7%; height: 16px;" align="left">Bal Qty</td>
									<td style="width: 10%; height: 16px;" align="left">Expiry Date</td>
									<td style="width: 12%; height: 16px;" align="left">Batch Code</td>
									<td style="width: 15%; height: 16px;" align="left">Manufacture Batch Code</td>
									
								</tr>
							</table>
					<div style="background-color: #fafbfb;
					    border: 1px solid #ccc;
					    display: block;
					    height: 250px;
					    margin: auto;
					    overflow-x: hidden;
					    overflow-y: scroll;
					    width: 100%;">
					    
					<table id="tblBatch" class="transTablex col6-center" style="width: 100%;">
						<tbody>    
<%-- 										<col style="width:15%"><!--  COl1   --> --%>
<%-- 										<col style="width:10%"><!--  COl2   --> --%>
<%-- 										<col style="width:30%"><!--  COl3   --> --%>
<%-- 										<col style="width:10%"><!--  COl4   --> --%>
<%-- 										<col style="width:15%"><!--  COl5   --> --%>
<%-- 										<col style="width:20%"><!--  COl6   --> --%>
							<c:forEach items="${BatchList}" var="MISBatch" varStatus="status">

								<tr>
									<td style="width: 7%; height: 18px;" align="left"><input readonly="readonly" class="Box" size="5%" id="txtProdCode.${status.index}" name="listBatchDtl[${status.index}].strProdCode" value="${MISBatch.strProdCode}" /></td>
									<td style="width: 30%; height: 18px;" align="left"><input readonly="readonly" class="Box" size="33%" name="listBatchDtl[${status.index}].strProdName" value="${MISBatch.strProdName}"/></td>
									<td style="width: 8%; height: 18px;" align="Right"><input style="text-align: right;" required="required" size="6%" id="txtQty.${status.index}"  name="listBatchDtl[${status.index}].dblQty" value="${MISBatch.dblQty}" onblur="Javacsript:funCheckIssueQty(this)" /></td>
									<td style="width: 8%; height: 18px;" align="Right"><input readonly="readonly" style="text-align: right;" class="Box" id="txtBatchQty.${status.index}" size="6%"  value="0" /></td>
									<td style="width: 8%; height: 18px;" align="Right"><input readonly="readonly" style="text-align: right;" name="listBatchDtl[${status.index}].dblPendingQty" class="Box" id="txtBalQty.${status.index}" size="6%"  value="0" /></td>
									<td style="width: 13%; height: 18px;" align="left"><input readonly="readonly" required="required" class="Box" id="txtExpiryDate.${status.index}" size="10%" name="listBatchDtl[${status.index}].dtExpiryDate" value=""/></td>
									<td style="width: 13%; height: 18px;" align="left"><input readonly="readonly" required="required" size="13%" id="txtBatchCode.${status.index}" name="listBatchDtl[${status.index}].strBatchCode" value="" ondblclick="funHelp('Batch',${status.index})"/></td>
									<td style="width: 20%; height: 18px;" align="left"><input readonly="readonly" class="Box" size="14%" id="txtManuBatchCode.${status.index}" name="listBatchDtl[${status.index}].strManuBatchCode" value="" /></td>
									  
								</tr>
							</c:forEach>
						</tbody>							
					</table>
					</div>	
				</div>
			<br>	
			<p align="center">
			     <input type="submit" value="Submit" onclick="return btnSubmit_onclick()" class="btn btn-primary center-block" class="form_button" />
			     &nbsp;
			     <input type="button" value="Reset" onclick="funResetFields();" class="btn btn-primary center-block" class="form_button" />
		   </p>		
	</s:form>
	</div>
</body>
</html>
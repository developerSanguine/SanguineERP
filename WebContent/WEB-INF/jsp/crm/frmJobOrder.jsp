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
<script type="text/javascript">
	var fieldName,txtAgainst;

	$(document).ready(function() {
	
		$(".tab_content").hide();
		$(".tab_content:first").show();

		$("ul.tabs li").click(function() {
			$("ul.tabs li").removeClass("active");
			$(this).addClass("active");
			$(".tab_content").hide();

			var activeTab = $(this).attr("data-state");
			$("#" + activeTab).fadeIn();
		});

		
		$(document).ajaxStart(function() {
			$("#wait").css("display", "block");
		});
		$(document).ajaxComplete(function() {
			$("#wait").css("display", "none");
		});
		
		$( "#txtJODate" ).datepicker({ dateFormat: 'yy-mm-dd' });
		$( "#txtJODate" ).datepicker('setDate','today');
		
		
		$("#btnGenJobOrder").hide();
		
		$('#txtProdCode').blur(function () {
			 var code=$('#txtProdCode').val();
			 if (code.trim().length > 0 && code !="?" && code !="/"){							   
			 	funSetProductData(code);
	   		}
		});
		
		$('#txtJOCode').blur(function () {
			 var code=$('#txtJOCode').val();
			 if (code.trim().length > 0 && code !="?" && code !="/"){							   
				 funSetJOwithSOData(code);
	   		}
		});
		
		 $('#txtSOCode').blur(function () {
			 var code=$('#txtSOCode').val();
			 if (code.trim().length > 0 && code !="?" && code !="/"){							   
				 funSetSOCode(code);
	   		}
		}); 
		
		$("form").submit(function(){	
			$("#tblJobOrderDtl").empty();
			if($("#txtProdCode").val().trim()=='' && $("#txtProdCode").val().trim().length==0) {
				alert("Please Select proper Product Code");
				$("#txtProdCode").focus();
				return false;
			} 
			
			if($("#txtQty").val().trim()=='' && $("#txtQty").val().trim().length==0) {
				alert("Please Enter Quantity");
				$("#txtQty").focus();
				return false;
			} 
			
		});//Form submit
		
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
		
		
	});//Document Dot Ready
	
	
	function funSetSOCode(SOcode){
		
		funResetFields();
		funClearRowData();
		 $("#btnGenJobOrder").hide();
	 	
    	gurl=getContextPath()+"/loadJobOrderAgainst.html?SOcode="+SOcode+"&strAgainst="+txtAgainst;
		 $.ajax({
			type : "GET",
			url : gurl,
			dataType : "json",
			success : function(response){ 
				if(response.length >0){
					
			        $("#btnGenJobOrder").show();
			        $("#txtSOCode").val(SOcode);
					
				}else{
					
					if(response.length<=0)
					{
						alert("No Job Orders Available For Sales Order");
						$("#txtSOCode").val('');
					}else{
						 $("#txtSOCode").val(SOcode);
						$.each(response, function(i,item){
							var objModel = response[i];
						funAddJobOrderList(objModel.strJOCode,objModel.strProdCode,objModel.strProdName,
									objModel.dblQty,objModel.strStatus);
     	       	    	 });
						
					}
					
				}
			},
			error : function(e){

			}
		}); 
	}

	
	function funGenerateJobOrder(){
		
		funResetFields();
		funClearRowData();
		$("#txtAgainst").focus();
		var SOcode = $("#txtSOCode").val();
    	gurl=getContextPath()+"/generateJobOrderAgainst.html?SOcode="+SOcode+"&strAgainst="+txtAgainst;
		 $.ajax({
			type : "GET",
			url : gurl,
			dataType : "json",
			success : function(response){ 
				
				
				if(response.length <=0){
					alert("No Job Orders Available For Sales Order");
        			$("#txtSOCode").val('');
        			$("#txtSOCode").focus();
				}else{
					$.each(response, function(i,item){
						var objModel = response[i];
						funAddJobOrderList(objModel.strJOCode,objModel.strProdCode,objModel.strProdName,
								objModel.dblQty,objModel.strStatus);
     	       	    	 });
						
				}
				
			},
			error : function(e){

			}
		});  
		 
		 
	}
	
	function funSetJOwithSOData(JOcode){
		
		funClearJOData();
		$("#txtQty").focus();
    	gurl=getContextPath()+"/loadJobOrderData.html?JOcode="+JOcode;
		 $.ajax({
			type : "GET",
			url : gurl,
			dataType : "json",
			success : function(response){ 
				
				if(response.strJOCode == "Invalid Code"){
					alert("Job Order Code Invalid Please select Again");
        			$("#txtJOCode").val('');
        			$("#txtJOCode").focus();
				}else{
					$("#txtJOCode").val(response.strJOCode);
					$("#txtJODate").val(response.dteJODate);
					$("#txtProdCode").val(response.strProdCode);
					$("#txtprodName").text(response.strProdName);
					$("#txtQty").val(response.dblQty);
					$("#txtStatus").text(response.strStatus);
					
				}
				
			},
			error : function(e){

			}
		});  
		 
		 
	}
	
	
	function funSetProductData(code){
		
		$("#txtQty").focus();
		var searchUrl="";
		searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
		$.ajax ({
	        type: "GET",
	        url: searchUrl,
		    dataType: "json",
		    success: function(response)
		    {
		    	if('Invalid Code' == response.strProdCode){
		    		alert('Invalid Product Code');
			    	$("#txtProdCode").val('');
			    	$("#txtprodName").text('');
			    	$("#txtProdCode").focus();
		    	}
		    	else{
			    	$("#txtProdCode").val(response.strProdCode);
			    	$("#txtprodName").text(response.strProdName);
				}
				
			},
			error : function(e){

			}
		});  
		 
		 
	}

	
	function funAddJobOrderList(strJOCode,strProdCode,strProdName,dblQty,strStatus){
		
			var table = document.getElementById("tblJobOrderDtl");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
			
		    row.insertCell(0).innerHTML= "<input name=\"jobOrderList["+(rowCount)+"].strJOCode\" readonly=\"readonly\" class=\"Box\" size=\"12%\" id=\"txtJOCode."+(rowCount)+"\" value='"+strJOCode+"' />";		  		   	  
		    row.insertCell(1).innerHTML= "<input name=\"jobOrderList["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box\" size=\"12%\" id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";		 
		    row.insertCell(2).innerHTML= "<input name=\"jobOrderList["+(rowCount)+"].strProdName\"  readonly=\"readonly\" class=\"Box\" size=\"35%\" id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"' />";		 
		    row.insertCell(3).innerHTML= "<input name=\"jobOrderList["+(rowCount)+"].dblQty\" type=\"text\"  readonly=\"readonly\" size=\"10%\" class=\"Box\" id=\"txtQty."+(rowCount)+"\" value='"+dblQty+"' />";
		    row.insertCell(4).innerHTML= "<input name=\"jobOrderList["+(rowCount)+"].strStatus\" type=\"text\" readonly=\"readonly\" class=\"Box\" size=\"20%\"  id=\"txtStatus."+(rowCount)+"\" value='"+strStatus+"' />";

	}

	function funHelp1()
	{
		txtAgainst=$("#txtAgainst").val();
		funSetTransCodeHelp(txtAgainst);
		fieldName=txtAgainst;
       // window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		 window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
    }
	
	function funSetTransCodeHelp(txtAgainst)
	{
		switch (txtAgainst) 
		{
		   case 'salesOrder':
			  // reportName="loadExciseSalesMasterData.html";
			   transactionName='salesorder';
		       break;
		       
		 /*   case 'productionOrder':
			   reportName="loadOPData.html";
			   transactionName='ProductionOrder';
		       break;
		       
		   case 'serviceOrder':
			   reportName="loadExciseBrandOpeningMasterData.html";
			   transactionName='ServiceOrder';
		       break; */
		}
	}
	
	
	function funSetData(code){

		switch(fieldName){

			case 'salesOrder' : 
					funSetSOCode(code);
				break;
				
			case 'JOCode' : 
				funSetJOwithSOData(code);
			break;
			
			case 'productmaster' : 
				funSetProductData(code);
			break;
			
		}
	}



	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	
	function funClearRowData() {
		$("#tblJobOrderDtl").find("tr:gt(0)").remove();
	} 
	

	function funClearJOData() {
		$("#txtJOCode").val('');
		$("#txtProdCode").val('');
		$("#txtprodName").text('');
		$("#txtQty").val('');
		$("#txtStatus").text('');
	} 
	
	function funResetFields(){
		
		$("#txtJOCode").val('');
		$("#txtJODate" ).datepicker('setDate','today');
		$("#txtProdCode").val('');
		$("#txtprodName").text('');
		$("#txtQty").val('');
		$("#txtStatus").text('');
	}
	
</script>

</head>
<body>
	<div class="container">
		<label id="formHeading">Job Order</label>
	
	<s:form name="JobOrder" method="POST" action="saveJobOrder.html">
		<div style="border: 0px solid black; width: 100%; height: 100%; margin-left: auto; margin-right: auto; background-color: #C0E4FF;">
			<div id="tab_container">
				<ul class="tabs">
					<li class="active" data-state="tab1">Sale Order Wise</li>
					<li data-state="tab2">Direct</li>
				</ul>
					<br/>
					<br/>
						<div id="tab1" class="tab_content">
							<div class="row transTable">
								<div class="col-md-2">
									<label>Against</label>
									<select id="txtAgainst">
										<option value="salesOrder">Sales Order</option>
										<option value="productionOrder">Production Order</option>
										<option value="serviceOrder">Service Order</option>
									</select>
								</div>
								<div class="col-md-2">	
									<label>Order Code</label>
									<s:input type="text" id="txtSOCode" path="strSOCode" ondblclick="funHelp1()"
												cssClass="searchTextBox"  />
								</div>
								<div class="col-md-2">
									<div id="btnGenJobOrder">
										<input type="button" id="generateJobOrder" value="Generate" onClick="funGenerateJobOrder();" />
									</div>
								</div>	
								
							</div>
							<br/>
							
							<div class="transTable" style="background-color: #fbfafa; border: 1px solid #ccc;
									 display: block; height: 250px;overflow-x: hidden; overflow-y: scroll; margin:0px; ">
								<table id="tblJobOrderDtl" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
											class="transTablex col15-center">
									<tr bgcolor="#c0c0c0">
											<th width="15%">Job Order No.</th>
											<!--  COl1   -->
											<th width="15%">Product Code</th>
											<!--  COl2   -->
											<th width="40%">Product Name</th>
											<!--  COl3   -->										
											<th width="10%">Quantity</th>
											<!--  COl4   -->
											<th width="20%">Status</th>
											<!--  COl5   -->
									</tr>
								</table>
							</div>

						</div>
							 

						<div id="tab2" class="tab_content">
							<div class="row transTable" style="overflow:hidden;">
								<div class="col-md-2">
									<label>Job Order Code</label>
									<s:input type="text" id="txtJOCode" path="strJOCode"
											cssClass="searchTextBox" ondblclick="funHelp('JOCode');" />
								</div>
								<div class="col-md-2">
									<label>Job Order Date</label>
									<s:input type="text" id="txtJODate" path="dteJODate" require="require"
											cssClass="calenderTextBox" style="width:80%;" />
								</div>
								<div class="col-md-2">
									<label>Product</label>
									<s:input type="text" id="txtProdCode" path="strProdCode" require="require"
											cssClass="searchTextBox" ondblclick="funHelp('productmaster');" />
								</div>
								<div class="col-md-2">
									<label id="txtprodName" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:   center;"
									></label>
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-2">		
									<label>Quantity</label>
									<s:input type="text"  id="txtQty" path="dblQty" require="require"
										cssClass="BoxW124px decimal-places numberField"	/>
								</div>
								<div class="col-md-2">	
									<label>Status</label>
									<label id="txtStatus" style="background-color:#dcdada94; width: 100%; height: 52%;text-align:   center;"
									> </label>
								</div>
							</div>
				<div class="center" style="text-align:center;">
					<a href="#"><button class="btn btn-primary center-block" value="Submit"
						class="form_button">Submit</button></a> &nbsp;
					<a href="#"><button class="btn btn-primary center-block" value="Reset" onclick="funResetFields()"
						class="form_button">Reset</button></a>
				</div>	
			</div>	
		</div>
	</div>
</s:form>
</div>
</body>
</html>

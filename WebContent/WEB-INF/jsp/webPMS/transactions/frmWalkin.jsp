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
		<link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />	
	 	 
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
<%-- 	<script type="text/javascript" src="<spring:url value="/resources/js/Accordian/jquery-ui-1.8.13.custom.min.js"/>"></script> --%>
		<script type="text/javascript" src="<spring:url value="/resources/js/Accordian/jquery.multi-accordion-1.5.3.js"/>"></script>
	
<title></title>
<style>
.container{
background:#f2f2f2;
}
.ui-widget input{
font-size:13px;
}

</style>

<script type="text/javascript">

	var fieldName,listRow=0;
	var strDemo;	
	var totalTerrAmt = 0.0;
	
//Initialize tab Index or which tab is Active

	$(document).ready(function() 
	{		
		
		
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
		
		 var pmsDate='<%=session.getAttribute("PMSDate").toString()%>';
		  var dte=pmsDate.split("-");
		  $("#txtPMSDate").val(dte[2]+"-"+dte[1]+"-"+dte[0]);
		  
		  var roomNo='<%=session.getAttribute("RoomNo").toString()%>';
		  var roomTypeDesc='<%=session.getAttribute("RoomType").toString()%>';
		  <%-- var roomDate='<%=session.getAttribute("RoomDate").toString()%>'; --%>
		  var roomType='<%=session.getAttribute("RoomTypeCode").toString()%>';
		  var roomCode='<%=session.getAttribute("RoomCode").toString()%>';
		 if(roomNo!='' && roomType!=''&& roomCode!='')
		 {
			 $("#lblRoomDesc").text(roomNo);
			 $("#txtRoomTypeCode").val(roomType);
			 $("#txtRoomNo").val(roomCode);
			 $("#lblRoomType").text(roomTypeDesc);
			 
			 <%session.removeAttribute("RoomNo");
			 	  session.removeAttribute("RoomTypeCode");
			 	session.removeAttribute("RoomCode");
			 	session.removeAttribute("RoomType");
			 %>
		 }
		 else
		 {
			 $("#lblRoomDesc").text("");
			 $("#txtRoomTypeCode").val(' ');
			 $("#txtRoomNo").val(' ');
			 $("#lblRoomType").text("");
			 <%session.removeAttribute("RoomNo");
			 	session.removeAttribute("RoomTypeCode");
			 	session.removeAttribute("RoomCode");
			 	session.removeAttribute("RoomType");
			 %>
		 }
		 

		 
		 /*  $("#txtWalkinDate").datepicker({ dateFormat: 'dd-mm-yy' });
		  $('#txtWalkinDate').datepicker('setDate',roomDate); */
	});
	
	

	$(function()
	{
		var pmsDate='<%=session.getAttribute("PMSDate").toString()%>';
		
		$('#txtWalkinTime').timepicker();
		$('#txtCheckOutTime').timepicker();
		
		$('#txtWalkinTime').timepicker({
		        'timeFormat':'H:i:s'
		});
		$('#txtCheckOutTime').timepicker({
		        'timeFormat':'H:i:s'
		});
		
		$('#txtWalkinTime').timepicker('setTime', new Date());
		//$('#txtCheckOutTime').timepicker('setTime', new Date());
		$('#txtCheckOutTime').val("${tmeCheckOutPropertySetupTime}");
		
		$("#txtWalkinDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtWalkinDate").datepicker('setDate', pmsDate); 
		
		$("#txtCheckOutDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtCheckOutDate").datepicker('setDate', pmsDate);



		
		
// 		$("#txtWalkinDate").datepicker({ dateFormat: 'dd-mm-yy' });
// 		$("#txtWalkinDate").datepicker('setDate', pmsDate);
		
// 		$("#txtCheckOutDate").datepicker({ dateFormat: 'dd-mm-yy' });
// 		$("#txtCheckOutDate").datepicker('setDate', pmsDate);
		
		$("#txtWalkinTime").timepicker();
		$("#txtCheckOutTime").timepicker();
		
		$("#txtDOB").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtDOB").datepicker('setDate', pmsDate);
				
		$("#txtPassportExpiryDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtPassportExpiryDate").datepicker('setDate', pmsDate);
		
		$("#txtPassportIssueDate").datepicker({ dateFormat: 'dd-mm-yy' });
		$("#txtPassportIssueDate").datepicker('setDate', pmsDate);
		
		
		$('a#baseUrl').click(function() 
		{
			if($("#txtWalkinNo").val().trim()=="")
			{
				alert("Please Select Wakin No ");
				return false;
			}
			
			
		   	window.open('attachDoc.html?transName=frmWalkin.jsp&formName=Walkin &code='+$('#txtWalkinNo').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		});		
	});
	

	function funSetData(code){

		switch(fieldName){

			case 'WalkinNo' : 
				funSetWalkinNo(code);
				//funSetWalkinInformation(code);unHelp
				
				break;
				
			case 'CorporateCode' : 
				funSetCorporateCode(code);
				break;
				
			case 'BookerCode' : 
				funSetBookerCode(code);
				break;
				
			case 'AgentCode' : 
				funSetAgentCode(code);
				break;
				
			case 'guestCode' : 
				funSetGuestCode(code);
				break;
				
// 			case 'roomType' : 
// 				funSetRoomTypeData(code);
// 				break;
			
			case 'mobileNo'	:
				funSetMobileData(code);
				break;
				
			case 'roomCode'	:
				funSetRoomNo(code);
				break;
				
			case 'extraBed' : 
				funSetExtraBed(code);
				break;
				
			case "incomeHead":
				funSetIncomeHead(code);
			break;
			
			case "roomType":
				funSetRoomType(code);
			break;
			
			case "package":
				funSetPackageNo(code);
			break;
			
			case "roomByRoomType":
				funSetRoomNo(code);
			break;
			
			case "plan":
				funSetPlanMasterData(code);
			break;
		}
	}

	
	function funSetRoomType(code){
		$("#txtRoomTypeCode").val(code);
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadRoomTypeMasterData.html?roomCode=" + code,
			dataType : "json",
		    async:false,
			success : function(response){ 
				if(response.strAgentCode=='Invalid Code')
	        	{
	        		alert("Invalid Room Type");
	        		$("#lblRoomType").text('');
	        	}
	        	else
	        	{					        	    	        		
	        		$("#lblRoomType").text(response.strRoomTypeDesc);
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
	
	
	function funSetRoomNo(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadRoomMasterData.html?roomCode=" + code,
			dataType : "json",
			success : function(response){ 
				if(response.strRoomCode=='Invalid Code')
	        	{
	        		alert("Invalid Room No");
	        		$("#txtRoomNo").val('');
	        	}
	        	else
	        	{
	        		if(response.strStatus=='Blocked')
	        			{
	        			alert('This room is Blocked Please Select Different Room');
	        			}
	        		else
	        		{
	        		$("#txtRoomNo").val(response.strRoomCode);
	        		$("#lblRoomDesc").text(response.strRoomDesc);
	        		funSetRoomType(response.strRoomTypeCode);
	        		}
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
	

	function funSetWalkinNo(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadWalkinData.html?docCode=" + code,
			dataType : "json",
			success : function(response)
			{
				if(response.strWalkinNo=='Invalid Code')
	        	{
	        		alert("Invalid Walkin No");
	        		$("#txtWalkinNo").val('');
	        	}
	        	else
	        	{
	        		funFillWalkinHdData(response);
	        	}
			},
			error : function(e)
			{
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

	
	function funSetWalkinInformation(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadWalkinInformation.html?docCode=" + code,
			dataType : "json",
			success : function(response)
			{ 
				if(response.strWalkinNo=='Invalid Code')
	        	{
	        		alert("Invalid Walkin No");
	        		$("#txtWalkinNo").val('');
	        	}
	        	else
	        	{
	        		funFillWalkinHdData(response);
	        	}
			},
			error : function(e)
			{
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

	
	
	function funFillWalkinHdData(response)
	{
		$("#txtWalkinNo").val(response.strWalkinNo);
    	$("#txtWalkinTime").val(response.tmeWalkinTime);
		$("#txtWalkinDate").val(response.dteWalkinDate);
		$("#txtCheckOutDate").val(response.dteCheckOutDate);
		$("#txtCheckOutTime").val(response.tmeCheckOutTime);
		$("#txtCorporateCode").val(response.strCorporateCode);
		$("#txtBookerCode").val(response.strBookerCode);
		$("#txtAgentCode").val(response.strAgentCode);
		$("#txtNoOfNights").val(response.intNoOfNights);
		$("#txtRemarks").val(response.strRemarks);
		$("#txtRoomNo").val(response.strRoomNo);
		$("#lblRoomDesc").text(response.strRoomDesc);
	    $("#txtExtraBed").val(response.strExtraBedCode);
	    $("#lblExtraBed").text(response.strExtraBedDesc);
	    $("#txtNoOfAdults").val(response.intNoOfAdults);
	    $("#txtNoOfChild").val(response.intNoOfChild);
	    
	    $("#txtPackageCode").val(response.strPackageCode);
		$("#txtPackageName").val(response.strPackageName);
		
		if(response.strPlanCode!='')
		{
			$("#txtPlanCode").val(response.strPlanCode);
			funSetPlanMasterData(response.strPlanCode);
		}
		
	    funRemoveProductRowsForIncomeHead();
		funRemoveTariffRows();
		funFillWalkinDtlGrid(response.listWalkinDetailsBean);
		funAddRommRateDtlOnWalkinSelect(response.listWalkinRoomRateDtl);
		funGetPreviouslyLoadedPkgList(response.listRoomPackageDtl);
		/*var incomeHeadCode =response.strIncomeHeadCode;
		var incomeHead = incomeHeadCode.split(',');
		for(var i=0; i<incomeHead.length; i++)
		{
		funSetIncomeHead(incomeHead[i]);
		}
		*/
		
		
	}
	
	function funAddRommRateDtlOnWalkinSelect(dataList)
	{
		
		 var table=document.getElementById("tblRommRate");
		 
		 for(var i=0;i<dataList.length;i++ )
	     {
			 var rowCount=table.rows.length;
			 var row=table.insertRow();
			 var list=dataList[i];
			 var date=list.dtDate;
// 			 var roomDesc = funGetRoomDescOnLoad(list.strRoomNo);
			var roomtypeDesc=funSetRoomType(list.strRoomType);
		 	var roomtypeDesc=$("#lblRoomType").text();
		 	$("#lblRoomType").text("");
			 var dateSplit = date.split("-");
			 date=dateSplit[2]+"-"+dateSplit[1]+"-"+dateSplit[0];
			 var dateSplit = date.split("-");
			 date=dateSplit[2]+"-"+dateSplit[1]+"-"+dateSplit[0];
			 row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-center: 5px;width:34%;\" name=\"listWalkinRoomRateDtl["+(rowCount)+"].dtDate\"  id=\"dtDate."+(rowCount)+"\" value='"+date+"' >";
	 	     row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"34%\" id=\"strRoomTypeDesc."+(rowCount)+"\" value='"+roomtypeDesc+"' />";
	 	     row.insertCell(2).innerHTML= "<input type=\"text\" style=\"text-align:right;width:34%;\"  name=\"listWalkinRoomRateDtl["+(rowCount)+"].dblRoomRate\" id=\"dblRoomRate."+(rowCount)+"\" onchange =\"Javacsript:funCalculateTotals()\" value='"+list.dblRoomRate+"' >";
	 	     row.insertCell(3).innerHTML= "<input type=\"hidden\" class=\"Box \" name=\"listWalkinRoomRateDtl["+(rowCount)+"].strRoomType\" id=\"strRoomType."+(rowCount)+"\" value='"+list.strRoomType+"' >";
			 }
	}
	
	
	function funSetIncomeHead(code)
	{
		$("#txtIncomeHeadCode").val(code);
		var searchurl=getContextPath()+"/loadIncomeHeadMasterData.html?incomeCode="+code;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strIncomeHeadCode=='Invalid Code')
			        	{
			        		alert("Invalid Income Head Code");
			        		$("#txtIncomeHeadCode").val('');
			        	}
			        	else
			        	{
			        		funfillIncomHeadGrid(response);
			        		
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
	
	
	function funSetPackageNo(code){

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadPackageMaster.html?docCode=" + code,
			dataType : "json",
			success : function(response)
			{ 
				if(response.strPackageCode!="Invalid")
		    	{
					$("#txtPackageCode").val(response.strPackageCode);
					if($("#txtRoomTypeCode").val()=='')
					{
						alert('Select RoomType!!');
					}
					else
					{
						$("#txtPackageName").val(response.strPackageName);
						$.each(response.listPackageDtl, function(i,item)
						{
							funAddIncomeHeadRow(item.strIncomeHeadCode.split('#')[0],item.strIncomeHeadCode.split('#')[1],item.dblAmt);		
						});
					}
		    	}
		    	else
			    {
			    	alert("Invalid Package No");
			    	$("#txtPackageCode").val(code);
			    	$("#txtPackageCode").focus();
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
	
	function funfillIncomHeadGrid(data){
		
		$("#txtIncomeHead").val(data.strIncomeHeadCode);
		$("#txtIncomeHeadName").val(data.strIncomeHeadDesc);
	 
		//funAddIncomeHeadRow();
		
		//$("#txtIncomeHead").val('');
		//$("#lblIncomeHeadName").text('');
	
	}
	
	
	//add income head
	function funAddIncomeHeadRow(incomeHeadCode,incomeHeadName,incomeHeadAmt)
	{
		/*var incomeHeadCode=$("#txtIncomeHead").val();
		var incomeHeadName=$("#txtIncomeHeadName").val();
		var incomeHeadAmt=$("#txtIncomeHeadAmt").val(); 
		*/var amount="0.0";
		
		var flag=false;
		flag=funChechDuplicate(incomeHeadCode);
		if(flag)
		{
			alert("Already Added.");
		}
		else
		{
			var table=document.getElementById("tblIncomeHeadDtl");
			var rowCount=table.rows.length;
			var row=table.insertRow();
			
			var incomehead = $("#hidIncomeHead").val();
			
			if(!incomehead==''){
				incomehead=incomehead+","+incomeHeadCode;
				 $("#hidIncomeHead").val(incomehead);
			}
			else{
				$("#hidIncomeHead").val(incomeHeadCode);
			}
			
			
			 
	 	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-left: 5px;width:50%;\"  name=\"listRoomPackageDtl["+(rowCount)+"].strIncomeHeadCode\"    id=\"strIncomeHeadCode."+(rowCount)+"\" value='"+incomeHeadCode+"' >";
	 	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-left: 5px;width:50%;\" name=\"listRoomPackageDtl["+(rowCount)+"].strIncomeHeadName\"   id=\"strIncomeHeadDesc."+(rowCount)+"\" value='"+incomeHeadName+"' >";
	 	    row.insertCell(2).innerHTML= "<input type=\"readonly\"   class=\"Box \"  style=\"text-align:right;\" name=\"listRoomPackageDtl["+(rowCount)+"].dblIncomeHeadAmt\"   id=\"dblIncomeRate."+(rowCount)+"\" value='"+incomeHeadAmt+"' >";
	 	    row.insertCell(3).innerHTML= "<input type=\"button\" value=\"\" style=\"padding-right: 5px;width:80%;text-align: right;\" class=\"deletebutton\" onclick=\"funRemoveRow(this)\" />";
					
		//calculate totals
			funCalculateTotals();
		
			//$("#txtIncomeHead").val('');
			//$("#dblIncomeHeadAmt").val('');
		}
	}
	
	
	//check duplicate value
	function funChechDuplicate(incomeHeadCode)
	{
		var flag=false;
		var table=document.getElementById("tblIncomeHeadDtl");
		var rowCount=table.rows.length;
		if(rowCount>0)
		{
		    for(var i=0;i<rowCount;i++)
		    {
		    	if(table.rows[i].cells[0]!=null)
		    	{
		       var containsAccountCode=table.rows[i].cells[0].innerHTML;
		    	}
		       var addedIHCode=$(containsAccountCode).val();
		       if(addedIHCode==incomeHeadCode)
		       {
		    	   flag=true;
		    	   break;
		       }
		    }
		}
		return flag;
	}
	

	//calculate totals
	function funCalculateTotals()
	{
		var totalAmt=0.00;
		var table=document.getElementById("tblIncomeHeadDtl");
		var rowCount=table.rows.length;
		if(rowCount>0)
		{
		    for(var i=0;i<rowCount;i++)
		    {
		    	var containsAccountCode=table.rows[i].cells[2].innerHTML;
		       	totalAmt=totalAmt+parseFloat($(containsAccountCode).val());
		    }
		   	totalAmt=parseFloat(totalAmt).toFixed(maxAmountDecimalPlaceLimit);
		}
		//$("#dblTotalAmt").text(totalAmt);
		
		//For tarrif
		var totalTarriff=0;
		if(document.getElementById("tblRommRate").rows.length>0)
		{
			for(var i=0;i<document.getElementById("tblRommRate").rows.length;i++)
		    {
				var objName =document.getElementById("dblRoomRate."+i);
		        totalTarriff=totalTarriff+parseFloat(objName.value);
		    }
			totalTarriff=parseFloat(totalTarriff).toFixed(maxAmountDecimalPlaceLimit);
		}
		
		$("#txtTotalAmt").val(totalTarriff);
		var table=document.getElementById("tblTotalPackageDtl");
		var rowCount=table.rows.length;
		while(rowCount>0)
		{table.deleteRow(0);
		   rowCount--;
		}
		var row=table.insertRow();
		row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-left: 56%;width:100%; font-size:13px; font-weight: bold;text-align:right; \"  id=\"strPackageDesc."+(rowCount)+"\" value='Total' >";
 	    row.insertCell(1).innerHTML= "<input type=\"text\" class=\"Box \"  style=\"text-align:right; font-size:13px; font-weight: bold;width:95%;\"  id=\"dblIncomeRate."+(rowCount)+"\" value='"+totalAmt+"' >";
 	    
 	    row=table.insertRow();
		row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-left: 67%;width:100%; font-size:13px; font-weight: bold;text-align:right; \"  id=\"strPackageDesc."+(rowCount)+"\" value='Room Tarrif' >";
	    row.insertCell(1).innerHTML= "<input type=\"readonly\"   class=\"Box \" style=\"text-align:right; font-size:13px; font-weight: bold;width:95%;\"  id=\"dblIncomeRate."+(rowCount)+"\" value='"+totalTarriff+"' >";
	    var totalPkgAmt=0;
	    var rowCount=table.rows.length;
	    if(rowCount>0)
		{
		    for(var i=0;i<rowCount;i++)
		    {
		    	var containsAccountCode=table.rows[i].cells[1].innerHTML;
		    	totalPkgAmt=totalPkgAmt+parseFloat($(containsAccountCode).val());
		    }
		    totalPkgAmt=parseFloat(totalPkgAmt).toFixed(maxAmountDecimalPlaceLimit);
		}
	    row=table.insertRow();
		row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-left: 70%;width:100%; font-size:13px; font-weight: bold;text-align:right; \"  id=\"strPackageDesc."+(rowCount)+"\" value='Total Package' >";
	    row.insertCell(1).innerHTML= "<input type=\"text\" class=\"Box \"  style=\"text-align:right; font-size:13px; font-weight: bold;width:95%;\"  id=\"dblIncomeRate."+(rowCount)+"\" value='"+totalPkgAmt+"' >";
	    $("#txtTotalPackageAmt").val(totalPkgAmt);
	}
	
	
	/*
	function funFillWalkinHdData(response)
	{
		$("#txtWalkinNo").val(response[0][0]);
		$("#txtWalkinDate").val(response[0][1]);
		$("#txtWalkinTime").val(response[0][2]);
		$("#txtCheckOutDate").val(response[0][3]);
		$("#txtCheckOutTime").val(response[0][4]);
		$("#txtCorporateCode").val(response[0][5]);
		$("#txtBookerCode").val(response[0][6]);
		$("#txtAgentCode").val(response[0][7]);
	    $("#txtNoOfNights").val(response[0][8]);
	
		funFillWalkinDtlGrid(response.listWalkinDetailsBean);
		funFillGuestMasterDetails(response.strGuestCode);
	}
	*/
	
	function funFillWalkinDtlGrid(resListWalkinDetailsBean)
	{
		funRemoveProductRows();
		var count=0;
		$.each(resListWalkinDetailsBean, function(i,item)
        {
			count=i;
			var roomtypeDesc=funSetRoomType(resListWalkinDetailsBean[i].strRoomType);
			var roomtypeDesc=$("#lblRoomType").text();
			$("#lblRoomType").text("");
			funAddDetailsRow(resListWalkinDetailsBean[i].strRoomNo,resListWalkinDetailsBean[i].strRoomDesc,resListWalkinDetailsBean[i].strRoomType,
				resListWalkinDetailsBean[i].strGuestCode,resListWalkinDetailsBean[i].strGuestFirstName,resListWalkinDetailsBean[i].strGuestMiddleName,
				resListWalkinDetailsBean[i].strGuestLastName,resListWalkinDetailsBean[i].lngMobileNo,resListWalkinDetailsBean[i].intNoOfAdults
				,resListWalkinDetailsBean[i].intNoOfChild,resListWalkinDetailsBean[i].strExtraBedCode,resListWalkinDetailsBean[i].strExtraBedDesc,"","",roomtypeDesc);
        });
		listRow=count+1;
	}
	
	
	function funFillGuestMasterDetails(guestCode)
	{
		funSetGuestCode(guestCode);
	}
	
	
	/**
	* Get and Set data from help file and load data Based on Selection Passing Value(Room Master Code)
	**/
	

	function funSetCorporateCode(code)
	{
		$("#txtCorporateCode").val(code);
		
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadCorporateCode.html?docCode=" + code,
			dataType : "json",
			success : function(response){ 

			},
			error : function(e){

			}
		});
	}

	function funSetBookerCode(code)
	{
		$("#txtBookerCode").val(code);

		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadBookerCode.html?docCode=" + code,
			dataType : "json",
			success : function(response){ 

			},
			error : function(e){

			}
		});
	}

	function funSetAgentCode(code)
	{
		$("#txtAgentCode").val(code);
		$.ajax({
			type : "GET",
			url : getContextPath()+ "/loadAgentCode.html?docCode=" + code,
			dataType : "json",
			success : function(response){ 

			},
			error : function(e){

			}
		});
	}

	function funSetGuestCode(code)
	{
		var searchurl=getContextPath()+"/loadGuestInformation.html?guestCode="+code;
		 $.ajax({
		        type: "GET",
		        url: searchurl,
		        dataType: "json",
		        success: function(response)
		        {
		        	if(response.strGuestCode=='Invalid Code')
		        	{
		        		alert("Invalid Walikn No");
		        		$("#txtGuestCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtGuestCode").val(response[0][0]);
		        		$("#txtGuestFirstName").val(response[0][1]);
		        		 $("#txtGuestMiddleName").val(response[0][2]);
		        		 $("#txtGuestLastName").val(response[0][3]);
		        		 $("#txtMobileNo").val(response[0][4]);
		        		 $("#txtAddress").val(response[0][5]);
		        		
		        		 
		        		 
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
	* Get and Set data from help file and load data Based on Selection Passing Value(Mobile No)
	**/
	
	function funSetMobileData(code)
	{
		var searchurl=getContextPath()+"/loadMobileNo.html?mobileNo="+code;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strRoomTypeCode=='Invalid Code')
			        	{
			        		alert("Invalid Mobile No");
			        		$("#txtMobileNo").val('');
			        	}
			        	else
			        	{
				        	$("#txtGuestCode").val(response.strGuestCode);
				        	
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

	
	
	function funSetExtraBed(code)
	{
		$("#txtExtraBed").val(code);
		var searchurl=getContextPath()+"/loadExtraBedMasterData.html?extraBedCode="+code;
		 $.ajax({
			    type: "GET",
			    url: searchurl,
			    dataType: "json",
			    success: function(response)
			    {
			        if(response.strExtraBedTypeCode=='Invalid Code')
			        {
			        	alert("Invalid ExtraBed Code");
			        	$("#txtExtraBed").val('');
			        }
			        else
			        {
				        $("#lblExtraBed").text(response.strExtraBedTypeDesc);
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
	
	
	
	function funHelp(transactionName)
	{	
		if(transactionName=="guestCode")
		{
			if($("#txtRoomNo").val()==" ")
			{
				alert("Please Select Room");
			}
			else
			{
				fieldName=transactionName;
				window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			}
		}
		else
		{
			fieldName=transactionName;
			window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		}
		
		//window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
	
	 
	function funHelp1(transactionName,row)
	{
		gridHelpRow=row;
		fieldName=transactionName;
		var condition = $("#txtRoomTypeCode").val();
		if(transactionName=="roomByRoomType" && condition!=" ")
		{
			window.open("searchform.html?formname="+fieldName+"&strRoomTypeCode="+condition+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		
		}
		else
		{
			if(condition==" ")
			{
				alert("Please Select Room Type !!!");
			}
			//window.open("searchform.html?formname="+transactionName+"&searchText=","mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
		}
	}
	 
	
	//Function to Delete Selected Row From Grid
	function funDeleteRow(obj)
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblwalkindtl");
	    table.deleteRow(index);
	}

	
	
	//Delete a All record from a grid
	function funRemoveProductRows()
	{
		var table = document.getElementById("tblwalkindtl");
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	
	/**
	* On Blur Event on mobileNo Textfield
	**/
	$('#txtMobileNo').blur(function() 
	{
			var code = $('#txtMobileNo').val();
			/*if (code.trim().length > 0 && code !="?" && code !="/")
			{
				funSetData(code);
			}
			*/
	});
	
	
	
// Get Detail Info From detail fields and pass them to function to add into detail grid
	function funGetDetailsRow() 
	{
		var roomNo =$("#txtRoomNo").val().trim();
		var roomDesc='';
		var guestCode=$("#txtGuestCode").val().trim();
		var guestFirstName=$("#txtGuestFirstName").val().trim();
		var guestMiddleName=$("#txtGuestMiddleName").val().trim();
		var guestLastName=$("#txtGuestLastName").val().trim();
		var mobileNo=$("#txtMobileNo").val().trim();
		var extraBedCode=$("#txtExtraBed").val();
		var extraBedDesc=$("#lblExtraBed").text();
	    var noOfAdults=$("#txtNoOfAdults").val();
	    var noOfChild=$("#txtNoOfChild").val();
	    var address=$("#txtAddress").val().trim();
	    var remark=$("#txtRemark").val();
	    var roomTypecode=$("#txtRoomTypeCode").val();
	    var roomTypeDesc=$("#lblRoomType").text();
	    if(mobileNo=='')
		{
			alert('Enter Mobile No!!!');
			$("#txtMobileNo").focus();
			return;
		}
		else
		{
			var pattern = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
			if (pattern.test(mobileNo)) 
			{
			}
			else
			{
				alert("Invalid Mobile No");
			    return;
			}
			
			if(roomTypecode=='')
			{
				alert('Select roomtype!!!');
				return;
			}
		}
		
		if($("#txtGuestFirstName").val().trim()=='')
		{
			alert('Enter Guest First Name!!!');
			$("#txtGuestFirstName").focus();
			return;
		}
		
// 		if(roomNo=='')
// 		{
// 			alert('Select Room No!!!');
// 			$("#txtRoomNo").focus();
// 			return;
// 		}
		
		if(noOfAdults=='')
		{
			alert('Enter No of Adults!!!');
			$("#txtNoOfAdults").focus();
			return;
		}
		
		if(noOfChild=='')
		{
			alert('Enter No of Child!!!');
			$("#txtNoOfChild").focus();
			return;
		}
		
	    funAddDetailsRow(roomNo,roomDesc,roomTypecode,guestCode,guestFirstName,guestMiddleName,guestLastName,mobileNo,noOfAdults,noOfChild,remark,extraBedCode,extraBedDesc,roomTypecode,roomTypeDesc);
	   
	    
	    funFillRoomRate(roomNo);
	}
	
	// Function to add detail grid rows	
	function funAddDetailsRow(roomNo,roomDesc,roomType,guestCode,guestFirstName,guestMiddleName,guestLastName,mobileNo,noOfAdults,noOfChild,remark,extraBedCode,extraBedDesc,roomTypecode,roomTypeDesc) 
	{
	    var table = document.getElementById("tblwalkindtl");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    rowCount=listRow;	  
	   
	    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"13%\" id=\"strExtraBedDesc."+(rowCount)+"\" value='"+extraBedDesc+"' />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" id=\"strRoomTypeDesc."+(rowCount)+"\" value='"+roomTypeDesc+"' />";	    
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" id=\"strRoomTypeDesc."+(rowCount)+"\" value='"+roomNo+"' />";
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strGuestFirstName\" id=\"strGuestFirstName."+(rowCount)+"\" value='"+guestFirstName+"' />";
	    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strGuestMiddleName\" id=\"strGuestMiddleName."+(rowCount)+"\" value='"+guestMiddleName+"' />";
	    row.insertCell(5).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strGuestLastName\" id=\"strGuestLastName."+(rowCount)+"\" value='"+guestLastName+"' />";
	    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" name=\"listWalkinDetailsBean["+(rowCount)+"].lngMobileNo\" id=\"lngMobileNo."+(rowCount)+"\" value='"+mobileNo+"' />";
	    row.insertCell(7).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"2%\" name=\"listWalkinDetailsBean["+(rowCount)+"].intNoOfAdults\" id=\"intNoOfAdults."+(rowCount)+"\" value='"+noOfAdults+"' />";
	    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"2%\" name=\"listWalkinDetailsBean["+(rowCount)+"].intNoOfChild\" id=\"intNoOfChild."+(rowCount)+"\" value='"+noOfChild+"' />";
	    row.insertCell(9).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"5%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strRemark\" id=\"strRemark."+(rowCount)+"\" value='"+remark+"' />";
	    
	    row.insertCell(9).innerHTML= "<input type=\"button\" class=\"deletebutton\" size=\"5%\" value = \"\" onClick=\"Javacsript:funDeleteRow(this)\"/>";
	    row.insertCell(10).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"2%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strGuestCode\" id=\"strGuestCode."+(rowCount)+"\" value='"+guestCode+"' type='hidden' />";
	    row.insertCell(11).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"2%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strRoomNo\" id=\"strRoomNo."+(rowCount)+"\" value='"+roomNo+"' type='hidden' />";
	    row.insertCell(12).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"2%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strExtraBedCode\" id=\"strExtraBedCode."+(rowCount)+"\" value='"+extraBedCode+"' type='hidden' />";
	    row.insertCell(13).innerHTML= "<input type=\"hidden\" class=\"Box\" size=\"0%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strRoomDesc\" id=\"strRoomDesc."+(rowCount)+"\" value='' />";
	    row.insertCell(14).innerHTML= "<input type=\"hidden\" size=\"0%\" name=\"listWalkinDetailsBean["+(rowCount)+"].strRoomType\" id=\"strRoomType."+(rowCount)+"\" value='"+roomType+"' />";
	    listRow++;
	    funResetWalkinDetailFields();
	    
	    
	}
	
	
	function funFillRoomRate(roomNo)
	{
		
		 var arrivalDate= $("#txtWalkinDate").val();
		 var departureDate=$("#txtCheckOutDate").val();
		 var paxCount=$("#txtNoOfAdults").val();
		 var roomDescList = new Array();
		 var table = document.getElementById("tblwalkindtl");
		 var rowCount = table.rows.length;
		 for (i = 0; i < rowCount; i++){
			 
			 var oCells = table.rows.item(i).cells;
			 
			 if(roomDescList!='')
			 {
					 roomDescList = roomDescList + ","+table.rows[i].cells[14].children[0].value;
				
			 }
			
			 else
			 {
				 roomDescList = table.rows[i].cells[14].children[0].value;	 
			 }	 

		}
		 
		 $.ajax({
				type : "POST",
				url : getContextPath()+ "/loadRoomRateWalkin.html?arrivalDate="+arrivalDate+"&departureDate="+departureDate+"&roomDescList="+roomDescList+"&paxCount="+paxCount,
			    dataType: "json",
		        async:false,
		        success: function(response)
		        {
				  funAddRommRateDtl(response);
				},
				error: function(jqXHR, exception){
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
	
	// Reset Walkin Detail Fields
	function funResetWalkinDetailFields()
	{		
	   /*  $("#txtGuestCode").val('');
	    $("#txtGuestFirstName").val('');
	    $("#txtGuestMiddleName").val('');
	    $("#txtGuestLastName").val('');
	    $("#txtMobileNo").val(''); */
	}
	
	function fun1()
	{
		//alert("saved");
	}
	
	
	/**
	* Success Message After Saving Record
	**/
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
			window.location.href=getContextPath()+"/frmQuickCheckIn.html?walkinNo="+message.split(':')[1] ;
		<%
		}}%>

	});
	
		function funAddRow()
		{
			var flag=false;
			
			
			if($("#txtIncomeHead").val().trim().length==0)
			{
				alert("Please Select Income Head.");
			}
			
			if($("#txtIncomeHead").val().trim().length==0)
			{
				alert("Please Select Income Head.");
			}
			else
			{
				if($("#txtIncomeHeadAmt").val().trim().length==0)
				{
					alert("Please Enter Amount For Income Head.");
				}
				else
				{
					flag=true;
					if($("#txtRoomTypeCode").val()=='')
					{
						alert('Select RoomType!!');
					}
					else
					{
						flag=true;
						funAddIncomeHeadRow($("#txtIncomeHead").val(),$("#txtIncomeHeadName").val(),$("#txtIncomeHeadAmt").val());
						$("#txtIncomeHead").val("");
						$("#txtIncomeHeadName").val("");
						$("#txtIncomeHeadAmt").val("");
					}
					
				}
			}		
			return flag;
		}
	 
	 function funAddRommRateDtl(dataList)
		{

			$('#tblRommRate tbody').empty()
		     var table=document.getElementById("tblRommRate");
			 
			if(dataList.length-1 ==  0)
			{
				for(var i=0;i<dataList.length;i++ )
			     {
					 var rowCount=table.rows.length;
					 var row=table.insertRow();
					 var list=dataList[i];
					 var date=list[0];
					 var dateSplit= date.split("-");
					 var month=dateSplit[1];
					 var day = dateSplit[2];
//			 		 if(day<10) 
//			 		 {
//			 			 day='0'+day;
//			 		 } 

//			 		 if(month<10) 	
//			 		 {
//			 			 month='0'+month;
//			 		 } 
					 date=day+"-"+month+"-"+dateSplit[0];
				    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-center: 5px;width:34%;\" name=\"listWalkinRoomRateDtl["+(rowCount)+"].dtDate\"  id=\"dtDate."+(rowCount)+"\" value='"+date+"' >";
				    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"34%\" id=\"strTypeRoomDesc."+(rowCount)+"\" value='"+list[2]+"' />";
		 	        row.insertCell(2).innerHTML= "<input type=\"text\"    style=\"text-align:right;width:34%;\"  name=\"listWalkinRoomRateDtl["+(rowCount)+"].dblRoomRate\" id=\"dblRoomRate."+(rowCount)+"\"  onchange =\"Javacsript:funGetSelectedRow(this)\" value='"+list[1]+"' >";
		 	        row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-center: 5px;width:50%;\" name=\"listWalkinRoomRateDtl["+(rowCount)+"].strRoomType\" id=\"strRoomType."+(rowCount)+"\" value='"+list[3]+"' >";

		 	       totalTerrAmt =totalTerrAmt + list[1];
		 	 	    $("#txtTotalAmt").val(totalTerrAmt);
			     }
			}
			else
			{
				for(var i=0;i<dataList.length-1;i++ )
			     {
					 var rowCount=table.rows.length;
					 var row=table.insertRow();
					 var list=dataList[i];
					 var date=list[0];
					 var dateSplit= date.split("-");
					 var month=dateSplit[1];
					 var day = dateSplit[2];
//			 		 if(day<10) 
//			 		 {
//			 			 day='0'+day;
//			 		 } 

//			 		 if(month<10) 	
//			 		 {
//			 			 month='0'+month;
//			 		 } 
					 date=day+"-"+month+"-"+dateSplit[0];
				    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-center: 5px;width:34%;\" name=\"listWalkinRoomRateDtl["+(rowCount)+"].dtDate\"  id=\"dtDate."+(rowCount)+"\" value='"+date+"' >";
				    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"34%\" id=\"strTypeRoomDesc."+(rowCount)+"\" value='"+list[2]+"' />";
		 	        row.insertCell(2).innerHTML= "<input type=\"text\"    style=\"text-align:right;width:34%;\"  name=\"listWalkinRoomRateDtl["+(rowCount)+"].dblRoomRate\" id=\"dblRoomRate."+(rowCount)+"\"  onchange =\"Javacsript:funGetSelectedRow(this)\" value='"+list[1]+"' >";
		 	        row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box \"  style=\"padding-center: 5px;width:50%;\" name=\"listWalkinRoomRateDtl["+(rowCount)+"].strRoomType\" id=\"strRoomType."+(rowCount)+"\" value='"+list[3]+"' >";

		 	       totalTerrAmt =totalTerrAmt + list[1];
		 	 	    $("#txtTotalAmt").val(totalTerrAmt);
			     }
			}	
			 
		}
	 function CalculateDateDiff() {
		 
		    var fromDate=$("#txtWalkinDate").val();
			var toDate=$("#txtCheckOutDate").val();
			var frmDate= fromDate.split('-');
		    var fDate = new Date(frmDate[1]+"/"+frmDate[0]+"/"+frmDate[2]);//mm/dd/yyyy
		    
		    var tDate= toDate.split('-');
		    var t1Date = new Date(tDate[1]+"/"+tDate[0]+"/"+tDate[2]);//mm/dd/yyyy
		    // To calculate the time difference of two dates 
			 var Difference_In_Time = t1Date.getTime() - fDate.getTime(); 
			   
			 // To calculate the no. of days between two dates 
			 //var Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24); 
			if (Difference_In_Time >= 0 ) 
	  		 {
	  			var total_days = (Difference_In_Time) / (1000 * 60 * 60 * 24) ;
	  			$("#txtNoOfNights").val(total_days);
	  			var roomNo =$("#txtRoomNo").val().trim();
	  			funFillRoomRate(roomNo);
	         	return true;
	         	
	         }else{
	        	 alert("Please Check Checkout Date");
	        	 $("#txtCheckOutDate").datepicker({ dateFormat: 'dd-mm-yy' });
				 $("#txtCheckOutDate").datepicker('setDate', pmsDate);
	        	 return false
	         }
	  		 
	  		funFillRoomRate('');
	  		
		}
	 
	 function funChangeWalkinDate()
		{
			var arrivalDate=$("#txtWalkinDate").val();
		    var pmsDate='<%=session.getAttribute("PMSDate").toString()%>';

	    	if (arrivalDate < pmsDate) 
	  		 {
			    	alert(" Walkin Date Should not be come before PMS Date");
			    	$("#txtWalkinDate").datepicker({ dateFormat: 'dd-mm-yy' });
					$("#txtWalkinDate").datepicker('setDate', pmsDate);
					return false
	         }
	    	CalculateDateDiff();
	    	funFillRoomRate('');
	    	
		}

	 function funCreateNewGuest(){
			
			window.open("frmGuestMaster.html", "myhelp", "scrollbars=1,width=500,height=350");
	<%-- 		var GuestDetails='<%=session.getAttribute("GuestDetails").toString()%>'; --%>
//	 		var guest=GuestDetails.split("#");
			
		}
	 
	 function funOpenCheckIn()
	 {
		 window.open("frmCheckIn.html", "myhelp", "scrollbars=1,width=500,height=350");
	 }


	//Delete a All record from a grid
		function funRemoveTariffRows()
		{
			var table = document.getElementById("tblRommRate");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
	
		function funRemoveProductRowsForIncomeHead()
		{
			var table = document.getElementById("tblIncomeHeadDtl");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		function funRemoveRow(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblIncomeHeadDtl");
		    table.deleteRow(index);
		    funCalculateTotals();
		}
		
		function funGetPreviouslyLoadedPkgList(resPackageIncomeHeadList)
		{
			$.each(resPackageIncomeHeadList, function(i,item)
			 {
		 		funAddIncomeHeadRow(item.strIncomeHeadCode,item.strIncomeHeadName,item.dblIncomeHeadAmt);
		 	 });
			
		}
		
		
		function funValidateForm()
		{
			var flg=false;
			if($("#txtRoomTypeCode").val()=='')
			{
				alert("Please Select Room Type");
				flg=false;
			}
			else
			{
				flg=true;
				if($("#txtWalkinTime").val()=='')
				{
					alert("Please Enter Walkin Time");
					flg=false;
				}
				
				if($("#txtCheckOutTime ").val()=='')
				{
					alert("Please Enter CheckOut Time");
					flg=false;
				}
				
				if($("#txtNoOfAdults").val()=='')
				{
					alert('Enter No of Adults!!!');
					$("#txtNoOfAdults").focus();
					flg=false;
				}
				
				if($("#txtNoOfChild").val()=='')
				{
					alert('Enter No of Child!!!');
					$("#txtNoOfChild").focus();
					flg=false;
				}
				
				 if($("#dblRoomRate").val()==" ")
				{
					alert('Please Enter Amount Greater than 0  !!!');
					$("#dblRoomRate.0").focus();
					flg=false;
				} 
				
				var table = document.getElementById("tblwalkindtl");
			    var rowCount = table.rows.length;
				if(rowCount==0)
				{
					alert("Please Enter Guest For Walkin");
					flg=false;
				}
				
				
				var walkinDate = new Date($("#txtWalkinDate").val()); //Year, Month, Date
		        var checkOutDate = new Date($("#txtCheckOutDate").val()); //Year, Month, Date
		       /*  if (walkinDate > checkOutDate) {
				    	alert("CheckOut Date Should not be come before Arrival Date");
				    	flg=false;
		        }
		         */
		        if(document.getElementById("tblIncomeHeadDtl").rows.length>0)
		        {
		        	var table = document.getElementById("tblTotalPackageDtl");
				    var rowCount = table.rows.length;
					if(rowCount>0)
					{
						if($("#txtPackageName").val()=='')
						 {
							alert("Please Enter Package Name");
							flg=false;
						 }
					}
		        }
		  		
			}	
					
			return flg;
		}	

		function funCalculateDiscount()
		{
				$("#txtTotalAmt").val(totalTerrAmt);
				var discPer=$("#txtDiscount").val();
				var grandTotCal=$("#txtTotalAmt").val()-($("#txtTotalAmt").val()*(discPer/100));
				
				$("#txtTotalAmt").val(grandTotCal);
				alert(+discPer+' Percent Discount is applied');
			
		}

		function funGetSelectedRow(obj)
		{
			
			 var index = obj.parentNode.parentNode.rowIndex;
			  //  var table = document.getElementById("tblRommRate");
			//    table.deleteRow(index);
			
			
			var isOk=confirm("Do You Want Change Amount For all Room Type Rate ?");
			if(isOk)
				{
					var value1=document.getElementById("dblRoomRate."+index).value;
					for(var i=0;i<document.getElementById("tblRommRate").rows.length;i++)
				    {
						document.getElementById("dblRoomRate."+i).value=value1;
						//var objName =document.getElementById("dblRoomRate."+i);
				      //  totalTarriff=totalTarriff+parseFloat(objName.value);
				    }
				}
			funCalculateTotals();
		}
		
		function funSetPlanMasterData(code)
		{
			$("#txtPlanCode").val(code);
			var searchurl=getContextPath()+"/loadPlanMasterData.html?planCode="+code;
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	if(response.strPlanCode=='Invalid Code')
				        	{
				        		alert("Invalid Plan Code");
				        		$("#txtPlanCode").val('');
				        	}
				        	else
				        	{
					        	$("#txtPlanDesc").val(response.strPlanDesc);
					        	
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
</script>



</head>
<body>
	<label id="formHeading">Walk In</label>
		<s:form name="Walkin" method="POST" action="saveWalkin.html">
		<div id="multiAccordion">	
<!--   General Tab Start -->
			<h3><a href="#">General</a></h3>
		 		 <div>
					<div class="container transTable">
						<div class="row" style="padding: 10px 0px;">
							<div class="col-md-2">
								<label>Walkin No</label>
								<s:input type="text" id="txtWalkinNo" path="strWalkinNo" cssClass="searchTextBox" ondblclick="funHelp('WalkinNo');"/>
							</div>
							<div class="col-md-2">
								<label>Walkin Date</label>
								<s:input type="text" id="txtWalkinDate" path="dteWalkinDate"  cssClass="calenderTextBox"  onchange="funChangeWalkinDate();" style="width:75%;" />
							</div>
							<div class="col-md-2">
								<label>Walkin Time</label>
								<s:input type="text" id="txtWalkinTime" path="tmeWalkinTime"  cssClass="calenderTextBox" style="width:75%;"/>
							</div>
							<div class="col-md-2">
								<label>Check-Out Date</label>
								<s:input type="text" id="txtCheckOutDate" path="dteCheckOutDate" cssClass="calenderTextBox"  onchange="CalculateDateDiff();" style="width:75%;"/>
							</div>
							<div class="col-md-2">
								<label>Check-Out Time</label>
								<s:input type="text" id="txtCheckOutTime" items="${tmeCheckOutPropertySetupTime}" path="tmeCheckOutTime"  cssClass="calenderTextBox" style="width:75%;"/>				
							</div><br><br><br>
							<div class="col-md-2"></div>
							<div class="col-md-2">
								<label>Corporate Code</label>
								<s:input type="text" id="txtCorporateCode" path="strCorporateCode" cssClass="searchTextBox" ondblclick="funHelp('CorporateCode');"/>
							</div>
							<div class="col-md-2">
								<label>Booker Code</label>
								<s:input type="text" id="txtBookerCode" path="strBookerCode" cssClass="searchTextBox" ondblclick="funHelp('BookerCode');"/>
							</div>
							<div class="col-md-2">
								<label>Agent Code</label>
								<s:input type="text" id="txtAgentCode" path="strAgentCode" cssClass="searchTextBox" ondblclick="funHelp('AgentCode');"/>
							</div>
							<div class="col-md-2">
								<label>Room Type</label>
	                  			<input type="text" id="txtRoomTypeCode" name="txtRoomTypeCode" Class="searchTextBox" ondblclick="funHelp('roomType')" />
	                  		</div>		
	                  		<div class="col-md-2">
								<label id="lblRoomType" style="background-color:#dcdada94; width: 100%; height: 43%; margin: 23px 0px;"></label>
							</div>
							<div class="col-md-2"></div>
							<div class="col-md-2">
								<label>Room No</label>
								<s:input type="text" id="txtRoomNo" name="txtRoomNo" ondblclick="funHelp1('roomByRoomType')" path="strRoomNo" cssClass="searchTextBox"/>
							</div>
							<div class="col-md-2"> 
								<label id="lblRoomDesc" style="background-color:#dcdada94; width: 100%; height: 43%; margin: 23px 0px;"></label>
							</div>
							<div class="col-md-2"> 
								<label>Extra Bed</label>
								<s:input type="text" id="txtExtraBed" name="txtExtraBed" path="strExtraBedCode" cssClass="searchTextBox" ondblclick="funHelp('extraBed')" />
							</div>
							<div class="col-md-2"> 
								<label id="lblExtraBed" style="background-color:#dcdada94; width: 100%; height: 43%; margin: 23px 0px;"></label>
							</div>
							<div class="col-md-2">
								<div class="row"> 
									<div class="col-md-6">  
										<label>#Adult</label>
										<s:input id="txtNoOfAdults" value = '1' name="txtNoOfAdults" path="intNoOfAdults" type="number" min="1" step="1" style="text-align: right;"/>
									</div>
									<div class="col-md-6"> 
										<label>#Child</label>
										<s:input id="txtNoOfChild" path="intNoOfChild" type="number" min="0" step="1" name="txtNoOfChild" style="text-align: right;"/>				
									</div>
								</div>
							</div>
							<div class="col-md-2"></div>
							<div class="col-md-2"> 
								<label>No Of Nights</label>
								<s:input   id="txtNoOfNights" path="intNoOfNights"  type="number"  style="text-align: right;width: 70%;" />
							</div>
							<div class="col-md-2"> 
								<label>Remarks</label>
								<s:input id="txtRemarks" path="strRemarks" />
							</div>	
							 <div class="col-md-2"><label>Plan </label><s:input id="txtPlanCode" path="strPlanCode" cssClass="searchTextBox" ondblclick="funHelp('plan')" style="height: 50%;width: 104%;"/></div>				
						     <div class="col-md-2"><label>Plan Desc</label><s:input id="txtPlanDesc" path="strPlanDesc"/></div>				
										
						</div>
					</div>
				</div>
<!--   General Tab end -->

<!--   Guest Tab start -->
			<h3><a href="#">Guest Details</a></h3>
				<div>
					<div class="container transTable">
						<div class="row">			
					  		<div class="col-md-2"> 
						   	 	<label>Guest Code</label>
						   		<input id="txtGuestCode"  ondblclick="funHelp('guestCode')" class="searchTextBox" />
						   	</div>
							<div class="col-md-2"> 
								<input type="Button" value="New Guest" onclick="return funCreateNewGuest()" class="btn btn-primary center-block" style="margin-top:20px;" />
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-2"> 
								<label>Mobile No</label>
								<input id="txtMobileNo"  name="txtMobileNo" type="text" />				
					  		</div>
					  		
					  		<div class="col-md-2"> 
					    		<label>Guest Name</label>
						 		<input id="txtGuestFirstName"  name="txtGuestFirstName" type="text" />
						 	</div>
						 	<div class="col-md-2"> 
								 <label>Middle Name</label>
					     		<input id="txtGuestMiddleName"  name="txtGuestMiddleName" type="text" />
					     	</div>
					     	<div class="col-md-2"> 
					     		<label>Last Name</label>
						 		<input id="txtGuestLastName"  name="txtGuestLastName" type="text" />
							</div>
							<div class="col-md-4"></div>					
					 		<div class="col-md-2"> 
								<label>Address</label>
						 		<input id="txtAddress"  name="txtAddress" type="text" />
						 	</div>
						 	<div class="col-md-2"> 
						 		<label>Remarks</label>
								<input type="text" id="txtRemark" path="strRemark" type="text" />
							</div>
							<div class="col-md-2"> 
						 		<input type="Button" value="Add" onclick="return funGetDetailsRow()" class="btn btn-primary center-block" style="margin-top:20px;" />
						 	</div>
						</div>
						
					<br> 
					<div class="dynamicTableContainer" style="height: 200px; margin-bottom:15px;">
						<table style="height: 28px; border: #0F0; width: 109%; font-size: 11px;">
							<tr bgcolor="#c0c0c0">
		<!-- 					<td style="width:13%;">Room Desc</td> -->
								<td style="width:13.5%;">Extra Bed</td>
								<td style="width:11%;">Room Type</td>
								<td style="width:12%;">Room No</td>
								<td style="width:13%;">First Name</td>
								<td style="width:13%;">Middle Name</td>
								<td style="width:10%;">Last Name</td>
								<td style="width:4%;">Mobile No</td>
								<td style="width:5%;">Adults</td>
								<td style="width:5%;">Child</td>
								<td style="width:5%;">Remarks</td>
								<td style="width:5%;">Delete</td>
							</tr>
						</table>
				
					 <div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 150px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 109%;">
						<table id="tblwalkindtl" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
							class="transTablex col8-center">
							<tbody>	
								<col style="width:13%">
								<col style="width:13%">
								<col style="width:13%">
								<col style="width:13%">
								<col style="width:13%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:4%">
								<col style="width:5%">
								<col style="width:5%">
								<col style="width:5%">
								<col style="display:none;">
							</tbody>
						</table>
					</div>
				</div>
			</div>	
		</div>

<!--   Guest Tab End  -->


<!-- 			<!-- Guest Details Tab Start --> 
<!-- 			<div id="tab2" class="tab_content" style="height: 400px"> -->
<!-- 			<br> <br> -->
<!-- 			 <table class="transTable"> -->
<!-- 				<tr> -->
<!-- 					 <td> -->
<!-- 						   <label>GuestPrefix</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<s:select id="cmbGuestPrefix" path="strGuestPrefix" cssClass="BoxW124px"> --%>
<%-- 			    			<s:options items="${prefix}"/> --%>
<%-- 			    	    </s:select>							 --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 						<label>FirstName</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<s:input colspan="3" type="text" id="txtFirstName" path="strFirstName"  />							 --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 						<label>MiddleName</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 					 	<s:input colspan="3" type="text" id="txtMiddleName" path="strMiddleName"  />						 --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 		      		<td> -->
<!-- 				    	<label>LastName</label> -->
<!-- 					</td> -->
<!-- 					<td>				 -->
<%-- 						<s:input colspan="3" type="text" id="txtLastName" path="strLastName"  /> --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 						<label>Gender</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<s:select id="cmbGender" path="strGender" cssClass="BoxW124px"> --%>
<%-- 			    			<s:options items="${gender}"/> --%>
<%-- 			    		</s:select> --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 						<label>DOB</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 					    <s:input colspan="3" type="text" id="txtDOB" path="dteDOB" cssClass="calenderTextBox" /> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				    <td> -->
<!-- 						<label>Designation</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						 <s:input colspan="3" type="text" id="txtDesignation" path="strDesignation"  />							 --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 						<label>Address</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<s:input colspan="3" type="text" id="txtAddress" path="strAddress"  />							 --%>
<!-- 					</td> -->
<!-- 					<td> -->
<!-- 					   	<label>City</label> -->
<!-- 					</td> -->
<!-- 					<td> -->
<%-- 						<s:select id="cmbCity" path="strCity" cssClass="BoxW124px"> --%>
<%-- 			    			<s:options items="${listCity}"/> --%>
<%-- 			    		</s:select>						 	 --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			  	
<tr> -->
<!-- 					<td> -->
<!-- 						<label>State</label> -->
<!-- 					</td> -->
<!-- 					<td>  -->
<%-- 						<s:select id="cmbState" path="strState" cssClass="BoxW124px"> --%>
<%-- 			    			<s:options items="${listState}"/> --%>
<%-- 			    		</s:select> --%>
<!-- 					</td> -->
<!-- 						<td> -->
<!-- 							<label>Country</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
						 
<%-- 						 <s:select id="cmbCountry" path="strCountry" cssClass="BoxW124px"> --%>
<%-- 			    			<s:options items="${listCountry}"/> --%>
<%-- 			    		</s:select> --%>
						
<!-- 						</td> -->
						
<!-- 						<td> -->
					
<!-- 							<label>Nationality</label> -->
<!-- 						</td> -->
<!-- 						
<td> -->
<%-- 						   <s:input colspan="3" type="text" id="txtNationality" path="strNationality"  /> --%>
							
<!-- 						</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					 <td> -->
<!-- 						   <label>PinCode</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						<s:input colspan="3" type="text" id="txtPinCode" path="intPinCode"/> --%>
							
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 							<label>MobileNo</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						      <s:input colspan="3" type="text" id="txtMobileNo" path="intMobileNo" onblur="fun1(this);" /> --%>
							 
<!-- 						</td> -->
						
<!-- 						
<td> -->
<!-- 							<label>FaxNo</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						   <s:input colspan="3" type="text" id="txtFaxNo" path="intFaxNo" /> --%>
							
<!-- 						</td> -->
						
<!-- 				</tr> -->
				
<!-- 				<tr>	 -->
<!-- 						<td> -->
<!-- 							<label>EmailId</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						   <s:input colspan="3" type="text" id="txtEmailId" path="strEmailId" /> --%>
							
<!-- 						</td> -->
						
<!-- 						<td> -->
<!-- 						   <label>PANNo</label> -->
<!-- 						</td> -->
<!-- 						
<td> -->
<%-- 						   <s:input colspan="3" type="text" id="txtPANNo" path="strPANNo"  /> --%>
						
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 							<label>ArrivalFrom</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						    <s:input colspan="3" type="text" id="txtArrivalFrom" path="strArrivalFrom"  /> --%>
							
<!-- 						</td> -->
<!-- 				</tr> -->
				
					
<!-- 				<tr> -->
<!-- 					  <td> -->
<!-- 							<label>ProceedingTo</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						  <s:input colspan="3" type="text" id="txtProceedingTo" path="strProceedingTo" /> --%>
							
<!-- 						</td> -->
						
<!-- 						<td> -->
<!-- 							<label>Status</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						   <s:input colspan="3" type="text" id="txtStatus" path="strStatus" /> --%>
							
<!-- 						
</td> -->
						
<!-- 						<td> -->
<!-- 						   <label>VisitingType</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 					      <s:input colspan="3" type="text" id="txtVisitingType" path="strVisitingType"  /> --%>
						
<!-- 						</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 						<td> -->
<!-- 							<label>PassportNo</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						    <s:input colspan="3" type="text" id="txtPassportNo" path="strPassportNo"  /> --%>
							
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 							<label>PassportIssueDate</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
						    
<%-- 							 <s:input colspan="3" type="text" id="txtPassportIssueDate" path="dtePassportIssueDate" cssClass="calenderTextBox" /> --%>
<!-- 						</td> -->
						
<!-- 						<td> -->
<!-- 							<label>PassportExpiryDate</label> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						      <s:input colspan="3" type="text" id="txtPassportExpiryDate" path="dtePassportExpiryDate" cssClass="calenderTextBox" /> --%>
						
<!-- 						</td> -->
<!-- 				</tr> -->
<!-- 				</table> -->
<!-- 				</div> -->
<!-- 			<!--Personal Tab End  -->

<!-- Start Tariff Tab -->

			<h3><a href="#">Tariff</a></h3>
			<div>
		 		<div class="container">
					<div class="dynamicTableContainer" style="height: auto; width: 85%">
						<table style="height: 28px; border: #0F0; width: 100%;font-size:13px;">
							<tr bgcolor="#c0c0c0" style="height: 24px;">
								<!-- col1   -->
								<td align="center" style="width: 35%;text-align:left">Date</td>
									<!-- col1   -->
									<!-- col2   -->
								<td align="center" style="width: 35%;text-align:left">Room Type.</td>
									<!-- col2   -->
									<!-- col3   -->
								<td align="center" style="width: 35%;text-align:left">Rate.</td>
									<!-- col3   -->		
							</tr>
						</table>
						<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 200px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
							<table id="tblRommRate" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll" class="transTablex col3-center">
								<tbody>
									<!-- col1   -->
									<col style="width:34%">
									<!-- col1   -->
									
									<!-- col2   -->
									<col style="width:34%" >
									<!-- col2   -->
									
									<!-- col3   -->
									<col style="width:34%" >
									<!-- col3   -->
									
									<!-- col4   -->
									<col style="width:0%" >
									<!-- col4   -->
								</tbody>
							</table>
						</div>
					</div>
					<div class="row" style="padding-bottom:10px;">
						<div class="col-md-2">
							<label>Total</label>
							<s:input id="txtTotalAmt" path="" style="text-align:right" readonly="true"/>
						</div>
						<div class="col-md-2">
							<label>Discount</label>
							<s:input id="txtDiscount" step="0.01" path="dblDiscountPercent" style = "text-align:right;" onblur="funCalculateDiscount();"  />
						</div>
					</div>
				</div>
			</div>
<!-- End Tariff Tab -->



<!-- Start of Package Tab -->
	 <h3><a href="#">Package</a></h3>
		 <div>
	 		<div class="container transTable">
	 			<div class="row" style="padding:10px">
			 	  <div class="col-md-2">
					   <label>Package Code</label>
					   <s:input id="txtPackageCode" path="strPackageCode"  readonly="true"  ondblclick="funHelp('package')" cssClass="searchTextBox"/>
				  </div>
				  <div class="col-md-2">
					   <label>Package Name</label>
					   <s:input id="txtPackageName" path="strPackageName" />
				  </div>
				  <div class="col-md-2">
					  <label>Income Head</label>
					  <s:input id="txtIncomeHead" path=""  readonly="true"  ondblclick="funHelp('incomeHead')" cssClass="searchTextBox"/>
				  </div>
				  <div class="col-md-2">
					   	<label>Income Head Name</label>
						<input type="text" id="txtIncomeHeadName" path=""   />
				  </div>
				  <div class="col-md-2">
					    <label>Amount</label>
					    <input type="text" id="txtIncomeHeadAmt" path="" style="text-align:right" Class="BoxW124px"  />
				  </div>
				   <div class="col-md-2"></div>
				  <div class="col-md-2">
						<input type="button" value="Add" class="btn btn-primary center-block" style="margin-top:20px;" onclick='return funAddRow()'/>
				 </div>
			</div>
		
		<!-- Generate Dynamic Table   -->		
			<div class="dynamicTableContainer" style="height: 320px;margin-bottom: 15px;">
				<table style="height: 28px; border: #0F0; width: 100%;font-size:13px;">
					<tr bgcolor="c0c0c0" style="height: 24px;">
						<!-- col1   -->
						<td align="left" style="width: 30.6%">Income Head Code</td>
						<!-- col1   -->
						
						<!-- col2   -->
						<td align="left" style="width: 30.6%">Income Head Name</td>
						<!-- col2   -->
						
						<!-- col3   -->
						<td align="right" style="width: 30.6%">Amount</td>
						<!-- col3   -->
						<!-- col4   -->
						<td align="center">Delete</td>
						<!-- col4  -->									
					</tr>
				</table>
			<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 200px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
				<table id="tblIncomeHeadDtl" style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll" class="transTablex col3-center">
					<tbody>
						<!-- col1   -->
					
						<col width="100%">
						<!-- col1   -->
						
						<!-- col2   -->
						<col width="100%" >
						<!-- col2   -->
						
						<!-- col3   -->
						<col width="100%" >
						<!-- col3   -->
						
						<!-- col4   -->
						<col  width="10%">
						<!-- col4   -->
					</tbody>
				</table>
			</div>	
			
			<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 120px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
				<table id="tblTotalPackageDtl" style="width: 100%; border: #0F0; font-size:15px; font-weight: bold; table-layout: fixed; overflow: scroll" class="display dataTable no-footer">
					<tbody>
						<!-- col1   -->
						<col width="100%" >
						<!-- col1   -->
						<!-- col2   -->
						<col width="100%" >
						<!-- col2   -->
						
						<!-- col3   -->
						<col  width="10%">
						<!-- col3   -->
					</tbody>
				</table>
			</div>		
		</div>
	 </div>
	 
   <!-- End of Package Tab -->
					
</div>
		
		<!-- <div class="center">
			<a href="#"><button class="btn btn-primary center-block" tabindex="3" value="Submit" onclick="return funValidateForm();"
				class="form_button">Submit</button></a>
			<a href="#"><button class="btn btn-primary center-block" value="Reset" onclick="funResetFields()"
				class="form_button">Reset</button></a>
		</div> -->
		
		<p class="center" style="margin-top:10px;">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block form_button" onclick="return funValidateForm();" style="color:#000;padding-bottom: 23px;"/>
			&nbsp;<input type="reset" value="Reset" class="btn btn-primary center-block form_button" onclick="funResetFields()" style="color:#000;padding-bottom: 23px;"/>
		</p>	
		
			<s:input type="hidden" id="hidIncomeHead" path="strIncomeHeadCode"></s:input>
			<s:input type="hidden" id="txtTotalPackageAmt" path="strTotalPackageAmt"></s:input>
		<br>
		<br>
</div>
	</s:form>



<script type="text/javascript">
		$(function(){
			$('#multiAccordion').multiAccordion({
// 				active: [1, 2],
				click: function(event, ui) {
				},
				init: function(event, ui) {
				},
				tabShown: function(event, ui) {
				},
				tabHidden: function(event, ui) {
				}
				
			});
			
			$('#multiAccordion').multiAccordion("option", "active", [0]);  // in this line [0,1,2] wirte then these index are open
		});
		</script>
		
</body>
</html>
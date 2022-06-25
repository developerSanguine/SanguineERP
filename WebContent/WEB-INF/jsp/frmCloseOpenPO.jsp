<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	
	    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />

		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	
	<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>
	<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
    <title>Close Open PO</title>
	
<style type="text/css">

   #tblCloseOpenPO tbody tr:first-child{
		background:#c0c0c0;
	}
	#tblCloseOpenPO tbody{
		background:#fbfafa;
	}
	#tblCloseOpenPO tbody td{
	border:1px solid #000;
	}
</style>	
<script type="text/javascript">
//Set Focus on Location Name
$(document).ready(function(){
	resetForms("frmCloseOpenPO");
	$("#txtlocName").focus();
	
	 <%if (session.getAttribute("success") != null) 
				{			
				  boolean test = ((Boolean) session.getAttribute("success")).booleanValue();			
					session.removeAttribute("success");
					if (test) {
						%>
						alert("PO Updated Successfully ");
					<%
					}
				}%>
				
	$("#chkALL").click(function ()
			{
			    $(".POCheckBoxClass").prop('checked', $(this).prop('checked'));
			});
});



		$(function ()
		{
			var startDate="${startDate}";
			var startDateOfMonth="${startDateOfMonth}";
			var arr = startDate.split("/");
			Dat=arr[0]+"-"+arr[1]+"-"+arr[2];
			$( "#txtFromDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtFromDate" ).datepicker('setDate', startDateOfMonth);
			$( "#txtToDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtToDate" ).datepicker('setDate', 'today');
			
			 var locationCode ='<%=session.getAttribute("locationCode").toString()%>';
			
			 $("#cmbLocation").val(locationCode);
			 var transecExportType='';
			

			$('a#urlDocCode').click(function() 
			{
			    $(this).attr('target', '_blank');
			});
			
});
	
	
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
		 
		function funOnClickExcecute()
			{
			
				if($("#txtLocCode").val()=='')
				{
					alert("Enter Location Code!");
					return false;
				}
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var table = document.getElementById("tblCloseOpenPO");
				var rowCount = table.rows.length;
				while(rowCount>0)
				{
					table.deleteRow(0);
					rowCount--;
				}
				
				var fromDate=$("#txtFromDate").val();
				var toDate=$("#txtToDate").val();
				var locCode=$("#txtLocCode").val();
	           
				funGetCloseOpenPO(fromDate,toDate,locCode);
				
	            return false;
			}
			
				
function funGetCloseOpenPO(fromDate,toDate,locCode){
	
	var searchUrl=getContextPath()+"/LoadCloseOpenPOforGRN.html?locCode="+locCode+"&fDate="+fromDate+"&tDate="+toDate;
	$.ajax({
		type :"GET",
		url : searchUrl,
		dataType : "json",
		async: false,
		success: function(response){
			funRemRows();
			$.each(response, function(i,item)
			{
				funFillBillTable(response[i].strPOCode,response[i].dtPODate,response[i].strSuppName,response[i].strAgainst,response[i].strSOCode,response[i].dblTotal,response[i].strUserCreated,response[i].dtDateCreated,response[i].strGRNCode,response[i].dtGRNDate);
				
			});
			
		},
		error : function(jqXHR, exception)
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

	
	
	
function funFillBillTable(strPOCode,dtPODate,strSuppName,strAgainst,strSOCode,dblTotal,strUserCreated,dtDateCreated,strGRNCode,dtGRNDate)
{
	
    var table = document.getElementById("tblCloseOpenPO");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    
  
  //  row.insertCell(0).innerHTML= "<input  id=\"cbSel."+(rowCount)+"\"  type=\"checkbox\"  class=\"POCheckBoxClass \"  style=\"padding-left: 5px;width: 100%;\" name=\"listCloseOpenPODtl["+(rowCount)+"].strPOCodeisSelected\" onClick=\"Javacsript:funCheckPOSelected("+rowCount+")\"  id=\"strPOCodeisSelected."+rowCount+"\" value='N' >";
    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" type=\"checkbox\"  class=\"Box \"  style=\"padding-left: 5px;width: 100%;\" name=\"listCloseOpenPODtl["+(rowCount)+"].strPOCodeisSelected\" onClick=\"Javacsript:funCheckPOSelected("+rowCount+")\"  id=\"strPOCodeisSelected."+rowCount+"\" value='N' >";
    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: left;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strPOCode\" id=\"strPOCode."+(rowCount)+"\" value='"+strPOCode+"' />";
    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: left;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].dtPODate\" id=\"dtPODate."+(rowCount)+"\" value='"+dtPODate+"' />";
   	row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: left;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strSuppName\" id=\"strSuppName."+(rowCount)+"\" value='"+strSuppName+"' />";
    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strAgainst\" id=\"strAgainst."+(rowCount)+"\" value='"+strAgainst+"' />";
    row.insertCell(5).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strSOCode\" id=\"strSOCode."+(rowCount)+"\" value='"+strSOCode+"' />";
    row.insertCell(6).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].dblTotal\" id=\"dblTotal."+(rowCount)+"\" value='"+dblTotal+"' />";
    row.insertCell(7).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strUserCreated\" id=\"strUserCreated."+(rowCount)+"\" value='"+strUserCreated+"' />";
    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].dtDateCreated\" id=\"dtDateCreated."+(rowCount)+"\" value='"+dtDateCreated+"' />";
    row.insertCell(9).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].strGRNCode\" id=\"strGRNCode."+(rowCount)+"\" value='"+strGRNCode+"' />";
    row.insertCell(10).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" style=\"text-align: right;width:100%\" name=\"listCloseOpenPODtl["+(rowCount)+"].dtGRNDate\" id=\"dtGRNDate."+(rowCount)+"\" value='"+dtGRNDate+"' />";
    
       
}


function funCheckPOSelected(count)
{
	
	var no=0;
	$('#tblCloseOpenPO tr').each(function() {
		
		if(document.getElementById("strPOCodeisSelected."+no).checked == true)
		{
			document.getElementById("strPOCodeisSelected."+no).value='Y';
		
		}
		else
		{
		 document.getElementById("strPOCodeisSelected."+no).value='N';
		}
		no++;
	});

	
	
}






//	Remove All Row from Grid
		function funRemRows() 
		{
			var table = document.getElementById("tblCloseOpenPO");
			var rowCount = table.rows.length-1;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		//Check Which PO is selected
	/*	function funCheckUncheck()
		{
			
			var table = document.getElementById("tblCloseOpenPO");
			var rowCount = table.rows.length;	
			
		    for (var i=1;i<rowCount;i++)
		    {
		        if(document.all("chkALL").checked==true)
		        {
		        	
		        	document.all("cbSel."+i).checked=true; 
		        }
		        else
		        {
		        	document.all("cbSel."+i).checked=false;  
		        }
		    }
			
		}		 
		
	*/	
		
		
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


//Set data on the basis of selecting Help
function funSetData(code)
		{			
			switch (fieldName) 
			{			   
			   case 'locationmaster':
			    	funSetLocation(code);
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

/*
Checking Validation before submiting the data
*/
function funCallFormAction(actionName, object) {
	//if(clickCount==0){
		//clickCount=clickCount+1;

		
		 var rowCount = $('#tblCloseOpenPO tr').length;
				    //alert(rowCount1);
				    if(rowCount>0)
				    	{
							return true;
				    	}
				    else
				    	{
				    		alert("Please Fill the Grid");
				    		return false;
				    	} 
		
			/*		if(("strPOCodeisSelected.").val()=='')
					{
					   alert("Please Select the PO Code!");
					   return false;
					}

  */
	
	
	}	






function funResetFields()
{
	location.reload(true); 
}	

</script>

<body>
	<div  class="container transTable">
		<label id="formHeading">Close Open PO</label>
	    <s:form name="frmCloseOpenPO" method="GET" action="UpdateCloseOpenPO.html" target="_blank" >
	   		<br />
	                <div class="row transTable">
	                 <div class="col-md-2">
				        <label>Location Code </label>
				        <s:input id="txtLocCode" name="txtLocCode" path="strLocCode" readOnly="true" ondblclick="funHelp('locationmaster')"   cssClass="searchTextBox"/>
				    </div>
				    <div class="col-md-3">
				     	<label>Location Name</label>
				        <s:input type="text" id="txtlocName" name="txtlocName" size="80px"  path="strLocName" cssStyle="text-transform: uppercase;" required="true"/>
				        <s:errors path="strLocName"></s:errors>
				    </div>  
				     </div>  
			    <!-- <div class="col-md-4"></div> -->
			    <div class="row transTable">
			     <div class="col-md-2">	  
				      <label id="lblFromDate">From Date</label>
			          <s:input id="txtFromDate" name="fromDate" path="dteFromDate" cssClass="calenderTextBox" style="width:80%;"/>
			          <s:errors path="dteFromDate"></s:errors>
			     </div>
			     <div class="col-md-2">	
				      <label id="lblToDate">To Date</label>
			       		<s:input id="txtToDate" name="toDate" path="dteToDate" cssClass="calenderTextBox" style="width:80%;"/>
			        	<s:errors path="dteToDate"></s:errors>
			      </div>
			      
			     </div>
			     <div class="center" style="margin-right: 50%;">
			
				<input  type="button" value="Execute"  id="btnExecute" class="btn btn-primary center-block" class="form_button"
				onclick="return funOnClickExcecute()" />&nbsp;
				</div>
				
				
	  	<div class="dynamicTableContainer" style="height: 400px;" width="108%">
			<table style="width: 100%; border: #0F0; table-layout: fixed;"class="transTablex col15-center" >
				
		
		<!--  <td width="15%">Select<input type="checkbox" id="chkALL" onclick="funCheckUncheck()" /></td>	-->	
								
								<td width="12%" col align="left">Select</td>					
								<td width="25%" col align="center">PO Code</td>
								<td width="24%">PO Date</td>			
								<td width="40%" col align="center">SupplierName</td>    
								<td width="18%">PO Against</td>
								<td width="25%">Document_No</td>				
								<td width="20%">PO_Amount</td>    
								<td width="20%">User Created</td>
								<td width="20%">Date Created</td>
								<td width="25%">PartialGRN_Code</td>   
								<td width="15%">PartialGRN_Date</td>
				</tr>
				
			</table>
			
		  	<div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 330px; margin: auto;  width: 103%;">
			<table id="tblCloseOpenPO" style="width: 100%; border: #0F0; table-layout: fixed;overflow: scroll;" class="transTablex col15-center">		
		       <tbody>
					
						<colgroup><col style="width: 11%">
						<col style="width: 22%">
						<col style="width: 22%">
						<col style="width: 35%">
				 		<col style="width: 15%"> 
						<col style="width: 18%">
						<col style="width: 18%">
						<col style="width: 18%"> 
						<col style="width: 18%">
						<col style="width: 22%;/* padding-right: 7%; */">
						<col style="width: 20%">
					</colgroup>
					</tbody>
				</table>
			</div>
		</div>
			
			<br>
			<p align="center" style="margin-right: 6%;">
				<input type="submit" value="Submit" class="btn btn-primary center-block" class="form_button" onclick="return funCallFormAction('submit',this)" />
				&nbsp;
				<input type="button" value="Reset" class="btn btn-primary center-block" class="form_button"  onclick="funResetFields()"/>
			</p>
			
			
			
			
			
			
		</s:form>
		</div>
	</body>
</html>
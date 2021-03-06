<%@ page language="java" contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<spring:url value="/resources/js/jQuery.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js"/>"></script>	
<script type="text/javascript" src="<spring:url value="/resources/js/validations.js"/>"></script>
	
<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />	


<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

 	
	<%-- End Default Script For Page  --%>
	
	<%-- Started Default CSS For Page  --%>

	 	
	 	<link rel="stylesheet"  href="<spring:url value="/resources/css/pagination.css"/>" />
	 	<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
	 	<link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 
 	
 	<%-- End Default CSS For Page  --%>
 	
 	<%--  Started Script and CSS For Select Time in textBox  --%>
	
	
	<%-- End Script and CSS For Select Time in textBox  --%>

<title>Grn For Bill Passing</title>	
<script type="text/javascript">
//From Close after Pressing ESC Button
	window.onkeyup = function (event) {
		if (event.keyCode == 27) {
			window.close ();
		}
	}
</script>
<script type="text/javascript">
	//Ajax Waiting
	$(document).ready(function() 
		{
		
		var startDate="${startDate}";
		var arr = startDate.split("/");
		 
		var date = new Date(); 
		var month=date.getMonth()+1;
        Dat= 1 +"-"+month+"-"+date.getFullYear();
        
	    $("#txtReqFromDate").datepicker({ dateFormat: 'dd-mm-yy' });
	    $("#txtReqFromDate" ).datepicker('setDate', Dat);
		
	    $("#txtReqToDate").datepicker({ dateFormat: 'dd-mm-yy' });
	    $("#txtReqToDate" ).datepicker('setDate', 'today');
	    $(document).ajaxStart(function()
		 	{
			    $("#wait").css("display","block");
		  	});
		 	
			$(document).ajaxComplete(function()
			{
			    $("#wait").css("display","none");
			});	
		});
		
	//Get Project Path	
	function getContextPath() 
	{
		return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	}
	//Get supplier Code when Form is loding
	function funExecute()
	{
		
		var strSuppCode='<%=request.getParameter("strSuppCode") %>';
		var strFromDate= $("#txtReqFromDate").val();
		var strToDate= $("#txtReqToDate").val();
		funFillDetails(strSuppCode,strFromDate,strToDate);
	}
	
	//Getting Purchase Order Data based on supplier
	function funFillDetails(strSuppCode,strFromDate,strToDate)
	{
		var searchUrl=getContextPath()+"/loadGRNForBillPassing.html?strSuppCode="+strSuppCode+"&strFromDate="+strFromDate+"&strToDate="+strToDate;	
		$.ajax({
	 	        type: "GET",
	 	        url: searchUrl,
	 		    dataType: "json",
	 		    success: function(response)
	 		    {
	 		    	funRemRows();
			    	$.each(response, function(i,item)
	 		         {
			    		funfillGrid(response[i][0],response[i][1],response[i][2],response[i][3],response[i][4]);
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

	//Filling Grid
	function funfillGrid(strGRNCode,dtGRNDate,bill,total,location)
	{	   
	    var table = document.getElementById("tblDNDet");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input id=\"cbSel."+(rowCount)+"\" type=\"checkbox\"  />";
	    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"12%\" id=\"strGRNCode."+(rowCount)+"\" value='"+strGRNCode+"'>";
	    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\" id=\"dtPODate."+(rowCount)+"\" value='"+dtGRNDate+"' >";
	    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"strAgainst."+(rowCount)+"\" value='"+bill+"' >";
	    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;\" size=\"20%\" id=\"total."+(rowCount)+"\" value='"+total+"' >";
	    row.insertCell(5).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"currency."+(rowCount)+"\" value='"+location+"' >";
	    
	    
	}
	
	//Remove All Row from Grid
	function funRemRows() 
	{
		var table = document.getElementById("tblDNDet");
		var rowCount = table.rows.length-1;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	
	//Check Which PO is selected
	function funCheckUncheck()
	{
		
		var table = document.getElementById("tblDNDet");
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
	
	//After Closing Windows Return back to Data in GRN
	function btnClose_onclick()
	{
	    var table = document.getElementById("tblDNDet");
	    var rowCount = table.rows.length;  
	    var strGRNCode="";
	    for(no=1;no<rowCount;no++)
	    {
	        if(document.all("cbSel."+no).checked==true)
	        	{
	        		//alert(document.all("strReqCode."+no).innerHTML);
	            	strGRNCode=strGRNCode+document.all("strGRNCode."+no).value+",";
	        	}
	    }
	    strGRNCode=strGRNCode.substring(strGRNCode,strGRNCode.length-1)    
	    window.returnValue=strGRNCode+"#";
	    window.close()
	}
	
 //function funExecute()
	//{
   	//  strLocFrom='<%=request.getParameter("strLocFrom") %>'
    //  strLocTo='<%=request.getParameter("strLocTo") %>'  
    //      var fromDate= $("#txtReqFromDate").val();
        //  var toDate= $("#txtReqToDate").val();
      //    funfillgrnData(strLocFrom,strLocTo,fromDate,toDate);

	//}
	

</script>
</head>
<body onload="funOnLoad()">
<div style="width: 100%; height: 40px; background-color: #c0c0c0">
		<p align="center" style="padding-top: 5px;color: white">PO for GRN</p>
	</div>
    <form id="form1"> 
    
    <table  class="masterTable" style="width: 100%">
                           <%--  <tr>
                                <td>Group</td>
                                <td >
                                    <select id="cmbGroup" onchange="funFillSubGroup()" >
                                        <option selected="selected" value="ALL">ALL</option>
                                    </select>
                                </td>
                                <td >
                                    Sub Group</td>
                                <td >
                                    <label id="lblWODate"></label>
                                    <select id="cmbSGroup">
                                        <option selected="selected" value="ALL">ALL</option>
                                    </select></td>
                            </tr> --%>
                            <tr>
                            <td>
							<div class="">
								<label>from Date</label>.
								<input id="txtReqFromDate" name="txtReqFromDate" type="text" required="required"  pattern="\d{1,2}-\d{1,2}-\d{4}" 
										 cssClass="calenderTextBox" style="width:80%;"/>
								
							</div>
                            </td>
                            <td>
                            
								<div class="">
									<!-- <td><label>MIS Date:</label></td> -->
									<label>To Date</label>
							<input id="txtReqToDate" name="txtReqToDate" type="text" required="required"  pattern="\d{1,2}-\d{1,2}-\d{4}" 
											 cssClass="calenderTextBox" style="width:80%;"/>
								</div>
                            </td> 
                            
                             <td>
                              		 	<button type="button" class="btn btn-primary center-block" id="btnExecute" onclick="funExecute()" value="EXECUTE">Execute</button>
                              
                             </td>
                            </tr>
                           
                        </table>
          
        <div style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 450px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 99.80%;">
			<table id="tblDNDet"  class="masterTable" style="width: 90%;border-collapse: separate; ">
                 <tbody>
                     <tr bgcolor="#c0c0c0">
                           <td width="10%">Select<input type="checkbox" id="chkALL" onclick="funCheckUncheck()" /></td>	
						   <td width="15%">GRN Code</td>				
						   <td width="15%">Date</td>    
						   <td width="16%">Bill No</td>
						   <td width="10%">Amount</td>
						   <td width="12%">Location</td>
						</tr>
                   </tbody>
              </table>
          </div>
         <div class="center" style="text-align:center">
			<a href="#"><button class="btn btn-primary center-block" id="btnClose" value="Close" onclick="return btnClose_onclick()" style="padding: 10px;">Close</button></a> &nbsp;
		</div>
       <div id="wait"
			style="display: none; width: 60px; height: 60px; border: 0px solid black; position: absolute; top: 60%; left: 55%; padding: 2px;">
			<img
				src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif"
				width="60px" height="60px" />
		</div>
       
    </form>
</body>
</html>
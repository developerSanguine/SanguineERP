<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>REPORT GROUP MASTER</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
  
<script type="text/javascript">
	/*On form Load It Reset form :Ritesh 22 Nov 2014*/
	$(document).ready(function() {
		
		$("#txtGroupName").focus();
	});

</script>  


<script type="text/javascript">
	var fieldName;
	
	
	function funSetData(code) {
		switch (fieldName) {
		case "property":
			funSetPropertyData(code);
			break;
		 case "reportgroup":
			 funSetReportGroupData(code);
			break; 
		}
	}
	
	 
	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	
	} 
	
	
	
 
	
	
	function funSetPropertyData(code)
	{
		$("#txtPropertyCode").val(code);
		var searchurl=getContextPath()+"/loadPropertyMasterData.html?Code="+code;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if('Invalid Code' == response.propertyCode){
							alert("Invalid Property Code")
							$("#txtPropertyCode").val('');
							$("#lblPropertyName").text('');
							$("#txtPropertyCode").focus();
							
						}else{
							$("#txtPropertyCode").val(response.propertyCode);
							$("#lblPropertyName").text(response.propertyName);
							
							
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
	

	
	function funSetReportGroupData(code)
	{
		$("#txtGroupCode").val(code);
		var searchurl=getContextPath()+"/loadReportGroupMasterData.html?groupCode="+code;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strGroupCode=='Invalid Code')
			        	{
			        		alert("Invalid Group Code");
			        		$("#txtGroupCode").val('');
			        	}
			        	else
			        	{
			        		$("#txtGroupCode").val(response.strGCode);
				        	$("#txtGroupName").val(response.strGName);
				        	
				        	$("#txtGroupName").focus();
				        	var listdata=response.listPropertyDtlModel
							$.each(listdata, function(i,item)
			                {
								//count=i;
								funLoadPropertyGroupData(listdata[i].propertyCode,listdata[i].propertyName);
								                          
			                });
							//listRow=count+1;
				        
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
	
	function funResetFields() 
	{
	 location.reload(true); 	
	}

//Check Validation Submit on Click
	/* function funCallFormAction(actionName,object) 
	{
		var flg=true;
		
		if($('#txtGroupCode').val().trim()=="")
			{
				alert("Please Select Group Code");
				$('#txtGroupCode').focus();
				return false;
			}
		if($('#txtPropertyCode').val().trim()=="")
		{
			alert("Please Select Property Code");
			return false;
		}
		
	}
	*/
	 
	
/*	function funRemoveProductRows()
	{
		var table = document.getElementById("tblProperty");
		var rowCount = table.rows.length;
		while(rowCount>0)
		{
			table.deleteRow(0);
			rowCount--;
		}
	}
	*/
	
	function btn_AddOnclick()
	{			
		
		if($("#txtPropertyCode").val().trim().length==0)
	    {
			  	alert("Please Enter Property Code Or Search");
		     	$('#txtPropertyCode').focus();
		     	return false; 
	    }
		
	    else
	    {
			funAddRow();
        }
	 
	}
	
	function funLoadPropertyGroupData(strPropertyCode,strPropertyName)
	{
		
	    var table = document.getElementById("tblPropertyCode");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    
	    row.insertCell(0).innerHTML= "<input name=\"listPropertyDtlModel["+(rowCount)+"].propertyCode\" readonly=\"readonly\" class=\"Box PropertyCode\" size=\"9%\" id=\"txtPropertyCode."+(rowCount)+"\" value='"+strPropertyCode+"'>";
	    row.insertCell(1).innerHTML= "<input name=\"listPropertyDtlModel["+(rowCount)+"].propertyName\" readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"lblPropertyName."+(rowCount)+"\" value='"+strPropertyName+"' >";
	    row.insertCell(2).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">'; 
	    //listRow++;
	    
	}
	
	
	
	
	function funAddRow() 
	{
		var propertyCode = $("#txtPropertyCode").val();
	    var propertyName =$("#lblPropertyName").text();		    
	   
	    var table = document.getElementById("tblPropertyCode");
	    var rowCount = table.rows.length;
	    var row = table.insertRow(rowCount);
	    row.insertCell(0).innerHTML= "<input name=\"listPropertyDtlModel["+(rowCount)+"].propertyCode\" readonly=\"readonly\" class=\"Box PropertyCode\" size=\"9%\" id=\"txtPropertyCode."+(rowCount)+"\" value='"+propertyCode+"'>";
	    row.insertCell(1).innerHTML= "<input name=\"listPropertyDtlModel["+(rowCount)+"].propertyName\" readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"lblPropertyName."+(rowCount)+"\" value='"+propertyName+"' >";
	    row.insertCell(2).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">'; 
   } 
	
	//Delete particular row when click on delete button on product 
	function funDeleteRow(obj)
	{
	    var index = obj.parentNode.parentNode.rowIndex;
	    var table = document.getElementById("tblPropertyCode");
	    table.deleteRow(index);
	    
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
		<%
		}}%>

	});
	
	</script>


	
   <body>
<div class="container">
	<label id="formHeading">Report Group Master</label>
	<s:form name="frmReportGroupMaster" method="POST" action="saveReportGroupMaster.html">
		
		<div class="row masterTable">
		
			<div class="col-md-2">
				<label>Report Group Code</label>
				<s:input colspan="4" type="text" id="txtGroupCode" path="strGCode" cssClass="searchTextBox" ondblclick="funHelp('reportgroup')"/>
				
			</div>
		 
			<div class="col-md-2">
				<label>Report Group Name</label>
				<s:input colspan="4" type="text" id="txtGroupName" path="strGName" /> <s:errors path="strGName"></s:errors>
			</div>
		
			<br>
		
			<div class="col-md-8"></div>
			
<div class="col-md-2">
<label id = "lblPropertyCode">Property Code</label>
 <s:input path="strPropertyCode" id="txtPropertyCode" required="required" ondblclick="funHelp('property');" cssClass="searchTextBox" />
 
</div>
	
 <div class="col-md-2">
<label for="strPropertyName" id="lblPropertyName"
style="font-size: 12px; background-color: #dcdada94; width: 100%; height: 51%; margin-top: 27px;padding: 4px;"></label> 
</div>

	
		
		</div>
		<div class="col-md-2">
			<input id="btnAdd" type="button" value="Add" class="btn btn-primary center-block" onclick="return btn_AddOnclick();" style="margin-top:10px;"></input></td>
		</div>

		
			<div class="dynamicTableContainer"  style="width:100%;height: 235px">
						<table style="height:28px;border:#0F0;width:100%;font-size:11px;">
							<tr bgcolor="#c0c0c0" >
								<td width="10%">Property Code</td><!--  COl1   -->				
								<td width="20%">Property Name</td><!--  COl2   -->
								<td width="10%">Delete</td><!--  COl3   -->
							</tr>
						</table>
					
					<div style="background-color: #fbfafa;border: 1px solid #ccc; display: block; height: 190px;
					   	 margin: auto; overflow-x: hidden;  overflow-y: scroll; width: 100%;">
						<table id="tblPropertyCode" style="width:100%;border: #0F0;table-layout:fixed;overflow:scroll" class="transTablex col7-center">
						<tbody>    
							<col style="width:10%"><!--  COl1   -->		
							<col style="width:22%"><!--  COl2   -->
							<col style="width:10%"><!--  COl3   -->
							
						<%-- <c:forEach items="${command.listPropertyDtlModel}" var="recipe" varStatus="status">
							<tr>
								<td><input type="text" class="Box id" size="10%" name="listPropertyDtlModel[${status.index}].strPropertyCode" value="${recipe.strPropertyCode}" readonly="readonly"/></td>					
								<td><input class="Box" size="30%" name="listPropertyDtlModel[${status.index}].strPropertyName" value="${recipe.strPropertyName}" readonly="readonly"/></td>
									
									 <td><input type="button" value = "Delete" onClick="Javacsript:funDeleteRow(this)" class="deletebutton"></td>
							</tr>
						</c:forEach> --%>
						</tbody>
					</table>
				</div>	
			</div>					

<!-- <div id="childProdImages" style="width: 35%; height:300px; background-color: inherit; float: left;margin-left: 0px;overflow-x: hidden;     overflow-y: scroll; border-width: 1px; border-style: solid; border-color: #c3c5c7;">
	</div>
 -->
	<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
			<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
		</div>

	<div class="center" style="margin-right: 5%;">

		   <a href="#"><button class="btn btn-primary center-block" id="formsubmit"  value="Submit" >Save</button></a>
		  
		   <a href="#"><button class="btn btn-primary center-block" type="button"  value="Reset" onclick="funResetFields();">Reset</button></a>
		</div>
		<br><br>			
		
	</s:form>
</div>
</body>
</html>





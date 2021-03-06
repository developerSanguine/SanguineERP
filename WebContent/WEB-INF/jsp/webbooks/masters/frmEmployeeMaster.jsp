<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8">

		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 	
	 	<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
<title>Employee Master</title>

<script type="text/javascript">


var fieldName;

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
	
	
	 $(document).ready(function() 
			    {
					$(".tab_content").hide();
					$(".tab_content:first").show();
					$("ul.tabs li").click(function() 
					{
						$("ul.tabs li").removeClass("active");
						$(this).addClass("active");
						$(".tab_content").hide();
						var activeTab = $(this).attr("data-state");
						
						$("#" + activeTab).fadeIn();					
						
					});																	
				});
				
	 $(function() {
			
			$('#txtAccountCode').blur(function() {
				var code = $('#txtAccountCode').val();
				if(code.trim().length > 0 && code !="?" && code !="/")
				{
					funSetAccountDetails(code);
				}
			});
			
			$('#txtEmployeeCode').blur(function() {
				var code = $('#txtEmployeeCode').val();
				if(code.trim().length > 0 && code !="?" && code !="/")
				{
					funSetEmployeeMasterData(code);
				}
			});
			
		
		});
	 
	 
	
	 function funRemoveRow(selectedRow,tableId)
		{
		    
		    var rowIndex = selectedRow.parentNode.parentNode.rowIndex;	    
		    
		    switch(tableId)
		    {
		    	case 'tblOpeningBalance':
		    			document.getElementById("tblOpeningBalance").deleteRow(rowIndex);
		    			break;		    	
		    }				   
		}
	
	
	
	
	 /* function to add rows to  Opening Balance dynamic table */
		function funAddRowToTblOpeningBalance(tableId)
		{
		    var table=document.getElementById(tableId);	    
		    var rowCount=table.rows.length;
		    var row = table.insertRow(rowCount);
		    var flag=true;
		    if(rowCount>1)
		    {
		        var accountCode= $("#txtAccountCode").val();
		        for(var i=1;i<rowCount;i++)
		        {
		            var containsAccountCode=table.rows[i].cells[0].innerHTML;
		            if(accountCode.trim()==containsAccountCode)
		            {	               
		                flag=false;	                
		            }
		        }	        
		    }
		    if(flag)
		    {

				row.insertCell(0).innerHTML = "<input readonly=\"readonly\" size=\"10%\" class=\"Box\"  name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strAccountCode\" id=\"strAccountCode."+(rowCount)+"\" style=\"text-align: left;  height:20px;\"  value='"+$("#txtAccountCode").val()+"' />";
				row.insertCell(1).innerHTML = "<input readonly=\"readonly\" size=\"20%\"  class=\"Box\"  name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strAccountName\" id=\"strAccountName."+(rowCount)+"\" style=\"text-align: left;  height:20px;\"  value='"+$("#txtAccountName").val()+"' />";
				row.insertCell(2).innerHTML = "<input readonly=\"readonly\" size=\"10%\" class=\"Box\" style=\"text-align: right;\"  name=\"listEmployeeOpenongBalModel["+(rowCount)+"].dblOpeningbal\" id=\"dblOpeningbal."+(rowCount)+"\" style=\"text-align: left;  height:20px;\"  value='"+$("#txtOpeningBalance").val()+"' />";
				row.insertCell(3).innerHTML = "<input readonly=\"readonly\" size=\"10%\" class=\"Box\"  name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strCrDr\" id=\"strCrDr."+(rowCount)+"\" style=\"text-align: left;  height:20px;\"  value='"+$("#cmbDrCr").val()+"' />";
				row.insertCell(4).innerHTML = "<input readonly=\"readonly\" size=\"20%\" class=\"Box\" style=\"text-align: right;\"   name=\"currentBal\" id=\"currentBal."+(rowCount)+"\" style=\"text-align: left;  height:20px;\"  value='"+$("#txtCurrentBalance").val()+"' />";
				row.insertCell(5).innerHTML = "<input type=\"button\" value=\"Delete\"  class=\"deletebutton\" onclick=\"funRemoveRow(this,'tblOpeningBalance')\" />";		    		   		    
			    
			    $("#txtAccountCode").val('');
			    $("#txtAccountName").val('');
			    $("#txtOpeningBalance").val('');
			    $("#cmbDrCr").prop('selectedIndex',0);
			    $("#txtCurrentBalance").val('');
		    }
		    else
		    {
		        alert("Record Already Exists!");
		    }  
		}
		function funCheckDataValidation(tableId)
		{
		    switch(tableId)
		    {
		    	case 'tblOpeningBalance':
			        var accountCode = $("#txtAccountCode").val();
				    var accountName = $("#txtAccountName").val();
				    var openingBalance = $("#txtOpeningBalance").val();
				    var DrCr= $("#cmbDrCr").val();
				    var currentBalance = $("#txtCurrentBalance").val();
				    
				    if(accountCode.trim()==''||accountName.trim()==''||openingBalance.trim()==''||DrCr.trim()==''||currentBalance.trim()=='')
				    {	       
				       return false;
				    }
				    else
				    {
				       return true;
				    }
				    break				    		    
		    }
		}
	
	
	
	 function funAddRow(tableId)
		{	    	 
		  var isValidData=funCheckDataValidation(tableId);
		  
		  if(isValidData)
		  {
		      switch(tableId)
			   {
			  	 case "tblOpeningBalance":
			      	 	funAddRowToTblOpeningBalance(tableId);
			       		break;			  	
			   }
		  } 
		  else
		  {
		      alert("Please Enter Valid Data!!!");
		  }    	    	  
		}
	
	 function funSetAccountDetails(accountCode)
		{
		    $("#txtAccountCode").val(accountCode);
			var searchurl=getContextPath()+"/loadAccountMasterData.html?accountCode="+accountCode;
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	if(response.strAccountCode=='Invalid Code')
				        	{
				        		alert("Invalid Account Code");
				        		$("#txtAccountCode").val('');
				        		$("#txtAccountName").val('');
				        	}
				        	else 
				        	{
					        	$("#txtAccountName").val(response.strAccountName);
					        	$("#txtAccountName").focus();				        					        	
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

	function funSetData(code){

		switch(fieldName)
		{		
			case "employeeCode":
			     funSetEmployeeMasterData(code);
				 break;
				 
			case "EmployeeAccountCode": 
			     funSetAccountDetails(code);
				 break;
		}
	}

	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}

	
	
	function funLoadOpeningBalTable(strAccountCode,strAccountName,dblOpeningbal,strCrDr)
	{
		
			var table = document.getElementById("tblOpeningBalance");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"22%\" name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strAccountCode\" id=\"txtAccountCode."+(rowCount)+"\" value='"+strAccountCode+"' >";
		    row.insertCell(1).innerHTML= "<input class=\"Box\" size=\"20%\" name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strAccountName\"  id=\"txtAccountName."+(rowCount)+"\" value='"+strAccountName+"'>";		    	    
		    row.insertCell(2).innerHTML= "<input class=\"Box\" size=\"10%\" style=\"text-align: right;\" size=\"8%\" name=\"listEmployeeOpenongBalModel["+(rowCount)+"].dblOpeningbal\" id=\"txtOpeningBalance."+(rowCount)+"\" value='"+dblOpeningbal+"'>";
		    row.insertCell(3).innerHTML= "<input class=\"Box\"  size=\"15%\" name=\"listEmployeeOpenongBalModel["+(rowCount)+"].strCrDr\" id=\"cmbDrCr."+(rowCount)+"\" value="+strCrDr+">";
		    row.insertCell(4).innerHTML= "<input class=\"Box\"  size=\"15%\" name=\"listEmployeeOpenongBalModel["+(rowCount)+"].dblCurrentbal\" id=\"currentBal."+(rowCount)+"\" value="+0+">";
			row.insertCell(5).innerHTML="<input type=\"button\" value=\"Delete\"  class=\"deletebutton\" onclick=\"funRemoveRow(this,'tblOpeningBalance')\" />";   
		
	}
	
	function funSetEmployeeMasterData(employeeCode)
	{
	    $("#txtEmployeeCode").val();
		var searchurl=getContextPath()+"/loadEmployeeMasterData.html?employeeCode="+employeeCode;
		 $.ajax({
			        type: "GET",
			        url: searchurl,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strEmployeeCode=='Invalid Code')
			        	{
			        		alert("Invalid Employee Code");
			        		$("#txtEmployeeCode").val('');
			        		$("#txtEmployeeName").val('');
			        	}
			        	else
			        	{
			        		$("#txtEmployeeCode").val(response.strEmployeeCode);
				        	$("#txtEmployeeName").val(response.strEmployeeName);
			        	}
			        	
			        	$.each(response.listEmployeeOpenongBalModel, function(i, item) {
							
							funLoadOpeningBalTable(item[0],item[1],item[2],item[3]);
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
	
	function funResetFields()
	{
		location.reload(true); 
	}
	

	function funValidateForm() 
		{
			var flg=false;
			var empName=$("#txtEmployeeName").val().trim();
			if(empName=='') 
			{
				alert('Enter Employee Name!!!');
				$("#txtEmployeeName").focus();
			}
			else
			{
				var pattern =/^[a-zA-Z\s]+$/;
				if (pattern.test(empName)) 
				{
					flg=true;
				}
				else
				{
					alert("Enter valid employee name!!");
				}
			}
			return flg;
		}
	
</script>

</head>
<body>

	<div class="container">
		<label id="formHeading">Employee Master</label>
			<s:form name="EmployeeMaster" method="POST" action="saveEmployeeMaster.html">
				<div class="row masterTable">
					<div class="col-md-5">
							<div class="row">
								<div class="col-md-5">
								<label >Employee Code</label>
									<s:input type="text" id="txtEmployeeCode" path="strEmployeeCode" style="height:48%" ondblclick="funHelp('employeeCode')" readOnly="true" class="searchTextBox"/>
								</div>
								<div class="col-md-7">
									<label >Employee Name</label>
									<s:input id="txtEmployeeName" type="text" required="true" path="strEmployeeName" />
								</div>
							</div>
						</div>	
				</div>
				
				<!--Opening Balance-->
		<div id="tab4" class="tab_content" style="height: auto;">
	
			<div class="row">
				
					<div class="col-md-2"><label>Account Code</label>
												<s:input id="txtAccountCode" path=""  style="height:48%; width:105%" cssClass="searchTextBox" readOnly="true" ondblclick='funHelp("EmployeeAccountCode")' />
						</div>
						<div class="col-md-3"><label>Account Name</label>
											<s:input id="txtAccountName" path="" type="text"   />
						</div>
				       
				        <div class="col-md-2"><label style="padding-left: 15px;">Opening Balance</label>
				        			<s:input  type="number" id="txtOpeningBalance" path=""   class="decimal-places numberField" cssStyle="text-align: right; border:none" />
				        </div>
				        
				        <div class="col-md-1"><label style="padding-left: 15px;">Dr/Cr</label>
				        			<s:select id="cmbDrCr" path="" items="${listDrCr}" cssClass="BoxW124px" style="margin:0px;" />
				        </div>
				        
				        <div class="col-md-2"><label>Current Balance</label>
				        			<s:input id="txtCurrentBalance" path=""  style="width:50%; text-align:right;" readonly="true" value="0"/>
				        </div>		
				        
				        <div class="col-md-2">	        
			   	       				<input type="button" value="Add" style="padding: 8px 24px;  margin-top: 20px"  class="btn btn-primary center-block" onclick='funAddRow("tblOpeningBalance")'/>
			   	       	</div>			   			
			  		    				
			 </div>
			<br>
			<div style="background-color: #f2f2f2; border: 1px solid #ccc;display: block; height: 150px;
				    				margin: auto;overflow-x: hidden; overflow-y: scroll;width: 99%;">
				<!-- Dynamic Table Generation for tab4 (Opening Balance) -->
				<table id="tblOpeningBalance" class="transTablex" style="width: 100%;">				
					<tr style="padding:2px; background:#c0c0c0;">
					        <td>Account Code</td>
					        <td>Account Name</td>
					        <td>Opening Balance</td>
					        <td>Dr/Cr</td>
					        <td>Current Balance</td>		
					        <td>Delete</td>				       
				   	</tr>			   						   	    				  
				</table>	
			</div>						
		</div>	
		<br />
		<p align="right">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button" onclick="return funValidateForm();" />&nbsp
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>
			</s:form>
		</div>

</body>
</html>
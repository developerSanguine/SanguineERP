<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="default.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Web Stocks</title>
    <style>
    .transTable td {
         padding-left: 27px;
         }
    </style>
    <script type="text/javascript">
    	var fieldName;
    	/**
		 * Reset Textfield
		 */
    	function funResetFields()
    	{
    		$("#txtProdCode").val('');
    	}
    	/**
		 * Open help windows
		 */
    	function funHelp(transactionName)
		{
			fieldName=transactionName;
		//	 window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
			 window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	    }
    	/**
		 * Set Data after selecting form Help windows
		 */
		function funSetData(code)
		{
			$("#txtProdCode").val(code);
		}
    	
    	
		function funGetGroupData()
		{
			var searchUrl = getContextPath() + "/loadAllGroupData.html";
			
			$.ajax({
				type : "GET",
				url : searchUrl,
				dataType : "json",
				beforeSend : function(){
					 $("#wait").css("display","block");
			    },
				success : function(response) {
					funRemRows("tblGroup");
					$.each(response, function(i,item)
			 		{
						funfillGroupGrid(response[i].strGCode,response[i].strGName);
					});
					funGroupChkOnClick();
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
		 * Filling Group data in Grid
		 */
		function funfillGroupGrid(strGroupCode,strGroupName)
		{
			
			 	var table = document.getElementById("tblGroup");
			    var rowCount = table.rows.length;
			    var row = table.insertRow(rowCount);
			    
			    row.insertCell(0).innerHTML= "<input id=\"cbGSel."+(rowCount)+"\" type=\"checkbox\" class=\"GCheckBoxClass\" checked=\"checked\" onclick=\"funGroupChkOnClick()\"/>";
			    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"strGCode."+(rowCount)+"\" value='"+strGroupCode+"' >";
			    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"35%\" id=\"strGName."+(rowCount)+"\" value='"+strGroupName+"' >";
		}
		
		/**
		 * After Select Group Data get the SubGroup Data
		**/
		function funGroupChkOnClick()
		{
			var table = document.getElementById("tblGroup");
		    var rowCount = table.rows.length;  
		    var strGCodes="";
		    for(no=0;no<rowCount;no++)
		    {
		        if(document.all("cbGSel."+no).checked==true)
		        	{
		        		if(strGCodes.length>0)
		        			{
		        				strGCodes=strGCodes+","+document.all("strGCode."+no).value;
		        			}
		        		else
		        			{
		        			strGCodes=document.all("strGCode."+no).value;
		        			}
		        	}
		    }
		    funGetSubGroupData(strGCodes);
		}
		
		/**
		 * Getting SubGroup Based on Group Code Passing Value(Group Code)
		**/
		function funGetSubGroupData(strGCodes)
		{
			strCodes = strGCodes.split(",");
			var count=0;
			funRemRows("tblSubGroup");
			for (ci = 0; ci < strCodes.length; ci++) 
			 {
				var searchUrl = getContextPath() + "/loadSubGroupCombo.html?code="+ strCodes[ci];
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
					success : function(response)
					{
						$.each(response, function(key, value) {
							
							funfillSubGroup(key,value);
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
		}
		
		/**
		 * Filling SubGroup data in grid
		**/
		function funfillSubGroup(strSGCode,strSGName) 
		{
			var table = document.getElementById("tblSubGroup");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    
		    row.insertCell(0).innerHTML= "<input id=\"cbSGSel."+(rowCount)+"\" type=\"checkbox\" checked=\"checked\" name=\"SubGroupthemes\" value='"+strSGCode+"' class=\"SGCheckBoxClass\" />";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"15%\" id=\"strSGCode."+(rowCount)+"\" value='"+strSGCode+"' >";
		    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"35%\" id=\"strSGName."+(rowCount)+"\" value='"+strSGName+"' >";
		}
		
		    /**
		     * Remove All Row from Table Passing Value(Table Id)
	        **/
			function funRemRows(tableName) 
			{
				var table = document.getElementById(tableName);
				var rowCount = table.rows.length;
				while(rowCount>0)
				{
					table.deleteRow(0);
					rowCount--;
				}
			}
			
			/**
			 * Select All Group, SubGroup
			**/
			 $(document).ready(function () 
				{
					$("#chkSGALL").click(function () {
					    $(".SGCheckBoxClass").prop('checked', $(this).prop('checked'));
					});
					
					$("#chkGALL").click(function () 
					{
					    $(".GCheckBoxClass").prop('checked', $(this).prop('checked'));
					    funGroupChkOnClick();
					});
					
	    			funGetGroupData();

					
				});
			 
			 /**
			  * Checking Validation when user Click On Submit Button
		     **/
	 function btnSubmit_OnClick() 
		{	
		 var strSubGroupCode="";
		 $('input[name="SubGroupthemes"]:checked').each(function() {
			 if(strSubGroupCode.length>0)
				 {
				 	strSubGroupCode=strSubGroupCode+","+this.value;
				 }
				 else
				 {
					 strSubGroupCode=this.value;
				 }
			});
		 $("#hidSubCodes").val(strSubGroupCode);
		 return true;
		}
			 
			 $(document).ready(function()
			    		{
			    	var tablename='';
			    			$('#searchGrp').keyup(function()
			    			{
			    				tablename='#tblGroup';
			    				searchTable($(this).val(),tablename);
			    			});
			    			$('#searchSGrp').keyup(function()
			    	    			{
			    						tablename='#tblSubGroup';
			    	    				searchTable($(this).val(),tablename);
			    	    			});
			    		});

					    /**
						 * Function for Searching in Table Passing value(inputvalue and Table Id) 
						 */
			    		function searchTable(inputVal,tablename)
			    		{
			    			var table = $(tablename);
			    			table.find('tr').each(function(index, row)
			    			{
			    				var allCells = $(row).find('td');
			    				if(allCells.length > 0)
			    				{
			    					var found = false;
			    					allCells.each(function(index, td)
			    					{
			    						var regExp = new RegExp(inputVal, 'i');
			    						if(regExp.test($(td).find('input').val()))
			    						{
			    							found = true;
			    							return false;
			    						}
			    					});
			    					if(found == true)$(row).show();else $(row).hide();
			    				}
			    			});
			    		}
			    
			 
			 /**
			   * Reset from
			 **/
			 function funResetFields()
				{
					location.reload(true); 
				}
    	
    	
    </script>
  </head>
  
	<body>
	<div class="container masterTable">
		<label id="formHeading">Recipes List</label>
	      <s:form name="frmRecipesList" method="GET" action="rptRecipesList.html" target="_blank">
	
	   <div class="row">	
		         <div class="col-md-2"><label>Product Code</label>
					   <s:input  id="txtProdCode" readonly="true" path="strDocCode" ondblclick="funHelp('productProducedslip')" cssClass="searchTextBox" cssStyle="width:150px;background-position: 136px 4px;"/>
				  </div>
				
				<div class="col-md-2"><label>Report Type</label>
					<s:select id="cmbDocType" path="strDocType" style="width:auto;">
				    		<s:option value="PDF">PDF</s:option>
				    		<s:option value="XLS">EXCEL</s:option>
				    		<s:option value="HTML">HTML</s:option>
				    		<s:option value="CSV">CSV</s:option>
				    	</s:select>
				</div>
				
				<div class="col-md-2"><label>Rate PickUp From</label>
					   <s:select  id="cmbRatePickUpFrom" path="strShowBOM" style="width:auto;" >
							<option selected="selected" value="Product Master">Product Master</option>
							<option value="Last Purchase Rate">Last Purchase Rate</option>
						</s:select>
				</div>
		</div>
				
		<div class="row transTable">
		   <div class="col-md-6"><label>Group</label>
			      <input type="text"  style="width:35%;" readonly="true" id="searchGrp" placeholder="Type to search" Class="searchTextBox">
		   </div>
		   <div class="col-md-6"><label>Sub Group</label>
		  		   <input type="text" id="searchSGrp" readonly="true" style="width:35%;" Class="searchTextBox" placeholder="Type to search">
		   </div>
		   
		  <div class="col-md-12"></div><br>
		  
			 <div  class="col-md-6"
							style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 150px; overflow-x: hidden; overflow-y: scroll;">
							<table id="" class="display"
								style="width: 100%; border-collapse: separate;">
								<tbody>
									<tr bgcolor="#c0c0c0">
										<td width="15%"><input type="checkbox" id="chkGALL"
											checked="checked" onclick="funCheckUncheck()" />Select</td>
										<td width="25%">Group Code</td>
										<td width="70%">Group Name</td>

									</tr>
								</tbody>
							</table>
							<table id="tblGroup" class="masterTable"
								style="width: 100%; border-collapse: separate;">
								<tbody>
									<tr bgcolor="#fafbfb">
										<td width="15%"></td>
										<td width="20%"></td>
										<td width="65%"></td>

									</tr>
								</tbody>
							</table>
				</div>
						
				<div  class="col-md-6"
						style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 150px; overflow-x: hidden; overflow-y: scroll;">

						<table id="" class="masterTable"
								style="width: 100%; border-collapse: separate;">
								<tbody>
									<tr bgcolor="#c0c0c0">
										<td width="15%"><input type="checkbox" id="chkSGALL"
											checked="checked" onclick="funCheckUncheckSubGroup()" />Select</td>
										<td width="25%">Sub Group Code</td>
										<td width="70%">Sub Group Name</td>

									</tr>
								</tbody>
							</table>
							<table id="tblSubGroup" class="masterTable"
								style="width: 100%; border-collapse: separate;">
								<tbody>
									<tr bgcolor="#fafbfb">
										<td width="15%"></td>
										<td width="25%"></td>
										<td width="65%"></td>

									</tr>
								</tbody>
							</table>
				  </div>
				</div>
			
				<!-- <td><input type="submit" value="Submit" /></td>
				<td><input type="reset" value="Reset" onclick="funResetFields()"/></td>	 -->				
			
			<br>
			<p align="center">
				<input type="submit" value="Submit" class="btn btn-primary center-block" class="form_button" onclick = "return btnSubmit_OnClick()"/>
				 &nbsp;
			    <input type="button" value="Reset" class="btn btn-primary center-block" class="form_button"  onclick="funResetFields()"/>
			</p>
			<s:input type="hidden" id="hidSubCodes" path="strSGCode"></s:input>
		</s:form>
		</div>
	</body>
</html>
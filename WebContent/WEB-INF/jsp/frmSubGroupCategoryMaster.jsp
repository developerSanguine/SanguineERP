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
<title>SUB GROUP CATEGORY MASTER</title>
	
<script type="text/javascript">
$(document).ready(function(){
	 resetForms('subgrpForm1');
	    $("#txtSubgroupName").focus();	
});
</script>
	<script type="text/javascript">
	
	 $(document).ready(function()
				{
					$(function() {
						$("#txtSubgroupName").autocomplete({
						source: function(request, response)
						{
							var searchUrl=getContextPath()+"/AutoCompletGetSubGroupName.html";
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
					

				    $("#chkExciseable").click(function() {
				        if (this.checked) {
				        	$("#hidExciseable").val('Y');
				        }else
				        	{
				        	$("#hidExciseable").val('N');
				        	}
				    });
					
					
					
				});


	
	
		var fieldName1;		
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
			$("#txtSubgroupName").focus();	

		});
		
		function funSetSubGroupCategory(code)
		{
				 $.ajax({
					        type: "GET",
					        url: getContextPath()+"/loadSubGroupCategoryMasterData.html?subGroupCode="+code,
					        dataType: "json",
					        success: function(response)
					        {
					        	if(response.strSGCode=='Invalid SubGroup Category Code')
					        	{
					        		alert("Invalid SubGroup Category Code");
					        		$("#txtSubgroupCCode").val('');
					        		$("#txtSubgroupCCode").focus();
					        	}
					        	else
					        	{
					        		$("#txtSubgroupCCode").val(response.strSGCCode);
					        		$("#txtSubgroupName").val(response.strSGCName);
						        	$("#txtSubgroupDesc").val(response.strSGCDesc);
						        	$("#txtSubGroupCode").val(response.strSGCode);
						        	$("#lblgroupname").text(response.strSGCName);	
					        	}
					        	//funSetSubGroup(response.strSGCode);
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
		
		function funSetSubGroup(code)
		{
			$("#txtSubGroupCode").val(code);
			 
			$.ajax({
			        type: "GET",
			        url: gurl+code,
			        dataType: "json",
			        success: function(response)
			        {
			        	if(response.strSGCode=='Invalid Code')
			        	{
			        	//	alert("Invalid SubGroup Code");
			        		$("#txtSubgroupCCode").val('');
			        		$("#txtSubgroupCCode").focus();
			        	}
			        	
			        	else
			        		{
				        	//$("#txtSubgroupName").val(response.strSGName);
				        	//$("#txtSubgroupDesc").val(response.strSGDesc);
				        	//$("#txtGroupCode").val(response.strGCode);
				        	$("#txtSubGroupCode").val(response.strSGCode);
				        	$("#lblgroupname").text(response.strSGName);	
				        	
				        					    
				        
				        	
				        	//funSetGroup(response.strGCode);
				        	
				        	
			        		}
					},
			        error: function(e)
			        {				        	
			        	alert("Invalid SubGroup Code");
		        		$("#txtSubgroupCCode").val('');
			        }
		      });
		}
	
		function funHelp(transactionName)
		{
			fieldName1=transactionName;	
			
			
			if(fieldName1=='subgroupcategory')
			{
				gurl=getContextPath()+"/loadSubGroupCategoryMasterData.html?subGroupCode=";
				
			}
			else
			{
				gurl=getContextPath()+"/loadSubGroupMasterData.html?subGroupCode=";				
			}			
	       // window.open("searchform.html?formname="+transactionName+"&searchText=", 'window', 'width=600,height=600');
	     //   window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	       window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	    }
		
		function funSetData(code)
		{
			switch (fieldName1) 
			{
			   
			   case 'subgroupcategory':
			    	funSetSubGroupCategory(code);
			        break;
			
			   case 'subgroup':
			    	funSetSubGroup(code);
			        break;
			   
			}
			
		}
		$(function()
				{
					
				    
					$('a#baseUrl').click(function() 
					{
						if($("#txtSubgroupCCode").val().trim()=="")
						{
							alert("Please Select Sub Group Code");
							return false;
						}
 
						 window.open('attachDoc.html?transName=frmSubGroupCategorysMaster.jsp&formName=SubGroup Master&code='+$('#txtSubgroupCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
                   });
 					
					$('#txtSubgroupCCode').blur(function(){						
						    var code=$('#txtSubgroupCCode').val();
						    if (code.trim().length > 0 && code !="?" && code !="/") {
						    	funSetSubGroupCategory(code);
						  		}
						  
					});							
					$('#txtSubGroupCode').blur(function(){						
						    var code=$('#txtSubGroupCode').val();
						    if (code.trim().length > 0 && code !="?" && code !="/") {
						    	funSetSubGroup(code);
						  	}						  
					});	
					
					$('#txtSubgroupName').blur(function () {
						 var strSGCName=$('#txtSubgroupName').val();
					      var st = strSGCName.replace(/\s{2,}/g, ' ');
					      $('#txtSubgroupName').val(st);
						});
				});
		
		function funCallFormAction(actionName,object) 
		{
			var flg=true;
			if($('#txtSubgroupCode').val()=='')
			{
				var code = $('#txtSubgroupName').val();
				 $.ajax({
				        type: "GET",
				        url: getContextPath()+"/checksubGroupName.html?subgroupName="+code,
				        async: false,
				        dataType: "text",
				        success: function(response)
				        {
				        	if(response=="true")
				        		{
				        			alert("SubGroup Name Already Exist!");
				        			$('#txtSubgroupName').focus();
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
			//alert("flg"+flg);
			return flg;
		}
	</script>

</head>
<body onload="funResetFields()">
	<div class="container">
	<label id="formHeading">SubGroup Category Master</label>
	
	<s:form name="subgrpForm1" method="POST" action="saveSubGroupCategoryMaster.html?saddr=${urlHits}">
		<div class="row masterTable">
			<!--  <th align="right" colspan="2"> <a id="baseUrl" href="#"> Attach Documents</a>&nbsp; &nbsp; &nbsp;
						&nbsp; </th> -->
		  	<div class="col-md-2">
				<s:label path="strSGCCode" >Sub-Group Category Code</s:label>
		     	<s:input id="txtSubgroupCCode" readonly="true" name="txtSubgroupCCode" path="strSGCCode" ondblclick="funHelp('subgroupcategory')"  cssClass="searchTextBox" />	
		   	</div>
		    <div class="col-md-2">
		        <s:label path="strSGCName">Sub-Group Category Name</s:label>
		    	<s:input id="txtSubgroupName" name="txtSubgroupName" path="strSGCName" required="true"/>
		        <s:errors path="strSGCName"></s:errors>
		    </div>
		     <div class="col-md-2">
			  	<s:label path="strSGCDesc">Description</s:label>
			  	<s:input id="txtSubgroupDesc" name="txtSubgroupDesc" autocomplete="off"  path="strSGCDesc" />
			</div>
		    <div class="col-md-6"></div>
			<div class="col-md-2">
			 	<s:label path="strSGCode" >Sub Group Code</s:label>
		      	<s:input type="text" id="txtSubGroupCode" readonly="true" name="txtSubGroupCode" autocomplete="off" path="strSGCode" ondblclick="funHelp('subgroup')" required="true" cssClass="searchTextBox" />
		    </div>
		    <div class="col-md-2">	
		      	<label id="lblgroupname" style="background-color:#dcdada94; width: 100%; height: 49%; margin: 23px 0px; text-align: center;"></label>
			</div>	
			
			   <div class="col-md-6"></div>						
		   	
			
			
		</div>
		<div class="center" style="margin-right: 51%;">
			<a href="#"><button class="btn btn-primary center-block" value="Submit" onclick="return funCallFormAction('submit',this);">Submit</button></a>
			&nbsp;
			<a href="#"><button class="btn btn-primary center-block"  value="Reset" >Reset</button></a>
		</div>
		
	</s:form>
</div>
</body>
</html>
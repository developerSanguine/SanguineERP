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

		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	
<title>Budget Flash</title>

<script type="text/javascript">
 	
 	/**
	 * Ready Function for Ajax Waiting
	 */
	$(document).ready(function() {
		
		
		$(document).ajaxStart(function() {
			$("#wait").css("display", "block");
		});
		$(document).ajaxComplete(function() {
			$("#wait").css("display", "none");
		});
		var loggedInProperty="${LoggedInProp}";
		$("#cmbProperty").val(loggedInProperty);
// 		funLoadTableHeaderData();
	});

		function funLoadTableHeaderData()
		{
			var searchUrl="";
			var year=$("#cmbYear").val();
			searchUrl=getContextPath()+"/loadBudgetHeader.html?year="+year;			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				      funFillHeaderData(response);
		        		
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
		
	
		
		
		function funFillHeaderData(data)
		{
			$('#tblFlashHeader tbody').empty();
			  var table = document.getElementById("tblFlashHeader");
			  var rowCount = table.rows.length;
			    var row = table.insertRow(rowCount);
// 			    row.insertCell(0).innerHTML= "<input class=\"Box\" size=\"9%\"  id=\"txtGroupCode.1\" value='GroupCode' />";
// 			   var cnt=1;
// 			    for(var i=0;i<data.length;i++)
// 			    {
// 			    row.insertCell(cnt).innerHTML= "<input class=\"Box\" size=\"9%\"   value='' />";
// 	 			row.insertCell(cnt).innerHTML= "<input class=\"Box\" size=\"9%\"   value='"+data[i]+"' />";
// 	 			cnt++;
// 	 			row.insertCell(cnt).innerHTML= "<input class=\"Box\" size=\"9%\"  value='' />";
// 	 			cnt++;
// 			    }  

	  row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\" style=\"text-align:left;\" value=\'Groupcode'\ >";
			   
			    var j=1;
				    for(var i=0;i<data.length;i++)
				    {
				   
				  row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='' >";
				   j++;
				   row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='"+data[i]+"' >";
				   j++;
				   row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='' >";
			    }
		}
		
		
		function funLoadTableDeatailData()
		{
			var searchUrl="";
			var propCode=$("#cmbProperty").val();
			var year=$("#cmbYear").val();
				
			searchUrl=getContextPath()+"/loadBudgetDetail.html?propCode="+propCode+"&year="+year;			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				      funFillDetailData(response);
		        		
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
			return false;
		}
		
		function funFillDetailData(data){
			
			$('#tblFlashDetail tbody').empty();
			
			  var table = document.getElementById("tblFlashDetail");
			  var rowCount = table.rows.length;
			  var row = table.insertRow(rowCount);
// 			  row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"10%\"  value='Groupcode' >";
			    var list=data[0];
			    
// 				    for(var j=1;j<list.length;j++)
// 				    {
				   
// 				  row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='Bud' >";
// 				   j++;
// 				   row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='GRN' >";
// 				   j++;
// 				   row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\"  value='Var' >";
// 			    }
			    
// 				    rowCount++;
			   
			    for(var i=0;i<data.length;i++)
			    {
			    var list=data[i];
			     row = table.insertRow(rowCount);
			    for(var j=0;j<list.length;j++)
			    {
		    	if(rowCount==0||rowCount==1)
		    		{
		    		row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align:left; background-color:#c0c0c0;\" size=\"24%\"  value='"+list[j]+"' >";
		    		}
		    	else{
			          row.insertCell(j).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align:right;\" size=\"24%\"  value='"+list[j]+"' >";
			        }
			    }
			    rowCount++;
			    }
		}

</script>
<body>
	<div class="container">
		<label id="formHeading" id="lblFormHeadingName">Budget Flash</label>
		<s:form name="BudgetFlash" method="POST" action="">

		<div class="row transTable">
		 	<div class="col-md-2">
				<label>Properties</label>
				<s:select  items="${mapProperties}" id="cmbProperty" path=""  onchange="funChangeProperty();">
				</s:select>
			</div>		
			<div class="col-md-2">
 				<label>Year</label>
					<select id="cmbYear">
				    	<option value="2017-2018">2017-2018</option>
				    	<option value="2018-2019">2018-2019</option>
				    </select>
			</div>
			<div class="col-md-2">	
				<a href="#"><button class="btn btn-primary center-block"  value="Execute" onclick="return funLoadTableDeatailData()"
					class="form_button">Execute</button></a>
			</div>		
				
      
		</div>
<!-- 	<div class="dynamicTableContainer" style="height:290px "> -->
			

<!-- 	<table id="tblFlashHeader" style="height: 28px; border: #0F0; width: 154%;font-size:11px; table-layout: fixed;; -->
<!-- 	      font-weight: bold; overflow: scroll"> -->

<!-- 	</table> -->

			<div style="display: block; margin: auto; overflow-x: auto; overflow-y: scroll; width: 100%;">
				<table id="tblFlashDetail" style="border:#0F0;table-layout:fixed; overflow-y: scroll; overflow-x: scroll;"  class="transTablex col20-center">
					<tbody> 
			
					</tbody>
					
				</table>

			</div>
<!-- 		</div> -->



		<br />
		<br />
	
<br><br>
	<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
				<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
			</div>
			
	</s:form>
</div>
</body>
</html>
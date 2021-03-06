<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script type="text/javascript">

	var fieldName;
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
				alert("Data Save successfully :\t"+message);
	<%
	}}%>

});
	

	
	//validation
	function funValidate(data)
	{
		var flg=true;
		if($("#txtStaffName").val().trim().length==0)
			{
			alert("Please Enter Staff Name !!");
			 flg=false;
			}
		else if($("#txtStaffCatCode").val().trim().length==0)
			{
			
			alert("Please Select Staff Categeory Code !!");
			 flg=false;
			
			}
		return flg;
	}
	
	
	function funSetData(code){

		switch(fieldName)
		{		
		   case 'StaffCode':
		    	funSetStaffCode(code);
		        break;
		   
		   case 'StaffCatCode':
		    	funSetDeptCode(code);
		        break;
		
		
		}
	}

	
	function funSetStaffCode(code)
	{
			var searchUrl="";
			searchUrl=getContextPath()+"/loadStaffMasterData.html?staffCode="+code;			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	$("#txtStaffCode").val(code);
				    	$("#txtStaffName").val(response.strStaffName);
				    	$("#txtStaffCatCode").val(response.strStaffCatCode);
		        		
				    	if(response.strOperationalYN=="Y")
			        	{
			        		
			        		document.getElementById("chkOperationalYN").checked = response.strOperationalYN == 'Y' ? true: false;
			        	}
		        		else
			        	{
			        		$("#chkOperationalYN").attr('checked', false);
			        		
			        	}
				    	$("#txtMobile").val(response.strMobile);
				    	$("#txtEmail").val(response.strEmail);
				    	
				    	
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
	
	
	function funSetDeptCode(code)
	{
		$("#txtStaffCatCode").val(code);
		
	}
	
	
	function funHelp(transactionName)
	{		
		fieldName=transactionName;
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px,dialogWidth:1100px,top=500,left=500")
		
	}
</script>

</head>
<body>

	<div class="container masterTable">
	<label id="formHeading">Staff Master</label>
	    <s:form name="BanquetStaffMaster" method="POST" action="saveBanquetStaffMaster.html">

		 <div class="row">
          
			<div class="col-md-2"><label>Staff Code</label>
				<s:input id="txtStaffCode" name="txtreqCode" path="strStaffCode" cssClass="searchTextBox" ondblclick="funHelp('StaffCode')" readonly="true"/>
			</div>
		
			<div class="col-md-2"><label>Staff Name</label>
				<s:input id="txtStaffName" name="txtStaffName" path="strStaffName" />
			</div>				
		    <div class="col-md-8"></div>
		    
			<div class="col-md-2"><label>Staff Categeory Code</label>
				<s:input id="txtStaffCatCode" name="txtStaffCatCode" path="strStaffCatCode" class="searchTextBox" ondblclick="funHelp('StaffCatCode')" readonly="true"/>
			</div>					
			
			<div class="col-md-2"><label>Operational Y/N</label><br>
				<s:checkbox id="chkOperationalYN" name="chkOperationalYN" path="strOperationalYN" value="Y" checked="true"/>
			</div>
			<div class="col-md-8"></div>
			
			<div class="col-md-2"><label>Mobile No.</label> 
		    
					        <!-- pattern="[789][0-9]{9}" -->
			     <s:input  type="tel" pattern="[0-9]{10,10}"  maxlength="11"  placeholder="Enter Valid MobileNo." id="txtMobile" name="txtMobile" path="strMobile" style="border:none;" />
		    </div> 
				
			<div class="col-md-2"><label>Email </label>
			       <s:input  placeholder="name@email.com" id="txtEmail" name="txtEmail" path="strEmail"/>
			</div>
		
		</div>

		<br />
		<p align="center" style="margin-right: 49%;">
			<input type="submit" value="Submit" tabindex="3" class="btn btn-primary center-block" class="form_button" onclick="return funValidate(this)"/>
			&nbsp;
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>

	</s:form>
	</div>
</body>
</html>

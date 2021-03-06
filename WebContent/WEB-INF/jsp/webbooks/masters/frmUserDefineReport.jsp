<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<title></title>
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 	
	 	<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
<title>Insert title here</title>

	<script>
	
		var fieldName,gridHelpRow,searchData;

		$(function ()
		{
			/*$("#txtReportDate").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtReportDate").datepicker('setDate','today');
			$("#txtReportDate").datepicker();
			*/
		});
		
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
		
		 $(function() {
				
				$('#txtReportCode').blur(function() {
					var code = $('#txtReportCode').val();
					if(code.trim().length > 0 && code !="?" && code !="/")
					{
						funSetReportName(code);
					}
				});
				
				
				
			
			});
		
		function funHelp(transactionName)
		{
			fieldName=transactionName;
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	    }
		function funHelp1(transactionName,row,searchType)
		{
			gridHelpRow=row;
			fieldName=transactionName;
			searchData=searchType;
			window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		}
		
		function funSetData(code)
		{
			switch (fieldName) 
			{
			   case 'userDefinedReportCode':
				   funSetReportName(code);
			        break;
			        
			   case "acGroupCode":
				   funSetGroupCode(code,gridHelpRow,searchData);
			   break;  
				 
			   case "accountCode": 
				   funSetAccountCode(code,gridHelpRow,searchData);
				break;	 
			        
			}
		}
		
		function funSetReportName(code)
		{
			$.ajax({
				type : "GET",
				url : getContextPath()+ "/loadUserDefinedReportMasterData.html?userDefinedCode=" + code,
				dataType : "json",
				success : function(response)
				{
					funRemoveAllRows();
					if(response.strReportId==null)
					{
						alert("Invalid Report Id");
						$("#txtReportCode").val('');
						$("#txtReportName").val('');
					}
					else
					{	
				
					$("#txtReportCode").val(response.strReportId);
					$("#txtReportName").val(response.strReportName);
					//var userDefDate=response.dteUserDefDate.split(" ")[0].split("-");
					//$("#txtReportDate").val(userDefDate[2]+"-"+userDefDate[1]+"-"+userDefDate[0]);
					$("#cmbReportDate").val(response.dteUserDefDate);
					$.each(response.listUserDefRptDtlModel, function(i, data) 
					{
						funAddProductRow(data.strType,data.strColumn,data.strOperator,data.strFGroup,data.strTGroup,data.strFAccount,data.strTAccount,data.strDescription,data.strConstant,data.strFormula,data.strPrint);
					});
					}
				},
				error : function(e){
				}
			});
		}
		
		
		function funRemoveAllRows() 
	    {
			var table = document.getElementById("tblUserDefindDtl");
			var rowCount = table.rows.length;			   
			for(var i=rowCount-1;i>=0;i--)
			{
				table.deleteRow(i);						
			} 
	    }
		
		function funDeleteRow(obj) 
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblUserDefindDtl");
		    table.deleteRow(index);
		}
		
		
		
		function funAddProductRow(selectedType,strColumn,selectedOperator,FGroup,TGroup,FAccount,TAccount,description,constant,formula,selectedPrintYN)
		{
			var table = document.getElementById("tblUserDefindDtl");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		    row.insertCell(0).innerHTML= "<input name=\"listUserDefRptDtlBean["+(rowCount)+"].intSrNo\" readonly=\"readonly\"  class=\"Box\" style=\"text-align: right;\" size=\"3%\" padding=\"0px\" id=\"intSrNo."+(rowCount)+"\" value='"+(rowCount+1)+"' />";	
 		    row.insertCell(1).innerHTML= "<select name=\"listUserDefRptDtlBean["+(rowCount)+"].strType\" class=\"Box\" style=\"width: 100%;\"  id=\"strType."+(rowCount)+"\"  onchange=\"funClickOnType(this.value,"+(rowCount)+")\">   '"+funGetTypeList(selectedType)+"'";
		    row.insertCell(2).innerHTML= "<select name=\"listUserDefRptDtlBean["+(rowCount)+"].strColumn\" class=\"Box\" style=\"width: 100%;\"  id=\"strColumn."+(rowCount)+"\" >   '"+funGetColumnNoTypeList(strColumn)+"'";
		    row.insertCell(3).innerHTML= "<select name=\"listUserDefRptDtlBean["+(rowCount)+"].strOperator\" class=\"Box\" style=\"width: 100%;\"  id=\"strOperator."+(rowCount)+"\"  >   '"+funGetOperatorList(selectedOperator)+"'";
		    row.insertCell(4).innerHTML= "<input name=\"listUserDefRptDtlBean["+(rowCount)+"].strFGroup\"  readonly=\"readonly\"  class=\"searchTextBox1\" size=\"7%\" id=\"strFGroup."+(rowCount)+"\" value='"+FGroup+"'  ondblclick=\"Javacsript:funHelp1('acGroupCode',"+(rowCount)+",'FGroup' )\"/>";		  		   	  
		    row.insertCell(5).innerHTML= "<input name=\"listUserDefRptDtlBean["+(rowCount)+"].strTGroup\"  readonly=\"readonly\"  class=\"searchTextBox1\" size=\"7%\" id=\"strTGroup."+(rowCount)+"\" value='"+TGroup+"'  ondblclick=\"Javacsript:funHelp1('acGroupCode',"+(rowCount)+",'TGroup')\"/>";
		    row.insertCell(6).innerHTML= "<input name=\"listUserDefRptDtlBean["+(rowCount)+"].strFAccount\"  readonly=\"readonly\"  class=\"searchTextBox\" size=\"6%\" id=\"strFAccount."+(rowCount)+"\" value='"+FAccount+"' ondblclick=\"Javacsript:funHelp1('accountCode',"+(rowCount)+",'FAccount' )\"/>";	  		   	  
		    row.insertCell(7).innerHTML= "<input name=\"listUserDefRptDtlBean["+(rowCount)+"].strTAccount\"  readonly=\"readonly\"  class=\"searchTextBox\" size=\"6%\" id=\"strTAccount."+(rowCount)+"\" value='"+TAccount+"' ondblclick=\"Javacsript:funHelp1('accountCode',"+(rowCount)+",'TAccount')\"/>";	  		   	  
		    row.insertCell(8).innerHTML= "<input type=\"text\"  size=\"18%\" name=\"listUserDefRptDtlBean["+(rowCount)+"].strDescription\" style=\"text-align: left; width:170px;\"  id=\"strDescription."+(rowCount)+"\" value='"+description+"'  />";
		    row.insertCell(9).innerHTML= "<input type=\"text\"  size=\"4.4%\" name=\"listUserDefRptDtlBean["+(rowCount)+"].strConstant\" style=\"text-align: left; width:45px;\"  id=\"strConstant."+(rowCount)+"\" value='"+constant+"'  />";
		    row.insertCell(10).innerHTML= "<input type=\"text\"  size=\"4.4%\" name=\"listUserDefRptDtlBean["+(rowCount)+"].strFormula\" style=\"text-align: left; width:48px;\"  id=\"strFormula."+(rowCount)+"\" value='"+formula+"'  />";
		    row.insertCell(11).innerHTML= "<select name=\"listUserDefRptDtlBean["+(rowCount)+"].strPrint\" class=\"Box\" style=\"width: 100%;\"  id=\"strPrint."+(rowCount)+"\"  >   '"+funGetPrintYNList(selectedPrintYN)+"'";
		    row.insertCell(12).innerHTML= '<input  class="deletebutton" value = "Delete" onClick="Javacsript:funDeleteRow(this)">';
		    funClickOnType(selectedType,rowCount);   
		    return false;
		}
		
		function funGetTypeList(selectedType)
		{
			var type="";
			var strType=["Text","Group","GL_Code","Constant","Formula"]
			type += "<option value="+selectedType+" selected>"+selectedType+"</option>";
			for(var i=0;i<strType.length;i++)
			{
				if(strType[i]!=selectedType)
				 type += "<option value="+strType[i]+">"+strType[i]+"</option>";
			}
			return type;
		}
		
		function funGetOperatorList(selectedOperator)
		{
			var type="";
			var strType=["Between","Equal"]
			type += "<option value="+selectedOperator+" selected>"+selectedOperator+"</option>";
			for(var i=0;i<strType.length;i++)
			{
				if(strType[i]!=selectedOperator)
				 type += "<option value="+strType[i]+">"+strType[i]+"</option>";
			}
			return type;
		}
		
		function funGetPrintYNList(selectedPrintYN)
		{
			var type="";
			var strType=["N","Y"]
			type += "<option value="+selectedPrintYN+" selected>"+selectedPrintYN+"</option>";
			for(var i=0;i<strType.length;i++)
			{
				if(strType[i]!=selectedPrintYN)
				 type += "<option value="+strType[i]+">"+strType[i]+"</option>";
			}
			return type;
		}
		
		function funGetColumnNoTypeList(selectedColumnNoType)
		{
			var columnNo="";
			var strColumnNo=["1","2","3","4"]
			columnNo += "<option value="+selectedColumnNoType+" selected>"+selectedColumnNoType+"</option>";
			for(var i=0;i<strColumnNo.length;i++)
			{
				if(strColumnNo[i]!=selectedColumnNoType)
					columnNo += "<option value="+strColumnNo[i]+">"+strColumnNo[i]+"</option>";
			}
			return columnNo;
		}
		
		
		 function funClickOnType(item,rowCount)
		 {
		   if(item=="Text")
		 	{
			    document.getElementById("strFGroup."+rowCount).disabled = true;  
		    	document.getElementById("strTGroup."+rowCount).disabled = true;   
		    	document.getElementById("strFAccount."+rowCount).disabled = true;   
		    	document.getElementById("strTAccount."+rowCount).disabled = true;  
			}
		    else if(item=="Group")
			{
		    	document.getElementById("strFGroup."+rowCount).disabled = false;  
		    	document.getElementById("strTGroup."+rowCount).disabled = false;  
		    	document.getElementById("strFAccount."+rowCount).disabled = true;  
		    	document.getElementById("strTAccount."+rowCount).disabled = true; 
		    	
			} 
		    else if(item=="GL_Code")
			{
		    	document.getElementById("strFGroup."+rowCount).disabled = true;  
		    	document.getElementById("strTGroup."+rowCount).disabled = true;  
		    	document.getElementById("strFAccount."+rowCount).disabled = false;  
		    	document.getElementById("strTAccount."+rowCount).disabled = false; 
			}
		    else if(item=="Constant")
			{
		    	document.getElementById("strFGroup."+rowCount).disabled = true;  
		    	document.getElementById("strTGroup."+rowCount).disabled = true;  
		    	document.getElementById("strFAccount."+rowCount).disabled = true;  
		    	document.getElementById("strTAccount."+rowCount).disabled = true; 
			}
		    else if(item=="Formula")
			{
		    	document.getElementById("strFGroup."+rowCount).disabled = true;  
		    	document.getElementById("strTGroup."+rowCount).disabled = true;  
		    	document.getElementById("strFAccount."+rowCount).disabled = true;  
		    	document.getElementById("strTAccount."+rowCount).disabled = true; 
			}
		   
 	     }
		 

		
		function funSetGroupCode(code,gridHelpRow,searchType)
		{
			if(searchData=="FGroup")
			{
				 document.getElementById("strFGroup."+gridHelpRow).value=code;
			}	
			else
			{
			    document.getElementById("strTGroup."+gridHelpRow).value=code;
			}	
			
		}
		function funSetAccountCode(code,gridHelpRow,searchType)
		{
			if(searchData=="FAccount")
			{
				document.getElementById("strFAccount."+gridHelpRow).value=code;
			}
			else
			{
				document.getElementById("strTAccount."+gridHelpRow).value=code;
			}	 
		}
		
		
		function funGetVaildation() 
		 {
				var flg=true;
				var table = document.getElementById("tblUserDefindDtl");
				var rowCount = table.rows.length;	

				if($("#txtReportName").val()=="")
		 		{
		 			alert('Enter User Defined Report Name!! ');
		 			return false;
		 		}
				
			  	if(rowCount<1)
				{
					alert("Please insert data in Grid");
					return false;
				}
				else
				{
					for(var i=0;i<rowCount;i++)
					{
						if(document.getElementById("strColumn."+i).value=='')
						{
							alert('Enter ColumnNo!! ');
							flg=false;
						}
						else
						{
							var regex=/^[0-9]+$/;
						    if (document.getElementById("strColumn."+i).value.match(regex))
						    {
						    	flg=true;
						    	if(document.getElementById("strDescription."+i).value=='')
								{
				    				alert('Enter Description!! ');
				    				flg=false;
								}
						    	else
						    	{
						    		flg=true;
						    		if(document.getElementById("strType."+i).value=='Constant')
					    			{
					    			  if(document.getElementById("strConstant."+i).value=='')
									  {
					    				alert('Enter Constant!! ');
					    				flg=false;
									  }	  
					    			}
						    		
						    		if(document.getElementById("strType."+i).value=='Formula')
					    			{
					    			  if(document.getElementById("strFormula."+i).value=='')
									  {
					    				alert('Enter Formula!! ');
					    				flg=false;
									  }	
					    			}
					    			
						    	}	
						    	
						    }
						    else
						    {
						    	alert('Enter Valid ColumnNo!! ');
						    	flg=false;
						    }	
						}
		    			
					}	
					return flg;
				}
		  }
		
		
		/**
		* Reset The Group Name TextField
		**/
		function funResetFields()
		{
			location.reload(true); 
	    }

	</script>

</head>
	<body>
	<div class="container-fluid">
		<label id="formHeading">User Defined Report Master</label>
			<s:form id="frmUserDefinedReportMaster" method="POST" action="saveUserDefinedReportMaster.html?saddr=${urlHits}">
				<div class="row masterTable">
					<div class="col-md-5">
						<label>Report ID</label><br>
							<div class="row">
								<div class="col-md-5">
									<s:input type="text" id="txtReportCode" path="strReportId" readonly="true" style="height:100%" ondblclick="funHelp('userDefinedReportCode');" class="searchTextBox"/>
								</div>
								<div class="col-md-7">
									<s:input id="txtReportName" type="text" required="true" path="strReportName"  />
								</div>
							</div>
					</div>	
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-5">
								<label>Date</label>
									<s:select id="cmbReportDate" path="dteUserDefDate" items="${listUserDefDate}" cssClass="BoxW124px"> </s:select></div>
							<div class="col-md-7">
								 <a href="#"><button class="btn btn-primary center-block" onclick="return funAddProductRow('Text','1','Equal','','','','','Desc','','','N')"
									class="form_button">Add</button></a>
							</div>
						</div>
					</div>		    			        			   
				</div>
				<div class="dynamicTableContainer" style="height: 300px; ">
			
			 <table class="transTablex col15-center" id="criteriaTable" style="width: 100%; border: #0F0; table-layout: fixed;">
				<tr style="font-family: sans-serif; background: #c0c0c0;" >
				    
				    <td>Sr.No</td>
					<!--  COl1   -->
					<td>Type</td>
					<!--  COl2   -->
					<td>Print In Col</td>
					<!--  COl3   -->
					<td>Operator</td>
					<!--  COl4   -->
					<td>Group</td>
					<!--  COl5   -->
					<td>Group</td>
					<!-- COl6   -->
					<td>Account</td>
					<!--  COl7   -->
					<td>Account</td>
					<!-- COl8   -->
					<td>Description</td>
					<!-- COl9   -->
					<td>Constant</td>
					<!-- COl10   -->
					<td>Formula</td>
					<!-- COl11   -->	
					<td>Print</td>
					<!-- COl12   -->
					<td>Del</td> 
						
				</tr>					
			</table>
					
			<table id="tblUserDefindDtl"
				style="width: 100%; border: #0F0; table-layout: fixed;"
				class="transTablex col15-center">
				<tbody>
				<col>
				<!--  COl1   -->
				<col>
				<!--  COl2   -->
				<col>
				<!--  COl3   -->
				<col> 
				<!--COl4   -->
				<col> 
				<!--COl5   -->
				<col> 
				<!-- COl6   -->
				<col> 
				<!-- COl7   -->
				<col> 
				<!-- COl8   -->
				<col> 
				<!--  COl9   -->
				<col> 
				<!--  COl10   -->
				<col> 
				<!--  COl11  -->
				<col>
		    	<!--COl12  -->
				<col>

				</tbody>

			</table>
			   
			</div>
			<br>
			<p align="right">
			<input id="btnSubmit" type="submit" value="Submit" class="btn btn-primary center-block" class="form_button" onclick="return funGetVaildation()" />&nbsp
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
			</p>
			
			<table class="transTable" id="tblReport">					
			</table>
			
			</s:form>
		</div>
	</body>
</html>
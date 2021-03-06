<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	
	    
<title>PHYSICAL STOCK POSTING</title>
<script type="text/javascript">
	/**
	 * Ready Function for Ajax Waiting
	 */
	 
	 var phystckeditable;
	 var checkPOSSales;
	$(document).ready(function(){
// 		 resetForms('stkPosting');
		   $("#txtProdCode").focus();	
		   $(document).ajaxStart(function(){
			    $("#wait").css("display","block");
			  });
			  $(document).ajaxComplete(function(){
			    $("#wait").css("display","none");
			  });
		
			  
			  
			  phystckeditable="${phystckeditable}" ;
			  if(phystckeditable=="false"){
				  $("#txtStkPostCode").prop('disabled', true);
			  }	
			  checkPOSSales="${strCheckPOSSales}" ;
			  
			  $(document).ajaxStart(function()
						{
						    $("#wait").css("display","block");
						});
						$(document).ajaxComplete(function()
						{
							$("#wait").css("display","none");
						});
			  
	});
</script>

	<script type="text/javascript">
	
	    /**
	     * Global Variable
	    **/		
		var fieldName,listRow=0;
		var ReceivedconversionUOM="";
		var issuedconversionUOM="";
		var recipeconversionUOM="";
		var ConversionValue=0;
		var maxQuantityDecimalPlaceLimit=3;
		
		/**
		 * Check validation before adding product data in grid
		 */
		function btnAdd_onclick() 
		{			
			var flag= funCheckPOSSalesData();
			if(flag)
			{
			    return false;
			}
			
			if($("#txtProdCode").val().trim().length ==0)
	        {
				 alert("Please Enter Product Code Or Search");
	             $("#txtProdCode").focus() ; 
	             return false;
	        }
			if($("#txtQuantity").val().trim()=="" || parseInt($("#txtQuantity").val())<0)
			{		
				alert("Please Enter Quantity");			
				$("#txtQuantity").focus();
				return false;
			}	     	 
			else
		    {
				var strProdCode=$("#txtProdCode").val();
				if(funDuplicateProduct(strProdCode))
	            	{
						funAddRow();
	            	}
			}
		}
		
		
		
		/**
		 * Check duplicate record in grid
		 */
		function funDuplicateProduct(strProdCode)
		{
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    	{
				    $('#tblProduct tr').each(function()
				    {
					    if(strProdCode==$(this).find('input').val())// `this` is TR DOM element
	    				{
					    	alert("Already added "+ strProdCode);
		    				flag=false;
	    				}
					});
				    
		    	}
		    return flag;
		  
		}
		
		/**
		 * Adding Product Data in grid 
		 */
		 function funAddRow() 
			{	
			    var prodCode = $("#txtProdCode").val();
			    var prodName = document.getElementById("lblProdName").innerHTML;
			    var unitPrice = $("#txtCostRM").val();
			    unitPrice=parseFloat(unitPrice).toFixed(maxAmountDecimalPlaceLimit);
			    var wtunit = $("#txtWtUnit").val();
			    
			    var ProductData=fungetConversionUOM(prodCode);
			    
			    var actualRate = $("#txtActualRate").val();
			    actualRate=parseFloat(actualRate).toFixed(maxAmountDecimalPlaceLimit);
			     
			    wtunit=parseFloat(wtunit).toFixed(maxAmountDecimalPlaceLimit);
			    var currentStkQty = $("#txtStock").val();
			    
			    var currentStkQtyRecepi = $("#txtStock").val();
			    var currentStkQty1=currentStkQtyRecepi.split(".");
			    var tmpCurrentStkQty='';
				if(currentStkQty1.length>1){
					tmpCurrentStkQty=parseFloat("0."+currentStkQty1[1]) * ProductData.dblRecipeConversion;
					tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
				}
				if(tmpCurrentStkQty!=''){
					currentStkQtyRecepi=currentStkQty1[0]+"."+tmpCurrentStkQty;
				}
			    
			    
			    var phyStkQty = $("#txtQuantity").val();
			    if($('#cmbConversionUOM').val()=="RecUOM")
				{
	    			
					ConversionValue=ProductData.dblReceiveConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					phyStkQty=parseFloat(phyStkQty)/parseFloat(ConversionValue);
					
					// here we calculate physical stock qty in decimal point 
					 var tmpPhyStk1=phyStkQty;
					if(ProductData.dblReceiveConversion != ProductData.dblRecipeConversion){
						tmpPhyStk1=parseFloat(tmpPhyStk1).toFixed(maxQuantityDecimalPlaceLimit);	
						if(ProductData.dblRecipeConversion >1000){
							tmpPhyStk1=parseFloat($("#txtQuantity").val()).toFixed(4);   
							var vartxtQuantity= tmpPhyStk1.split(".");
							   if(vartxtQuantity[1]!=''){
								   if(vartxtQuantity[1] > ProductData.dblRecipeConversion){
									   tmpPhyStk1=parseFloat($("#txtQuantity").val()).toFixed(maxQuantityDecimalPlaceLimit);
								   }
							   }
							
						}
					}
					 
					 
					 var tmpPhyStkQty1= tmpPhyStk1.toString().split(".");
					var tmpPhyStkQty2='';
					if(tmpPhyStkQty1.length>1){
						if(ProductData.dblReceiveConversion != ProductData.dblRecipeConversion){
							tmpPhyStkQty2=parseFloat(tmpPhyStkQty1[1]) / ProductData.dblRecipeConversion;	
						}else{
							tmpPhyStkQty2=parseFloat("0."+tmpPhyStkQty1[1]) / ProductData.dblRecipeConversion;
						}
						
						//tmpPhyStkQty2=tmpPhyStkQty2.toFixed(0);
					}
					if(tmpPhyStkQty2!=''){
						phyStkQty=parseFloat(tmpPhyStkQty1[0])+tmpPhyStkQty2;	
					} 
					
				}
			    if($('#cmbConversionUOM').val()=="RecipeUOM")
				{
	    			//var ProductData=fungetConversionUOM(prodCode);
					ConversionValue=ProductData.dblRecipeConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					phyStkQty=parseFloat(phyStkQty)/parseFloat(ConversionValue);
				}
			    if($('#cmbConversionUOM').val()=="IssueUOM")
				{
	    			//var ProductData=fungetConversionUOM(prodCode);
					ConversionValue=ProductData.dblIssueConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					phyStkQty=parseFloat(phyStkQty)/parseFloat(ConversionValue);
				}
			   
			    var tempphyStkQty=parseFloat(phyStkQty).toFixed(maxQuantityDecimalPlaceLimit);
			    var variance=tempphyStkQty-currentStkQty;
			    variance=parseFloat(variance).toFixed(maxQuantityDecimalPlaceLimit);
			    var adjValue = unitPrice*variance;
			    adjValue=parseFloat(adjValue).toFixed(maxQuantityDecimalPlaceLimit);
			    
			    var actulAdjValue = actualRate*variance;
			    actulAdjValue=parseFloat(actulAdjValue).toFixed(maxQuantityDecimalPlaceLimit);
			    
			    var adjWeight = wtunit*variance;
			    adjWeight=parseFloat(adjWeight).toFixed(maxQuantityDecimalPlaceLimit);		    
			    var table = document.getElementById("tblProduct");
			    var rowCount = table.rows.length;
			    var row = table.insertRow(rowCount);
			    
			    
			    var DiscurrentStkQty=$("#txtStock").val();
			    DiscurrentStkQty=parseFloat(DiscurrentStkQty).toFixed(maxQuantityDecimalPlaceLimit);
			    var tempStkQty=DiscurrentStkQty.split(".");
			    
			    DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tempStkQty[1])*parseFloat(ConversionValue)+" "+recipeconversionUOM;
			    if($('#cmbConversionUOM').val()=="RecUOM")
				{
			    	DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tempStkQty[1])* ProductData.dblRecipeConversion+" "+recipeconversionUOM;
				}
			    
			    var tempQty=tempphyStkQty.split(".");
			    var Displyqty=tempQty[0]+" "+ReceivedconversionUOM+" "+tempQty[1]+" "+recipeconversionUOM;
			    if(recipeconversionUOM==ReceivedconversionUOM){
			    	Displyqty=tempQty[0]+"."+tempQty[1] +ReceivedconversionUOM;
			    }
			    var LooseQty=$("#txtQuantity").val();
	 			if(ProductData.dblRecipeConversion >1000){
			    	LooseQty=parseFloat(LooseQty).toFixed(4);   
					var vartxtQuantity= LooseQty.split(".");
					   if(vartxtQuantity[1]!=''){
						   if(vartxtQuantity[1] > ProductData.dblRecipeConversion){
							  
			    LooseQty=parseFloat(LooseQty).toFixed(maxQuantityDecimalPlaceLimit);
	 					}
					   }
			    	
			   
	 			}else{
			    	LooseQty=parseFloat(LooseQty).toFixed(maxQuantityDecimalPlaceLimit);	
			    }
			    
			    //calculate display actual qty 
			    var DisplyActualQty=Displyqty;
			    
			    var tmpPhyStkQty2= $("#txtQuantity").val().split(".");
			    if(recipeconversionUOM !=ReceivedconversionUOM){
			    	
			    	if($('#cmbConversionUOM').val()=="RecUOM"){
				    	if(tmpPhyStkQty2[1]!=''){
					if(ProductData.dblRecipeConversion >1000){
				    	    	
				    	    	DisplyActualQty =parseFloat($("#txtQuantity").val()).toFixed(4);
				    	    	tmpPhyStkQty2=DisplyActualQty.split(".");
				    	    	  if(tmpPhyStkQty2[1]!=''){
									   if(tmpPhyStkQty2[1] > ProductData.dblRecipeConversion){
										   DisplyActualQty=parseFloat(DisplyActualQty).toFixed(maxQuantityDecimalPlaceLimit);
										   tmpPhyStkQty2=DisplyActualQty.split(".");
										   DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" "+ tmpPhyStkQty2[1] +" "+recipeconversionUOM;
									   }
								   }else{
									   DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" "+ tmpPhyStkQty2[1] +" "+recipeconversionUOM;	   
								   }
				    	    	
				    	    		
				    	    }else{
					    	DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tmpPhyStkQty2[1]) * 1000 +" "+recipeconversionUOM;
						}
						
						
						}else{
					    	DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" 0 "+recipeconversionUOM;
					    }
					}else if($('#cmbConversionUOM').val()=="RecipeUOM"){
				    	tmpPhyStkQty2 = $("#txtQuantity").val();
				    	tmpPhyStkQty2= parseFloat(tmpPhyStkQty2) / ProductData.dblRecipeConversion ;
				    	var tPhyStkQty=tmpPhyStkQty2.toString().split(".");
				    	
				    	DisplyActualQty = tPhyStkQty[0]+" "+ReceivedconversionUOM+" 0 "+recipeconversionUOM;
				    	if(tPhyStkQty.length >1){
				    		DisplyActualQty = tPhyStkQty[0]+" "+ReceivedconversionUOM+"."+ parseFloat("0."+tPhyStkQty[1]) * ProductData.dblRecipeConversion +" "+recipeconversionUOM;
				    	}
				    }
			    }
			    
			    
			    
			    /* var tempCurrStkQty= currentStkQtyRecepi.split(".");
			    
			    var disQtyInRecipe=(parseFloat(tempStkQty[0]) * ProductData.dblRecipeConversion) + parseFloat(tempStkQty[1]); 
			    var CurrQtyInRecipe=(parseFloat(tempCurrStkQty[0]) * ProductData.dblRecipeConversion) + parseFloat(tempCurrStkQty[1]);
			    
			    DisplyActualQty= CurrQtyInRecipe-disQtyInRecipe;
			     */
			    
			     var tempvariance=variance.split(".");
			     var DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+"."+parseFloat(tempvariance[1])*parseFloat(ConversionValue)+" "+recipeconversionUOM;
			     if(recipeconversionUOM ==ReceivedconversionUOM){
			    	 DisplayVariance=variance+" "+ReceivedconversionUOM;
			     }else{
			    
			    	 if($('#cmbConversionUOM').val()=="RecUOM")
						{
						 	var currentStkQty1=$("#txtStock").val().split(".");
				 		    var tmpCurrentStkQty="0";
				 			if(currentStkQty1.length>1){
							tmpCurrentStkQty=currentStkQty1[0] * ProductData.dblRecipeConversion;
				 				tmpCurrentStkQty= tmpCurrentStkQty + parseFloat("0."+currentStkQty1[1]) * ProductData.dblRecipeConversion ;
				 				tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
				 			}else{
				 				tmpCurrentStkQty= currentStkQty1[0] * ProductData.dblRecipeConversion;
				 				tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
				 			}
							var stkCurrRecp=tmpCurrentStkQty;
				 			var strPhyStkQty=$("#txtQuantity").val().split(".");
				 			var tmpPhyStkQty="0";
				 			if(strPhyStkQty.length>1){
				 				tmpPhyStkQty=strPhyStkQty[0] * ProductData.dblRecipeConversion;
				 				tmpPhyStkQty= parseFloat(tmpPhyStkQty) + parseFloat(strPhyStkQty[1]);
				 				
				 			}else{
				 				tmpPhyStkQty= strPhyStkQty[0] * ProductData.dblRecipeConversion;
				 			}
							
			var stkVar= parseFloat(tmpPhyStkQty) - parseFloat(stkCurrRecp);
				 			
				 			DisplayVariance = stkVar / ProductData.dblRecipeConversion;
				 			
				 			var tempvariance= DisplayVariance.toString().split(".");
						 	DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+" "+parseFloat( parseFloat("0."+tempvariance[1]) * ProductData.dblRecipeConversion ).toFixed(0)+" "+recipeconversionUOM;	 
						}
			    	  else if($('#cmbConversionUOM').val()=="RecipeUOM"){
			    		 
				 		    var tmpCurrentStkQty="0";
				 		    var diff=  phyStkQty -  $("#txtStock").val();
				 			var currentStkQty1= diff.toString().split(".");   
				 		    
				 			
						DisplayVariance=currentStkQty1[0]+" "+ReceivedconversionUOM ;
				 			if(currentStkQty1.length>1){
				 				tmpCurrentStkQty=parseFloat("0."+currentStkQty1[1]) * ProductData.dblRecipeConversion ;
				 				tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
								DisplayVariance=currentStkQty1[0]+" "+ReceivedconversionUOM+" "+tmpCurrentStkQty +" "+recipeconversionUOM;
				 			}
				 			/* var stkCurr=currentStkQty1[0]+"."+tmpCurrentStkQty;
				 			var stkVar= parseFloat($("#txtQuantity").val()) -  parseFloat(stkCurr);
				 			DisplayVariance = stkVar.toFixed(maxQuantityDecimalPlaceLimit);
				 			var tempvariance= DisplayVariance.split(".");
						 	DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+" "+tempvariance[1] +" "+recipeconversionUOM;	  */
						}
			     }
				 
				    
				 
				 
				 
			   /*  var varianceInRecipe=parseFloat(variance);
			     if(varianceInRecipe!=0 || varianceInRecipe !=''){
			    	 var varianceInRecipe1=varianceInRecipe.split(".");
			    	 varianceInRecipe1[1]
			    	 DisplayVariance = tempvariance[0]+" "+ReceivedconversionUOM+"."+parseFloat(tempvariance[1])*parseFloat(ConversionValue)+" "+recipeconversionUOM;
			    } */
			     
			    rowCount=listRow;
			    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\" name=\"listStkPostDtl["+(rowCount)+"].strProdCode\" id=\"txtProdCode."+(rowCount)+"\" value="+prodCode+">";
			    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"30%\" name=\"listStkPostDtl["+(rowCount)+"].strProdName\" id=\"lblProdName."+(rowCount)+"\" value='"+prodName+"'>";
			    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"margin-left: -72px;text-align: right;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblPrice\" id=\"txtCostRM."+(rowCount)+"\" value="+unitPrice+">";
			    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  style=\"margin-left: -66px;text-align: right;\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblWeight\" id=\"txtWtUnit."+(rowCount)+"\"  value="+wtunit+">";
			    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left: -60px;\" size=\"12%\"  id=\"txtDisplayStock."+(rowCount)+"\" value='"+DiscurrentStkQty+"'>";
			   
			    /* row.insertCell(5).innerHTML= "<input class=\"Box\" type=\"text\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyQty\" size=\"9%\" style=\"text-align: right;\" id=\"txtDisplyQty."+(rowCount)+"\"  value='"+Displyqty+"'/>"; */	
			    row.insertCell(5).innerHTML= "<input class=\"Box\" type=\"text\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyQty\" size=\"15%\" style=\"text-align: right;margin-left: -37px;border: 1px solid #a2a2a2; padding: 1px;width: 110%;\" id=\"txtDisplyQty."+(rowCount)+"\"  value='"+DisplyActualQty+"'/>";
			    row.insertCell(6).innerHTML= "<input class=\"decimal-places inputText-Auto\" type=\"text\" style=\"text-align: right;margin-left: -23px;border: 1px solid #a2a2a2;padding: 1px; width: 75%;\" name=\"listStkPostDtl["+(rowCount)+"].dblLooseQty\" id=\"txtLooseQty."+(rowCount)+"\"  value='"+LooseQty+"' onblur=\"funUpdatePrice(this);\" />";	
			   
			    row.insertCell(7).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"14%\" style=\"margin-left: -37px;\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyVariance\" id=\"txtDisplayVariance."+(rowCount)+"\" value='"+DisplayVariance+"'>";	
			    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left: 10px;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjWt\" id=\"lblAdjWeight."+(rowCount)+"\" value="+adjWeight+">";
			    row.insertCell(9).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;margin-left: -7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjValue\" id=\"lblAdjValue."+(rowCount)+"\"  value="+adjValue+">";	
			    
			    row.insertCell(10).innerHTML= "<input readonly=\"readonly\" class=\"Box totalActualValueCell\" style=\"text-align: right;margin-left: -7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblActualValue\" id=\"lblActualAdjValue."+(rowCount)+"\"  value="+actulAdjValue+">";	
			    row.insertCell(11).innerHTML= "<input type=\"button\" value = \"Delete\" class=\"deletebutton\" style=\"margin-left: 10px;\" onClick=\"Javacsript:funDeleteRow(this)\">";
			    
			    row.insertCell(12).innerHTML= "<input type=\"hidden\"  class=\"decimal-places inputText-Auto\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblActualRate\" id=\"txtActualRate."+(rowCount)+"\" value="+actualRate+" >";
			    row.insertCell(13).innerHTML= "<input type=\"hidden\"  class=\"decimal-places inputText-Auto\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblPStock\" id=\"txtQuantity."+(rowCount)+"\" value="+phyStkQty+" >";
			    row.insertCell(14).innerHTML= "<input type=\"hidden\" name=\"listStkPostDtl["+(rowCount)+"].dblVariance\" id=\"lblVariance."+(rowCount)+"\" value="+variance+">";	
			    row.insertCell(15).innerHTML= "<input name=\"listStkPostDtl["+(rowCount)+"].dblCStock\" id=\"txtStock."+(rowCount)+"\" value="+currentStkQty+">";
			  
			    listRow++;
			    funApplyNumberValidation();
			    funCalSubTotal();
			    funResetProductFields();
			    
			    $("#txtLocCode").attr("readonly", true); 
			    $("#txtStkPostDate").attr("readonly", true) .datepicker("destroy");
			    $("#hidConversionUOM").val($("#cmbConversionUOM").val());
			    $("#cmbConversionUOM").attr("disabled", true);
			    $("#hidProductMasterUpdateYN").val($("#cmbProductMaster").val());
			    $("#cmbProductMaster").attr("disabled", true);
			    $("#txtProdCode").focus() ; 
			    return false;
			}
			
		
		/**
		 * Update total price when user change the qty 
		 */
		 function funUpdatePrice(object){
			
		}
		function funUpdatePrice1(object)
		{
			var index=object.parentNode.parentNode.rowIndex;
			var cStock=document.getElementById("txtStock."+index).value;
			var looseQty=document.getElementById("txtLooseQty."+index).value;
			document.getElementById("txtQuantity."+index).value=looseQty;
			var PhyQty=document.getElementById("txtQuantity."+index).value;
			var unitPrice=document.getElementById("txtCostRM."+index).value;
			
			var actualRate=document.getElementById("txtActualRate."+index).value; 
			actualRate=parseFloat(actualRate).toFixed(maxAmountDecimalPlaceLimit);
			var variance=PhyQty-cStock;
			document.getElementById("lblVariance."+index).value=variance;
			
			var prodCode = document.getElementById("txtProdCode."+index).value;
			 if($('#cmbConversionUOM').val()=="RecUOM")
				{
	    			var ProductData=fungetConversionUOM(prodCode);
					ConversionValue=ProductData.dblReceiveConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					PhyQty=parseFloat(PhyQty)/parseFloat(ConversionValue);
				}
			    if($('#cmbConversionUOM').val()=="RecipeUOM")
				{
	    			var ProductData=fungetConversionUOM(prodCode);
					ConversionValue=ProductData.dblRecipeConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					PhyQty=parseFloat(PhyQty)/parseFloat(ConversionValue);
				}
			    if($('#cmbConversionUOM').val()=="IssueUOM")
				{
	    			var ProductData=fungetConversionUOM(prodCode);
					ConversionValue=ProductData.dblIssueConversion;
					ReceivedconversionUOM=ProductData.strReceivedUOM;
					issuedconversionUOM=ProductData.strIssueUOM;
					recipeconversionUOM=ProductData.strRecipeUOM;
					PhyQty=parseFloat(PhyQty)/parseFloat(ConversionValue);
				}
			    PhyQty=parseFloat(PhyQty).toFixed(maxQuantityDecimalPlaceLimit);
			    
			    
			    var adjValue = unitPrice*variance;
				document.getElementById("lblAdjValue."+index).value=parseFloat(adjValue).toFixed(maxQuantityDecimalPlaceLimit);
				
				var actualAdjValue = actualRate*variance;
				document.getElementById("lblActualAdjValue."+index).value=parseFloat(actualAdjValue).toFixed(maxQuantityDecimalPlaceLimit);
			    
				var tempQty=PhyQty.split(".");
				var Displyqty=tempQty[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempQty[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
				document.getElementById("txtDisplyQty."+index).value=Displyqty;
				variance=parseFloat(variance).toFixed(maxQuantityDecimalPlaceLimit);
				var tempvariance=variance.split(".");
				var DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+"."+parseFloat("0."+tempvariance[1])*parseFloat(ConversionValue)+" "+recipeconversionUOM;
				document.getElementById("txtDisplayVariance."+index).value=DisplayVariance;
				funCalSubTotal();
			
		}
		
		/**
		 * Delete a particular record from a grid
		 */
		function funDeleteRow(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblProduct");
		    table.deleteRow(index);
		}
		
		/**
		 * Ready function
		 * Checking Autorization
		 * Success Message after Submit the Form
		 * Open slip
		 */
		$(document).ready(function(){
			
			var message='';
			var SAmessage='';
			<%if (session.getAttribute("success") != null) {
				            if(session.getAttribute("successMessage") != null){%>
				            message='<%=session.getAttribute("successMessage").toString()%>';
				            alert("Data Save successfully\n\n"+message);
				            <%
				            session.removeAttribute("successMessage");
				            }
				            if(session.getAttribute("successMessageSA") != null){%>
				            SAmessage='<%=session.getAttribute("successMessageSA").toString()%>';
				            alert("Data Save successfully\n\n"+SAmessage);
				            <%
				            session.removeAttribute("successMessageSA");
				            }
							boolean test = ((Boolean) session.getAttribute("success")).booleanValue();
							session.removeAttribute("success");
							if (test) {
							%>	
			<%
			}}%>
			
			var flagOpenFromAuthorization="${flagOpenFromAuthorization}";
			if(flagOpenFromAuthorization == 'true')
			{
				funGetPhyStkPostingData("${authorizationPhyStkCode}");
			}
			
			var code='';
			<%if(null!=session.getAttribute("rptStockPostingCode")){%>
			code='<%=session.getAttribute("rptStockPostingCode").toString()%>';
			<%session.removeAttribute("rptStockPostingCode");%>
			var isOk=confirm("Do You Want to Generate Slip?");
			if(isOk){
			window.open(getContextPath()+"/openRptPhysicalStockPostingSlip.html?rptStockPostingCode="+code,'_blank');
			}
			<%}%>
			});
		
		/**
		 * Reset form
		 */
		function funResetFields()
		{
			location.reload(true); 
		} 
		
		/**
		 * Remove all product from grid
		 */
		function funRemProdRows()
	    {
			var table = document.getElementById("tblProduct");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
	    }
		
		/**
		 * Reset textfield
		 */
		function funResetProductFields()
		{
			$("#txtProdCode").val('');
		    document.getElementById("lblProdName").innerHTML='';
		    $("#txtCostRM").val('');
		    $("#txtWtUnit").val('');
		    $("#txtStock").val('');
		    $("#txtQuantity").val('');
		    $("#spStockUOM").text('');
		    $("#spStockUOMWithConversion").text('');
		    
		}
		
		
				
		/**
		 * Checking Validation before submiting the data
		 */
		$(function() 
		{
			$( "#txtStkPostDate" ).datepicker({ dateFormat: 'dd-mm-yy' });
			$( "#txtStkPostDate" ).datepicker('setDate', 'today');
			
			$("form").submit(function()
			{
				var table = document.getElementById("tblProduct");
			    var rowCount = table.rows.length;
			    
			    if (!fun_isDate($("#txtStkPostDate").val())) 
			    {
				 alert('Invalid Date');
				 $("#txtStkPostDate").focus();
				 return false;  
			   }
				if($("#txtStkPostDate").val()=='')
				{
					alert("Please Enter Or Select Date");
					return false;
				}
				else if($("#txtLocCode").val()=='')
				{
					alert("Please Enter Location Or Search");
					return false;
				}
				else if(rowCount==0)
				{
					alert("Please Add Product in Grid");
					return false;
				}  
				var stkDate=$("#txtStkPostDate").val();
				if(funGetMonthEnd(document.all("txtLocCode").value,stkDate)!=true)
				{
	            	alert("Month End Done For Selected Month");
		            return false;
	            }
				else
				{
					return true;
				}
				
				
			});
		});
	
		/**
		 * Open Help Form 
		 **/
		 function funHelp1(transactionName,loc)
			{ 
				if ($('#txtLocCode').attr("readonly")!='readonly')
				{
					fieldName=transactionName;
					window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;top=500,left=500")
				}
			}
		 
		 
		function funHelp(transactionName)
		{
			var location=$("#txtLocCode").val();
			fieldName=transactionName;
			if(fieldName=='productInUse')
			{
				if($("#txtLocCode").val()=='')
				{
					alert("Please Select Location");
				}
				else
				{
			        window.open("searchform.html?formname="+transactionName+"&locationCode="+location+"&searchText=","","dialogHeight:600px;dialogWidth:1000px;top=500,left=500")
				}
			}
			else
			{
			//	 window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:800px;dialogLeft:200px;")
				 window.open("searchform.html?formname="+transactionName+"&locationCode="+location+"&searchText=","","dialogHeight:600px;dialogWidth:800px;top=500,left=500")
			}
	    }
		
		/**
		 * Set Data after selecting form Help windows
		 */
		function funSetData(code)
		{
			switch (fieldName) 
			{
			    case 'stkpostcode':
					funGetPhyStkPostingData(code);
			        break;
			        
			    case 'locationmaster':
			    	funSetLocation(code);
			        break;
			        
			    case 'RawProduct':
			    	funSetProduct(code);
			        break;
			   
			}
		}
		
		/**
		 * Get Physical stock Data after selecting form Help windows
		 */
		function funGetPhyStkPostingData(code)
		{
			$("#txtProdCode").focus();
			var searchUrl="";
			searchUrl=getContextPath()+"/frmPhysicalStkPosting1.html?PSCode="+code;	
			//alert(searchUrl);
			$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	if(response.strPSCode=='Invalid Code')
			       	{
			       		alert('Invalid Code');
			       		$("#txtStkPostCode").val('');
			       		$("#txtStkPostCode").focus();
			       		return false;
			       	}
			       	else
			       	{
			       		$("#txtStkPostCode").val(response.strPSCode);
			       		$("#txtStkPostDate").val(response.dtPSDate);
			       		$("#txtLocCode").val(response.strLocCode);
			       		$("#txtLocName").text(response.strLocName);
			       		$("#txtTotalAmount").val(response.dblTotalAmt);
			       		$("#txtAreaNarration").val(response.strNarration);
			       		$("#cmbConversionUOM").val(response.strConversionUOM);		
			       		$("#cmbProductMaster").val(response.strProductMasterUpdateYN);		
			       	 	$("#txtLocCode").attr("readonly", true); 
					    $("#txtStkPostDate").attr("readonly", true) .datepicker("destroy");
					    $("#hidConversionUOM").val(response.strConversionUOM);
					    $("#hidProductMasterUpdateYN").val(response.strProductMasterUpdateYN);
					    $("#cmbConversionUOM").attr("disabled", true);
					    $("#cmbProductMaster").attr("disabled", true);
			       		
			       	 	/* $("#txtLocCode").attr("disabled", "disabled"); 
					    $("#txtStkPostDate").attr("disabled", "disabled"); 
					    $("#cmbConversionUOM").attr("disabled", "disabled"); */
					    
			       		var saCode = response.strSACode ;
			       		$('#hidSACode').val(saCode);
			       		if(!(saCode.length==0))
			       			{
			       				$("#txtAreaNarration").val("Stock Adjustment Code :" + response.strSACode);
			       			}
			       		
		        		$("#txtProdCode").focus();
		        		funGetProdData1(response.listStkPostDtl);
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
		
		function funGetProdData1(response)
		{
			var count=0;
					funRemProdRows();
					$.each(response, function(i,item)
                    {		//alert(i);
                    	count=i;
						funfillProdRow(response[i].strProdCode,response[i].strProdName,response[i].dblPrice,response[i].dblWeight,
						response[i].dblCStock,response[i].dblPStock,response[i].dblVariance,response[i].dblAdjValue,response[i].dblAdjWt,
						response[i].strDisplyQty,response[i].dblLooseQty,response[i].strDisplyVariance,response[i].dblActualRate,response[i].dblActualValue);
                                                   
                    });
				listRow=count+1;
				funCalSubTotal();
		}
		
		/**
		 * Filling Data in grid
		 */
		function funfillProdRow(prodCode,prodName,unitPrice,wtunit,currentStkQty,
				phyStkQty,variance,adjValue,adjWeight,Displyqty,LooseQty,DisplayVariance,dblActualRate,dblActualValue)
		{
			
			if($('#cmbConversionUOM').val()=="RecUOM")
			{
    			var ProductData=fungetConversionUOM(prodCode);
				ConversionValue=ProductData.dblReceiveConversion;
				ReceivedconversionUOM=ProductData.strReceivedUOM;
				issuedconversionUOM=ProductData.strIssueUOM;
				recipeconversionUOM=ProductData.strRecipeUOM;
				
			}
		    if($('#cmbConversionUOM').val()=="RecipeUOM")
			{
    			var ProductData=fungetConversionUOM(prodCode);
				ConversionValue=ProductData.dblRecipeConversion;
				ReceivedconversionUOM=ProductData.strReceivedUOM;
				issuedconversionUOM=ProductData.strIssueUOM;
				recipeconversionUOM=ProductData.strRecipeUOM;
			}
		    if($('#cmbConversionUOM').val()=="IssueUOM")
			{
    			var ProductData=fungetConversionUOM(prodCode);
				ConversionValue=ProductData.dblIssueConversion;
				ReceivedconversionUOM=ProductData.strReceivedUOM;
				issuedconversionUOM=ProductData.strIssueUOM;
				recipeconversionUOM=ProductData.strRecipeUOM;
			}
		    currentStkQty=parseFloat(currentStkQty).toFixed(maxQuantityDecimalPlaceLimit);
		    var tempStkQty=currentStkQty.split(".");
		    DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+"."+parseFloat("0."+tempStkQty[1])*parseFloat(ConversionValue)+" "+recipeconversionUOM;
		    var table = document.getElementById("tblProduct");
			    var rowCount = table.rows.length;
			    var row = table.insertRow(rowCount);		   
			    
			    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box productCode\" size=\"9%\" name=\"listStkPostDtl["+(rowCount)+"].strProdCode\" id=\"txtProdCode."+(rowCount)+"\" value="+prodCode+">";
			    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"30%\" name=\"listStkPostDtl["+(rowCount)+"].strProdName\" id=\"lblProdName."+(rowCount)+"\" value='"+prodName+"'>";
			    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"margin-left: -72px;text-align: right;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblPrice\" id=\"txtCostRM."+(rowCount)+"\" value="+unitPrice+">";
			    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  style=\"margin-left: -66px;text-align: right;\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblWeight\" id=\"txtWtUnit."+(rowCount)+"\"  value="+wtunit+">";
			    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left: -60px;\" size=\"12%\"  id=\"txtDisplayStock."+(rowCount)+"\" value='"+DiscurrentStkQty+"'>";
			    
			    row.insertCell(5).innerHTML= "<input class=\"Box\" type=\"text\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyQty\" size=\"15%\" style=\"text-align: right;margin-left: -37px;border: 1px solid #a2a2a2; padding: 1px;width: 110%;\" id=\"txtDisplyQty."+(rowCount)+"\" value='"+Displyqty+"'/>";	
			    row.insertCell(6).innerHTML= "<input class=\"decimal-places inputText-Auto looseQty\" type=\"text\" style=\"text-align: right;margin-left: -23px;border: 1px solid #a2a2a2;padding: 1px; width: 75%;\" name=\"listStkPostDtl["+(rowCount)+"].dblLooseQty\"  id=\"txtLooseQty."+(rowCount)+"\"  value='"+LooseQty+"'onblur=\"funUpdatePrice(this);\" />";	
			    
			    row.insertCell(7).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  size=\"14%\" style=\"margin-left: -37px;\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyVariance\" id=\"txtDisplayVariance."+(rowCount)+"\" value='"+DisplayVariance+"'>";
			    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left: 10px;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjWt\" id=\"lblAdjWeight."+(rowCount)+"\" value="+adjWeight+">";
			    row.insertCell(9).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;margin-left:-7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjValue\" id=\"lblAdjValue."+(rowCount)+"\"  value="+adjValue+">";			    					
			    
			    row.insertCell(10).innerHTML= "<input readonly=\"readonly\" class=\"Box totalActualValueCell\" style=\"text-align: right;margin-left: -7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblActualValue\" id=\"lblActualAdjValue."+(rowCount)+"\"  value="+dblActualValue+">";
			    row.insertCell(11).innerHTML= "<input type=\"button\" value = \"Delete\" class=\"deletebutton\" style=\"margin-left: 10px;\" onClick=\"Javacsript:funDeleteRow(this)\">";
			    row.insertCell(12).innerHTML= "<input type=\"hidden\"  class=\"decimal-places inputText-Auto\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblActualRate\" id=\"txtActualRate."+(rowCount)+"\" value="+dblActualRate+" >";
			    row.insertCell(13).innerHTML= "<input type=\"hidden\" required = \"required\"  class=\"Box phyStk\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblPStock\" id=\"txtQuantity."+(rowCount)+"\" value="+phyStkQty+" >";
			    row.insertCell(14).innerHTML= "<input type=\"hidden\" name=\"listStkPostDtl["+(rowCount)+"].dblVariance\" id=\"lblVariance."+(rowCount)+"\" value="+variance+">";
			    row.insertCell(15).innerHTML= "<input type=\"hidden\" name=\"listStkPostDtl["+(rowCount)+"].dblCStock\" id=\"txtStock."+(rowCount)+"\" value="+currentStkQty+">";
		}
		
		/**
		 * Set and Get Location Data after selecting form Help windows
		 */
		function funSetLocation(code)
		{
			var searchUrl="";
			searchUrl=getContextPath()+"/loadLocationMasterData.html?locCode="+code;
			//alert("sdf");
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	if(response.strLocCode=='Invalid Code')
				       	{
				       		alert("Invalid Location Code");
				       		$("#txtLocCode").val('');
				       		$("#txtLocName").text("");
				       		$("#txtLocCode").focus();
				       	}
				       	else
				       	{
				    	$("#txtLocCode").val(response.strLocCode);
				    	$("#txtLocName").text(response.strLocName);
				    	$('#txtProdCode').focus();
				    	
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
		 * Set and Get Product Data after selecting form Help windows
		 */
		function funSetProduct(code)
		{
			var searchUrl="";
			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
			$.ajax
			({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    async: false,
			    success: function(response)
			    {
			    	if('Invalid Code' == response.strProdCode){
			    		alert('Invalid Product Code');
				    	$("#txtProdCode").val('');
				    	$("#lblProdName").text('');
				    	$("#txtProdCode").focus();
			    	}else{
			    	$("#txtProdCode").val(response.strProdCode);
		        	$("#lblProdName").text(response.strProdName);
		        	var dblStock=funGetProductStock(response.strProdCode);
		        	$("#txtStock").val(dblStock);
		        	//$("#spStockUOM").text(response.strReceivedUOM);
		        	$("#txtCostRM").val(response.dblCostRM);
		        	$("#txtWtUnit").val(response.dblWeight);
		        	
		        	
		        	 var currentStkQty1=$("#txtStock").val().split(".");
		 		    var tmpCurrentStkQty='';
		 			if(currentStkQty1.length>1){
		 				tmpCurrentStkQty=parseFloat(parseFloat("0."+currentStkQty1[1]) * response.dblRecipeConversion );
		 				tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
		 			}
		 			var currentStkQtyRecepi=currentStkQty1 +" "+response.strReceivedUOM;
		 			if(tmpCurrentStkQty!=''){
		 				currentStkQtyRecepi="("+currentStkQty1[0]+" "+response.strReceivedUOM+" "+tmpCurrentStkQty+" "+response.strRecipeUOM+")";
		 			
		 			}
		        	
		        	$("#spStockUOMWithConversion").text(currentStkQtyRecepi);
		        	
		        	
		        	funLatestGRNProductRate(response.strProdCode,response.dblCostRM);
		        	
		        	$("#txtQuantity").focus();
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
		 * Get stock for product 
		 */
		function funGetProductStock(strProdCode)
		{
			var searchUrl="";	
			var locCode=$("#txtLocCode").val();
			var dtPhydate=$("#txtStkPostDate").val();
			var dblStock="0.000";
			searchUrl=getContextPath()+"/getProductStockInUOM.html?prodCode="+strProdCode+"&locCode="+locCode+"&strTransDate="+dtPhydate+"&strUOM=RecUOM";	
			//alert(searchUrl);		
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    async: false,
				    success: function(response)
				    {
				    	dblStock= response;
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
			return dblStock;//Math.round(dblStock * 100) / 100;
		}
		
		/**
		 * Calculating Subtotal
		 */
		function funCalSubTotal()
	    {
			funApplyNumberValidation();
	        var dblQtyTot=0;		        
	        var subtot=0;
	        var actTotal=0;
	        $('#tblProduct tr').each(function() {
			    var totalvalue = $(this).find(".totalValueCell").val();
			    subtot = parseFloat(subtot + parseFloat(totalvalue));
			    var totalActvalue = $(this).find(".totalActualValueCell").val();
			    actTotal = parseFloat(actTotal + parseFloat(totalActvalue));
			  
			 });	
	        
	        
			$("#txtTotalAmount").val(parseFloat(subtot).toFixed(parseInt(maxAmountDecimalPlaceLimit)));  
			$("#txtTotalActualAmount").val(parseFloat(actTotal).toFixed(parseInt(maxAmountDecimalPlaceLimit))); 
			
	    }	
		
		/**
		 * Ready function 
		 * Attached document Link
		 * Text Field on blur event
		 */
		$(function()
		{
			$('a#baseUrl').click(function() 
			{
				if($("#txtStkPostCode").val().trim()=="")
				{
					alert("Please Select Stock Posting Code");
					return false;
				}

				 window.open('attachDoc.html?transName=frmPhysicalStkPosting.jsp&formName=Physical Stock Posting&code='+$('#txtStkPostCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
			});
			
			$('#txtProdCode').blur(function () {
				var code=$('#txtProdCode').val();
				if (code.trim().length > 0 && code !="?" && code !="/"){	
					   funSetProduct(code);
				   }
				});
			
			$('#txtLocCode').blur(function () {
				var code=$('#txtLocCode').val();
				if (code.trim().length > 0 && code !="?" && code !="/"){						  
					   funSetLocation(code);
				   }
				});
			
			$('#txtStkPostCode').blur(function () {
				 var code=$('#txtStkPostCode').val();	
				 if (code.trim().length > 0 && code !="?" && code !="/"){						  				  
					 funGetPhyStkPostingData(code);
				   }
				});
		});
			
		/**
		 * Apply Number Textfield validation
		 */
		function funApplyNumberValidation(){
			$(".numeric").numeric();
			$(".integer").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
			$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
			$(".positive-integer").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
		    $(".decimal-places").numeric({ decimalPlaces: maxQuantityDecimalPlaceLimit, negative: false });
		    $(".decimal-places-amt").numeric({ decimalPlaces: maxAmountDecimalPlaceLimit, negative: false });
		}
		
		/**
		 * Open Export/Import Excel 
		 **/
		function funOpenExportImport()			
		{
			var transactionformName="frmPhysicalStkPosting";
			var locCode=$('#txtLocCode').val();
			var dtPhydate=$("#txtStkPostDate").val();
			
		//	response=window.showModalDialog("frmExcelExportImport.html?formname="+transactionformName+"&strLocCode="+locCode,"","dialogHeight:500px;dialogWidth:500px;dialogLeft:550px;");
			response=window.open("frmExcelExportImport.html?formname="+transactionformName+"&strLocCode="+locCode+"&dtPhydate="+dtPhydate,"","dialogHeight:500px;dialogWidth:500px;dialogLeft:550px;");
	        
			var timer = setInterval(function ()
				    {
					if(response.closed)
						{
							if (response.returnValue != null)
							{
								if(null!=response)
						        {
									var flag= funCheckPOSSalesData();
									if(flag)
									{
										return false;
									}
									response=response.returnValue;
						        	var count=0;
						        	funResetProductFields();
						        	funRemProdRows();
						        	 $("#txtLocCode").attr("readonly", true); 
						 		    $("#txtStkPostDate").attr("readonly", true) .datepicker("destroy");
						 		    $("#hidConversionUOM").val($("#cmbConversionUOM").val());
						 		    $("#cmbConversionUOM").attr("disabled", true);
						 		   $("#hidProductMasterUpdateYN").val($("#cmbProductMaster").val());
						 		    $("#cmbProductMaster").attr("disabled", true);
						        	var LooseQty=0;
							    	$.each(response, function(i,item)
									{	
							    		document.getElementById("lblStatus").innerHTML='';
							    		count=i;
							    		var dblStock="";
							    		if(response[i].strProdCode!=null)
							    			{
							    				dblStock=funGetProductStock(response[i].strProdCode);
							    			}
							    		
							    		
							    		if($('#cmbConversionUOM').val()=="RecUOM")
							    		{
							    			var ProductData=fungetConversionUOM(response[i].strProdCode);
							    			
							    			ReceivedconversionUOM=ProductData.strReceivedUOM;
						    				issuedconversionUOM=ProductData.strIssueUOM;
						    				recipeconversionUOM=ProductData.strRecipeUOM;
						    				
						    				var ConversionValue=ProductData.dblReceiveConversion;
						    				var dblQty=parseFloat(response[i].dblPStock)/parseFloat(ConversionValue);
						    				dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
						    				var tempQty=dblQty.split(".");
						    			    var Displyqty=tempQty[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempQty[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
						    			    LooseQty=parseFloat(response[i].dblPStock).toFixed(maxQuantityDecimalPlaceLimit);
					 		    			
						    			    var phyStkQty=response[i].dblPStock;
						    			    var tmpPhyStk1=response[i].dblPStock;
						    				if(ProductData.dblReceiveConversion != ProductData.dblRecipeConversion){
						    					tmpPhyStk1=parseFloat(tmpPhyStk1).toFixed(3);	
						    				}
						    				 
						    				 
						    				var tmpPhyStkQty1= tmpPhyStk1.toString().split(".");
						    				var tmpPhyStkQty2='';
						    				if(tmpPhyStkQty1.length>1){
						    					if(ProductData.dblReceiveConversion != ProductData.dblRecipeConversion){
						    						tmpPhyStkQty2=parseFloat(tmpPhyStkQty1[1]) / ProductData.dblRecipeConversion;	
						    					}else{
						    						tmpPhyStkQty2=parseFloat("0."+tmpPhyStkQty1[1]) / ProductData.dblRecipeConversion;
						    					}
						    					
						    					//tmpPhyStkQty2=tmpPhyStkQty2.toFixed(0);
						    				}
						    				if(tmpPhyStkQty2!=''){
						    				  phyStkQty=parseFloat(tmpPhyStkQty1[0])+tmpPhyStkQty2;	
						    				} 
						    				
						    			    
						    			    funFillFromExcelData(response[i].strProdCode,response[i].strProdName,response[i].dblPrice,
					 		    				response[i].dblWeight,dblStock,phyStkQty,Displyqty,LooseQty,ReceivedconversionUOM,recipeconversionUOM,ConversionValue,response[i].dblActualRate,ProductData);
							    		}
							    		if($('#cmbConversionUOM').val()=="IssueUOM")
						    			{
							    			var ProductData=fungetConversionUOM(response[i].strProdCode);

							    			ReceivedconversionUOM=ProductData.strReceivedUOM;
						    				issuedconversionUOM=ProductData.strIssueUOM;
						    				recipeconversionUOM=ProductData.strRecipeUOM;
						    				
						    				var ConversionValue=ProductData.dblIssueConversion;
						    				var dblQty=parseFloat(response[i].dblPStock)/parseFloat(ConversionValue);
						    				dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
						    				var tempQty=dblQty.split(".");
						    			    var Displyqty=tempQty[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempQty[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
						    			    LooseQty=parseFloat(response[i].dblPStock).toFixed(maxQuantityDecimalPlaceLimit);	
						    			   
						    			    funFillFromExcelData(response[i].strProdCode,response[i].strProdName,response[i].dblPrice,
							    				response[i].dblWeight,dblStock,dblQty,Displyqty,LooseQty,ReceivedconversionUOM,recipeconversionUOM,ConversionValue,response[i].dblActualRate,ProductData);
						    			}
							    		if($('#cmbConversionUOM').val()=="RecipeUOM")
						    			{
							    			var ProductData=fungetConversionUOM(response[i].strProdCode);

							    			ReceivedconversionUOM=ProductData.strReceivedUOM;
						    				issuedconversionUOM=ProductData.strIssueUOM;
						    				recipeconversionUOM=ProductData.strRecipeUOM;
						    				
						    				var ConversionValue=ProductData.dblRecipeConversion;
						    				var dblQty=parseFloat(response[i].dblPStock)/parseFloat(ConversionValue);
						    				dblQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
						    				var tempQty=dblQty.split(".");
						    			    var Displyqty=tempQty[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempQty[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
						    			    LooseQty=parseFloat(response[i].dblPStock).toFixed(maxQuantityDecimalPlaceLimit);
						    			   
						    			    funFillFromExcelData(response[i].strProdCode,response[i].strProdName,response[i].dblPrice,
							    				response[i].dblWeight,dblStock,dblQty,Displyqty,LooseQty,ReceivedconversionUOM,recipeconversionUOM,ConversionValue,response[i].dblActualRate,ProductData);
						    			}
							    		//document.getElementById("lblStatus").innerHTML='';
							    		//$("#lblStatus").text(response[i].strProdName);
								  	}); 
							    	funCalSubTotal();
							    	listRow=count+1;
							    	 
						        }
			
							}
							clearInterval(timer);
						}
				    }, 500);
			
			
			
		}
		/**
		 * Filling Grid
		 */
		function funFillFromExcelData(strProdCode,strProdName,dblCostPUnit,dblWeight,dblStock,dblQty,Displyqty,LooseQty,ReceivedconversionUOM,recipeconversionUOM,ConversionValue, dblActualRate,ProductData) 
		{	
		    var prodCode = strProdCode;
		    var prodName = strProdName;
		    var unitPrice = dblCostPUnit;
		    unitPrice=parseFloat(unitPrice).toFixed(maxAmountDecimalPlaceLimit);
		    var wtunit = dblWeight;
		    dblActualRate=parseFloat(dblActualRate).toFixed(maxAmountDecimalPlaceLimit);
		    
		    wtunit=parseFloat(wtunit).toFixed(maxAmountDecimalPlaceLimit);
		    var currentStkQty = dblStock;
		    var tempphyStkQty=parseFloat(dblQty).toFixed(maxQuantityDecimalPlaceLimit);
		    var phyStkQty = dblQty;
		    var variance=tempphyStkQty-currentStkQty;
		    LooseQty=parseFloat(LooseQty).toFixed(maxQuantityDecimalPlaceLimit);
		    		    
		    var DiscurrentStkQty=dblStock;
		    
		    
		    DiscurrentStkQty=parseFloat(DiscurrentStkQty).toFixed(maxQuantityDecimalPlaceLimit);
		    var tempStkQty=DiscurrentStkQty.split(".");
		    
		    DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tempStkQty[1])*parseFloat(ProductData.dblRecipeConversion)+" "+recipeconversionUOM;
		    if($('#cmbConversionUOM').val()=="RecUOM")
			{
		    	DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tempStkQty[1])*  ProductData.dblRecipeConversion +" "+recipeconversionUOM;
			}
		  
		    
		    var tempQty=LooseQty.toString().split(".");
		    var Displyqty=parseFloat(tempQty[0])/parseFloat(ConversionValue)+" "+ReceivedconversionUOM+" "+tempQty[1]+" "+recipeconversionUOM;
		    if(recipeconversionUOM==ReceivedconversionUOM){
		    	Displyqty=tempQty[0]+"."+tempQty[1] +ReceivedconversionUOM;
		    }
		    
// 		    var LooseQty=$("#txtQuantity").val();
// 		   
		    
		    //calculate display actual qty 
		    var DisplyActualQty=Displyqty;
		    
		    var tmpPhyStkQty2= LooseQty.toString().split(".");
		    if(recipeconversionUOM !=ReceivedconversionUOM){
		    	
		    	if($('#cmbConversionUOM').val()=="RecUOM"){
			    	if(tmpPhyStkQty2[1]!=''){
				    	DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" "+parseFloat("0."+tmpPhyStkQty2[1]) * 1000 +" "+recipeconversionUOM;
				    	 
				    }else{
				    	DisplyActualQty =tmpPhyStkQty2[0]+" "+ReceivedconversionUOM+" 0 "+recipeconversionUOM;
				    }
			    }
		    	else if($('#cmbConversionUOM').val()=="RecipeUOM"){
			    	tmpPhyStkQty2 = LooseQty;
			    	tmpPhyStkQty2= parseFloat(tmpPhyStkQty2) / ProductData.dblRecipeConversion ;
			    	var tPhyStkQty=tmpPhyStkQty2.toString().split(".");
			    	
			    	DisplyActualQty = tPhyStkQty[0]+" "+ReceivedconversionUOM+" 0 "+recipeconversionUOM;
			    	if(tPhyStkQty.length >1){
			    		DisplyActualQty = tPhyStkQty[0]+" "+ReceivedconversionUOM+"."+ parseFloat("0."+tPhyStkQty[1]) * ProductData.dblRecipeConversion +" "+recipeconversionUOM;
			    	}
			    }
		    	
		    }
		    
		    
		    
		    /* var tempCurrStkQty= currentStkQtyRecepi.split(".");
		    
		    var disQtyInRecipe=(parseFloat(tempStkQty[0]) * ProductData.dblRecipeConversion) + parseFloat(tempStkQty[1]); 
		    var CurrQtyInRecipe=(parseFloat(tempCurrStkQty[0]) * ProductData.dblRecipeConversion) + parseFloat(tempCurrStkQty[1]);
		    
		    DisplyActualQty= CurrQtyInRecipe-disQtyInRecipe;
		     */
		    
		     var tempvariance=variance.toString().split(".");
		     var DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+"."+parseFloat(tempvariance[1])*parseFloat( ProductData.dblRecipeConversion)+" "+recipeconversionUOM;
		     if(recipeconversionUOM ==ReceivedconversionUOM){
		    	 DisplayVariance=variance.toFixed(maxQuantityDecimalPlaceLimit)+" "+ReceivedconversionUOM;
		     }else{
		    
		    	 if($('#cmbConversionUOM').val()=="RecUOM")
				{
					 	var currentStkQty1=dblStock.toString().split(".");
			 		    var tmpCurrentStkQty='';
			 			if(currentStkQty1.length>1){
			 				tmpCurrentStkQty=parseFloat("0."+currentStkQty1[1]) * ProductData.dblRecipeConversion ;
			 				tmpCurrentStkQty.toFixed(3);
			 			}
			 			var stkCurr=currentStkQty1[0]+"."+tmpCurrentStkQty;
			 			var stkVar= parseFloat(LooseQty.toString()) -  parseFloat(stkCurr);
			 			DisplayVariance = stkVar.toFixed(maxQuantityDecimalPlaceLimit);
			 			var tempvariance= DisplayVariance.split(".");
					 	DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+" "+tempvariance[1] +" "+recipeconversionUOM;	 
				}
		    	else if($('#cmbConversionUOM').val()=="RecipeUOM"){
		    		 
			 		    var tmpCurrentStkQty="0";
			 		    var diff=  phyStkQty - currentStkQty;
			 			var currentStkQty1= diff.toString().split(".");   
			 		    
			 			
					DisplayVariance=currentStkQty1[0]+" "+ReceivedconversionUOM ;
			 			if(currentStkQty1.length>1){
			 				tmpCurrentStkQty=parseFloat("0."+currentStkQty1[1]) * ProductData.dblRecipeConversion ;
			 				tmpCurrentStkQty=tmpCurrentStkQty.toFixed(0);
							DisplayVariance=currentStkQty1[0]+" "+ReceivedconversionUOM+" "+tmpCurrentStkQty +" "+recipeconversionUOM;
			 			}
			 			/* var stkCurr=currentStkQty1[0]+"."+tmpCurrentStkQty;
			 			var stkVar= parseFloat($("#txtQuantity").val()) -  parseFloat(stkCurr);
			 			DisplayVariance = stkVar.toFixed(maxQuantityDecimalPlaceLimit);
			 			var tempvariance= DisplayVariance.split(".");
					 	DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+" "+tempvariance[1] +" "+recipeconversionUOM;	  */
					}
		    	 
		    	 
		    	 
		     }
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		   // phyStkQty=parseFloat(phyStkQty).toFixed(maxQuantityDecimalPlaceLimit);
		    //
		    
		    variance=parseFloat(variance).toFixed(maxQuantityDecimalPlaceLimit);
		    var adjValue = unitPrice*variance;
		    adjValue=parseFloat(adjValue).toFixed(maxQuantityDecimalPlaceLimit);
		    
		    var actualAdjValue = dblActualRate*variance;
		    actualAdjValue=parseFloat(actualAdjValue).toFixed(maxQuantityDecimalPlaceLimit);
		    
		    var adjWeight = wtunit*variance;
		    adjWeight=parseFloat(adjWeight).toFixed(maxQuantityDecimalPlaceLimit);		    
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		  
		    
// 		    var DiscurrentStkQty=dblStock;
// 		    DiscurrentStkQty=parseFloat(DiscurrentStkQty).toFixed(maxQuantityDecimalPlaceLimit);
// 		    var tempStkQty=DiscurrentStkQty.split(".");
// 		    DiscurrentStkQty=tempStkQty[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempStkQty[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
		    
// 		    var tempvariance=variance.split(".");
// 		    var DisplayVariance=tempvariance[0]+" "+ReceivedconversionUOM+"."+Math.round(parseFloat("0."+tempvariance[1])*parseFloat(ConversionValue))+" "+recipeconversionUOM;
		   
		    row.insertCell(0).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"9%\" name=\"listStkPostDtl["+(rowCount)+"].strProdCode\" id=\"txtProdCode."+(rowCount)+"\" value="+prodCode+">";
		    row.insertCell(1).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"30%\" name=\"listStkPostDtl["+(rowCount)+"].strProdName\" id=\"lblProdName."+(rowCount)+"\" value='"+prodName+"'>";
		    row.insertCell(2).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"margin-left: -72px;text-align: right;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblPrice\" id=\"txtCostRM."+(rowCount)+"\" value="+unitPrice+">";
		    row.insertCell(3).innerHTML= "<input readonly=\"readonly\" class=\"Box\"  style=\"margin-left: -66px;text-align: right;\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblWeight\" id=\"txtWtUnit."+(rowCount)+"\"  value="+wtunit+">";
		    row.insertCell(4).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left: -60px;\" size=\"12%\" id=\"txtDisplayStock."+(rowCount)+"\" value='"+DiscurrentStkQty+"'>";
		    
		    row.insertCell(5).innerHTML= "<input class=\"Box\" type=\"text\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyQty\" size=\"15%\" style=\"text-align:right;margin-left: -37px;border: 1px solid #a2a2a2; padding: 1px;width: 110%;\" id=\"txtDisplyQty."+(rowCount)+"\" value='"+DisplyActualQty+"'/>";	
		    row.insertCell(6).innerHTML= "<input class=\"decimal-places inputText-Auto\" type=\"text\" style=\"text-align: right;margin-left: -23px;border: 1px solid #a2a2a2;padding: 1px; width: 75%;\" name=\"listStkPostDtl["+(rowCount)+"].dblLooseQty\" id=\"txtLooseQty."+(rowCount)+"\"  value='"+LooseQty+"'onblur=\"funUpdatePrice(this);\" />";	
		   
		    row.insertCell(7).innerHTML= "<input readonly=\"readonly\" class=\"Box\" size=\"14%\" style=\"margin-left:-37px;\" name=\"listStkPostDtl["+(rowCount)+"].strDisplyVariance\"  id=\"txtDisplayVariance."+(rowCount)+"\" value='"+DisplayVariance+"'>";	
		    row.insertCell(8).innerHTML= "<input readonly=\"readonly\" class=\"Box\" style=\"text-align: right;margin-left:10px;\" size=\"6%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjWt\" id=\"lblAdjWeight."+(rowCount)+"\" value="+adjWeight+">";
		    row.insertCell(9).innerHTML= "<input readonly=\"readonly\" class=\"Box totalValueCell\" style=\"text-align: right;margin-left: -7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblAdjValue\" id=\"lblAdjValue."+(rowCount)+"\"  value="+adjValue+">";	
		   
		    row.insertCell(10).innerHTML= "<input readonly=\"readonly\" class=\"Box totalActualValueCell\" style=\"text-align: right;margin-left: -7px;\" size=\"9%\"  name=\"listStkPostDtl["+(rowCount)+"].dblActualValue\" id=\"lblActualAdjValue."+(rowCount)+"\"  value="+actualAdjValue+">";
		    row.insertCell(11).innerHTML= "<input type=\"button\" value = \"Delete\" class=\"deletebutton\" style=\"margin-left: 10px;\" onClick=\"Javacsript:funDeleteRow(this)\">";
		    row.insertCell(12).innerHTML= "<input type=\"hidden\"  class=\"decimal-places inputText-Auto\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblActualRate\" id=\"txtActualRate."+(rowCount)+"\" value="+dblActualRate+" >";
		    row.insertCell(13).innerHTML= "<input type=\"hidden\" required = \"required\"  class=\"decimal-places inputText-Auto\" size=\"6%\" name=\"listStkPostDtl["+(rowCount)+"].dblPStock\" id=\"txtQuantity."+(rowCount)+"\" value="+phyStkQty+" >";
		    row.insertCell(14).innerHTML= "<input type=\"hidden\" name=\"listStkPostDtl["+(rowCount)+"].dblVariance\" id=\"lblVariance."+(rowCount)+"\" value="+variance+">";	
		    row.insertCell(15).innerHTML= "<input type=\"hidden\" name=\"listStkPostDtl["+(rowCount)+"].dblCStock\" id=\"txtStock."+(rowCount)+"\" value="+currentStkQty+">";
		    funApplyNumberValidation();
		   
    	    //$("#lblStatus").text(strProdName);
		    return false;
		}
		

	    /**
		 * Get conversion Ratio form product master
		 */
		 function fungetConversionUOM(code)
			{
				var searchUrl="";
				var ProductData;
				searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
				$.ajax
				({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    async: false,
				    success: function(response)
				    {
				    	ProductData=response;
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
				return ProductData;
			}
	    
	/*     function funLatestGRNProductRate(code,dblCostRM)
	    {
	    	var searchUrl="";
			searchUrl=getContextPath()+"/loadGRNProductRate.html?prodCode="+code;
			$.ajax({
		        type: "GET",
		        url: searchUrl,
			    dataType: "json",
			    success: function(response)
			    {
			    	if('Invalid Code ' == response[0]){
			    	
			    		$("#txtActualRate").val(dblCostRM);
			    	}else{
			    		
			    		$("#txtActualRate").val(response[1]);
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
	     */
	    function funLatestGRNProductRate(code,dblCostRM)
		{
	    	 var searchUrl=getContextPath()+"/loadGRNProductRate.html?prodCode="+code;	
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    async: false,
				    success: function(response)
				    {
				    	if('Invalid Code ' == response[0]){
				    	
				    		$("#txtActualRate").val(dblCostRM);
				    	}else{
				    		
				    		$("#txtActualRate").val(response[1]);
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
	     
	    
	   //Check Month End done or not
			function funGetMonthEnd(strLocCode,transDate) {
				var strMonthEnd="";
				var searchUrl = "";
				searchUrl = getContextPath()+ "/checkMonthEnd.html?locCode=" + strLocCode+"&GRNDate="+transDate;

				$.ajax({
					type : "GET",
					url : searchUrl,
					dataType : "json",
					async: false,
					success : function(response) {
						strMonthEnd=response;
						//alert(strMonthEnd);
					},
					error : function(jqXHR, exception) {
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
				if(strMonthEnd=="1" || strMonthEnd=="-1")
					return false;
				if(strMonthEnd=="0")
					return true;
			}
	    
	    
	    
			function funGetKeyCode(event,controller) {
			    var key = event.keyCode;
			    
			    if(controller=='Qty' && key==13)
			    {
			    	btnAdd_onclick(); 
			    }
			    
			   
			}
			
	    
			 function btnRepost_onclick(){
				    
			    	// $('#tblProduct tr').each(function() {
			    		//var row
			    		
			    		var tabledata = [];
			    		var cnt=0;
			    		 $('#tblProduct tr').each(function() {
			    			 
			    		 //phyStk
				    		 var arr= [];
			    		 	 var pstockQty = $(this).find(".looseQty").val();
			    			 var productCode = $(this).find(".productCode").val();
				    		 arr[0] = pstockQty;
				    		 arr[1] = productCode;
				    		 
			    			 tabledata[cnt]= arr;
			    			 cnt++;
			    		 });
			    	
			    	     //alert(tabledata);
			    	     funRemProdRows();
			    		 var prodData=[];
			    		 for (index = 0; index < tabledata.length; index++) { 
			    			 
			    			   prodData=tabledata[index];
			    			   funSetProduct(prodData[1]);
			    			   $("#txtQuantity").val(prodData[0]);
			    			   btnAdd_onclick();
			    			   
			    			}  
			    		  
			    	$("#txtStkPostCode").val('');
			    	$("#txtAreaNarration").val('');
			    }
			    
			    function funGetLocationWiseProduct()
				{
			    	var code=$("#txtLocCode").val();
			    		
				
			    	 var searchUrl=getContextPath()+"/GetLocationWisProduct.html?locCode="+code;	
					$.ajax({
					        type: "GET",
					        url: searchUrl,
						    dataType: "json",
						    async: false,
						    success: function(response)
						    {
						    	$.each(response, function(i,item)
								{		
								    funStockZero(response[i]);		
								    
								}); 
						    	
						    	$("#txtStkPostCode").val('');
						    	$("#txtAreaNarration").val('');
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
			    
			    function funStockZero(code)
			    {
			    	funSetProduct(code);
	    			$("#txtQuantity").val("0");
	    			btnAdd_onclick();
			    }
			    
			    function funCheckPOSSales()
				{
			    	var postingDate=$("#txtStkPostDate").val();
			    	var loc=$("#txtLocCode").val();	
			       
					var searchUrl="";
					searchUrl=getContextPath()+"/CheckPOSCheck.html?postingDate="+postingDate+"&location="+loc;
					$.ajax
					({
				        type: "GET",
				        url: searchUrl,
					    dataType: "json",
					    async: false,
					    success: function(response)
					    {
					    	ProductData=response.strDocType;
					    	
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
					 return ProductData;
				
				}
			    function funCheckPOSSalesData()
			    {
			    	
			    	var flag=false;
			    	var table = document.getElementById("tblProduct");
				    var rowCount = table.rows.length;		   
				    if(!(rowCount>0))
			    	{
				    	if(checkPOSSales=="Y")
						{
							var isPOSSales=funCheckPOSSales();
							if(isPOSSales=="N")
							{
								var isCheckOk=confirm("POS Data is not posted Still Do You Want to Continue.."); 
								
								if(!isCheckOk)
								{
									 flag=true; 
								}
							}
						}
			
			    	}
			         return flag;
				
			    }
			    
			    function funResetFields()
				{
					location.reload(true); 
				}	 
	    
	</script>
	
</head>

<body onload="funOnload();">
	<div class="container">
		<label id="formHeading">Physical Stock Posting</label>
		<s:form name="stkPosting" method="POST" action="savePhyStkPosting.html?saddr=${urlHits}">	
		<s:input type="hidden" id="hidSACode" path="strSACode"></s:input>	
		<s:input type="hidden" id="hidConversionUOM" path="strConversionUOM"></s:input>
		<s:input type="hidden" id="hidProductMasterUpdateYN" path="strProductMasterUpdateYN"></s:input>
	
		<div class="row transTable">
			<div class="col-md-12">
				<a onclick="funOpenExportImport()" href="javascript:void(0);">Export/Import</a>
				<!-- <a id="baseUrl" href="#"> Attach Documents</a> -->
			</div>
			<div class="col-md-2">
				<label id="lblStkPostCode">Stock Posting Code</label>
				<s:input id="txtStkPostCode" path="strPSCode" ondblclick="funHelp('stkpostcode')" cssClass="searchTextBox" />
			</div>
			<div class="col-md-2">	
				<label id="lblStkPostDate">Stock Posting Date</label>
				<s:input id="txtStkPostDate" type="text" path="dtPSDate"
						required="required" pattern="\d{1,2}-\d{1,2}-\d{4}"
						cssClass="calenderTextBox" onchange="funCheckPOSSalesData();" style="width:80%;"/>
			</div>
			<div class="col-md-2">	
				<label>Conversion UOM</label>
				<select id="cmbConversionUOM">
					<option value="RecUOM">Recieved UOM</option>
					<option value="IssueUOM">Issue UOM</option>
					<option value="RecipeUOM">Recipe UOM</option>
				</select>
			</div>
			<div class="col-md-2">	
			 	<label id="lblNote" style="color:red;font-size:13px  ">Note:Decimal values will be consider as recipe uom(loose qty)</label>
			</div>
			
			
			<div class="col-md-4"></div>
			<div class="col-md-2">
				<label id="lblLocation">Location</label>
				<s:input id="txtLocCode" path="strLocCode" ondblclick="funHelp1('locationmaster','loc')" value="${locationCode}"
					cssClass="searchTextBox" />
			</div>
			<div class="col-md-2">	
				<s:label id="txtLocName" path="strLocName" readonly="true" style="background-color:#dcdada94; width: 100%; height: 52%; margin-top: 26px; text-align:  center;"
				>${locationName}</s:label>
			</div>
		</div>
		<div  class="row transTable">
			<div class="col-md-2">	
			 	 <label>Product Code</label>
			  	 <input id="txtProdCode" ondblclick="funHelp('RawProduct')" class="searchTextBox"></input>
			 </div>
			<div class="col-md-2">	
			 	 <label>Product Name</label>
				 <label id="lblProdName" style="background-color:#dcdada94; width: 100%; height: 52%; text-align:center;"></label>
			 </div>
			<div class="col-md-2">	
				<label>Weighted Avg Price</label>
			 	<input id="txtCostRM" readonly="readonly"  type="text" class="decimal-places-amt numberField" ></input>
			 </div>
			 <div class="col-md-2">	
				<label>Actual Rate</label>
				<input id="txtActualRate" readonly="readonly"   type="text" class="decimal-places-amt numberField" ></input>
			 </div>
			 <div class="col-md-2">	
				<label>Update Product Master Y/N</label>
				<select id="cmbProductMaster" path="strProductMasterUpdateYN">
					<option value="Yes">Yes</option>
					<option value="No">No</option>	
						
				</select>
			</div>
			
			  <div class="col-md-1"></div> <div class="col-md-1"></div>
			
			
			<div class="col-md-2">	
					<label>Stock</label>
					<input id="txtStock" readonly="readonly" type="text"></input>
			  		<span id="spStockUOM"></span> 
			 	 	<span id="spStockUOMWithConversion"></span>
			 </div>
				 <!-- <td><label>Stock</label></td>
			 	 <td><input id="txtStock" readonly="readonly" class="BoxW116px right-Align"></input></td> -->
			 <div class="col-md-2">	
			  		<label>Wt/Unit</label>
			 		<input id="txtWtUnit"  type="text"  class="decimal-places numberField" ></input>
			  </div>
			 <div class="col-md-2">	
			 		<label>Quantity</label>
					<input id="txtQuantity"  type="text"  class="numberField" onkeypress="funGetKeyCode(event,'Qty')"></input>
			  </div>
		 
			<div class="col-md-5">
			  <!-- <!-- <a href="#"><button class="btn btn-primary center-block" id="btnAdd"  value="Add" onclick="return btnAdd_onclick();">Add</button></a> -->
			  <button type="button" class="btn btn-primary center-block" id="btnAdd"  value="Add" onclick="return btnAdd_onclick();">Add</button>
			
			  <!--  <a href="#"><button class="btn btn-primary center-block" id="btnRepost"  value="Repost" onclick="return btnRepost_onclick();">Repost</button></a> --> 
			 <button type="button" class="btn btn-primary center-block" id="btnRepost"  value="Repost" onclick="return btnRepost_onclick();">Repost</button>
			
			  <!-- <a href="#"><button class="btn btn-primary center-block" id="btnMakeStockZero" value="Make Stk Zero" onclick="return funGetLocationWiseProduct();" style="width:123px;" >Make Stk Zero</button></a> -->
			  <button type="button" class="btn btn-primary center-block" id="btnMakeStockZero" value="Make Stk Zero" onclick="return funGetLocationWiseProduct();" style="width:123px;" >Make Stk Zero</button>
		      
		      <label id="lblStatus"></label>
		    </div>
		</div>
	
		<div class="dynamicTableContainer" style="height: 300px;">
			<table
				style="height: 28px; border: #0F0; width: 100%; font-size: 11px; font-weight: bold;">
				<tr bgcolor="#c0c0c0">
					<td width="2%">Prod Code</td>
					<!--  COl1   -->
					<td width="4%">Product Name</td>
					<!--  COl2   -->
					<td width="1.5%">Unit Price</td>
					<!--  COl3   -->
					<td width="1%">Wt/Unit</td>
					<!--  COl4   -->
					<td width="1.5%">Current Stock</td>
					<!--  COl5   -->
					<td width="1%">Qty</td>
					<!--  COl6   -->
					<td width="1%">Loose Qty</td>
					<!--  COl7   -->
					<td width="1%">Variance</td>
					<!--  COl8   -->
					<td width="1%">Adjusted Wt</td>
					<!--  COl9   -->
					<td width="1%">Weighted Adj. Value</td>
					<!--  COl10   -->
					<td width="1%">Actual Value</td>
					<!--  COl11   -->
					<td width="1%">Delete</td>
					<!--  COl12   -->
				</tr>
			</table>

			<div
				style="background-color: #fbfafa; border: 1px solid #ccc; display: block; height: 250px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">


				<table id="tblProduct"
					style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
					class="transTablex col11-center">
					<tbody>
					<col style="width: 8%">
					<!--  COl1   -->
					<col style="width: 30%">
					<!--  COl2   -->
					<col style="width: 5.5%">
					<!--  COl3   -->
					<col style="width: 5.5%">
					<!--  COl4   -->
					<col style="width: 8%">
					<!--  COl5   -->
					<col style="width: 8%">
					<!--  COl6   -->
					<col style="width: 8%">
					<!--  COl7   -->
					<col style="width: 7%">
					<!--  COl8   -->
					<col style="width: 8%">
					<!--  COl9   -->
					<col style="width: 8%">
					<!--  COl10   -->
					<col style="width: 8%">
					<!--  COl11   -->
					<col style="width: 5%">
					<!--  COl12   -->
					<col style="width:1%;display:none">
					<!--  COl13   -->
					<col style="width:1%;display:none">
					<!--  COl14   -->
					<col style="width:1%;display:none">
					<!--  COl15  -->

					<c:forEach items="${command.listStkPostDtl}" var="stkPost"
						varStatus="status">
						<tr>
							<td><input readonly="readonly" class="Box" size="10%"
								name="listStkPostDtl[${status.index}].strProdCode"
								value="${stkPost.strProdCode}" /></td>
							<td><input readonly="readonly" class="Box" size="100%"
								name="listStkPostDtl[${status.index}].strProdName"
								value="${stkPost.strProdName}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblPrice"
								value="${stkPost.dblPrice}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblWeight"
								value="${stkPost.dblWeight}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblCStock"
								value="${stkPost.dblCStock}" /></td>
							<td><input type="text" required="required"
								class="decimal-places inputText-Auto" size="6%"
								name="listStkPostDtl[${status.index}].dblPStock"
								value="${stkPost.dblPStock}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblVariance"
								value="${stkPost.dblVariance}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblAdjValue"
								value="${stkPost.dblAdjWt}" /></td>
							<td><input readonly="readonly" class="Box"
								style="text-align: right;" size="6%"
								name="listStkPostDtl[${status.index}].dblAdjWt"
								value="${stkPost.dblAdjValue}" /></td>
							<td><input type="button" value="Delete" class="deletebutton"
								onClick="Javacsript:funDeleteRow(this)"></td>

						</tr>
					</c:forEach>

					</tbody>

				</table>
			</div>
		</div>

		<div class="row transTable">
			<div class="col-md-2">
				<label>Total Amount</label>
				<s:input id="txtTotalAmount" type="text" value="" path="dblTotalAmt" readonly="true" class="numberField" />
			</div>	
			<div class="col-md-2">
				<label>Total Actual Amount</label>
				<input id="txtTotalActualAmount" type="text" value="0.0" readonly="readonly" class="numberField" />
			</div>	
			<div class="col-md-2">
				<label id="lblAreaNarration">Narration:</label>
				<s:textarea id="txtAreaNarration" path="strNarration"/>
			</div>	
		</div>	
		<div class="center" style="text-align:center">
			<a href="#"><button class="btn btn-primary center-block" id="btnStkPost" tabindex="3" value="Submit">Submit</button></a> &nbsp;
			<input type="button" value="Reset" class="btn btn-primary center-block" class="form_button"  onclick="funResetFields()"/>
		</div>
		<br><br>
		
			<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
				<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
			</div>
	</s:form>
</div>
<script type="text/javascript">
	funApplyNumberValidation();
</script>
</body>
</html>
package com.sanguine.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.text.DecimalFormat;
import com.sanguine.bean.clsStockFlashBean;
import com.sanguine.model.clsPropertySetupModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.service.clsStockFlashService;
import com.sanguine.util.clsReportBean;

@Controller
public class clsItemVarianceFlashController {
	@Autowired
	private clsGlobalFunctionsService objGlobalService;
	@Autowired
	private clsStockFlashService objStkFlashService;
	@Autowired
	clsGlobalFunctions objGlobal;
	
	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	
	@Autowired
	private clsGlobalFunctions objGlobalFunctions;

	@Autowired
	clsMISController objMIS;

	@Autowired
	clsGRNController objGRN;

	@Autowired
	clsMaterialReturnController objMatReturn;

	@Autowired
	clsStkAdjustmentController objStkAdj;

	@Autowired
	clsMaterialReqController objMatReq;

	@Autowired
	clsStkTransferController objStkTransfer;

	@Autowired
	clsProductionController objProduction;

	@Autowired
	clsPurchaseReturnController objPurRet;

	@Autowired
	clsStockController objOpStk;

	@Autowired
	clsSetupMasterService objSetupMasterService;

	@RequestMapping(value = "/frmItemVariancePriceFlash", method = RequestMethod.GET)
	private ModelAndView funOpenItemVarianceReport(@ModelAttribute("command") clsReportBean objBean, BindingResult result, HttpServletRequest req) {
		return funGetModelAndView(req);
	}

	private ModelAndView funGetModelAndView(HttpServletRequest req) {
		ModelAndView objModelView = new ModelAndView("frmItemVariancePriceFlash");
		String propertyCode = req.getSession().getAttribute("propertyCode").toString();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String locationCode = req.getSession().getAttribute("locationCode").toString();
		Map<String, String> mapProperty = objGlobalService.funGetPropertyList(clientCode);
		if (mapProperty.isEmpty()) {
			mapProperty.put("", "");
		}
		objModelView.addObject("listProperty", mapProperty);
	/*	HashMap<String, String> mapLocation = objGlobalService.funGetLocationList(propertyCode, clientCode);
		if (mapLocation.isEmpty()) {
			mapLocation.put("", "");
		}
*/

		HashMap<String, String> mapLocation = (HashMap<String, String>) objGlobalService.funGetLocationList(propertyCode, clientCode);
		if (!mapLocation.isEmpty()) {
			mapLocation.put("ALL", "ALL");
			mapLocation = clsGlobalFunctions.funSortByValues(mapLocation);
			
		} else {
			mapLocation.put("", "");
		}

		objModelView.addObject("LoggedInProp", propertyCode);
		objModelView.addObject("LoggedInLoc", locationCode);

	//	mapLocation = clsGlobalFunctions.funSortByValues(mapLocation);
		objModelView.addObject("listLocation", mapLocation);
		return objModelView;
	}

	
	  @RequestMapping(value = "/itemVarianceReportExcel", method = RequestMethod.GET)
      public ModelAndView itemVarianceFlashReportExcel( @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate,@RequestParam(value = "propCode") String propCode,@RequestParam(value = "locCode") String locCode, HttpServletRequest req,@ModelAttribute("command") clsReportBean objBean) {
		String clientCode = req.getSession().getAttribute("clientCode").toString();
	
		
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);
		List listStock = new ArrayList();
	
		String[] ExcelHeader = { "Location Code", "Product Code", "product Name",  "UOM", "Cost RM", "Actual Consumption", "Actual Consumption Value","Potential Consumption Qty","Potential Consumption Value","Variance Qty","Variance Value","Variance Percentage" };
		listStock.add(ExcelHeader);
       
		String dateTime[] = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ");
		List footer = new ArrayList<>();
		
		
		String sql = " SELECT  a.strLocCode ,a.strProdCode, a.strProdName, b.strUOM, round(b.dblCostRM,2), "
				+ "    ROUND((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "	   + a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk,2) as ActualConsumption, "
				+ "		ROUND((((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) * b.dblCostRM),2) ActualConsumptionValue, "
				+ "		ROUND(ifnull(c.PotentialQty,0),2) PotentialConsumptionQty, ROUND(ifnull(c.PotentialQty * b.dblCostRM,0),2) PotentialConsumptionValue, "
				+ "		ROUND(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk),2) VarianceQty, "
				+ "		ROUND(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced  "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) *  b.dblCostRM,2) VarainceValue, "
				+ "		ROUND(IFNULL((ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) *  b.dblCostRM) / ifnull(c.PotentialQty * b.dblCostRM,0),0),2) VaraincePercentage "
				+ "		FROM tblcurrentstock a LEFT OUTER JOIN  "
				+ "		tblproductmaster b ON a.strProdCode = b.strProdCode LEFT OUTER JOIN "
				+ "		(SELECT b.strProdCode ProdCode, sum(b.dblQty) PotentialQty "
				+ "		FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tbllocationmaster e  "
				+ "		WHERE a.strSACode = b.strSACode "
				+ "		AND b.strProdCode = c.strProdCode "
				+ "		AND a.strLocCode = e.strLocCode "
				+ "		and a.strNarration LIKE '%Sales Data%' "
				+ "		AND date(a.dtSADate) BETWEEN'" + fromDate + "' and '" + toDate + "' "
				+ "		AND b.dblQty > 0 "
				+ "		AND a.strLocCode = '" + locCode + "' "
				+ "		GROUP BY b.strProdCode, c.strProdName, e.strLocName, c.dblRecipeConversion) c "
				+ "		ON a.strProdCode = c.ProdCode "
				+ "		WHERE a.strLocCode = '" + locCode + "' and a.strUserCode = 'SANGUINE' AND  "
				+ "		(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk)) <>0 " ;
					

		System.out.println(sql);
		List list = objGlobalService.funGetList(sql);

		List listStockFlashModel = new ArrayList();
		for (int cnt = 0; cnt < list.size(); cnt++) {
			Object[] arrObj = (Object[]) list.get(cnt);
			List DataList = new ArrayList<>();
			DataList.add(arrObj[0].toString());
			DataList.add(arrObj[1].toString());
			DataList.add(arrObj[2].toString());
			DataList.add(arrObj[3].toString());
			DataList.add(arrObj[4].toString());
			DataList.add(arrObj[5].toString());
			DataList.add(arrObj[6].toString());
			DataList.add(arrObj[7].toString());
			DataList.add(arrObj[8].toString());
			DataList.add(arrObj[9].toString());
			DataList.add(arrObj[10].toString());
			DataList.add(arrObj[11].toString());
		
			listStockFlashModel.add(DataList);
			
			}
	
		List blank = new ArrayList<>();
		blank.add("");
		listStockFlashModel.add(blank);

		footer.add("Created on :" +dateTime[0]);
		footer.add("AT :" +dateTime[1]);
		footer.add("By :" +propCode);
		listStockFlashModel.add(footer);
		listStock.add(listStockFlashModel);
		// return a view which will be resolved by an excel view resolver
		return new ModelAndView("excelView", "stocklist", listStock);

	}


	@RequestMapping(value = "/frmItemVarianceReport", method = RequestMethod.GET)
	private @ResponseBody List funShowItemVarianceReport(@RequestParam(value = "locCode") String locCode, @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate, @RequestParam(value = "propCode") String propCode, HttpServletRequest req, HttpServletResponse resp) {
		objGlobal = new clsGlobalFunctions();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String userCode = req.getSession().getAttribute("usercode").toString();
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);

		String startDate = req.getSession().getAttribute("startDate").toString();
		String[] sp = startDate.split(" ");
		String[] spDate = sp[0].split("/");
		startDate = spDate[2] + "-" + spDate[1] + "-" + spDate[0];
		System.out.println(startDate);
		
		//String stockableItem = "Y";
		//objGlobal.funInvokeStockFlash(startDate, locCode, fromDate, toDate, clientCode, userCode, stockableItem, req, resp);
		//String sql = "";
		String stockableItem = "Y";
		
		funStockFlash(startDate, locCode, fromDate, toDate, clientCode, userCode, stockableItem, req, resp);
		
		List listTransFlash = funItemVarianceReportFlash(locCode, fromDate, toDate, propCode);

		return listTransFlash;
	
	}
	
	private List funItemVarianceReportFlash(String locCode, String fromDate, String toDate, String propCode) {
		
		String sql = " SELECT  a.strLocCode ,a.strProdCode, a.strProdName, b.strUOM, round(b.dblCostRM,2), "
				+ "    ROUND((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "	   + a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk,2) as ActualConsumption, "
				+ "		ROUND((((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) * b.dblCostRM),2) ActualConsumptionValue, "
				+ "		ROUND(ifnull(c.PotentialQty,0),2) PotentialConsumptionQty, ROUND(ifnull(c.PotentialQty * b.dblCostRM,0),2) PotentialConsumptionValue, "
				+ "		ROUND(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk),2) VarianceQty, "
				+ "		ROUND(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced  "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) *  b.dblCostRM,2) VarainceValue, "
				+ "		ROUND(IFNULL((ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk) *  b.dblCostRM) / ifnull(c.PotentialQty * b.dblCostRM,0),0),2) VaraincePercentage "
				+ "		FROM tblcurrentstock a LEFT OUTER JOIN  "
				+ "		tblproductmaster b ON a.strProdCode = b.strProdCode LEFT OUTER JOIN "
				+ "		(SELECT b.strProdCode ProdCode, sum(b.dblQty) PotentialQty "
				+ "		FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tbllocationmaster e  "
				+ "		WHERE a.strSACode = b.strSACode "
				+ "		AND b.strProdCode = c.strProdCode "
				+ "		AND a.strLocCode = e.strLocCode "
				+ "		and a.strNarration LIKE '%Sales Data%' "
				+ "		AND date(a.dtSADate) BETWEEN'" + fromDate + "' and '" + toDate + "' "
				+ "		AND b.dblQty > 0 "
				+ "		AND a.strLocCode = '" + locCode + "' "
				+ "		GROUP BY b.strProdCode, c.strProdName, e.strLocName, c.dblRecipeConversion) c "
				+ "		ON a.strProdCode = c.ProdCode "
				+ "		WHERE a.strLocCode = '" + locCode + "' and a.strUserCode = 'SANGUINE' AND  "
				+ "		(ifnull(c.PotentialQty,0) - ((a.dblOpeningStk + a.dblGRN + a.dblSCGRN + a.dblStkTransIn + a.dblMISIn + a.dblQtyProduced "
				+ "		+ a.dblSalesReturn + a.dblMaterialReturnIn) - a.dblClosingStk)) <>0 " ;
					
			List listTransWise = objGlobalService.funGetList(sql, "sql");
			
			
			return listTransWise;
		}
	
	@SuppressWarnings("deprecation")
	public void funStockFlash(String startDate, String locCode, String fromDate, String toDate, String clientCode, String userCode, String stockableItem, HttpServletRequest req, HttpServletResponse resp) {
		funDelNInsertStkTempTable(clientCode, userCode, locCode, stockableItem);
		if (!startDate.equals(fromDate)) {
			String tempFromDate = fromDate.split("-")[2] + "-" + fromDate.split("-")[1] + "-" + fromDate.split("-")[0];
			SimpleDateFormat obj = new SimpleDateFormat("dd-MM-yyyy");
			Date dt1;

			try {
				dt1 = obj.parse(tempFromDate);
				GregorianCalendar cal = new GregorianCalendar();
				cal.setTime(dt1);
				cal.add(Calendar.DATE, -1);
				String newToDate = (cal.getTime().getYear() + 1900) + "-" + (cal.getTime().getMonth() + 1) + "-" + (cal.getTime().getDate());

				objGlobalFunctions.funProcessStock(locCode, startDate, newToDate, clientCode, userCode, req, resp);

				String sql = "Update tblcurrentstock set dblOpeningStk=dblClosingStk, dblGRN=0, dblSCGRN=0" + ", dblStkTransIn=0, dblStkAdjIn=0, dblMISIn=0, dblMaterialReturnIn=0, dblQtyProduced=0" + ", dblStkTransOut=0, dblStkAdjOut=0, dblMISOut=0, dblQtyConsumed=0, dblSales=0" + ", dblMaterialReturnOut=0, dblDeliveryNote=0, dblPurchaseReturn=0 " + " where strUserCode='" + userCode
						+ "' and strClientCode='" + clientCode + "' ";
				objGlobalFunctionsService.funUpdate(sql, "sql");
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		objGlobalFunctions.funProcessStock(locCode, fromDate, toDate, clientCode, userCode, req, resp);
	}

	public void funDelNInsertStkTempTable(String clientCode, String userCode, String locCode, String stockableItem) {
		objGlobalFunctionsService.funDeleteCurrentStock(clientCode, userCode);

		String sql = "insert into tblcurrentstock (strProdCode,strProdName,strLocCode,strClientCode,strUserCode) " + " select a.strProdCode,a.strProdName,'" + locCode + "','" + clientCode + "','" + userCode + "' from tblproductmaster a ";
		if (stockableItem.equals("N")) {
			sql += " and a.strNonStockableItem='Y' ";
		}
		;

		objGlobalFunctionsService.funExcuteQuery(sql);

	}

}


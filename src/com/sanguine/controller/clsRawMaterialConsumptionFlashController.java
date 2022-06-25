package com.sanguine.controller;

import java.math.BigDecimal;
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
import com.sanguine.model.clsUserMasterModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.service.clsStockFlashService;
import com.sanguine.service.clsUserMasterService;
import com.sanguine.util.clsReportBean;

@Controller
public class clsRawMaterialConsumptionFlashController {
	@Autowired
	private clsGlobalFunctionsService objGlobalService;
	@Autowired
	private clsStockFlashService objStkFlashService;
	@Autowired
	clsGlobalFunctions objGlobal;

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
	
	@Autowired
	private clsUserMasterService objUserMasterService;


	
	@RequestMapping(value = "/frmRawMaterialConsumptionFlash", method = RequestMethod.GET)
	private ModelAndView funOpenRawMaterialConsumptionFlash(@ModelAttribute("command") clsStockFlashBean objPropBean, BindingResult result, HttpServletRequest req) {
		return funGetModelAndView(req);
	}

	private ModelAndView funGetModelAndView(HttpServletRequest req) {
		ModelAndView objModelView = new ModelAndView("frmRawMaterialConsumptionFlash");
		String propertyCode = req.getSession().getAttribute("propertyCode").toString();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String locationCode = req.getSession().getAttribute("locationCode").toString();
		Map<String, String> mapProperty = objGlobalService.funGetPropertyList(clientCode);
		if (mapProperty.isEmpty()) {
			mapProperty.put("", "");
		}
		objModelView.addObject("listProperty", mapProperty);
	 
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
	
	@RequestMapping(value = "/frmRMCReport", method = RequestMethod.GET)
	private @ResponseBody List funShowfrmTransReportFlash(@RequestParam(value = "locCode") String locCode, @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate, @RequestParam(value = "prodCode") String prodCode, HttpServletRequest req, HttpServletResponse resp) {
		objGlobal = new clsGlobalFunctions();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);

		String startDate = req.getSession().getAttribute("startDate").toString();
		String[] sp = startDate.split(" ");
		String[] spDate = sp[0].split("/");
		startDate = spDate[2] + "-" + spDate[1] + "-" + spDate[0];
		System.out.println(startDate);
		
	
		List listTransFlah = funRMCReportFlashQuery(locCode, fromDate, toDate, prodCode);

		return listTransFlah;
		
	}
	
	@RequestMapping(value = "/frmRMCReportDetail", method = RequestMethod.GET)
	private @ResponseBody List funShowfrmTransReportFlashDetail(@RequestParam(value = "locCode") String locCode, @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate, @RequestParam(value = "prodCode") String prodCode, HttpServletRequest req, HttpServletResponse resp) {
		objGlobal = new clsGlobalFunctions();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);

		String startDate = req.getSession().getAttribute("startDate").toString();
		String[] sp = startDate.split(" ");
		String[] spDate = sp[0].split("/");
		startDate = spDate[2] + "-" + spDate[1] + "-" + spDate[0];
		System.out.println(startDate);
		
	
		List listTransFlah = funRMCReportFlashQueryDetail(locCode, fromDate, toDate, prodCode);

		return listTransFlah;
		
	}
	
	
	
	  @RequestMapping(value = "/rawMaterialConsumptionSummaryReport", method = RequestMethod.GET)
      public ModelAndView rawMaterialConsumptionSummaryReport( @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate,@RequestParam(value = "prodCode") String prodCode,@RequestParam(value = "locCode") String locCode, HttpServletRequest req,@ModelAttribute("command") clsStockFlashBean objPropBean)  
	  {
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		//String prodCode = req.getSession().getAttribute("prodCode").toString();
		//String locCode = req.getSession().getAttribute("locCode").toString();
		
		
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);
		List listStock = new ArrayList();
		
		String[] ExcelHeader = { "Raw Material Code", "Raw Material Name", "Location Name", "Raw Material Qty","Finished Product Code","Finished Product Name","Finished Product Qty","Recipe Conversion" };
		listStock.add(ExcelHeader);
       
		String dateTime[] = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ");
		List footer = new ArrayList<>();
		
		String sql = " SELECT b.strProdCode, c.strProdName RawProdName, e.strLocName, concat(round(sum(b.dblQty) * c.dblRecipeConversion),' ', "
				+ " c.strRecipeUOM) QtyConsumed, b.strWSLinkedProdCode, d.strProdName FinishedProdName, sum(b.dblParentQty) ParentQty, c.dblRecipeConversion " 
				+ " FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tblproductmaster d, tbllocationmaster e " 
				+ " WHERE a.strSACode = b.strSACode "
				+ " AND b.strProdCode = c.strProdCode "
				+ " AND b.strWSLinkedProdCode = d.strProdCode "
				+ " AND a.strLocCode = e.strLocCode "  ;
		
		sql += "";
				if(!locCode.equalsIgnoreCase("All")){
					sql += " and  a.strLocCode='" + locCode + "' ";
				}

				if (!prodCode.equalsIgnoreCase("All")) {
					sql += " and b.strProdCode='" + prodCode + "' ";
				}
		
		sql += " and a.strNarration LIKE '%Sales Data%' "
				+ " AND date(a.dtSADate) BETWEEN '" + fromDate + "' AND '" + toDate + "' "
				+ " AND b.dblQty > 0 "
				+ " GROUP BY b.strProdCode, c.strProdName, e.strLocName, b.strWSLinkedProdCode, "
				+ " d.strProdName, c.dblRecipeConversion "
				+ " ORDER BY c.strProdName, a.dtSADate";

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
		
			listStockFlashModel.add(DataList);
			
			}
	
		List blank = new ArrayList<>();
		blank.add("");
		listStockFlashModel.add(blank);

		footer.add("Created on :" +dateTime[0]);
		footer.add("AT :" +dateTime[1]);
	//	footer.add("By :" +prodCode);
		listStockFlashModel.add(footer);
		listStock.add(listStockFlashModel);
		// return a view which will be resolved by an excel view resolver
		return new ModelAndView("excelView", "stocklist", listStock);

	}
	
	  
	  @RequestMapping(value = "/rawMaterialConsumptionDetailReport", method = RequestMethod.GET)
      public ModelAndView rawMaterialConsumptionDetailReport( @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate,@RequestParam(value = "prodCode") String prodCode,@RequestParam(value = "locCode") String locCode, HttpServletRequest req,@ModelAttribute("command") clsStockFlashBean objPropBean) {
		String clientCode = req.getSession().getAttribute("clientCode").toString();
	//	String prodCode =  objPropBean.getStrProdCode();
	//	String locCode =  objPropBean.getStrLocationCode();
		
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);
		List listStock = new ArrayList();
		
		String[] ExcelHeader = { "Raw Material Code", "Raw Material Name", "Location Name",  "SACode", "SADate", "Qty", "Display Qty","Raw Material Qty","Finished Product Code","Finished Product Name","Finished Product Qty","Recipe Conversion" };
		listStock.add(ExcelHeader);
       
		String dateTime[] = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ");
		List footer = new ArrayList<>();
		
		
		String sql =" SELECT b.strProdCode, c.strProdName RawProdName, e.strLocName, a.strSACode, DATE_FORMAT(a.dtSADate,'%d-%m-%y'), b.dblQty, b.strDisplayQty, "
			    + " b.strWSLinkedProdCode, d.strProdName FinishedProdName, b.dblParentQty, c.dblRecipeConversion  "
			    + " FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tblproductmaster d, tbllocationmaster e "
				+ " WHERE a.strSACode = b.strSACode "
				+ " AND b.strProdCode = c.strProdCode "
				+ " AND b.strWSLinkedProdCode = d.strProdCode "
				+ " AND a.strLocCode = e.strLocCode ";
				

			sql += "";
					if(!locCode.equalsIgnoreCase("All")){
						sql += " and  a.strLocCode='" + locCode + "' ";
					}

					if (!prodCode.equalsIgnoreCase("All")) {
						sql += " and b.strProdCode='" + prodCode + "' ";
					}
			
			sql += " and a.strNarration LIKE '%Sales Data%' "
				+ " AND date(a.dtSADate) BETWEEN '" + fromDate + "' AND '" + toDate + "' "
				+ " AND b.dblQty > 0 "
				+ " ORDER BY c.strProdName, a.dtSADate ";


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
		
			listStockFlashModel.add(DataList);
			
			}
	
		List blank = new ArrayList<>();
		blank.add("");
		listStockFlashModel.add(blank);

		footer.add("Created on :" +dateTime[0]);
		footer.add("AT :" +dateTime[1]);
		footer.add("By :" +prodCode);
		listStockFlashModel.add(footer);
		listStock.add(listStockFlashModel);
		// return a view which will be resolved by an excel view resolver
		return new ModelAndView("excelView", "stocklist", listStock);

	}


	private List funRMCReportFlashQuery(String locCode, String fromDate, String toDate, String prodCode) {
		
		String sql = " SELECT b.strProdCode, c.strProdName RawProdName, e.strLocName, concat(round(sum(b.dblQty) * c.dblRecipeConversion),' ', "
				+ " c.strRecipeUOM) QtyConsumed, b.strWSLinkedProdCode, d.strProdName FinishedProdName, sum(b.dblParentQty) ParentQty, c.dblRecipeConversion " 
				+ " FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tblproductmaster d, tbllocationmaster e " 
				+ " WHERE a.strSACode = b.strSACode "
				+ " AND b.strProdCode = c.strProdCode "
				+ " AND b.strWSLinkedProdCode = d.strProdCode "
				+ " AND a.strLocCode = e.strLocCode "  ;
		
		sql += "";
				if(!locCode.equalsIgnoreCase("All")){
					sql += " and  a.strLocCode='" + locCode + "' ";
				}

				if (!prodCode.equalsIgnoreCase("All")) {
					sql += " and b.strProdCode='" + prodCode + "' ";
				}
		
		sql += " and a.strNarration LIKE '%Sales Data%' "
				+ " AND date(a.dtSADate) BETWEEN '" + fromDate + "' AND '" + toDate + "' "
				+ " AND b.dblQty > 0 "
				+ " GROUP BY b.strProdCode, c.strProdName, e.strLocName, b.strWSLinkedProdCode, "
				+ " d.strProdName, c.dblRecipeConversion "
				+ " ORDER BY c.strProdName, a.dtSADate";

				
		List listTransWise = objGlobalService.funGetList(sql, "sql");
		
		
		return listTransWise;
	}
	
	private List funRMCReportFlashQueryDetail(String locCode, String fromDate, String toDate, String prodCode) {
		
	String sql =" SELECT b.strProdCode, c.strProdName RawProdName, e.strLocName, a.strSACode, DATE_FORMAT(a.dtSADate,'%d-%m-%y'), b.dblQty, b.strDisplayQty, "
		    + " b.strWSLinkedProdCode, d.strProdName FinishedProdName, b.dblParentQty, c.dblRecipeConversion  "
		    + " FROM tblstockadjustmenthd a, tblstockadjustmentdtl b, tblproductmaster c, tblproductmaster d, tbllocationmaster e "
			+ " WHERE a.strSACode = b.strSACode "
			+ " AND b.strProdCode = c.strProdCode "
			+ " AND b.strWSLinkedProdCode = d.strProdCode "
			+ " AND a.strLocCode = e.strLocCode ";
			

		sql += "";
				if(!locCode.equalsIgnoreCase("All")){
					sql += " and  a.strLocCode='" + locCode + "' ";
				}

				if (!prodCode.equalsIgnoreCase("All")) {
					sql += " and b.strProdCode='" + prodCode + "' ";
				}
		
		sql += " and a.strNarration LIKE '%Sales Data%' "
			+ " AND date(a.dtSADate) BETWEEN '" + fromDate + "' AND '" + toDate + "' "
			+ " AND b.dblQty > 0 "
			+ " ORDER BY c.strProdName, a.dtSADate ";

				
		List listTransWise = objGlobalService.funGetList(sql, "sql");
		
		
		return listTransWise;
	}



}
	
	

		
	
			

		
		
		
		
		
		
	
		
	
	
		
		
		

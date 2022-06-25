package com.sanguine.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sanguine.bean.clsGRNBean;
import com.sanguine.bean.clsProductBatchBean;
import com.sanguine.model.clsBatchHdModel;
import com.sanguine.model.clsBatchHdModel_ID;
import com.sanguine.model.clsGRNDtlModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsProductBatchService;
import com.sanguine.util.clsReportBean;

@Controller
public class clsProductBatchController {

	@Autowired
	private clsProductBatchService objBatchProcessService;

	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	
	@Autowired
	private clsGlobalFunctions objGlobalFunctions;

	private clsGlobalFunctions objGlobal = null;

	/**
	 * Open Batch Form
	 * 
	 * @param objBean
	 * @param request
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/frmBatchProcess", method = RequestMethod.GET)
	public ModelAndView funOpenBatchProcessForm(@ModelAttribute("setBatchAttribute") clsGRNBean objBean, HttpServletRequest request, Model model) {
		List<clsGRNDtlModel> BatchList = new ArrayList<clsGRNDtlModel>();
		if (request.getSession().getAttribute("BatchProcessList") != null) {
			BatchList = (List<clsGRNDtlModel>) request.getSession().getAttribute("BatchProcessList");
			model.addAttribute("BatchList", BatchList);
		}
		return new ModelAndView("frmBatchProcess");
	}

	/**
	 * Save Bath Form
	 * 
	 * @param objBean
	 * @param result
	 * @param request
	 * @return
	 */
	@SuppressWarnings("finally")
	@RequestMapping(value = "/saveBatchProcessing", method = RequestMethod.POST)
	public @ResponseBody String funSaveBatch(@ModelAttribute("setBatchAttribute") @Valid clsProductBatchBean objBean, BindingResult result, HttpServletRequest request) {
		objGlobal = new clsGlobalFunctions();
		String clientCode = request.getSession().getAttribute("clientCode").toString();
		String propCode = request.getSession().getAttribute("propertyCode").toString();
		String returnvalue = "";
		try {
			if (!result.hasErrors()) {
				List<clsBatchHdModel> BatchList = objBean.getListBatchDtl();
				for (int i = 0; i < BatchList.size(); i++) {
					clsBatchHdModel tempBatchModel = BatchList.get(i);
					clsBatchHdModel BatchModel = new clsBatchHdModel(new clsBatchHdModel_ID(tempBatchModel.getStrTransCode(), tempBatchModel.getStrProdCode(), clientCode,tempBatchModel.getStrBatchCode()));
					BatchModel.setStrTransCode(tempBatchModel.getStrTransCode());
					BatchModel.setStrProdCode(tempBatchModel.getStrProdCode());
					BatchModel.setStrClientCode(clientCode);
					long lastNo = objGlobalFunctionsService.funGetLastNo("tblbatchhd", "BatchCode", "intSrNo", clientCode);
					String code = tempBatchModel.getStrProdCode() + String.format("%04d", lastNo);
					BatchModel.setIntSrNo(lastNo);
					BatchModel.setStrBatchCode(code);
					BatchModel.setDblQty(tempBatchModel.getDblQty());
					BatchModel.setDblPendingQty(tempBatchModel.getDblQty());
					BatchModel.setDtExpiryDate(objGlobal.funGetDate("yyyy-MM-dd", tempBatchModel.getDtExpiryDate()));
					BatchModel.setStrManuBatchCode(tempBatchModel.getStrManuBatchCode());
					BatchModel.setStrTransType("GRN");
					BatchModel.setStrPropertyCode(propCode);
					BatchModel.setStrToLocCode("");
					BatchModel.setStrFromLocCode("");
					BatchModel.setStrTransCodeforUpdate("");
					objBatchProcessService.funSaveOrUpdateBatch(BatchModel);
					returnvalue = "Inserted";
					request.getSession().removeAttribute("BatchProcessList");
				}
			}
		} catch (Exception e) {
			returnvalue = "Inserted fail";
			e.printStackTrace();
		} finally {
			return returnvalue;
		}

	}

	/**
	 * Load Product Batch
	 * 
	 * @param strProdCode
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/loadProdBatchData", method = RequestMethod.GET)
	public @ResponseBody List<clsBatchHdModel> funGetBatchData(@RequestParam("prodCode") String strProdCode, HttpServletRequest request) {
		objGlobal = new clsGlobalFunctions();
		String clientCode = request.getSession().getAttribute("clientCode").toString();
		List<clsBatchHdModel> list = objBatchProcessService.funGetList(clientCode, strProdCode);
		return list;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/rptBatchReport", method = RequestMethod.GET)
	private ModelAndView funCallBatchReport(@RequestParam("BatchCode") String batchCode,@ModelAttribute("command") clsReportBean objBean, HttpServletResponse resp, HttpServletRequest req) {



		String FromDate=objBean.getDtFromDate();
		String ToDate=objBean.getDtToDate();
		
		
		String header = "ProdCode,TransCode,Qty,PendingQty,Document_Details,TransactionDate,LocName";

		List exportList = new ArrayList();

		exportList.add("BatchReport_" + batchCode);
		

		List titleData = new ArrayList<>();
		titleData.add("Batch Details");
		exportList.add(titleData);

		
		String dateTime[] = objGlobalFunctions.funGetCurrentDateTime("dd-MM-yyyy").split(" ");
		List filterData = new ArrayList<>();
		filterData.add("From Date");
		filterData.add(dateTime[0]);
		filterData.add("To Date");
		filterData.add(dateTime[0]);
		exportList.add(filterData);
		
		String[] excelHeader = header.split(",");
		exportList.add(excelHeader);
		StringBuilder sqlBuilderDtl = new StringBuilder();
		sqlBuilderDtl.setLength(0);
		sqlBuilderDtl.append (" select a.strProdCode, a.strTransCode, a.dblQty, a.dblPendingQty,"
						+    "	IFNULL(CONCAT(d.strPName,b.strBillNo),c.strNarration),IFNULL(b.dtGRNDate,c.dtSADate) Transaction_Date,"
						+    "	IFNULL(e.strLocName,f.strLocName) from tblbatchhd a LEFT OUTER JOIN tblGRNHd b ON a.strTransCode = b.strGRNCode " 
						+	 "	LEFT OUTER JOIN tblpartymaster d on b.strSuppCode = d.strPCode LEFT OUTER JOIN tbllocationmaster e on b.strLocCode = e.strLocCode "
						+	 "	LEFT OUTER JOIN tblstockadjustmenthd c ON a.strTransCode = c.strSACode LEFT OUTER JOIN tbllocationmaster f on c.strLocCode = f.strLocCode "
						+	 "	where a.strBatchCode = '" + batchCode + "' and a.strTransType IN ('GRN','SAO') order by Transaction_Date");

		
		
		List list = objGlobalFunctionsService.funGetList(sqlBuilderDtl.toString(), "sql");
		List Batchlist = new ArrayList();
		
		for (int i = 0; i < list.size(); i++) {
			Object[] ob = (Object[]) list.get(i);

			List dataList = new ArrayList<>();
			dataList.add(ob[0].toString());
			dataList.add(ob[1].toString());
			dataList.add(ob[2].toString());
			dataList.add(ob[3].toString());
			dataList.add(ob[4].toString());
			dataList.add(ob[5].toString());
			dataList.add(ob[6].toString());

		    Batchlist.add(dataList);
		}
		

	    for (int j = 0; j < 4; j++) {

			if (j == 3) {
				String dateTime1[] = objGlobalFunctions.funGetCurrentDateTime("dd-MM-yyyy").split(" ");
				List footer = new ArrayList<>();

				footer.add("Created on :" +dateTime1[0]);
				//footer.add(dateTime[0]);
				footer.add("AT :" +dateTime1[1]);
				//footer.add(dateTime[1]);
				Batchlist.add(footer);

			} else {
				List blank = new ArrayList<>();
				blank.add("");
				Batchlist.add(blank);
			}

		} 
		exportList.add(Batchlist);

		return new ModelAndView("excelViewFromDateTodateWithReportName", "listFromDateTodateWithReportName", exportList);

	}

	
	
	
	

}

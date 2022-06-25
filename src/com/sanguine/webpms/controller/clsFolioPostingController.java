package com.sanguine.webpms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sanguine.controller.clsGlobalFunctions;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.webpms.bean.clsFolioDtlBean;
import com.sanguine.webpms.bean.clsIncomeHeadMasterBean;
import com.sanguine.webpms.bean.clsTaxCalculation;
import com.sanguine.webpms.bean.clsTaxProductDtl;

import com.sanguine.webpms.dao.clsWebPMSDBUtilityDao;
import com.sanguine.webpms.model.clsFolioDtlModel;

import com.sanguine.webpms.model.clsFolioHdModel;
import com.sanguine.webpms.model.clsFolioTaxDtl;
import com.sanguine.webpms.model.clsIncomeHeadMasterModel;
import com.sanguine.webpms.service.clsFolioService;

@Controller
public class clsFolioPostingController {
	@Autowired
	private clsFolioService objFolioService;

	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;

	@Autowired
	private clsGlobalFunctions objGlobal;

	@Autowired
	clsPMSUtilityFunctions objPMSUtility;
	
	
	
	@Autowired
	private clsWebPMSDBUtilityDao objWebPMSUtility;


	// Open Folio
	@RequestMapping(value = "/frmFolioPosting", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {
		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmFolioPosting_1", "command", new clsFolioDtlBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmFolioPosting", "command", new clsFolioDtlBean());
		} else {
			return null;
		}
	}

	// load folio data on form
	@RequestMapping(value = "/loadFolioData", method = RequestMethod.GET)
	public @ResponseBody clsFolioHdModel funFetchFolioData(@RequestParam("folioNo") String folioNo, HttpServletRequest req) {
		clsFolioHdModel objFolioHdModel = null;

		if (objFolioHdModel == null) {
			objFolioHdModel = new clsFolioHdModel();
			objFolioHdModel.setStrFolioNo("Invalid Code");
		}
		return objFolioHdModel;
	}

	
@RequestMapping(value = "/loadFolioEditData", method = RequestMethod.GET)
	public @ResponseBody List funLoadDataForFolioEdit(@RequestParam("folioNo") String folioNo, HttpServletRequest req)
	{
		List list =null;
		try{
		
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String 	sql = "select a.strFolioNo,a.strDocNo,a.strRevenueCode,CONCAT(IFNULL(SUBSTRING_INDEX(SUBSTRING_INDEX(a.strPerticulars,'(', -1),')',1),''),' ',a.strRemark),"
					+ "a.dblDebitAmt,a.dblQuantity,date_format(a.dteDocDate,'%d-%m-%Y') from tblfoliodtl a WHERE a.strDocNo LIKE '%IN%' and a.strRevenueType!='Discount' and a.dblDebitAmt > 0 and a.strFolioNo='"+folioNo +"' ";
			list= objGlobalFunctionsService.funGetListModuleWise(sql, "sql");
			}
		catch(Exception e)
			{
				e.printStackTrace();
			}
		return list;
	}

	
	
	// Save folio posting
/*	@RequestMapping(value = "/saveFolioPosting", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsFolioDtlBean objBean, BindingResult result, HttpServletRequest req) {
		
		/*String urlHits = "1";
		try {
			urlHits = req.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}*/

		/*if (!result.hasErrors()) {
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String userCode = req.getSession().getAttribute("usercode").toString();
			String PMSDate = objGlobal.funGetDate("yyyy-MM-dd", req.getSession().getAttribute("PMSDate").toString());

			String strTransactionType = "Folio Posting";
			
			clsFolioHdModel objFolioHdModel = objFolioService.funGetFolioList(objBean.getStrFolioNo(), clientCode, "");
			List<clsFolioDtlModel> listFolioDtlModels = objFolioHdModel.getListFolioDtlModel();
			List<clsFolioTaxDtl> listFolioTaxDtl = objFolioHdModel.getListFolioTaxDtlModel();
			List<clsIncomeHeadMasterBean> listIncomeHeadBeans = objBean.getListIncomeHeadBeans();
			clsFolioDtlModel objFolioDtlModel = new clsFolioDtlModel();
			
			String docNo="";
			// generate doc No.
			String transaDate = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ")[0];
	
			String folioNo=objFolioHdModel.getStrFolioNo();
			
			
			
			String DocNo= objBean.getStrTransactionId();
			
			
			objWebPMSUtility.funExecuteUpdate("DELETE FROM tblfoliodtl WHERE strFolioNo='"+folioNo+"' and strDocNo='"+DocNo+"' and strClientCode='"+clientCode+"'","sql");
			
			String TaxData="select strfolioNo from tblfoliotaxdtl where strfolioNo='"+folioNo+"' ";
			
			List listTaxData=objGlobalFunctionsService.funGetListModuleWise(TaxData, "sql");	
			
			if(listTaxData.size()>0)
			{
				String strFolioNo="";
				strFolioNo = listTaxData.get(0).toString();
				
				objWebPMSUtility.funExecuteUpdate("DELETE FROM tblfoliotaxdtl WHERE strFolioNo='"+folioNo+"' and strClientCode='"+clientCode+"'","sql");
				
			}
				
				for (int ih = 0; ih < listIncomeHeadBeans.size(); ih++) {
					// long
					// nextDocNo=objGlobalFunctionsService.funGetNextNo("tblfoliodtl",
					// "FolioPosting", "strDocNo", clientCode,
					// "and left(strDocNo,2)='IN'");
					// String docNo="IN"+String.format("%06d", nextDocNo);
					long doc = objPMSUtility.funGenerateFolioDocForIncomeHead("IncomeHeadFolio");
					 docNo = "IN" + String.format("%06d", doc);

					String DocDate = objBean.getDteDocDate();
					objFolioDtlModel.setDteDocDate(objBean.getDteDocDate());
					objFolioDtlModel.setStrDocNo(docNo);
					objFolioDtlModel.setStrPerticulars(listIncomeHeadBeans.get(ih).getStrIncomeHeadDesc());
					objFolioDtlModel.setDblDebitAmt(listIncomeHeadBeans.get(ih).getDblAmount());
					objFolioDtlModel.setDblCreditAmt(0.00);
					objFolioDtlModel.setDblBalanceAmt(0.00);
					objFolioDtlModel.setStrRevenueType("Income Head");
					objFolioDtlModel.setStrRevenueCode(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
					objFolioDtlModel.setDblQuantity(objBean.getDblQuantity());
					objFolioDtlModel.setStrTransactionType(strTransactionType);
					objFolioDtlModel.setStrUserEdited(userCode);
					objFolioDtlModel.setDteDateEdited(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
					objFolioDtlModel.setStrRemark(listIncomeHeadBeans.get(ih).getStrRemark());
					objFolioDtlModel.setDblDiscAmt(0.00);
					objFolioDtlModel.setDblDiscPer(0.00);
					objFolioDtlModel.setStrOldFolioNo(" ");
					listFolioDtlModels.add(objFolioDtlModel);

				clsTaxProductDtl objTaxProductDtl = new clsTaxProductDtl();
				objTaxProductDtl.setStrTaxProdCode(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
				objTaxProductDtl.setStrTaxProdName(listIncomeHeadBeans.get(ih).getStrIncomeHeadDesc());
				objTaxProductDtl.setDblTaxProdAmt(listIncomeHeadBeans.get(ih).getDblAmount());
				String sql = "select a.strDeptCode from tblincomehead a "
						+ "where a.strIncomeHeadCode = '"+objTaxProductDtl.getStrTaxProdCode()+"' AND a.strClientCode='"+clientCode+"'";
				List list = objGlobalFunctionsService.funGetDataList(sql, "sql");
				String strDeptCode =  list.get(0).toString();
				objTaxProductDtl.setStrDeptCode(strDeptCode);
				List<clsTaxProductDtl> listTaxProdDtl = new ArrayList<clsTaxProductDtl>();
				listTaxProdDtl.add(objTaxProductDtl);   
				Map<String, List<clsTaxCalculation>> hmTaxCalDtl = objPMSUtility.funCalculatePMSTax(listTaxProdDtl, "Department");//Department

				if (hmTaxCalDtl.size() > 0) {
					List<clsTaxCalculation> listTaxCal = hmTaxCalDtl.get(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
					for (clsTaxCalculation objTaxCal : listTaxCal) {
						clsFolioTaxDtl objFolioTaxDtl = new clsFolioTaxDtl();
						objFolioTaxDtl.setStrDocNo(docNo);
						objFolioTaxDtl.setStrTaxCode(objTaxCal.getStrTaxCode());
						objFolioTaxDtl.setStrTaxDesc(objTaxCal.getStrTaxDesc());
						objFolioTaxDtl.setDblTaxableAmt(objTaxCal.getDblTaxableAmt());
						objFolioTaxDtl.setDblTaxAmt(objTaxCal.getDblTaxAmt());
						listFolioTaxDtl.add(objFolioTaxDtl);
					}
				}
			}
			

			objFolioHdModel.setListFolioDtlModel(listFolioDtlModels);
			objPMSUtility.funInsertFolioDtlBackup(objFolioHdModel.getStrFolioNo());
			objFolioHdModel.setListFolioTaxDtlModel(listFolioTaxDtl);
			objFolioService.funAddUpdateFolioHd(objFolioHdModel);
			req.getSession().setAttribute("success", true);
			req.getSession().setAttribute("successMessage", "Folio No. :".concat(objFolioHdModel.getStrFolioNo())+":"+docNo);
			objWebPMSUtility.funExecuteUpdate("DELETE FROM tblfoliodtl WHERE strFolioNo='"+folioNo+"' and strDocNo='"+DocNo+"' and strClientCode='"+clientCode+"'","sql");
			req.getSession().setAttribute("AdvanceAmount", objFolioHdModel.getStrReservationNo());
			
			return new ModelAndView("redirect:/frmFolioPosting.html");
		} /*else {
			return new ModelAndView("frmFolioPosting.html");
		}
	}
}*/
//Save folio posting
	@RequestMapping(value = "/saveFolioPosting", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsFolioDtlBean objBean, BindingResult result, HttpServletRequest req) {
		
	
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String userCode = req.getSession().getAttribute("usercode").toString();
			String PMSDate = objGlobal.funGetDate("yyyy-MM-dd", req.getSession().getAttribute("PMSDate").toString());

			String strTransactionType = "Folio Posting";
			
			String DocNo= objBean.getStrTransactionId();
			
	//		String folioNo=objFolioHdModel.getStrFolioNo();
			
			
	           objWebPMSUtility.funExecuteUpdate("DELETE FROM tblfoliodtl WHERE strFolioNo='"+objBean.getStrFolioNo()+"' and strDocNo='"+DocNo+"' and strClientCode='"+clientCode+"'","sql");
				
				String TaxData="select strfolioNo from tblfoliotaxdtl where strfolioNo='"+objBean.getStrFolioNo()+"' ";
				
				List listTaxData=objGlobalFunctionsService.funGetListModuleWise(TaxData, "sql");	
				
				if(listTaxData.size()>0)
				{
					String strFolioNo="";
					strFolioNo = listTaxData.get(0).toString();
					
					objWebPMSUtility.funExecuteUpdate("DELETE FROM tblfoliotaxdtl WHERE strFolioNo='"+objBean.getStrFolioNo()+"' and strClientCode='"+clientCode+"'","sql");
					
				}
			clsFolioHdModel objFolioHdModel = objFolioService.funGetFolioList(objBean.getStrFolioNo(), clientCode, "");
			List<clsFolioDtlModel> listFolioDtlModels = objFolioHdModel.getListFolioDtlModel();
			List<clsFolioTaxDtl> listFolioTaxDtl = objFolioHdModel.getListFolioTaxDtlModel();
			List<clsIncomeHeadMasterBean> listIncomeHeadBeans = objBean.getListIncomeHeadBeans();
			clsFolioDtlModel objFolioDtlModel = new clsFolioDtlModel();
			
			String docNo="";
			// generate doc No.
			String transaDate = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ")[0];
	
			
			
			for (int ih = 0; ih < listIncomeHeadBeans.size(); ih++) {
					
					long doc = objPMSUtility.funGenerateFolioDocForIncomeHead("IncomeHeadFolio");
					 docNo = "IN" + String.format("%06d", doc);

					objFolioDtlModel.setDteDocDate(objGlobal.funGetDate("yyyy/MM/dd",objBean.getDteDocDate()));
					objFolioDtlModel.setStrDocNo(docNo);
					objFolioDtlModel.setStrPerticulars(listIncomeHeadBeans.get(ih).getStrIncomeHeadDesc());
					objFolioDtlModel.setDblDebitAmt(listIncomeHeadBeans.get(ih).getDblAmount());
					objFolioDtlModel.setDblCreditAmt(0.00);
					objFolioDtlModel.setDblBalanceAmt(0.00);
					objFolioDtlModel.setStrRevenueType("Income Head");
					objFolioDtlModel.setStrRevenueCode(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
					objFolioDtlModel.setDblQuantity(objBean.getDblQuantity());
					objFolioDtlModel.setStrTransactionType(strTransactionType);
					objFolioDtlModel.setStrUserEdited(userCode);
					objFolioDtlModel.setDteDateEdited(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
					objFolioDtlModel.setStrRemark(listIncomeHeadBeans.get(ih).getStrRemark());
					objFolioDtlModel.setDblDiscAmt(0.00);
					objFolioDtlModel.setDblDiscPer(0.00);
					objFolioDtlModel.setStrOldFolioNo(" ");
					listFolioDtlModels.add(objFolioDtlModel);

				clsTaxProductDtl objTaxProductDtl = new clsTaxProductDtl();
				objTaxProductDtl.setStrTaxProdCode(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
				objTaxProductDtl.setStrTaxProdName(listIncomeHeadBeans.get(ih).getStrIncomeHeadDesc());
				objTaxProductDtl.setDblTaxProdAmt(listIncomeHeadBeans.get(ih).getDblAmount());
				String sql = "select a.strDeptCode from tblincomehead a "
						+ "where a.strIncomeHeadCode = '"+objTaxProductDtl.getStrTaxProdCode()+"' AND a.strClientCode='"+clientCode+"'";
				List list = objGlobalFunctionsService.funGetDataList(sql, "sql");
				String strDeptCode =  list.get(0).toString();
				objTaxProductDtl.setStrDeptCode(strDeptCode);
				List<clsTaxProductDtl> listTaxProdDtl = new ArrayList<clsTaxProductDtl>();
				listTaxProdDtl.add(objTaxProductDtl);   
				Map<String, List<clsTaxCalculation>> hmTaxCalDtl = objPMSUtility.funCalculatePMSTax(listTaxProdDtl, "Department");//Department

				if (hmTaxCalDtl.size() > 0) {
					List<clsTaxCalculation> listTaxCal = hmTaxCalDtl.get(listIncomeHeadBeans.get(ih).getStrIncomeHeadCode());
					for (clsTaxCalculation objTaxCal : listTaxCal) {
						clsFolioTaxDtl objFolioTaxDtl = new clsFolioTaxDtl();
						objFolioTaxDtl.setStrDocNo(docNo);
						objFolioTaxDtl.setStrTaxCode(objTaxCal.getStrTaxCode());
						objFolioTaxDtl.setStrTaxDesc(objTaxCal.getStrTaxDesc());
						objFolioTaxDtl.setDblTaxableAmt(objTaxCal.getDblTaxableAmt());
						objFolioTaxDtl.setDblTaxAmt(objTaxCal.getDblTaxAmt());
						listFolioTaxDtl.add(objFolioTaxDtl);
					}
				}
			}
			
			
			objFolioService.funAddUpdateFolioHd(objFolioHdModel);
			objFolioHdModel.setListFolioDtlModel(listFolioDtlModels);
			objPMSUtility.funInsertFolioDtlBackup(objFolioHdModel.getStrFolioNo());
			objFolioHdModel.setListFolioTaxDtlModel(listFolioTaxDtl);
		
			
			req.getSession().setAttribute("success", true);
			req.getSession().setAttribute("successMessage", "Folio No. :".concat(objFolioHdModel.getStrFolioNo())+":"+docNo);
			
			req.getSession().setAttribute("AdvanceAmount", objFolioHdModel.getStrReservationNo());
			
			return new ModelAndView("redirect:/frmFolioPosting.html");
		} 
}


package com.sanguine.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.sanguine.bean.clsSubGroupCategoryMasterBean;
import com.sanguine.model.clsSubGroupCategoryMasterModel;
import com.sanguine.model.clsSubGroupCategoryMasterModel_ID;

import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsSubGroupCategoryMasterService;

@Controller
public class clsSubGroupMasterCategoryController {
	@Autowired
	private clsSubGroupCategoryMasterService objSubGrpMasterService1;
	
	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	private clsGlobalFunctions objGlobal;
	@Autowired
	private clsGlobalFunctions objGlobalFunctions;

	Set<String> data = new HashSet<String>();

	@RequestMapping(value = "/AutoCompletGetSubGroupName1", method = RequestMethod.POST)
	public @ResponseBody Set<String> getSGNames(@RequestParam String term, HttpServletResponse response) {
		return simulateSearchResult(term);

	}

	/*
	 * @param SGName
	 * 
	 * @return
	 */
	private Set<String> simulateSearchResult(String SGCName) {
		Set<String> result = new HashSet<String>();
		// iterate a list and filter by SubGroupName
		for (String SGNames : data) {
			if (SGNames.contains(SGCName)) {
				result.add(SGNames);
			}
		}
		return result;
	}

	@RequestMapping(value = "/frmSubGroupCategoryMaster", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {

		String sql = "select strSGCName from tblsubgroupcategorymaster";
		@SuppressWarnings("rawtypes")
		List list = objGlobalFunctionsService.funGetList(sql, "sql");
		for (int i = 0; i < list.size(); i++) {
			String LcoationName = list.get(i).toString();
			data.add(LcoationName);
		}
		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmSubGroupCategoryMaster_1", "command", new clsSubGroupCategoryMasterModel());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmSubGroupCategoryMaster", "command", new clsSubGroupCategoryMasterModel());
		} else {
			return null;
		}

	}

	// Save or Update group master function to save or update record of group
	// master into database and also validates all fields of form.
	@RequestMapping(value = "/saveSubGroupCategoryMaster", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsSubGroupCategoryMasterBean objBean, BindingResult result, HttpServletRequest req) {
		objGlobal = new clsGlobalFunctions();
		String urlHits = "1";
		try {
			urlHits = req.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		String userCode = req.getSession().getAttribute("usercode").toString();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		if (!result.hasErrors()) {
			clsSubGroupCategoryMasterModel objModel = funPrepareSubGroupModel(objBean, userCode, clientCode);
			objSubGrpMasterService1.funAddUpdate(objModel);
			req.getSession().setAttribute("success", true);
			req.getSession().setAttribute("successMessage", "Subgroup Category Code : ".concat(objModel.getStrSGCCode()));
			
		}
		
		// return new ModelAndView("frmSubGroupMaster","command", new
		// clsSubGroupMasterModel());
		return new ModelAndView("redirect:/frmSubGroupCategoryMaster.html?saddr=" + urlHits);
	}

	// Assign filed function to set data onto form for edit transaction.
	@RequestMapping(value = "/loadSubGroupCategoryMasterData", method = RequestMethod.GET)
	public @ResponseBody clsSubGroupCategoryMasterModel funAssignFields(@RequestParam("subGroupCode") String subgroupCode, HttpServletRequest request) {
		String clientCode = request.getSession().getAttribute("clientCode").toString();
		clsSubGroupCategoryMasterModel objSubGroup = objSubGrpMasterService1.funGetObject(subgroupCode, clientCode);
		if (null == objSubGroup) {
			objSubGroup = new clsSubGroupCategoryMasterModel();
			objSubGroup.setStrSGCCode("Invalid Code");
		}

		return objSubGroup;
	}
	
	

	// Returns a single group master record by passing group code as primary
	// key. Also generates next Group Code if transaction is for Save Master
	private clsSubGroupCategoryMasterModel funPrepareSubGroupModel(clsSubGroupCategoryMasterBean objBean, String userCode, String clientCode) {
		long lastNo = 0;
		clsSubGroupCategoryMasterModel subgroup;

		if (objBean.getStrSGCCode().trim().length() == 0) {
			/*lastNo = objGlobalFunctionsService.funGetLastNo("tblsubgroupmaster", "SubGroupMaster", "intSGId", clientCode);*/
			/* Use for both Banquet and WebStocks*/
			lastNo = objGlobalFunctionsService.funGetLastNoModuleWise("tblsubgroupcategorymaster", "SubGroupCategoryMaster", "intSGCId", clientCode,"1-WebStocks");
			String subGroupCode = "SGC" + String.format("%06d", lastNo);
			subgroup = new clsSubGroupCategoryMasterModel(new clsSubGroupCategoryMasterModel_ID(subGroupCode, clientCode));
			subgroup.setIntSGCId(lastNo);
			subgroup.setDtCreatedDate(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
			subgroup.setStrUserCreated(userCode);
		} else {
			clsSubGroupCategoryMasterModel objSubGroup = objSubGrpMasterService1.funGetObject(objBean.getStrSGCCode(), clientCode);
			if (null == objSubGroup) {
				lastNo = objGlobalFunctionsService.funGetLastNo("tblsubgroupcategorymaster", "SubGroupCategoryMaster", "intSGCId", clientCode);
				String subGroupCode = "SG" + String.format("%06d", lastNo);
				subgroup = new clsSubGroupCategoryMasterModel(new clsSubGroupCategoryMasterModel_ID(subGroupCode, clientCode));
				subgroup.setIntSGCId(lastNo);
				subgroup.setDtCreatedDate(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
				subgroup.setStrUserCreated(userCode);
			} else {
				subgroup = new clsSubGroupCategoryMasterModel(new clsSubGroupCategoryMasterModel_ID(objBean.getStrSGCCode(), clientCode));
			}
		}
		subgroup.setStrSGCName(objBean.getStrSGCName());
		
		subgroup.setStrSGCDesc(objBean.getStrSGCDesc());
		subgroup.setStrSGCode(objBean.getStrSGCode());
		
		subgroup.setStrUserModified(userCode);
		subgroup.setDtLastModified(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
		
		return subgroup;
	}

	@RequestMapping(value = "/checksubGroupName1", method = RequestMethod.GET)
	public @ResponseBody boolean funCheckGroupName(@RequestParam("subgroupName") String Name, HttpServletRequest req) {
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		boolean count = objGlobalFunctions.funCheckName(Name, clientCode, "frmSubGroupCategoryMaster");
		return count;

	}

	@RequestMapping(value = "/AllloadSubGroup1", method = RequestMethod.GET)
	public @ResponseBody List<clsSubGroupCategoryMasterModel> funloadSubGroup(HttpServletRequest req) {
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		List<clsSubGroupCategoryMasterModel> listSubGropModel = objSubGrpMasterService1.funGetList();
		return listSubGropModel;

	}

}

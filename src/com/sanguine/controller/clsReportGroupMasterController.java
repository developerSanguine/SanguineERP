

package com.sanguine.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sanguine.bean.clsRecipeMasterBean;
import com.sanguine.bean.clsReportGroupMasterBean;
import com.sanguine.model.clsBomDtlModel;
import com.sanguine.model.clsBomHdModel;
import com.sanguine.model.clsGroupMasterModel;
import com.sanguine.model.clsPropertyMaster;
import com.sanguine.model.clsReportGroupMasterModel;
import com.sanguine.model.clsReportGroupMaster_ID;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsReportGroupMasterService;
import com.sanguine.util.clsReportBean;


@Controller
public class clsReportGroupMasterController {
	@Autowired
	private clsReportGroupMasterService objReportGroupMasterService;

	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	
	
	private clsGlobalFunctions objGlobal = null;
	
	Set<String> data = new HashSet<String>();
	
	

	@RequestMapping(value = "/frmReportGroupMaster", method = RequestMethod.GET)
	public ModelAndView funOpenReportGroupMasterForm(Map<String, Object> model, HttpServletRequest request)

	{
		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmReportGroupMaster_1", "command", new clsReportGroupMasterBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmReportGroupMaster", "command", new clsReportGroupMasterBean());
		} else {
			return null;
		}
		
	}

	
	@RequestMapping(value = "/saveReportGroupMaster", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsReportGroupMasterBean objBean, BindingResult result, HttpServletRequest req) {
		String urlHits = "1";
		try {
			urlHits = req.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String userCode = req.getSession().getAttribute("usercode").toString();
		
		
		long lastNo = 0;
		String propertyCode="";
		String code="";
		if (!result.hasErrors()) {
		
		clsReportGroupMasterModel objHdModel = new clsReportGroupMasterModel();
		if (objBean.getStrGCode().length() == 0) {
			lastNo = objGlobalFunctionsService.funGetLastNo("tblreportinggroup", "Report Group Master", "intRGId", clientCode);
			code = "RG" + String.format("%06d", lastNo);
			
			
		} else {
			code=objBean.getStrGCode();
		}
		List<clsPropertyMaster> listProp=objBean.getListPropertyDtlModel();
		if (null != listProp && listProp.size() > 0) {
			
			for (clsPropertyMaster ob : listProp) {
				propertyCode= ob.getPropertyCode();
				objHdModel.setStrReportGroupCode(code);
				objHdModel.setStrPropertyCode(propertyCode);
				objHdModel.setStrClientCode(clientCode);
				objHdModel.setStrReportGroupName(objBean.getStrGName());
				objHdModel.setintRGId(lastNo);
				objReportGroupMasterService.funAddUpdateReportGrp(objHdModel);
				
			}
			
		}
		req.getSession().setAttribute("success", true);
		req.getSession().setAttribute("successMessage", "Report Group Code : ".concat(objHdModel.getStrReportGroupCode()));

		return new ModelAndView("redirect:/frmReportGroupMaster.html?saddr=" + urlHits);
		}
		else
		{
			return new ModelAndView("redirect:/frmReportGroupMaster.html?saddr=" + urlHits);
		}
		
	}	
	

	
	// Assign filed function to set data onto form for edit transaction.
		@RequestMapping(value = "/loadReportGroupMasterData", method = RequestMethod.GET)
		public @ResponseBody clsReportGroupMasterBean funAssignFields(@RequestParam("groupCode") String groupCode, HttpServletRequest req) {
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String sql = "select strReportGroupCode,strReportGroupName,strPropertyCode from tblreportinggroup where strReportGroupCode='"+groupCode+"'";
			clsReportGroupMasterBean objBean=new clsReportGroupMasterBean();
			List listProperty=new ArrayList<>();
			List list = objGlobalFunctionsService.funGetList(sql, "sql");
			for (int i = 0; i < list.size(); i++) {
				Object[] obj = (Object[]) list.get(i);
				objBean.setStrGCode(obj[0].toString());
				objBean.setStrGName(obj[1].toString());
				String sqlProp = "select strPropertyCode,strPropertyName from tblpropertymaster where strPropertyCode='"+obj[2].toString()+"'";
				List listProp = objGlobalFunctionsService.funGetList(sqlProp, "sql");
				for (int j = 0; j < listProp.size(); j++) {
					Object[] objProp=(Object[]) listProp.get(j);
					clsPropertyMaster objPropHd=new clsPropertyMaster();
					objPropHd.setPropertyCode(objProp[0].toString());
					objPropHd.setPropertyName(objProp[1].toString());
					listProperty.add(objPropHd);
					
				}
				
			}
			objBean.setListPropertyDtlModel(listProperty);
			
			return objBean;
		}
}



































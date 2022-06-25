package com.sanguine.controller;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindingResult;









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

import com.sanguine.bean.clsCloseOpenPOBean;
import com.sanguine.bean.clsPurchaseOrderDtlBean;
import com.sanguine.bean.clsRecipeMasterBean;
import com.sanguine.model.clsBomDtlModel;
import com.sanguine.model.clsBomHdModel;
import com.sanguine.model.clsGRNHdModel;
import com.sanguine.model.clsLocationMasterModel;
import com.sanguine.model.clsProductMasterModel;
import com.sanguine.model.clsPropertyMaster;
import com.sanguine.model.clsPurchaseOrderDtlModel;
import com.sanguine.model.clsPurchaseOrderHdModel;
import com.sanguine.model.clsPurchaseOrderHdModel_ID;
import com.sanguine.model.clsSubGroupMasterModel;
import com.sanguine.model.clsSupplierMasterModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsPurchaseOrderService;
import com.sanguine.webpms.model.clsBillDtlBackupModel;
import com.sanguine.webpms.model.clsBillDtlModel;
import com.sanguine.webpms.model.clsBillHdBackupModel;
import com.sanguine.webpms.model.clsBillHdModel;
import com.sanguine.webpms.model.clsBillTaxDtlBackupModel;
import com.sanguine.webpms.model.clsBillTaxDtlModel;


@Controller
public class clsCloseOpenPOController {
	
	@Autowired
	private clsGlobalFunctionsService objGlobalService;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private clsGlobalFunctions objGlobal;
	@Autowired
	clsPurchaseOrderService objPurchaseOrderService;

	
   @RequestMapping(value = "/frmCloseOpenPO", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) 
	{
		
		clsCloseOpenPOBean objBean=new clsCloseOpenPOBean();
		String clientCode = request.getSession().getAttribute("clientCode").toString();
		String urlHits = "1";
			try {
				urlHits = request.getParameter("saddr").toString();
			} catch (NullPointerException e) {
				urlHits = "1";
			}
			
			model.put("urlHits", urlHits);
			if ("2".equalsIgnoreCase(urlHits)) {
				return new ModelAndView("frmCloseOpenPO_1", "command",new clsCloseOpenPOBean());
			} else if ("1".equalsIgnoreCase(urlHits)) {
				return new ModelAndView("frmCloseOpenPO", "command",new clsCloseOpenPOBean());
			} else {
				return null;
			}
	}


	/**
	 * Load Pending PO data in Pending PO Grid
	 */
	@RequestMapping(value = "/LoadCloseOpenPOforGRN", method = RequestMethod.GET)
	private @ResponseBody  List<clsCloseOpenPOBean> funShowfrmCloseOpenPOReport(@RequestParam(value = "locCode") String locCode, @RequestParam(value = "fDate") String fDate, @RequestParam(value = "tDate") String tDate,  HttpServletRequest req, HttpServletResponse resp) {
		
		objGlobal = new clsGlobalFunctions();
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String propCode = req.getSession().getAttribute("propertyCode").toString();
		String fromDate = objGlobal.funGetDate("yyyy-MM-dd", fDate);
		String toDate = objGlobal.funGetDate("yyyy-MM-dd", tDate);

	    List<clsCloseOpenPOBean> listPOdtl=new ArrayList();
		


		String sql = "select strPOCode,DATE_FORMAT(dtPODate,'%d-%m-%Y'),b.strPName ,a.strAgainst, a.strSOCode, IFNULL(a.dblTotal,0), a.strUserCreated , DATE_FORMAT(a.dtDateCreated,'%d-%m-%Y'), " 
					+ "	ifnull(c.strGRNCode,''),ifnull(DATE_FORMAT(c.dtGRNDate,'%d-%m-%Y'),'')" 
					+ "	FROM tblpurchaseorderhd a LEFT OUTER JOIN tblpartymaster b ON a.strSuppCode=b.strPCode "
					+ "	LEFT OUTER JOIN tblgrnhd c ON a.strPOCode = c.strPONo "
					+ "	WHERE a.strLocCode='" + locCode + "' AND a.dtPODate >= '" + fromDate + "' AND a.dtPODate <= '" +toDate + "' AND strPOCode IN (SELECT DISTINCT a.strPOCode FROM tblpurchaseorderdtl a LEFT OUTER "
				    + "	JOIN (SELECT b.strCode AS POCode, b.strProdCode, SUM(b.dblQty) AS POQty "
					+ "	FROM tblgrnhd a INNER JOIN tblgrndtl b ON a.strGRNCode = b.strGRNCode AND b.strClientCode='" + clientCode + "'"
					+ "	WHERE (a.strAgainst = 'Purchase Order') AND a.strClientCode='" + clientCode + "' "
					+ "	GROUP BY b.strCode, b.strProdCode) b ON a.strPOCode = b.POCode AND a.strProdCode = b.strProdCode " 
					+ "	AND a.strClientCode='" + clientCode + "' WHERE a.dblOrdQty > IFNULL(b.POQty,0)) AND a.strClosePO != 'Yes' AND a.strAuthorise='Yes' " 
					+ "	AND a.strClientCode='" + clientCode + "' AND a.strPropCode='" + propCode + "'";
						
									
	     List listCloseOpenPO = objGlobalService.funGetList(sql, "sql");
	     if(null!=listCloseOpenPO){
				if(listCloseOpenPO.size()>0){
				clsCloseOpenPOBean objPOBean;	
				for(int i=0;i<listCloseOpenPO.size();i++){
					objPOBean=new clsCloseOpenPOBean();
					Object ob[]=(Object[]) listCloseOpenPO.get(i);
			  
				objPOBean.setStrPOCode(ob[0].toString());
				objPOBean.setDtPODate(ob[1].toString());
				objPOBean.setStrSuppName(ob[2].toString());
				objPOBean.setStrAgainst(ob[3].toString());
				objPOBean.setStrSOCode(ob[4].toString());
				objPOBean.setDblTotal(Double.parseDouble(ob[5].toString()));
				objPOBean.setStrUserCreated(ob[6].toString());
				objPOBean.setDtDateCreated(ob[7].toString());
				objPOBean.setStrGRNCode(ob[8].toString());	
				objPOBean.setDtGRNDate(ob[9].toString());
			
				listPOdtl.add(objPOBean);
				}
			}
	     }		
	     
	     return listPOdtl;
		}



	@RequestMapping(value = "/UpdateCloseOpenPO", method = RequestMethod.GET)
	public @ResponseBody ModelAndView funUpdateCloseOpenPO(@ModelAttribute("command") @Valid clsCloseOpenPOBean objBean,BindingResult result,HttpServletResponse resp, HttpServletRequest req) {
		String urlHits = "1";
		try {
			urlHits = req.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		
	    if (!result.hasErrors())
	    {
			
			List<clsPurchaseOrderDtlBean> listPO=objBean.getListCloseOpenPODtl();
		    String poCode="";
			for (clsPurchaseOrderDtlBean ob : listPO)
			{
				if(ob.getStrPOCodeisSelected()!=null)
				{	
				
					if(ob.getStrPOCodeisSelected().equalsIgnoreCase("Y"))
				    {
					  	
					   poCode=poCode+","+"'"+ob.getStrPOCode()+"'";
					  
					}
			    }
			}
			poCode=poCode.substring(1);
			String sqlPODetails="update tblpurchaseorderhd a set a.strclosePO = 'Yes' where a.strPOCode IN( " +poCode + " ) ";  
			                    objGlobalService.funUpdate(sqlPODetails, "sql");
			                    req.getSession().setAttribute("success", true);
            return new ModelAndView("redirect:/frmCloseOpenPO.html?saddr=" + urlHits);         
	       
	    }                    
	      else
			{
				return new ModelAndView("redirect:/frmCloseOpenPO.html?saddr=" + urlHits);
			}
			
	   }	
		
}
		
		
		
		
		
		
		
		
		
	





























		
		
	









package com.sanguine.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.JRDataset;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JRDesignDataset;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;






import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.Connection;
import com.sanguine.bean.clsGRNBean;
import com.sanguine.bean.clsParentDataForBOM;
import com.sanguine.bean.clsRecipeMasterBean;
import com.sanguine.model.clsBomDtlModel;
import com.sanguine.model.clsBomHdModel;
import com.sanguine.model.clsGRNHdModel;
import com.sanguine.model.clsLocationMasterModel;
import com.sanguine.model.clsProductMasterModel;
import com.sanguine.model.clsPropertySetupModel;
import com.sanguine.model.clsSupplierMasterModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsRecipeMasterService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.util.clsReportBean;

@Controller
public class clsReplaceProductController {
	@Autowired
	private clsRecipeMasterService objRecipeMasterService;
	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	@Autowired
	private clsSetupMasterService objSetupMasterService;
	@Autowired
	private ServletContext servletContext;
	private clsGlobalFunctions objGlobal = null;
	
	@Autowired 
	private  clsWhatIfAnalysisController objWhatIfAnalysisController;
	
	@Autowired 
	private clsReportsController objReportsController;
	
	@Autowired
	private clsGlobalFunctions objGlobalFun;
	
//	double dblAmt=0.0;
//	double dblRate=0.0;
//	double bomrate =0.0;
//	double bomAmt=0.0;
	@RequestMapping(value = "/frmReplaceProduct", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {
		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);
		List<String> listProcess = new ArrayList<>();
		listProcess.add("Select");
		listProcess.add("Production");
		model.put("processList", listProcess);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmReplaceProduct_1", "command", new clsRecipeMasterBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmReplaceProduct", "command", new clsRecipeMasterBean());
		} else {
			return null;
		}

	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loadProductReceipeData", method = RequestMethod.GET)
	public @ResponseBody clsRecipeMasterBean  funGetProductReceipes(Map<String, Object> model,
			HttpServletRequest request) {

		String clientCode = request.getSession().getAttribute("clientCode").toString();
		
		String productCode = request.getParameter("prodCode").toString(); 
		String sql="select a.strBOMCode, a.strParentCode, c.strProdName, b.dblQty, b.strUOM, b.dblYieldPer, " 
				  + " DATE_FORMAT(a.dtValidFrom, '%d-%m-%Y') Valid_From, DATE_FORMAT(a.dtValidTo, '%d-%m-%Y') Valid_Till "
				  + " from tblbommasterhd a, tblbommasterdtl b, tblproductmaster c "
				  + " where a.strBOMCode = b.strBOMCode "
				  + " and a.strParentCode = c.strProdCode "
				  + " and b.strChildCode = '"+productCode+"' and curdate() between a.dtValidFrom and a.dtValidTo order by c.strProdName ";
       List list = objGlobalFunctionsService.funGetList(sql, "sql");
       List<clsRecipeMasterBean> listProd=new ArrayList<clsRecipeMasterBean>();
       clsRecipeMasterBean objBean1=new clsRecipeMasterBean();
       if (list.size() > 0) {
    	    for(int i = 0; i < list.size(); i++)
    	    {
    	    clsRecipeMasterBean objBean=new clsRecipeMasterBean();
			Object[] obj = (Object[]) list.get(i);
			objBean.setStrBOMCode(obj[0].toString());
			objBean.setStrParentCode(obj[1].toString());
			objBean.setStrParentName(obj[2].toString());
			objBean.setDblQty(Double.parseDouble(obj[3].toString()));
			objBean.setStrUOM(obj[4].toString());
			objBean.setDblYieldPer(obj[5].toString());
			objBean.setDtValidFrom(obj[6].toString());
			objBean.setDtValidTo(obj[7].toString());
			listProd.add(objBean);
			
    	    }
    	    objBean1.setListReplaceProduct(listProd);
		}	
	   return objBean1;
	}


	@RequestMapping(value = "/saveReplaceRecipeProductInMaster", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsRecipeMasterBean objBean, BindingResult result, HttpServletRequest req) {
		String urlHits = "1";
		try {
			urlHits = req.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		
		String clientCode = req.getSession().getAttribute("clientCode").toString();
		String userCode = req.getSession().getAttribute("usercode").toString();
		List<clsRecipeMasterBean> listBomCode=objBean.getListReplaceProduct();
		String bomCode="";
		for (clsRecipeMasterBean ob : listBomCode) {
			
			if(ob.getStrRecipeSelected()!=null)
			{
				if(ob.getStrRecipeSelected().equalsIgnoreCase("Y")  || ob.getStrRecipeSelected().equalsIgnoreCase("on"))
			    {
			      bomCode= bomCode+"," +"'"+	ob.getStrBOMCode()+"'";
			    }
			}
		}
		bomCode=bomCode.substring(1);
		String[] fromDate=objBean.getDtValidFrom().split("-");
		String fDate=fromDate[2]+"-"+fromDate[1]+"-"+fromDate[0];
		
		String[] toDate=objBean.getDtValidTo().split("-");
		String tDate=toDate[2]+"-"+toDate[1]+"-"+toDate[0];
		
		
		String sql="UPDATE tblbommasterhd SET dtValidTo=DATE_SUB('"+fDate+"', INTERVAL 1 DAY)  WHERE strBOMCode IN( "+bomCode+");";
		objGlobalFunctionsService.funUpdate(sql, "sql");
		boolean flagDtlDataInserted = false; 
		for (clsRecipeMasterBean ob : listBomCode) 
		{
			if(ob.getStrRecipeSelected()!=null)
			{
				if(ob.getStrRecipeSelected().equalsIgnoreCase("Y")  || ob.getStrRecipeSelected().equalsIgnoreCase("on"))
				    {
				
				clsBomHdModel objBomHdReplace=new clsBomHdModel();
						
				clsBomHdModel objBomHd = objRecipeMasterService.funGetObject(ob.getStrBOMCode(), clientCode);
				
				objBomHdReplace=funPrepareModel(objBomHd,userCode, clientCode,fDate,tDate);	
				objRecipeMasterService.funAddUpdate(objBomHdReplace);
				List listNewBomDtl = objRecipeMasterService.funGetDtlList(ob.getStrBOMCode(), clientCode);
				String newBomCode = objBomHdReplace.getStrBOMCode();
				//objRecipeMasterService.funDeleteDtl(newBomCode, clientCode);
				
				for (int i=0;i< listNewBomDtl.size();i++)
				   {
					Object[] obNew = (Object[]) listNewBomDtl.get(i);
					clsBomDtlModel bomDtl = (clsBomDtlModel) obNew[0];
					clsBomDtlModel newBomDtl=new clsBomDtlModel();
						if(objBean.getStrChildCode().equalsIgnoreCase(bomDtl.getStrChildCode()))
						{
							newBomDtl.setStrChildCode(objBean.getStrReplaceChildCode());
						}
						
						newBomDtl.setStrBOMCode(newBomCode);
						newBomDtl.setStrClientCode(clientCode);
						newBomDtl.setStrUOM(bomDtl.getStrUOM());
						newBomDtl.setDblYieldPer(bomDtl.getDblYieldPer());
						newBomDtl.setDblQtyConversion(bomDtl.getDblQtyConversion());
						newBomDtl.setDblWeight(bomDtl.getDblWeight());
						newBomDtl.setDblQty(bomDtl.getDblQty());
						
						objRecipeMasterService.funAddUpdateDtl(newBomDtl);
				   }
				flagDtlDataInserted = true;
			}
	    }
			
		}
		if (flagDtlDataInserted == true) {
			req.getSession().setAttribute("success", true);
			req.getSession().setAttribute("successMessage", "Product Replace Successfully : ");
		}
		return new ModelAndView("redirect:/frmReplaceProduct.html?saddr=" + urlHits);
	}




	private clsBomHdModel funPrepareModel(clsBomHdModel objModel, String userCode, String clientCode,String fromDate,String toDate) {
		long lastNo = 0;
		clsBomHdModel objHdNewModel = new clsBomHdModel();
		
		lastNo = objGlobalFunctionsService.funGetLastNo("tblbommasterhd", "BOMMaster", "intId", clientCode);
		String code = "B" + String.format("%07d", lastNo);
		objHdNewModel.setStrBOMCode(code);
		objHdNewModel.setIntId(lastNo);
		objHdNewModel.setStrUserCreated(objModel.getStrUserCreated());
		objHdNewModel.setDtCreatedDate(objModel.getDtCreatedDate());
		objHdNewModel.setStrClientCode(clientCode);
	
		objHdNewModel.setStrParentCode(objModel.getStrParentCode());
		objHdNewModel.setStrProcessCode(objModel.getStrProcessCode());
		objHdNewModel.setDtValidFrom( fromDate);
		objHdNewModel.setDtValidTo( toDate);
		objHdNewModel.setStrUserModified(objModel.getStrUserModified());
		objHdNewModel.setDtLastModified(objModel.getDtLastModified());
		objHdNewModel.setStrUOM(objModel.getStrUOM());
		objHdNewModel.setDblQty(objModel.getDblQty());
		objHdNewModel.setStrMethod(objModel.getStrMethod());
		objHdNewModel.setStrBOMType(objModel.getStrBOMType());
		return objHdNewModel;
	}

	

}

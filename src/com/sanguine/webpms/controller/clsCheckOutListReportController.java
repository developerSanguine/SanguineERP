package com.sanguine.webpms.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sanguine.controller.clsGlobalFunctions;
import com.sanguine.model.clsPropertySetupModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.webpms.bean.clsCheckOutListReportBean;
import com.sanguine.webpms.bean.clsCheckOutListReportDtlBean;
import com.sanguine.webpms.bean.clsFolioPrintingBean;
import com.sanguine.webpms.service.clsFolioService;

@Controller
public class clsCheckOutListReportController {

	@Autowired
	private clsFolioService objFolioService;
	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	@Autowired
	private clsGlobalFunctions objGlobal;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private clsSetupMasterService objSetupMasterService;

	// Open Folio Printing
	@RequestMapping(value = "/frmCheckOutList", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {
		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmCheckOutList_1", "command", new clsCheckOutListReportBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmCheckOutList", "command", new clsCheckOutListReportBean());
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/rptCheckOutList", method = RequestMethod.GET)
	public void funGenerateCheckOutListReport(@RequestParam("fromDate") String fromDate, @RequestParam("toDate") String toDate, HttpServletRequest req, HttpServletResponse resp) {
		try {
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String userCode = req.getSession().getAttribute("usercode").toString();
			String propertyCode = req.getSession().getAttribute("propertyCode").toString();
			String companyName = req.getSession().getAttribute("companyName").toString();
			String webStockDB=req.getSession().getAttribute("WebStockDB").toString();
			clsPropertySetupModel objSetup = objSetupMasterService.funGetObjectPropertySetup(propertyCode, clientCode);
			if (objSetup == null) {
				objSetup = new clsPropertySetupModel();
			}
			String reportName = servletContext.getRealPath("/WEB-INF/reports/webpms/rptCheckOutList.jrxml");
			String imagePath = servletContext.getRealPath("/resources/images/company_Logo.png");

			List<clsFolioPrintingBean> dataList = new ArrayList<clsFolioPrintingBean>();
			@SuppressWarnings("rawtypes")
			String propNameSql = "select a.strPropertyName  from "+webStockDB+".tblpropertymaster a where a.strPropertyCode='" + propertyCode + "' and a.strClientCode='" + clientCode + "' ";
			List listPropName = objGlobalFunctionsService.funGetDataList(propNameSql, "sql");
			String propName = "";
			if (listPropName.size() > 0) {
				propName = listPropName.get(0).toString();
			}

			HashMap reportParams = new HashMap();

			reportParams.put("pCompanyName", companyName);
			reportParams.put("pAddress1", objSetup.getStrAdd1() + "," + objSetup.getStrAdd2() + "," + objSetup.getStrCity());
			reportParams.put("pAddress2", objSetup.getStrState() + "," + objSetup.getStrCountry() + "," + objSetup.getStrPin());
			reportParams.put("pContactDetails", "");
			reportParams.put("strImagePath", imagePath);
			reportParams.put("strUserCode", userCode);
			reportParams.put("pFromDate", objGlobal.funGetDate("dd-MM-yyyy", fromDate));
			reportParams.put("pTtoDate", objGlobal.funGetDate("dd-MM-yyyy", toDate));
			reportParams.put("propName", propName);

			// get all parameters
			/*String sqlParametersCheckOutList = " SELECT bh.strReservationNo, IFNULL(h.strBookingTypeDesc,'NA'), " + " DATE_FORMAT(ch.dteDateCreated,'%d-%m-%Y'),IFNULL(c.strCorporateDesc,'NA'), " + " IFNULL(k.strBookerName,'NA'), DATE_FORMAT(a.dteCancelDate,'%d-%m-%Y'), " + " IFNULL(f.strDescription,'NA'),IFNULL(g.strBillingInstDesc,'NA'), "
					+ " CONCAT(j.strFirstName,' ',j.strMiddleName,' ',j.strLastName),j.strGuestCode,bh.strBillNo,Sum(bd.dblDebitAmt) " + " FROM tblbillhd bh " + " LEFT OUTER JOIN tblbilldtl bd ON bh.strBillNo = bd.strBillNo AND bd.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblcheckinhd ch ON ch.strCheckInNo = bh.strCheckInNo AND ch.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblreservationhd a ON a.strReservationNo = bh.strReservationNo and a.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblreservationdtl b ON a.strReservationNo=b.strReservationNo and b.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblcorporatemaster c ON a.strCorporateCode=c.strCorporateCode and c.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblbusinesssource f ON a.strBusinessSourceCode=f.strBusinessSourceCode and f.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblbillinginstructions g ON a.strBillingInstCode=g.strBillingInstCode and g.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblbookingtype h ON a.strBookingTypeCode=h.strBookingTypeCode and h.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblreceipthd i ON ch.strCheckInNo=i.strCheckInNo And i.strAgainst='Check-In' and i.strClientCode='"
					+ clientCode
					+ "' "
					+ " LEFT OUTER JOIN tblguestmaster j ON j.strGuestCode=b.strGuestCode and j.strClientCode='"
					+ clientCode + "' " + " LEFT OUTER JOIN tblbookermaster k ON k.strBookerCode=a.strBookerCode AND k.strClientCode='" + clientCode + "' " + " WHERE DATE(bh.dteBillDate) " + "  BETWEEN '" + fromDate + "' and '" + toDate + "' " + " AND ch.strClientCode='" + clientCode + "' AND a.strPropertyCode='" + propertyCode + "' group by bh.strReservationNo ";*/

			String sqlParametersCheckOutList = "SELECT a.strCheckInNo,a.strType, DATE(a.dteArrivalDate),Date(a.dteDepartureDate),c.strRoomDesc,"
					+ "c.strRoomTypeDesc,d.strFirstName, "
					+ "d.strMiddleName,d.strLastName,Concat(d.strAddressLocal,' ',d.strCityLocal,' ',"
					+ "d.strStateLocal,' ',d.strCountryLocal,' ',d.intPinCodeLocal),e.dblGrandTotal,d.strArrivalFrom "
					+ "FROM tblcheckinhd a,tblcheckindtl b,tblroom c,tblguestmaster d,tblbillhd e "
					+ "WHERE a.strCheckInNo=b.strCheckInNo AND b.strRoomNo=c.strRoomCode "
					+ "AND b.strGuestCode=d.strGuestCode and a.strCheckInNo=e.strCheckInNo "
					+ "and Date(a.dteDepartureDate) between '"+fromDate+"' and '"+toDate+"' AND a.strClientCode='"+clientCode+"' AND b.strClientCode='"+clientCode+"' AND c.strClientCode='"+clientCode+"' AND d.strClientCode='"+clientCode+"' AND e.strClientCode='"+clientCode+"'";			
			
			List listOfCheckOut = objGlobalFunctionsService.funGetDataList(sqlParametersCheckOutList, "sql");
			ArrayList fieldList = new ArrayList();

			
			for (int i = 0; i < listOfCheckOut.size(); i++) {
				clsCheckOutListReportBean checkOutListBean = new clsCheckOutListReportBean();
				Object[] arr = (Object[]) listOfCheckOut.get(i);
				

				checkOutListBean.setStrCheckInNo(arr[0].toString());
				checkOutListBean.setStrType(arr[1].toString());
				checkOutListBean.setDteDateCreated(objGlobal.funGetDate("dd-MM-yyyy", arr[2].toString()));
				checkOutListBean.setDteDepartureDate(objGlobal.funGetDate("dd-MM-yyyy", arr[3].toString()));
				checkOutListBean.setStrRoomTypeCode(arr[4].toString());
				checkOutListBean.setStrRoomTypeDesc(arr[5].toString());
				checkOutListBean.setStrFirstName(arr[6].toString());
				checkOutListBean.setStrMiddleName(arr[7].toString());
				checkOutListBean.setStrLastName(arr[8].toString());
				checkOutListBean.setStrAddress(arr[9].toString());
				checkOutListBean.setDblReceiptAmt(Double.parseDouble(arr[10].toString()));
				checkOutListBean.setStrArrivalFrom(arr[11].toString());
				
				
				
				
				fieldList.add(checkOutListBean);
			}

			JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(fieldList);
			JasperDesign jd = JRXmlLoader.load(reportName);
			JasperReport jr = JasperCompileManager.compileReport(jd);
			JasperPrint jp = JasperFillManager.fillReport(jr, reportParams, beanCollectionDataSource);
			List<JasperPrint> jprintlist = new ArrayList<JasperPrint>();
			if (jp != null) {
				jprintlist.add(jp);
				ServletOutputStream servletOutputStream = resp.getOutputStream();
				JRExporter exporter = new JRPdfExporter();
				resp.setContentType("application/pdf");
				exporter.setParameter(JRPdfExporterParameter.JASPER_PRINT_LIST, jprintlist);
				exporter.setParameter(JRPdfExporterParameter.OUTPUT_STREAM, servletOutputStream);
				exporter.setParameter(JRPdfExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
				resp.setHeader("Content-Disposition", "inline;filename=CheckOutList.pdf");
				exporter.exportReport();
				servletOutputStream.flush();
				servletOutputStream.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

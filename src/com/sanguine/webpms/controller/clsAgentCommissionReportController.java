package com.sanguine.webpms.controller;


import java.util.ArrayList;

import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;

import com.sanguine.controller.clsGlobalFunctions;

import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.webpms.bean.clsAgentCommisionBean;
import com.sanguine.webpms.service.clsAgentMasterService;


import javax.servlet.ServletContext;



@Controller
public class clsAgentCommissionReportController {

	@Autowired
	private clsAgentMasterService objAgentMasterService;

	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;
	
	@Autowired
	private clsGlobalFunctions objGlobalFunctions;
	
	@Autowired
	private clsSetupMasterService objSetupMasterService;



	@RequestMapping(value = "/frmAgentCommissionReport", method = RequestMethod.GET)
	public ModelAndView funOpenReportForm(Map<String, Object> model,HttpServletRequest request) {

		String urlHits = "1";
		try {
			urlHits = request.getParameter("saddr").toString();
		} catch (NullPointerException e) {
			urlHits = "1";
		}
		model.put("urlHits", urlHits);

		
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmAgentCommissionReport_1", "command",
					new clsAgentCommisionBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmAgentCommissionReport", "command",
					new clsAgentCommisionBean());
		} else {
			return null;
		}
	}
	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/exportCommissionDetailsReport", method = RequestMethod.GET)
	public ModelAndView funCallCommissionDetailsReport(HttpServletResponse resp, HttpServletRequest req, clsAgentCommisionBean objBean,@RequestParam("strAgentCode") String strAgentCode,@RequestParam("fromDate") String fromDate, @RequestParam("toDate") String toDate)  {
	{
		String strClientCode = req.getSession().getAttribute("clientCode").toString();
		String userCode = req.getSession().getAttribute("usercode").toString();
	
		int serial_number=1;
		
		
		List retList = new ArrayList();
		List detailList = new ArrayList();
		List headerList = new ArrayList();
		
	//	String fromDate = req.getParameter("frmDte").toString();
		String[] arr = fromDate.split("-");
		String fromDte = arr[2] + "-" + arr[1] + "-" + arr[0];
		
	//	String toDate = req.getParameter("toDte").toString();
		String[] arr1 = toDate.split("-");
		String toDte = arr1[2] + "-" + arr1[1] + "-" + arr1[0]; 
		
	//	String agentCode=objBean.getStrAgentCode();
		

		String sql =  " SELECT a.strBillNo,DATE_FORMAT(b.dteCheckInDate,'%d-%m-%Y'),DATE_FORMAT(a.dteBillDate, '%d-%m-%Y') AS CheckOutDate,date_format(a.dteBillDate, '%d-%m-%Y'), concat(d.strFirstName,' ',d.strMiddleName,' ', d.strLastName) GuestName , "
				+     " e.strRoomDesc, a.dblGrandTotal BillAmount, c.dblAdvToReceive AgentCommPercentage,"
				+	  " cast(a.dblGrandTotal * c.dblAdvToReceive/100 as decimal(10,2)) "
				+     " FROM tblbillhd a,tblcheckinhd b, tblagentmaster c, tblguestmaster d, tblroom e "
				+	  " WHERE a.strCheckInNo = b.strCheckInNo "
				+	  " and b.strAgentCode = c.strAgentCode AND a.strGuestCode = d.strGuestCode AND a.strRoomNo = e.strRoomCode "
				+	  " AND b.strAgentCode = '"+strAgentCode+"' "
				+	  " AND a.dteBillDate BETWEEN '"+fromDte+"' AND '"+toDte+"' ";
		
		
		
		List listAgentCode=objGlobalFunctionsService.funGetListModuleWise(sql,"sql");
		if(!listAgentCode.isEmpty())
		{
			for(int i=0;i<listAgentCode.size();i++)
			{
				Object[] arr2=(Object[]) listAgentCode.get(i);
				List DataList = new ArrayList<>();
				DataList.add(serial_number);
				DataList.add(arr2[0].toString());
				DataList.add(arr2[1].toString());
				DataList.add(arr2[2].toString());
				DataList.add(arr2[3].toString());
				DataList.add(arr2[4].toString());
				DataList.add(arr2[5].toString());
				DataList.add(arr2[6].toString());
				DataList.add(arr2[7].toString());
				DataList.add(arr2[8].toString());
				
				detailList.add( DataList);
				serial_number++;
				
			}
		}
		retList.add("Agent Commission Report_" + fromDte + "to" + toDte + "_" + userCode);
		List titleData = new ArrayList<>();
		titleData.add("Agent Commission Report");
		retList.add(titleData);
			
		List filterData = new ArrayList<>();
		filterData.add("From Date");
		filterData.add(fromDate);
		filterData.add("To Date");
	    filterData.add(toDate);
	    retList.add(filterData);  
		
	    headerList.add("Sr.No");
	    headerList.add("BillNo");
	    headerList.add("CheckInDate");
	    headerList.add("CheckOutDate");
		headerList.add("BillDate");
		headerList.add("GuestName");
		headerList.add("Room Desc");
		headerList.add("Bill Amount");
		headerList.add("AgentCommissionPercentage");
		headerList.add("AgentCommission");
		
		Object[] objHeader = (Object[]) headerList.toArray();

		String[] ExcelHeader = new String[objHeader.length];
		for (int k = 0; k < objHeader.length; k++) {
			ExcelHeader[k] = objHeader[k].toString();
		}
		
		retList.add(ExcelHeader);
		retList.add(detailList);
		
	
	return new ModelAndView("excelViewFromDateTodateWithReportName", "listFromDateTodateWithReportName", retList);
	//	return new ModelAndView("excelViewFromToDteReportName", "listFromToDateReportName", retList);
		

	}
		
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/exportCommissionSummaryReport", method = RequestMethod.GET)
	public ModelAndView funCallCommissionSummaryReport(HttpServletResponse resp, HttpServletRequest req, clsAgentCommisionBean objBean,@RequestParam("fromDate") String fromDate, @RequestParam("toDate") String toDate) {
	{
		String strClientCode = req.getSession().getAttribute("clientCode").toString();
		String userCode = req.getSession().getAttribute("usercode").toString();
	
		int serial_number=1;
		
		
		List retList = new ArrayList();
		List detailList = new ArrayList();
		List headerList = new ArrayList();
		
	
		String[] arr = fromDate.split("-");
		String fromDte = arr[2] + "-" + arr[1] + "-" + arr[0];
		
	
		String[] arr1 = toDate.split("-");
		String toDte = arr1[2] + "-" + arr1[1] + "-" + arr1[0];
		

		String sql = " SELECT b.strAgentCode AgentCode, c.strDescription AgentName, c.dblAdvToReceive AgentCommPercentage,"
				+    " SUM(a.dblGrandTotal) TotalBilling,CAST((SUM(a.dblGrandTotal)* c.dblAdvToReceive/100) as decimal(10,2)) "
				+ 	 " FROM tblbillhd a,tblcheckinhd b, tblagentmaster c "
				+    " WHERE a.strCheckInNo = b.strCheckInNo "
				+	 " and b.strAgentCode = c.strAgentCode "
				+    " AND a.dteBillDate BETWEEN '"+fromDte+"' AND '"+toDte+"'"
				+    " GROUP BY b.strAgentCode, c.strDescription, c.dblAdvToReceive";
		
		
		
		List listAgentCode=objGlobalFunctionsService.funGetListModuleWise(sql,"sql");
		if(!listAgentCode.isEmpty())
		{
			for(int i=0;i<listAgentCode.size();i++)
			{
				Object[] arr2=(Object[]) listAgentCode.get(i);
				List DataList = new ArrayList<>();
				DataList.add(serial_number);
				DataList.add(arr2[0].toString());
				DataList.add(arr2[1].toString());
				DataList.add(arr2[2].toString());
				DataList.add(arr2[3].toString());
				DataList.add(arr2[4].toString());
				
				detailList.add( DataList);
				serial_number++;
				
			}
		}
		retList.add("Agetn Commission Report_" + fromDte + "to" + toDte + "_" + userCode);
		List titleData = new ArrayList<>();
		titleData.add("Agent Commission Report");
		retList.add(titleData);
			
		List filterData = new ArrayList<>();
		filterData.add("From Date");
		filterData.add(fromDate);
		filterData.add("To Date");
	    filterData.add(toDate);
	    retList.add(filterData);  
		
	    headerList.add("Sr.No");
	    headerList.add("AgentCode");
		headerList.add("AgentName");
		headerList.add("AgentCommissionPercentage");
		headerList.add("Total Billing");
		headerList.add("Agent Commission");
		
		Object[] objHeader = (Object[]) headerList.toArray();

		String[] ExcelHeader = new String[objHeader.length];
		for (int k = 0; k < objHeader.length; k++) {
			ExcelHeader[k] = objHeader[k].toString();
		}
		
		retList.add(ExcelHeader);
		retList.add(detailList);
		
	
		return new ModelAndView("excelViewFromDateTodateWithReportName", "listFromDateTodateWithReportName", retList);
	//	return new ModelAndView("excelViewFromToDteReportName", "listFromToDateReportName", retList);
	}

	}

}

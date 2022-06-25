package com.sanguine.webpms.controller;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
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

import org.apache.log4j.Logger;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;

import com.sanguine.base.service.intfBaseService;
import com.sanguine.controller.clsGlobalFunctions;
import com.sanguine.controller.clsSendEmailController;
import com.sanguine.model.clsCompanyMasterModel;
import com.sanguine.model.clsPropertyMaster;
import com.sanguine.model.clsPropertySetupModel;
import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.service.clsPropertyMasterService;
import com.sanguine.service.clsSetupMasterService;
import com.sanguine.webpms.bean.clsCheckInBean;
import com.sanguine.webpms.bean.clsCheckInDetailsBean;
import com.sanguine.webpms.bean.clsFolioHdBean;
import com.sanguine.webpms.bean.clsGuestMasterBean;
import com.sanguine.webpms.bean.clsPostRoomTerrifBean;
import com.sanguine.webpms.bean.clsReservationDetailsBean;
import com.sanguine.webpms.bean.clsTaxCalculation;
import com.sanguine.webpms.bean.clsTaxProductDtl;
import com.sanguine.webpms.dao.clsExtraBedMasterDao;
import com.sanguine.webpms.dao.clsGuestMasterDao;
import com.sanguine.webpms.dao.clsRoomTypeMasterDao;
import com.sanguine.webpms.dao.clsWalkinDao;
import com.sanguine.webpms.dao.clsWebPMSDBUtilityDao;
import com.sanguine.webpms.model.clsCheckInDtl;
import com.sanguine.webpms.model.clsCheckInHdModel;
import com.sanguine.webpms.model.clsExtraBedMasterModel;
import com.sanguine.webpms.model.clsFolioDtlModel;
import com.sanguine.webpms.model.clsFolioHdModel;
import com.sanguine.webpms.model.clsGuestMasterHdModel;
import com.sanguine.webpms.model.clsPMSGroupBookingDtlModel;
import com.sanguine.webpms.model.clsPMSGroupBookingHDModel;
import com.sanguine.webpms.model.clsPackageMasterDtl;
import com.sanguine.webpms.model.clsPackageMasterHdModel;
import com.sanguine.webpms.model.clsPropertySetupHdModel;
import com.sanguine.webpms.model.clsReservationDtlModel;
import com.sanguine.webpms.model.clsReservationHdModel;
import com.sanguine.webpms.model.clsReservationRoomRateModelDtl;
import com.sanguine.webpms.model.clsRoomMasterModel;
import com.sanguine.webpms.model.clsRoomPackageDtl;
import com.sanguine.webpms.model.clsRoomTypeMasterModel;
import com.sanguine.webpms.model.clsWalkinHdModel;
import com.sanguine.webpms.model.clsWalkinRoomRateDtlModel;
import com.sanguine.webpms.service.clsCheckInService;
import com.sanguine.webpms.service.clsFolioService;
import com.sanguine.webpms.service.clsGuestMasterService;
import com.sanguine.webpms.service.clsPMSGroupBookingService;
import com.sanguine.webpms.service.clsPropertySetupService;
import com.sanguine.webpms.service.clsReservationService;
import com.sanguine.webpms.service.clsRoomMasterService;
import com.sanguine.webpms.service.clsWalkinService;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.validation.BindingResult;

import javassist.bytecode.stackmap.BasicBlock.Catch;

import javax.validation.Valid;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.misc.BASE64Encoder;

@Controller
public class clsCheckInEditController {

	@Autowired
	private clsCheckInService objCheckInService;

	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;

	@Autowired
	private clsGlobalFunctions objGlobal;

	@Autowired
	private clsGuestMasterService objGuestMasterService;

	@Autowired
	private clsGuestMasterDao objGuestMasterDao;

	@Autowired
	private clsFolioController objFolioController;

	@Autowired
	private clsFolioService objFolioService;

	@Autowired
	private clsExtraBedMasterDao objExtraBedMasterDao;

	@Autowired
	private clsPropertySetupService objPropertySetupService;

	@Autowired
	private clsGuestMasterService objGuestService;

	@Autowired
	private clsPropertyMasterService objPropertyMasterService;

	@Autowired
	clsRoomMasterService objRoomMaster;
	
	@Autowired
	clsPMSUtilityFunctions objPMSUtility;
	
	@Autowired 
	clsReservationService objReservationService;
	
	@Autowired
	private clsWebPMSDBUtilityDao objWebPMSUtility;

	@Autowired
	private intfBaseService objBaseService;
	
	
	@Autowired
	private clsWalkinDao objWalkinDao;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private clsSetupMasterService objSetupMasterService;
	

	@Autowired
	private clsGlobalFunctionsService objGlobalFunService;
	
	@Autowired
	private clsPostRoomTerrifController objPostRoomTerrif;
	@Autowired
	private clsRoomTypeMasterDao objRoomTypeMasterDao;

	@Autowired
	private clsPMSGroupBookingService objPMSGroupBookingService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	final static Logger logger = Logger.getLogger(clsSendEmailController.class);
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    binder.setAutoGrowCollectionLimit(1000000);
	}
	// Open CheckIn
	
	
	@RequestMapping(value = "/frmCheckInEdit", method = RequestMethod.GET)
	public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {
		String urlHits = "1";
		
		if(request.getParameter("saddr")!=null)
		{
			urlHits = request.getParameter("saddr").toString();
		}		
		model.put("urlHits", urlHits);
		if ("2".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmCheckInEdit_1", "command", new clsCheckInBean());
		} else if ("1".equalsIgnoreCase(urlHits)) {
			return new ModelAndView("frmCheckInEdit", "command", new clsCheckInBean());
		} else {
			return null;
		}
	}
	
	@RequestMapping(value = "/saveCheckInEdit", method = RequestMethod.POST)
	public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsCheckInBean objBean, BindingResult result, HttpServletRequest req) {
		if (!result.hasErrors()) {
			String clientCode = req.getSession().getAttribute("clientCode").toString();
			String userCode = req.getSession().getAttribute("usercode").toString();
			String propCode = req.getSession().getAttribute("propertyCode").toString();
			String startDate = req.getSession().getAttribute("startDate").toString();
			String PMSDate = objGlobal.funGetDate("yyyy-MM-dd", req.getSession().getAttribute("PMSDate").toString());
 
			String sqlFolioNo = "select a.strFolioNo from tblfoliohd a where a.strCheckInNo='"+objBean.getStrCheckInNo()+"' and a.strClientCode='"+clientCode+"'";
			String strFolioNo="";
			List listFolioNo  = objGlobalFunctionsService.funGetListModuleWise(sqlFolioNo, "sql");	
			String strPackageInclusiveRoomTerrif="N";
			
		/*	String sqldte = "select date(max(dtePMSDate)),strStartDay  from tbldayendprocess " + " where strPropertyCode='01' and strClientCode='" + clientCode + "' " + " and strDayEnd='N' ";
			List listdate = objGlobalFunctionsService.funGetListModuleWise(sqldte, "sql");
			Object[] arrObjDayEnd = (Object[]) listdate.get(0);
			*/
			if(listFolioNo.size()>0)
			{
				strFolioNo = listFolioNo.get(0).toString();
				String sqlFolioNoDtl = "select a.strPerticulars from tblfoliodtl a where a.strFolioNo='"+strFolioNo+"'";
				List listFolioNoDtl  = objGlobalFunctionsService.funGetListModuleWise(sqlFolioNoDtl, "sql");			
 				if(listFolioNoDtl.size()>0)
				{
					
					
						clsReservationHdModel objReservationModel = objReservationService.funGetReservationList(objBean.getStrAgainstDocNo(), clientCode, propCode);
						List<clsReservationRoomRateModelDtl> listRommRate = new ArrayList<clsReservationRoomRateModelDtl>();
						if(null!=objBean.getlistReservationRoomRateDtl())
						{
						for (clsReservationRoomRateModelDtl objRommDtlBean : objBean.getlistReservationRoomRateDtl()) 
						{
							String date=objRommDtlBean.getDtDate();
							if(date.split("-")[0].toString().length()<3)
							{	
							 objRommDtlBean.setDtDate(objGlobal.funGetDate("yyyy-MM-dd",date));
							}
							listRommRate.add(objRommDtlBean);
						}
					    }
						objReservationModel.setListReservationRoomRateDtl(listRommRate);
						objReservationService.funAddUpdateReservationHd(objReservationModel, objReservationModel.getStrBookingTypeCode());	
						
					}
			
 				if(null!=objBean.getListCheckInDetailsBean()){
					for (clsCheckInDetailsBean objCheckInDtlBean :objBean.getListCheckInDetailsBean()) {
					String sql=" UPDATE tblcheckindtl a SET a.intNoOfFolios='"+objCheckInDtlBean.getIntNoOfFolios()+"' WHERE a.strCheckInNo='"+objBean.getStrCheckInNo()+"' AND a.strRoomNo='"+objCheckInDtlBean.getStrRoomNo()+"'";
					objWebPMSUtility.funExecuteUpdate(sql, "sql");
					}
				}
			
 				for (clsRoomPackageDtl objPkgDtlBean : objBean.getListRoomPackageDtl()) 
				{
 			
				    String strReservationNo="";
				    clsReservationHdModel objReservationModel = objReservationService.funGetReservationList(objBean.getStrAgainstDocNo(), clientCode, propCode);
					String sqlReservationNo= "SELECT strReservationNo from tblreservationroomratedtl WHERE strReservationNo='"+objReservationModel.getStrReservationNo()+"' ";	
					List listReservationNo  = objGlobalFunctionsService.funGetListModuleWise(sqlReservationNo, "sql");	
					if(listReservationNo.size()>0)
					{
						strReservationNo = listReservationNo.get(0).toString();
						String sqlroom="delete from tblreservationroomratedtl where strReservationNo='"+strReservationNo+"' ";							
					    objWebPMSUtility.funExecuteUpdate(sqlroom, "sql"); 		
					
					}
				    
				    String sqlPackage="	UPDATE tblroompackagedtl a SET a.dblIncomeHeadAmt='"+objPkgDtlBean.getDblIncomeHeadAmt()+"' WHERE a.strCheckInNo='"+objBean.getStrCheckInNo()+"' ";
					objWebPMSUtility.funExecuteUpdate(sqlPackage, "sql"); 																	
					String sqlFolioPackage=" UPDATE tblfoliodtl a SET a.dblDebitAmt='"+objPkgDtlBean.getDblIncomeHeadAmt()+"' WHERE a.strFolioNo='"+strFolioNo+"' and  a.strPerticulars='Package' ";
					objWebPMSUtility.funExecuteUpdate(sqlFolioPackage, "sql"); 
				}
				
 				String sqlCheckIn="	UPDATE tblcheckinhd a SET a.dteDepartureDate='"+objGlobal.funGetDate("yyyy-MM-dd", objBean.getDteDepartureDate())+"' WHERE a.strCheckInNo='"+objBean.getStrCheckInNo()+"' ";
				objWebPMSUtility.funExecuteUpdate(sqlCheckIn, "sql"); 
				req.getSession().setAttribute("WarningMsg", "checkin Departure Date  has been edited Successfully");
				req.getSession().setAttribute("editCheckInNo", objBean.getStrCheckInNo());
				req.getSession().setAttribute("editType",objBean.getStrType());
 				
 				}
			
			
			
			clsCheckInHdModel objHdModel = funPrepareHdModel(objBean, userCode, clientCode, req);
			funPostRoomTarrif(objHdModel.getStrCheckInNo(),clientCode,PMSDate,propCode,userCode);
			
			req.getSession().setAttribute("success", true);
			req.getSession().setAttribute("successMessage", "Check In No : ".concat(objHdModel.getStrCheckInNo()));
			req.getSession().setAttribute("AdvanceAmount", objHdModel.getStrCheckInNo());
			req.getSession().setAttribute("against", objHdModel.getStrType());
			req.getSession().setAttribute("reservationCode", objHdModel.getStrReservationNo());
			
	      
			return new ModelAndView("redirect:/frmCheckInEdit.html");
		} else {
			return new ModelAndView("frmCheckInEdit");
		}
	}

	
	private void funPostRoomTarrif(String strCheckInNo,String clientCode,String strpmsDate,String propCode,String userCode) 
	{
		String[] arrSpDate = strpmsDate.split("-");
		Date dtNextDate = new Date(Integer.parseInt(arrSpDate[0]), Integer.parseInt(arrSpDate[1]), Integer.parseInt(arrSpDate[2]));
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(dtNextDate);
		cal.add(Calendar.DATE, 1);
		String newStartDate = cal.getTime().getYear() + "-" + (cal.getTime().getMonth()) + "-" + (cal.getTime().getDate());
		List<String> listRoomTerrifDocNo = new ArrayList<String>();
		String strTransactionType = "Check In";
		String sqlPostRoom = "SELECT a.strFolioNo,a.strRoomNo,c.dblRoomTerrif,a.strExtraBedCode, "
				+ "IFNULL(a.strReservationNo,''), IFNULL(a.strWalkInNo,''),c.strRoomTypeCode, "
				+ "IFNULL(SUM(d.dblIncomeHeadAmt),0), IFNULL(e.strComplimentry,'N'),ifnull(d.strPackageCode,'') "
				+ "FROM tblfoliohd a LEFT OUTER JOIN tblroompackagedtl d ON a.strCheckInNo=d.strCheckInNo,"
				+ "tblroom b,tblroomtypemaster c,tblcheckinhd e WHERE a.strRoomNo=b.strRoomCode "
				+ "AND b.strRoomTypeCode=c.strRoomTypeCode AND a.strCheckInNo=e.strCheckInNo "
				+ "and e.strCheckInNo='"+strCheckInNo+"' AND a.strClientCode='"+clientCode+"'  AND b.strClientCode='"+clientCode+"' AND c.strClientCode='"+clientCode+"' AND e.strClientCode='"+clientCode+"' GROUP BY a.strFolioNo ";
		
		List listRoomInfo = objGlobalFunctionsService.funGetListModuleWise(sqlPostRoom, "sql");
		String strPackageInclusiveRoomTerrif="N";
		
		for (int cnt = 0; cnt < listRoomInfo.size(); cnt++) 
		{
			
			clsPostRoomTerrifBean objPostRoomTerrifBean = new clsPostRoomTerrifBean();
			Object[] arrObjRoom = (Object[]) listRoomInfo.get(cnt);
			double dblRoomRate=0.0;
			List listPackage = objGlobalFunctionsService.funGetListModuleWise("select a.strPackageCode,a.strPackageInclusiveRoomTerrif from tblpackagemasterhd "
					+ " a where a.strPackageCode='"+arrObjRoom[9].toString()+"' and a.strClientCode='"+clientCode+"' ", "sql");
			if(listPackage!=null && listPackage.size()>0 )
			{
				Object[] obj=(Object[])listPackage.get(0);
				strPackageInclusiveRoomTerrif=obj[1].toString();
			}
			
			if(!arrObjRoom[4].toString().equals(""))
			{
				 String sqlRoomRate=" select a.dblRoomRate from  tblreservationroomratedtl a "
					        +" where a.strReservationNo='"+arrObjRoom[4].toString()+"' and a.strClientCode='"+clientCode+"' and a.strRoomType='"+arrObjRoom[6].toString()+"' and a.dtDate='"+strpmsDate+"' ";
				 List listRoomRate = objGlobalFunctionsService.funGetListModuleWise(sqlRoomRate, "sql");
				 
				 	/*String sqlUpdateDepartureDate = "update tblcheckinhd a set a.dteDepartureDate='"+newStartDate+"' where a.strClientCode='"+clientCode+"' AND a.strReservationNo='"+arrObjRoom[4].toString()+"' ";
					objWebPMSUtility.funExecuteUpdate(sqlUpdateDepartureDate, "sql");*/ 

				 
				 if(listRoomRate.size()>0)
				 {
					 dblRoomRate=Double.parseDouble(listRoomRate.get(0).toString());
				 }
				 else
				 {
					  sqlRoomRate=" select a.dblRoomRate from  tblreservationroomratedtl a "
						        +" where a.strReservationNo='"+arrObjRoom[4].toString()+"' and a.strClientCode='"+clientCode+"' and a.strRoomType='"+arrObjRoom[6].toString()+"' order by date(a.dtDate) desc ";
					  listRoomRate = objGlobalFunctionsService.funGetListModuleWise(sqlRoomRate, "sql");
					 if(listRoomRate.size()>0)
					 {
						 dblRoomRate=Double.parseDouble(listRoomRate.get(0).toString());
					 }
				 }
			}
			if(!arrObjRoom[5].toString().equals(""))
			{
				String sqlRoomRate=" select a.dblRoomRate from  tblwalkinroomratedtl a "
					        +" where a.strWalkinNo='"+arrObjRoom[5].toString()+"' and a.strClientCode='"+clientCode+"' and a.strRoomType='"+arrObjRoom[6].toString()+"' and a.dtDate='"+strpmsDate+"' ";
				 List listRoomRate = objGlobalFunctionsService.funGetListModuleWise(sqlRoomRate, "sql");
				 
				 	/*String sqlUpdateDepartureDate = "update tblcheckinhd a set a.dteDepartureDate='"+newStartDate+"' where a.strClientCode='"+clientCode+"' AND a.strWalkInNo='"+arrObjRoom[5].toString()+"' ";
					objWebPMSUtility.funExecuteUpdate(sqlUpdateDepartureDate, "sql"); */

				 
				 if(listRoomRate.size()>0)
				 {
				    dblRoomRate=Double.parseDouble(listRoomRate.get(0).toString());
				 }
				 else
				 {
					sqlRoomRate=" select a.dblRoomRate from  tblwalkinroomratedtl a "
						        +" where a.strWalkinNo='"+arrObjRoom[5].toString()+"' and a.strClientCode='"+clientCode+"' and a.strRoomType='"+arrObjRoom[6].toString()+"'  order by date(a.dtDate) desc ";
					  listRoomRate = objGlobalFunctionsService.funGetListModuleWise(sqlRoomRate, "sql");
					 if(listRoomRate.size()>0)
					 {
					    dblRoomRate=Double.parseDouble(listRoomRate.get(0).toString());
					 }
				 }
			}
			objPostRoomTerrifBean = new clsPostRoomTerrifBean();
			objPostRoomTerrifBean.setStrFolioNo(arrObjRoom[0].toString());
			objPostRoomTerrifBean.setStrRoomNo(arrObjRoom[1].toString());
			if(arrObjRoom[8].toString().equals("Y"))
			{
				objPostRoomTerrifBean.setDblRoomTerrif(0.0);
				objPostRoomTerrifBean.setDblOriginalPostingAmt(0.0);
			}
			else
			{
				objPostRoomTerrifBean.setDblRoomTerrif(dblRoomRate);
				objPostRoomTerrifBean.setDblOriginalPostingAmt(dblRoomRate);
			}
			objPostRoomTerrifBean.setStrFolioType("Room");
			String folioNo = arrObjRoom[0].toString();
			if(Double.valueOf(arrObjRoom[7].toString())>0)
			{
				if(strPackageInclusiveRoomTerrif.equalsIgnoreCase("Y"))
				{
					String docNo = objPostRoomTerrif.funInsertFolioRecords(folioNo, clientCode, propCode, objPostRoomTerrifBean,  strpmsDate, arrObjRoom[3].toString(),strTransactionType,userCode);
					listRoomTerrifDocNo.add(docNo);
				}
			}
			else
			{
				
			    String docNo = objPostRoomTerrif.funInsertFolioRecords(folioNo, clientCode, propCode, objPostRoomTerrifBean,  strpmsDate, arrObjRoom[3].toString(),strTransactionType,userCode);
			    listRoomTerrifDocNo.add(docNo);
				
			}
			
			
			if(Double.valueOf(arrObjRoom[7].toString())>0)
			{   
				dblRoomRate=Double.valueOf(arrObjRoom[7].toString());
				objPostRoomTerrifBean = new clsPostRoomTerrifBean();
				objPostRoomTerrifBean.setStrFolioNo(arrObjRoom[0].toString());
				objPostRoomTerrifBean.setStrRoomNo(arrObjRoom[1].toString());
				objPostRoomTerrifBean.setDblRoomTerrif(dblRoomRate);
				objPostRoomTerrifBean.setDblOriginalPostingAmt(dblRoomRate);
				objPostRoomTerrifBean.setStrFolioType("Package");
				folioNo = arrObjRoom[0].toString();
				String docNo=objPostRoomTerrif.funInsertFolioRecords(folioNo, clientCode, propCode, objPostRoomTerrifBean,strpmsDate, arrObjRoom[3].toString(),strTransactionType,userCode);	
				listRoomTerrifDocNo.add(docNo);
			} 
			
			
			
		
		}
		
		
	}
	
//Convert bean to model function
	public clsCheckInHdModel funPrepareHdModel(clsCheckInBean objBean, String userCode, String clientCode, HttpServletRequest req) {

		// Insert or update Walkin HD Details
		clsCheckInHdModel objModel = new clsCheckInHdModel();

		String PMSDate = objGlobal.funGetDate("yyyy-MM-dd", req.getSession().getAttribute("PMSDate").toString());
		if (objBean.getStrRegistrationNo().isEmpty()) // New Entry
		{
			String transaDate = objGlobal.funGetCurrentDateTime("dd-MM-yyyy").split(" ")[0];
			String checkInNo = objGlobal.funGeneratePMSDocumentCode("frmCheckIn", transaDate, req);
			String regNo = objGlobal.funGeneratePMSDocumentCode("frmCheckInRegNo", transaDate, req);

			objModel.setStrCheckInNo(checkInNo);
			objModel.setStrRegistrationNo(regNo);
			objModel.setStrUserCreated(userCode);
			objModel.setDteDateCreated(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
		} else // Update
		{
			objModel.setStrCheckInNo(objBean.getStrCheckInNo());
			objModel.setStrRegistrationNo(objBean.getStrRegistrationNo());
		}

		objModel.setDteCheckInDate(PMSDate);
		objModel.setStrType(objBean.getStrType());
		if (objBean.getStrType().equals("Reservation")) {
			objModel.setStrReservationNo(objBean.getStrAgainstDocNo());
			objModel.setStrWalkInNo("");
		} else {
			objModel.setStrReservationNo("");
			objModel.setStrWalkInNo(objBean.getStrAgainstDocNo());
		}
		objModel.setDteArrivalDate(objGlobal.funGetDate("yyyy-MM-dd", objBean.getDteArrivalDate()));
		objModel.setDteDepartureDate(objGlobal.funGetDate("yyyy-MM-dd", objBean.getDteDepartureDate()));
		objModel.setTmeArrivalTime(objBean.getTmeArrivalTime());
		objModel.setTmeDepartureTime(objBean.getTmeDepartureTime());
		objModel.setStrUserEdited(userCode);
		objModel.setDteDateEdited(objGlobal.funGetCurrentDateTime("yyyy-MM-dd"));
		objModel.setStrClientCode(clientCode);
		objModel.setStrRoomNo("");
		
		objModel.setStrExtraBedCode(objGlobal.funIfNull(objBean.getStrExtraBedCode()," ",objBean.getStrExtraBedCode()));
		
		objModel.setStrComplimentry(objBean.getStrComplimentry());

		objModel.setIntNoOfAdults(objBean.getIntNoOfAdults());
		objModel.setIntNoOfChild(objBean.getIntNoOfChild());
		if(objBean.getStrReasonCode().equals(""))
		{
			objModel.setStrReasonCode("");
		}
		else
		{
			objModel.setStrReasonCode(objBean.getStrReasonCode());
		}
		if(objBean.getStrRemarks().equals(""))
		{
			objModel.setStrRemarks("");
		}
		else
		{
			objModel.setStrRemarks(objBean.getStrRemarks());
		}

		List<clsCheckInDtl> listCheckinDtlModel = new ArrayList<clsCheckInDtl>();
		if (objBean.getListCheckInDetailsBean().size() > 0) {
			for (clsCheckInDetailsBean objCheckinDetails : objBean.getListCheckInDetailsBean()) {
				clsCheckInDtl objClsCheckinDtlModel = new clsCheckInDtl();
				objClsCheckinDtlModel.setStrRegistrationNo(objModel.getStrRegistrationNo());
				objClsCheckinDtlModel.setStrGuestCode(objCheckinDetails.getStrGuestCode());
				objClsCheckinDtlModel.setStrRoomNo(objCheckinDetails.getStrRoomNo());
				//Below field is for roomwise Pax (As per Sachin Sir)
				objClsCheckinDtlModel.setIntNoOfFolios(objCheckinDetails.getIntNoOfFolios());
				objClsCheckinDtlModel.setStrExtraBedCode(objGlobal.funIfNull(objCheckinDetails.getStrExtraBedCode(), "", objCheckinDetails.getStrExtraBedCode()));
				System.out.println("PAYEE=" + objCheckinDetails.getStrPayee());
				if (objCheckinDetails.getStrPayee() != null) {
					objClsCheckinDtlModel.setStrPayee(objCheckinDetails.getStrPayee());
				} else {
					objClsCheckinDtlModel.setStrPayee("N");
				}
				objClsCheckinDtlModel.setStrRoomType(objCheckinDetails.getStrRoomType());
				/*
				 * if(objBean.getStrPayeeGuestCode().equals(objCheckinDetails.
				 * getStrGuestCode())) { objCheckinDetails.setStrPayee("Y");
				 * }else { objCheckinDetails.setStrPayee("N"); }
				 */

				listCheckinDtlModel.add(objClsCheckinDtlModel);
			}
		}
		objModel.setListCheckInDtl(listCheckinDtlModel);
		objModel.setStrNoPostFolio(objGlobal.funIfNull(objBean.getStrNoPostFolio(), "N", objBean.getStrNoPostFolio()));
		objModel.setStrComplimentry(objGlobal.funIfNull(objBean.getStrComplimentry(), "N",objBean.getStrComplimentry()));
		objModel.setStrDontApplyTax(objGlobal.funIfNull(objBean.getStrDontApplyTax(), "N", objBean.getStrDontApplyTax()));
     objModel.setStrPlanCode(objBean.getStrPlanCode());
     objModel.setStrAgentCode(objBean.getStrAgentCode());
		/*objModel.setStrRemarks("");
		objModel.setStrReasonCode("");*/
		

		
		return objModel;
	}
	
	@RequestMapping(value = "/loadCheckInEditData", method = RequestMethod.GET)
	public @ResponseBody clsCheckInBean funLoadHdData(HttpServletRequest request) {

		String sql = "";
		String clientCode = request.getSession().getAttribute("clientCode").toString();
		String userCode = request.getSession().getAttribute("usercode").toString();
		String propCode = request.getSession().getAttribute("propertyCode").toString();
		clsCheckInBean objBean = new clsCheckInBean();
		String docCode = request.getParameter("docCode").toString();
		clsCheckInHdModel objCheckIn = objCheckInService.funGetCheckInData(docCode, clientCode);
		objBean.setStrCheckInNo(objCheckIn.getStrCheckInNo());
		objBean.setStrRegistrationNo(objCheckIn.getStrRegistrationNo());
		objBean.setStrType(objCheckIn.getStrType());
		if (objCheckIn.getStrType().equals("Reservation")) {
			objBean.setStrAgainstDocNo(objCheckIn.getStrReservationNo());
		} else {
			objBean.setStrAgainstDocNo(objCheckIn.getStrWalkInNo());
		}
		objBean.setDteArrivalDate(objGlobal.funGetDate("yyyy/MM/dd", objCheckIn.getDteArrivalDate()));
		objBean.setDteDepartureDate(objGlobal.funGetDate("yyyy/MM/dd", objCheckIn.getDteDepartureDate()));
		objBean.setTmeArrivalTime(objCheckIn.getTmeArrivalTime());
		objBean.setTmeDepartureTime(objCheckIn.getTmeDepartureTime());
		objBean.setStrAgentCode(objCheckIn.getStrAgentCode());

		sql = "select a.strRoomDesc,b.strRoomTypeDesc from tblroom a,tblroomtypemaster b " + " where a.strRoomTypeCode=b.strRoomTypeCode and a.strRoomCode='" + objCheckIn.getStrRoomNo() + "' ";
		List listRoomData = objGlobalFunctionsService.funGetListModuleWise(sql, "sql");

		if (!listRoomData.isEmpty()) {
						
			Object[] arrObjRoomData = (Object[]) listRoomData.get(0);
			objBean.setStrRoomNo(objCheckIn.getStrRoomNo());
			objBean.setStrRoomDesc(arrObjRoomData[0].toString());
		} else {
			objBean.setStrRoomNo("");
			objBean.setStrRoomDesc("");
		}

		if (!objCheckIn.getStrExtraBedCode().equals("")) {
			List listExtraBedData = objExtraBedMasterDao.funGetExtraBedMaster(objCheckIn.getStrExtraBedCode(), clientCode);
			if(listExtraBedData!=null && !listExtraBedData.isEmpty() )
			{
			clsExtraBedMasterModel objExtraBedMasterModel = (clsExtraBedMasterModel) listExtraBedData.get(0);
			objBean.setStrExtraBedCode(objCheckIn.getStrExtraBedCode());
			objBean.setStrExtraBedDesc(objExtraBedMasterModel.getStrExtraBedTypeDesc());
			}
		} else {
			objBean.setStrExtraBedCode("");
			objBean.setStrExtraBedDesc("");
		}
		objBean.setIntNoOfAdults(objCheckIn.getIntNoOfAdults());
		objBean.setIntNoOfChild(objCheckIn.getIntNoOfChild());
		objBean.setStrNoPostFolio(objCheckIn.getStrNoPostFolio());
		objBean.setStrPlanCode(objCheckIn.getStrPlanCode());
		objBean.setStrAgentCode(objCheckIn.getStrAgentCode());
		
		List<clsCheckInDetailsBean> listCheckInDtlBean = new ArrayList<clsCheckInDetailsBean>();
		for (clsCheckInDtl objCheckInDtlModel : objCheckIn.getListCheckInDtl()) {
			clsCheckInDetailsBean objCheckInDtlBean = new clsCheckInDetailsBean();
			objCheckInDtlBean.setStrGuestCode(objCheckInDtlModel.getStrGuestCode());

			sql = "select strFirstName,strMiddleName,strLastName,lngMobileNo from tblguestmaster " + " where strGuestCode='" + objCheckInDtlModel.getStrGuestCode() + "' and strClientCode='" + clientCode + "' ";
			List listGuestMaster = objGlobalFunctionsService.funGetListModuleWise(sql, "sql");

			// listGuestMaster.forEach(obj-> {});

			for (int cnt = 0; cnt < listGuestMaster.size(); cnt++) {
				Object[] arrObjGuest = (Object[]) listGuestMaster.get(cnt);
				String guestName = arrObjGuest[0] + " " + arrObjGuest[1] + " " + arrObjGuest[2];
				objCheckInDtlBean.setStrGuestName(guestName);
				objCheckInDtlBean.setLngMobileNo(Long.parseLong(arrObjGuest[3].toString()));
			}
			
		/*	sql="select strAgentCode from tblcheckinhd " + " where  strCheckinNo='" + objCheckIn.getStrCheckInNo() + "'";
			 AgentCode= objGlobalFunctionsService.funGetListModuleWise(sql, "sql"); 
			
			 if(AgentCode.size()>0)
			 {
				 objCheckInDtlBean.setStrAgentCode(objCheckInDtlModel.getStrRoomNo());
			 }
			
			*/
			
			sql = "select a.strRoomDesc,b.strRoomTypeDesc,b.strRoomTypeCode from tblroom a,tblroomtypemaster b " + " where a.strRoomTypeCode=b.strRoomTypeCode and a.strRoomCode='" + objCheckInDtlModel.getStrRoomNo() + "' ";
			List listRoomData1 = objGlobalFunctionsService.funGetListModuleWise(sql, "sql");
			Object[] arrObjRoomData1 = (Object[]) listRoomData1.get(0);
			objCheckInDtlBean.setStrRoomNo(objCheckInDtlModel.getStrRoomNo());
			objCheckInDtlBean.setStrRoomDesc(arrObjRoomData1[0].toString());

			if (!objCheckInDtlModel.getStrExtraBedCode().equals("")) {
				List listExtraBedData = objExtraBedMasterDao.funGetExtraBedMaster(objCheckInDtlModel.getStrExtraBedCode(), clientCode);
				clsExtraBedMasterModel objExtraBedMasterModel = (clsExtraBedMasterModel) listExtraBedData.get(0);
				objCheckInDtlBean.setStrExtraBedCode(objCheckInDtlModel.getStrExtraBedCode());
				objCheckInDtlBean.setStrExtraBedDesc(objExtraBedMasterModel.getStrExtraBedTypeDesc());
			} else {
				objCheckInDtlBean.setStrExtraBedCode("");
				objCheckInDtlBean.setStrExtraBedDesc("");
			}
			objCheckInDtlBean.setStrPayee(objCheckInDtlModel.getStrPayee());
			objCheckInDtlBean.setStrRoomType(objCheckInDtlModel.getStrRoomType());
			listCheckInDtlBean.add(objCheckInDtlBean);
		}
		objBean.setListCheckInDetailsBean(listCheckInDtlBean);
		
		
		if (objCheckIn.getStrType().equals("Reservation")) 
		{
			clsReservationHdModel objReservationModel = objReservationService.funGetReservationList(objBean.getStrAgainstDocNo(), clientCode, propCode);
			objBean.setlistReservationRoomRateDtl(objReservationModel.getListReservationRoomRateDtl());
		}
		else
		{
			List listWalkinData = objWalkinDao.funGetWalkinDataDtl(objBean.getStrAgainstDocNo(), clientCode);
			clsWalkinHdModel objWalkinHdModel = (clsWalkinHdModel) listWalkinData.get(0);
			objBean.setListWalkinRoomRateDtl(objWalkinHdModel.getListWalkinRoomRateDtlModel());
		}
		objBean.setListRoomPackageDtl(objCheckInService.funGetCheckInIncomeList(docCode, clientCode));
		for (clsRoomPackageDtl objPkgDtlModel : objBean.getListRoomPackageDtl()) 
		{
			objBean.setStrPackageCode(objPkgDtlModel.getStrPackageCode());
			objBean.setStrPackageName(objPkgDtlModel.getStrPackageName());
			break;
		}

		return objBean;
	}

	
	}		
	

package com.sanguine.webpms.bean;

import java.io.Serializable;

public class clsPMSSalesFlashBean implements Serializable
{
	private String strExportType;
	private String dteFromDate;
	private String dteToDate;
	private String strSettlementDesc;
	private String dblSettlementAmt;
	private String strRevenueType;
	private double dblAmount;
	private double dblTaxAmount;
	private String strTaxDesc;
	private String dblTaxableAmt;
	private String dblTaxAmt;
	private String strReservationNo;
	private String dteReservationDate;
	private String strGuestName;
	private String dblReceiptAmt;
	private String dteArrivalDate;
	private String dteDepartureDate;
	private String strBookingType;
	private String strRoomType;
	private String dteCancelDate;
	private String strRoomDesc;
	private String strReasonDesc;
	private String strRemark;
	private String strNoOfRooms;
	private String strBillNo;
	private String dteBillDate;
	private String strCheckInNo;
	private String strPerticular;
	private String dblVoidDebitAmt;
	private String strVoidType;
	private String strVoidUser;
	private String dteCheckInDate;
	private String strArrivalTime;
	private String dblGrandTotal;
	
	private String strReceiptNo;
	private String dteReceiptDate;
	private String strType;
	private String strSettlement;
	private double dblAdvanceAmount;
	private double dblDiscount;
	private double dblGrndTotal;
	private String dteDatesForHousekeeping;
	
	private String strStaffName;
	private String strAssignedRooms;
	private String strCompletedRooms="";
	private String strPendingRooms="";
	private String strMonthName="";
	private int week=0;
	private String strReservationRoomNo;
	
	private String strGuestCode;
	
	private String strDocCode;
	
	private String strIncomeHeadNo;
	
	private String strIncomeHeadDesc;
	
	private String dteDocDate;
	
	private String strFolioNo;
	
	private String strUserEdited;
	
	private String dteDateEdited;
	
	private double dblQuantity;
	
	private String strRoomStatus;
	
	private String strOccupiedStatus;
	
	private String strGuestStatus;
	
	private String dblDepositAmount;
	
	
	public String getStrExportType() {
		return strExportType;
	}
	public void setStrExportType(String strExportType) {
		this.strExportType = strExportType;
	}
	public String getDteFromDate() {
		return dteFromDate;
	}
	public void setDteFromDate(String dteFromDate) {
		this.dteFromDate = dteFromDate;
	}
	public String getDteToDate() {
		return dteToDate;
	}
	public void setDteToDate(String dteToDate) {
		this.dteToDate = dteToDate;
	}
	public String getStrSettlementDesc() {
		return strSettlementDesc;
	}
	public void setStrSettlementDesc(String strSettlementDesc) {
		this.strSettlementDesc = strSettlementDesc;
	}
	public String getDblSettlementAmt() {
		return dblSettlementAmt;
	}
	public void setDblSettlementAmt(String dblSettlementAmt) {
		this.dblSettlementAmt = dblSettlementAmt;
	}
	public String getStrRevenueType() {
		return strRevenueType;
	}
	public void setStrRevenueType(String strRevenueType) {
		this.strRevenueType = strRevenueType;
	}
	public double getDblAmount() {
		return dblAmount;
	}
	public void setDblAmount(double dblAmount) {
		this.dblAmount = dblAmount;
	}
	
	public double getDblTaxAmount() {
		return dblTaxAmount;
	}
	public void setDblTaxAmount(double dblTaxAmount) {
		this.dblTaxAmount = dblTaxAmount;
	}
	public String getStrTaxDesc() {
		return strTaxDesc;
	}
	public void setStrTaxDesc(String strTaxDesc) {
		this.strTaxDesc = strTaxDesc;
	}
	public String getDblTaxableAmt() {
		return dblTaxableAmt;
	}
	public void setDblTaxableAmt(String dblTaxableAmt) {
		this.dblTaxableAmt = dblTaxableAmt;
	}
	public String getDblTaxAmt() {
		return dblTaxAmt;
	}
	public void setDblTaxAmt(String dblTaxAmt) {
		this.dblTaxAmt = dblTaxAmt;
	}
	public String getStrReservationNo() {
		return strReservationNo;
	}
	public void setStrReservationNo(String strReservationNo) {
		this.strReservationNo = strReservationNo;
	}
	public String getDteReservationDate() {
		return dteReservationDate;
	}
	public void setDteReservationDate(String dteReservationDate) {
		this.dteReservationDate = dteReservationDate;
	}
	public String getStrGuestName() {
		return strGuestName;
	}
	public void setStrGuestName(String strGuestName) {
		this.strGuestName = strGuestName;
	}
	public String getDblReceiptAmt() {
		return dblReceiptAmt;
	}
	public void setDblReceiptAmt(String dblReceiptAmt) {
		this.dblReceiptAmt = dblReceiptAmt;
	}
	public String getDteArrivalDate() {
		return dteArrivalDate;
	}
	public void setDteArrivalDate(String dteArrivalDate) {
		this.dteArrivalDate = dteArrivalDate;
	}
	public String getDteDepartureDate() {
		return dteDepartureDate;
	}
	public void setDteDepartureDate(String dteDepartureDate) {
		this.dteDepartureDate = dteDepartureDate;
	}
	public String getStrBookingType() {
		return strBookingType;
	}
	public void setStrBookingType(String strBookingType) {
		this.strBookingType = strBookingType;
	}
	public String getStrRoomType() {
		return strRoomType;
	}
	public void setStrRoomType(String strRoomType) {
		this.strRoomType = strRoomType;
	}
	public String getDteCancelDate() {
		return dteCancelDate;
	}
	public void setDteCancelDate(String dteCancelDate) {
		this.dteCancelDate = dteCancelDate;
	}
	public String getStrRoomDesc() {
		return strRoomDesc;
	}
	public void setStrRoomDesc(String strRoomDesc) {
		this.strRoomDesc = strRoomDesc;
	}
	public String getStrReasonDesc() {
		return strReasonDesc;
	}
	public void setStrReasonDesc(String strReasonDesc) {
		this.strReasonDesc = strReasonDesc;
	}
	public String getStrRemark() {
		return strRemark;
	}
	public void setStrRemark(String strRemark) {
		this.strRemark = strRemark;
	}
	public String getStrNoOfRooms() {
		return strNoOfRooms;
	}
	public void setStrNoOfRooms(String strNoOfRooms) {
		this.strNoOfRooms = strNoOfRooms;
	}
	public String getStrBillNo() {
		return strBillNo;
	}
	public void setStrBillNo(String strBillNo) {
		this.strBillNo = strBillNo;
	}
	public String getDteBillDate() {
		return dteBillDate;
	}
	public void setDteBillDate(String dteBillDate) {
		this.dteBillDate = dteBillDate;
	}
	public String getStrCheckInNo() {
		return strCheckInNo;
	}
	public void setStrCheckInNo(String strCheckInNo) {
		this.strCheckInNo = strCheckInNo;
	}
	public String getStrPerticular() {
		return strPerticular;
	}
	public void setStrPerticular(String strPerticular) {
		this.strPerticular = strPerticular;
	}
	public String getDblVoidDebitAmt() {
		return dblVoidDebitAmt;
	}
	public void setDblVoidDebitAmt(String dblVoidDebitAmt) {
		this.dblVoidDebitAmt = dblVoidDebitAmt;
	}
	public String getStrVoidType() {
		return strVoidType;
	}
	public void setStrVoidType(String strVoidType) {
		this.strVoidType = strVoidType;
	}
	public String getStrVoidUser() {
		return strVoidUser;
	}
	public void setStrVoidUser(String strVoidUser) {
		this.strVoidUser = strVoidUser;
	}
	public String getDteCheckInDate() {
		return dteCheckInDate;
	}
	public void setDteCheckInDate(String dteCheckInDate) {
		this.dteCheckInDate = dteCheckInDate;
	}

	public String getStrArrivalTime() {
		return strArrivalTime;
	}
	public void setStrArrivalTime(String strArrivalTime) {
		this.strArrivalTime = strArrivalTime;
	}
	public String getDblGrandTotal() {
		return dblGrandTotal;
	}
	public void setDblGrandTotal(String dblGrandTotal) {
		this.dblGrandTotal = dblGrandTotal;
	}
	public String getStrReceiptNo() {
		return strReceiptNo;
	}
	public void setStrReceiptNo(String strReceiptNo) {
		this.strReceiptNo = strReceiptNo;
	}
	public String getDteReceiptDate() {
		return dteReceiptDate;
	}
	public void setDteReceiptDate(String dteReceiptDate) {
		this.dteReceiptDate = dteReceiptDate;
	}
	
	public String getStrSettlement() {
		return strSettlement;
	}
	public void setStrSettlement(String strSettlement) {
		this.strSettlement = strSettlement;
	}
	public String getStrType() {
		return strType;
	}
	public void setStrType(String strType) {
		this.strType = strType;
	}
	public double getDblAdvanceAmount() {
		return dblAdvanceAmount;
	}
	public void setDblAdvanceAmount(double dblAdvanceAmount) {
		this.dblAdvanceAmount = dblAdvanceAmount;
	}
	public double getDblDiscount() {
		return dblDiscount;
	}
	public void setDblDiscount(double dblDiscount) {
		this.dblDiscount = dblDiscount;
	}
	public double getDblGrndTotal() {
		return dblGrndTotal;
	}
	public void setDblGrndTotal(double dblGrndTotal) {
		this.dblGrndTotal = dblGrndTotal;
	}
	public String getDteDatesForHousekeeping() {
		return dteDatesForHousekeeping;
	}
	public void setDteDatesForHousekeeping(String dteDatesForHousekeeping) {
		this.dteDatesForHousekeeping = dteDatesForHousekeeping;
	}
	public String getStrStaffName() {
		return strStaffName;
	}
	public void setStrStaffName(String strStaffName) {
		this.strStaffName = strStaffName;
	}
	public String getStrAssignedRooms() {
		return strAssignedRooms;
	}
	public void setStrAssignedRooms(String strAssignedRooms) {
		this.strAssignedRooms = strAssignedRooms;
	}
	public String getStrCompletedRooms() {
		return strCompletedRooms;
	}
	public void setStrCompletedRooms(String strCompletedRooms) {
		this.strCompletedRooms = strCompletedRooms;
	}
	public String getStrPendingRooms() {
		return strPendingRooms;
	}
	public void setStrPendingRooms(String strPendingRooms) {
		this.strPendingRooms = strPendingRooms;
	}
	public String getStrMonthName() {
		return strMonthName;
	}
	public void setStrMonthName(String strMonthName) {
		this.strMonthName = strMonthName;
	}
	public int getWeek() {
		return week;
	}
	public void setWeek(int week) {
		this.week = week;
	}
	public String getStrGuestCode() {
		return strGuestCode;
	}
	public void setStrGuestCode(String strGuestCode) {
		this.strGuestCode = strGuestCode;
	}
	public String getStrReservationRoomNo() {
		return strReservationRoomNo;
	}
	public void setStrReservationRoomNo(String strReservationRoomNo) {
		this.strReservationRoomNo = strReservationRoomNo;
	}
	public String getStrDocCode() {
		return strDocCode;
	}
	public void setStrDocCode(String strDocCode) {
		this.strDocCode = strDocCode;
	}
	public String getStrIncomeHeadNo() {
		return strIncomeHeadNo;
	}
	public void setStrIncomeHeadNo(String strIncomeHeadNo) {
		this.strIncomeHeadNo = strIncomeHeadNo;
	}
	public String getStrIncomeHeadDesc() {
		return strIncomeHeadDesc;
	}
	public void setStrIncomeHeadDesc(String strIncomeHeadDesc) {
		this.strIncomeHeadDesc = strIncomeHeadDesc;
	}
	public String getStrFolioNo() {
		return strFolioNo;
	}
	public void setStrFolioNo(String strFolioNo) {
		this.strFolioNo = strFolioNo;
	}
	public String getDteDocDate() {
		return dteDocDate;
	}
	public void setDteDocDate(String dteDocDate) {
		this.dteDocDate = dteDocDate;
	}
	public String getStrUserEdited() {
		return strUserEdited;
	}
	public void setStrUserEdited(String strUserEdited) {
		this.strUserEdited = strUserEdited;
	}
	public String getDteDateEdited() {
		return dteDateEdited;
	}
	public void setDteDateEdited(String dteDateEdited) {
		this.dteDateEdited = dteDateEdited;
	}
	public double getDblQuantity() {
		return dblQuantity;
	}
	public void setDblQuantity(double dblQuantity) {
		this.dblQuantity = dblQuantity;
	}
	public String getStrRoomStatus() {
		return strRoomStatus;
	}
	public void setStrRoomStatus(String strRoomStatus) {
		this.strRoomStatus = strRoomStatus;
	}
	public String getStrOccupiedStatus() {
		return strOccupiedStatus;
	}
	public void setStrOccupiedStatus(String strOccupiedStatus) {
		this.strOccupiedStatus = strOccupiedStatus;
	}
	public String getStrGuestStatus() {
		return strGuestStatus;
	}
	public void setStrGuestStatus(String strGuestStatus) {
		this.strGuestStatus = strGuestStatus;
	}
	public String getDblDepositAmount() {
		return dblDepositAmount;
	}
	public void setDblDepositAmount(String dblDepositAmount) {
		this.dblDepositAmount = dblDepositAmount;
	}
	
	
	
}

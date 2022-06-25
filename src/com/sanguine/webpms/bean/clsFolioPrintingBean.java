package com.sanguine.webpms.bean;

public class clsFolioPrintingBean {

	// variables
	private String strFolioNo;
	private String dteFromDate;
	private String dteToDate;

	private String dteDocDate;
	private String strDocNo;
	private String strPerticulars;
	private double dblDebitAmt;
	private double dblCreditAmt;
	private double dblBalanceAmt;
	private double dblQuantity;
	
	private boolean isTax;
	
	private String RoomNo; 
	private String GuestName; 
	private String RoomType; 
	private String CheckInDate; 
	private String CheckOutDate; 
	private String Pax; 
	private String Plan; 
	private double FinalAmt; 
    private String BookedBy ;

	
	// getters and setters
	
	
	public String getStrFolioNo() {
		return strFolioNo;
	}

	public void setStrFolioNo(String strFolioNo) {
		this.strFolioNo = strFolioNo;
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

	public String getDteDocDate() {
		return dteDocDate;
	}

	public void setDteDocDate(String dteDocDate) {
		this.dteDocDate = dteDocDate;
	}

	public String getStrDocNo() {
		return strDocNo;
	}

	public void setStrDocNo(String strDocNo) {
		this.strDocNo = strDocNo;
	}

	public String getStrPerticulars() {
		return strPerticulars;
	}

	public void setStrPerticulars(String strPerticulars) {
		this.strPerticulars = strPerticulars;
	}

	public double getDblDebitAmt() {
		return dblDebitAmt;
	}

	public void setDblDebitAmt(double dblDebitAmt) {
		this.dblDebitAmt = dblDebitAmt;
	}

	public double getDblCreditAmt() {
		return dblCreditAmt;
	}

	public void setDblCreditAmt(double dblCreditAmt) {
		this.dblCreditAmt = dblCreditAmt;
	}

	public double getDblBalanceAmt() {
		return dblBalanceAmt;
	}

	public void setDblBalanceAmt(double dblBalanceAmt) {
		this.dblBalanceAmt = dblBalanceAmt;
	}

	public double getDblQuantity() {
		return dblQuantity;
	}

	public void setDblQuantity(double dblQuantity) {
		this.dblQuantity = dblQuantity;
	}

	public boolean isTax() {
		return isTax;
	}

	public void setTax(boolean isTax) {
		this.isTax = isTax;
	}

	public String getRoomNo() {
		return RoomNo;
	}

	public void setRoomNo(String roomNo) {
		RoomNo = roomNo;
	}

	public String getGuestName() {
		return GuestName;
	}

	public void setGuestName(String guestName) {
		GuestName = guestName;
	}

	public String getRoomType() {
		return RoomType;
	}

	public void setRoomType(String roomType) {
		RoomType = roomType;
	}

	public String getCheckInDate() {
		return CheckInDate;
	}

	public void setCheckInDate(String checkInDate) {
		CheckInDate = checkInDate;
	}

	public String getCheckOutDate() {
		return CheckOutDate;
	}

	public void setCheckOutDate(String checkOutDate) {
		CheckOutDate = checkOutDate;
	}

	public String getPax() {
		return Pax;
	}

	public void setPax(String pax) {
		Pax = pax;
	}

	public String getPlan() {
		return Plan;
	}

	public void setPlan(String plan) {
		Plan = plan;
	}

	public double getFinalAmt() {
		return FinalAmt;
	}

	public void setFinalAmt(double finalAmt) {
		FinalAmt = finalAmt;
	}

	public String getBookedBy() {
		return BookedBy;
	}

	public void setBookedBy(String bookedBy) {
		BookedBy = bookedBy;
	}

}

package com.sanguine.bean;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

import com.sanguine.model.clsCloseOpenPOModel;
import com.sanguine.model.clsLocCustMasterModel;
import com.sanguine.model.clsPropertyMaster;
import com.sanguine.model.clsPurchaseOrderHdModel;
import com.sanguine.webpms.bean.clsVoidBillBean;
import com.sanguine.bean.clsPurchaseOrderDtlBean;



public class clsCloseOpenPOBean {
	
	private String strUserCreated, dtDateCreated;
		
	private String strClientCode;
	
	private long intId;
	
	private String dteFromDate;
	
	private String dteToDate;
	
    private String strLocCode;
    
	private String strLocName;
	
	private String strGRNCode;
	
    private String dtGRNDate;
    
    private String strSuppName;
    
    private String strAgainst;
    
    private double dblTotal;
    
    private String strPOCode;
    
	private String dtPODate;
	
	private String strSuppCode;
	
	private String strSOCode;
	
	private String propertyCode;
	
	private String strPOCodeisSelected;
	
	private List<clsPurchaseOrderDtlBean> listCloseOpenPODtl;
	
	
	public List<clsPurchaseOrderDtlBean> getListCloseOpenPODtl() {
		return listCloseOpenPODtl;
	}
	public void setListCloseOpenPODtl(
			List<clsPurchaseOrderDtlBean> listCloseOpenPODtl) {
		this.listCloseOpenPODtl = listCloseOpenPODtl;
	}
	public String getStrUserCreated() {
		return strUserCreated;
	}
	public void setStrUserCreated(String strUserCreated) {
		this.strUserCreated = strUserCreated;
	}
	
	public String getDtDateCreated() {
		return dtDateCreated;
	}
	public void setDtDateCreated(String dtDateCreated) {
		this.dtDateCreated = dtDateCreated;
	}

	public String getStrClientCode() {
		return strClientCode;
	}
	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}
	public long getIntId() {
		return intId;
	}
	public void setIntId(long intId) {
		this.intId = intId;
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
	public String getStrLocCode() {
		return strLocCode;
	}
	public void setStrLocCode(String strLocCode) {
		this.strLocCode = strLocCode;
	}
	public String getStrLocName() {
		return strLocName;
	}
	public void setStrLocName(String strLocName) {
		this.strLocName = strLocName;
	}
	public String getStrGRNCode() {
		return strGRNCode;
	}
	public void setStrGRNCode(String strGRNCode) {
		this.strGRNCode = strGRNCode;
	}
	public String getDtGRNDate() {
		return dtGRNDate;
	}
	public void setDtGRNDate(String dtGRNDate) {
		this.dtGRNDate = dtGRNDate;
	}
	public String getStrSuppName() {
		return strSuppName;
	}
	public void setStrSuppName(String strSuppName) {
		this.strSuppName = strSuppName;
	}
	public String getStrAgainst() {
		return strAgainst;
	}
	public void setStrAgainst(String strAgainst) {
		this.strAgainst = strAgainst;
	}
	public double getDblTotal() {
		return dblTotal;
	}
	public void setDblTotal(double dblTotal) {
		this.dblTotal = dblTotal;
	}
	public String getStrPOCode() {
		return strPOCode;
	}
	public void setStrPOCode(String strPOCode) {
		this.strPOCode = strPOCode;
	}
	public String getDtPODate() {
		return dtPODate;
	}
	public void setDtPODate(String dtPODate) {
		this.dtPODate = dtPODate;
	}
	public String getStrSuppCode() {
		return strSuppCode;
	}
	public void setStrSuppCode(String strSuppCode) {
		this.strSuppCode = strSuppCode;
	}
	public String getStrSOCode() {
		return strSOCode;
	}
	public void setStrSOCode(String strSOCode) {
		this.strSOCode = strSOCode;
	}
	public String getPropertyCode() {
		return propertyCode;
	}

	public void setPropertyCode(String propertyCode) {
		this.propertyCode = propertyCode;
	}
	public String getStrPOCodeisSelected() {
		return strPOCodeisSelected;
	}
	public void setStrPOCodeisSelected(String strPOCodeisSelected) {
		this.strPOCodeisSelected = strPOCodeisSelected;
	}
}

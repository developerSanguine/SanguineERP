package com.sanguine.webbanquets.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Table;

@Entity
@Table(name="tblbqquotationhd")
@IdClass(clsBanquetQuotationModel_ID.class)

public class clsBanquetQuotationModelHd implements Serializable{
	private static final long serialVersionUID = 1L;
	public clsBanquetQuotationModelHd(){}

	public clsBanquetQuotationModelHd(clsBanquetQuotationModel_ID objModelID){
		strQuotationNo = objModelID.getStrQuotationNo();
		strClientCode = objModelID.getStrClientCode();
	}
	
	@ElementCollection(fetch = FetchType.EAGER)
	@JoinTable(name = "tblbqquotationdtl", joinColumns = { @JoinColumn(name = "strClientCode"), @JoinColumn(name = "strQuotationNo") })
	@Id
	@AttributeOverrides({
		@AttributeOverride(name="strQuotationNo",column=@Column(name="strQuotationNo")),@AttributeOverride(name="strClientCode",column=@Column(name="strClientCode"))
	})
	private List<clsBanquetQuotationModelDtl> listBanquetQuotationDtlModels = new ArrayList<clsBanquetQuotationModelDtl>();
	
	/*@Id
	@AttributeOverrides({ @AttributeOverride(name = "strBillNo", column = @Column(name = "strBillNo")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })
	//private List<clsBillDtlModel> listBillDtlModels = new ArrayList<clsBillDtlModel>();
*/
//Variable Declaration
	@Column(name="strQuotationNo")
	private String strQuotationNo;

	@Column(name="strPropertyCode")
	private String strPropertyCode;

	@Column(name="dteQuotationDate")
	private String dteQuotationDate;

	@Column(name="dteFromDate")
	private String dteFromDate;

	@Column(name="dteToDate")
	private String dteToDate;
	

	@Column(name="tmeFromTime")
	private String tmeFromTime;

	@Column(name="tmeToTime")
	private String tmeToTime;

	@Column(name="strUserCreated")
	private String strUserCreated;

	@Column(name="strUserEdited")
	private String strUserEdited;

	@Column(name="dteDateCreated")
	private String dteDateCreated;

	@Column(name="dteDateEdited")
	private String dteDateEdited;

	@Column(name="strCustomerCode")
	private String strCustomerCode;

	@Column(name="strEmailID")
	private String strEmailID;

	@Column(name="intMinPaxNo")
	private long intMinPaxNo;

	@Column(name="intMaxPaxNo")
	private long intMaxPaxNo;

	@Column(name="strClientCode")
	private String strClientCode;

	@Column(name="strEventCoordinatorCode")
	private String strEventCoordinatorCode;

	@Column(name="strAreaCode")
	private String strAreaCode;

	@Column(name="strFunctionCode")
	private String strFunctionCode;
	
	@Column(name="strBillingInstructionCode")
	private String strBillingInstructionCode;
	
	@Column(name="strQuotationStatus")
	private String strQuotationStatus;
	
	
	@Column(name="dblSubTotal")
	private double dblSubTotal;

	@Column(name="dblDiscAmt")
	private double dblDiscAmt;
	
	@Column(name="dblTaxAmt")
	private double dblTaxAmt;
	
	@Column(name="dblGrandTotal")
	private double dblGrandTotal;
	
	@Column(name="strBanquetCode")
	private String strBanquetCode;

	//Setter-Getter Methods
	public String getStrQuotationNo(){
		return strQuotationNo;
	}
	public void setStrQuotationNo(String strQuotationNo){
		this. strQuotationNo = (String) setDefaultValue( strQuotationNo, "NA");
	}

	public String getStrPropertyCode(){
		return strPropertyCode;
	}
	public void setStrPropertyCode(String strPropertyCode){
		this. strPropertyCode = (String) setDefaultValue( strPropertyCode, "NA");
	}

	public String getDteQuotationDate(){
		return dteQuotationDate;
	}
	public void setDteQuotationDate(String dteQuotationDate){
		this.dteQuotationDate=dteQuotationDate;
	}

	
	public String getStrUserCreated(){
		return strUserCreated;
	}
	public void setStrUserCreated(String strUserCreated){
		this. strUserCreated = (String) setDefaultValue( strUserCreated, "NA");
	}

	public String getStrUserEdited(){
		return strUserEdited;
	}
	public void setStrUserEdited(String strUserEdited){
		this. strUserEdited = (String) setDefaultValue( strUserEdited, "NA");
	}

	public String getDteDateCreated(){
		return dteDateCreated;
	}
	public void setDteDateCreated(String dteDateCreated){
		this.dteDateCreated=dteDateCreated;
	}

	public String getDteDateEdited(){
		return dteDateEdited;
	}
	public void setDteDateEdited(String dteDateEdited){
		this.dteDateEdited=dteDateEdited;
	}

	public String getStrCustomerCode(){
		return strCustomerCode;
	}
	public void setStrCustomerCode(String strCustomerCode){
		this. strCustomerCode = (String) setDefaultValue( strCustomerCode, "NA");
	}

	public String getStrEmailID(){
		return strEmailID;
	}
	public void setStrEmailID(String strEmailID){
		this. strEmailID = (String) setDefaultValue( strEmailID, "NA");
	}

	public long getIntMinPaxNo(){
		return intMinPaxNo;
	}
	public void setIntMinPaxNo(long intMinPaxNo){
		this. intMinPaxNo = (Long) setDefaultValue( intMinPaxNo, "NA");
	}

	public long getIntMaxPaxNo(){
		return intMaxPaxNo;
	}
	public void setIntMaxPaxNo(long intMaxPaxNo){
		this. intMaxPaxNo = (Long) setDefaultValue( intMaxPaxNo, "NA");
	}

	public String getStrClientCode(){
		return strClientCode;
	}
	public void setStrClientCode(String strClientCode){
		this. strClientCode = (String) setDefaultValue( strClientCode, "NA");
	}

	public String getStrEventCoordinatorCode(){
		return strEventCoordinatorCode;
	}
	public void setStrEventCoordinatorCode(String strEventCoordinatorCode){
		this. strEventCoordinatorCode = (String) setDefaultValue( strEventCoordinatorCode, "NA");
	}

	public String getStrAreaCode(){
		return strAreaCode;
	}
	public void setStrAreaCode(String strAreaCode){
		this. strAreaCode = (String) setDefaultValue( strAreaCode, "NA");
	}

	public String getStrFunctionCode(){
		return strFunctionCode;
	}
	public void setStrFunctionCode(String strFunctionCode){
		this. strFunctionCode = (String) setDefaultValue( strFunctionCode, "NA");
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

	public String getTmeFromTime() {
		return tmeFromTime;
	}

	public void setTmeFromTime(String tmeFromTime) {
		this.tmeFromTime = tmeFromTime;
	}

	public String getTmeToTime() {
		return tmeToTime;
	}

	public void setTmeToTime(String tmeToTime) {
		this.tmeToTime = tmeToTime;
	}
    
	
   public String getStrBillingInstructionCode() {
		return strBillingInstructionCode;
	}

	public void setStrBillingInstructionCode(String strBillingInstructionCode) {
		this.strBillingInstructionCode = strBillingInstructionCode;
	}
	public String getStrQuotationStatus() {
		return strQuotationStatus;
	}

	public void setStrQuotationStatus(String strQuotationStatus) {
		this.strQuotationStatus = strQuotationStatus;
	}

	public List<clsBanquetQuotationModelDtl> getListBanquetQuotationDtlModels() {
		return listBanquetQuotationDtlModels;
	}

	public void setListBanquetQuotationDtlModels(
			List<clsBanquetQuotationModelDtl> listBanquetQuotationDtlModels) {
		this.listBanquetQuotationDtlModels = listBanquetQuotationDtlModels;
	}
	public double getDblSubTotal() {
		return dblSubTotal;
	}

	public void setDblSubTotal(double dblSubTotal) {
		this.dblSubTotal = dblSubTotal;
	}

	public double getDblDiscAmt() {
		return dblDiscAmt;
	}

	public void setDblDiscAmt(double dblDiscAmt) {
		this.dblDiscAmt = dblDiscAmt;
	}

	public double getDblTaxAmt() {
		return dblTaxAmt;
	}

	public void setDblTaxAmt(double dblTaxAmt) {
		this.dblTaxAmt = dblTaxAmt;
	}

	public double getDblGrandTotal() {
		return dblGrandTotal;
	}

	public void setDblGrandTotal(double dblGrandTotal) {
		this.dblGrandTotal = dblGrandTotal;
	}
	

	//Function to Set Default Values
	private Object setDefaultValue(Object value, Object defaultValue){
		if(value !=null && (value instanceof String && value.toString().length()>0)){
			return value;
		}
		else if(value !=null && (value instanceof Double && value.toString().length()>0)){
			return value;
		}
		else if(value !=null && (value instanceof Integer && value.toString().length()>0)){
			return value;
		}
		else if(value !=null && (value instanceof Long && value.toString().length()>0)){
			return value;
		}
		else{
			return defaultValue;
		}
	}

	public String getStrBanquetCode() {
		return strBanquetCode;
	}

	public void setStrBanquetCode(String strBanquetCode) {
		this.strBanquetCode = strBanquetCode;
	}

}

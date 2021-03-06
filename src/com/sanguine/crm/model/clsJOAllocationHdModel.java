package com.sanguine.crm.model;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table(name = "tbljoborderallocationhd")
@IdClass(clsJOAllocationHdModel_ID.class)
public class clsJOAllocationHdModel implements Serializable {
	private static final long serialVersionUID = 1L;

	public clsJOAllocationHdModel() {
	}

	public clsJOAllocationHdModel(clsJOAllocationHdModel_ID objModelID) {
		strJACode = objModelID.getStrJACode();
		strClientCode = objModelID.getStrClientCode();
	}

	@Id
	@AttributeOverrides({ @AttributeOverride(name = "strJACode", column = @Column(name = "strJACode")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })
	// Variable Declaration
	@Column(name = "strJACode")
	private String strJACode;

	@Column(name = "intId")
	private Long intId;

	@Column(name = "strJANo")
	private String strJANo;

	@Column(name = "strSCCode")
	private String strSCCode;

	@Column(name = "dteJADate")
	private String dteJADate;

	@Column(name = "strRef")
	private String strRef;

	@Column(name = "dteRefDate")
	private String dteRefDate;

	@Column(name = "strDispatchMode")
	private String strDispatchMode;

	@Column(name = "strPayment")
	private String strPayment;

	@Column(name = "strTaxes")
	private String strTaxes;

	@Column(name = "strAuthorise")
	private String strAuthorise;

	@Column(name = "dbltotQty")
	private Double dbltotQty;

	@Column(name = "strUserCreated")
	private String strUserCreated;

	@Column(name = "dteDateCreated")
	private String dteDateCreated;

	@Column(name = "strUserModified")
	private String strUserModified;

	@Column(name = "dteLastModified")
	private String dteLastModified;

	@Column(name = "strClientCode")
	private String strClientCode;

	// Setter-Getter Methods

	public String getStrJACode() {
		return strJACode;
	}

	public void setStrJACode(String strJACode) {
		this.strJACode = strJACode;
	}

	public Long getIntId() {
		return intId;
	}

	public void setIntId(Long intId) {
		this.intId = intId;
	}

	public String getStrJANo() {
		return strJANo;
	}

	public void setStrJANo(String strJANo) {
		this.strJANo = strJANo;
	}

	public String getStrSCCode() {
		return strSCCode;
	}

	public void setStrSCCode(String strSCCode) {
		this.strSCCode = strSCCode;
	}

	public String getDteJADate() {
		return dteJADate;
	}

	public void setDteJADate(String dteJADate) {
		this.dteJADate = dteJADate;
	}

	public String getStrRef() {
		return strRef;
	}

	public void setStrRef(String strRef) {
		this.strRef = strRef;
	}

	public String getDteRefDate() {
		return dteRefDate;
	}

	public void setDteRefDate(String dteRefDate) {
		this.dteRefDate = dteRefDate;
	}

	public String getStrDispatchMode() {
		return strDispatchMode;
	}

	public void setStrDispatchMode(String strDispatchMode) {
		this.strDispatchMode = strDispatchMode;
	}

	public String getStrPayment() {
		return strPayment;
	}

	public void setStrPayment(String strPayment) {
		this.strPayment = strPayment;
	}

	public String getStrTaxes() {
		return strTaxes;
	}

	public void setStrTaxes(String strTaxes) {
		this.strTaxes = strTaxes;
	}

	public String getStrAuthorise() {
		return strAuthorise;
	}

	public void setStrAuthorise(String strAuthorise) {
		this.strAuthorise = strAuthorise;
	}

	public Double getDbltotQty() {
		return dbltotQty;
	}

	public void setDbltotQty(Double dbltotQty) {
		this.dbltotQty = dbltotQty;
	}

	public String getStrUserCreated() {
		return strUserCreated;
	}

	public void setStrUserCreated(String strUserCreated) {
		this.strUserCreated = strUserCreated;
	}

	public String getDteDateCreated() {
		return dteDateCreated;
	}

	public void setDteDateCreated(String dteDateCreated) {
		this.dteDateCreated = dteDateCreated;
	}

	public String getStrUserModified() {
		return strUserModified;
	}

	public void setStrUserModified(String strUserModified) {
		this.strUserModified = strUserModified;
	}

	public String getDteLastModified() {
		return dteLastModified;
	}

	public void setDteLastModified(String dteLastModified) {
		this.dteLastModified = dteLastModified;
	}

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

}

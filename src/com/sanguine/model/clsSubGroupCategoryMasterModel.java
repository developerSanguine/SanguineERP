package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;


@Entity
@Table(name = "tblsubgroupcategorymaster")
@IdClass(clsSubGroupCategoryMasterModel_ID.class)
public class clsSubGroupCategoryMasterModel implements Serializable {
	private static final long serialVersionUID = 1L;

	public clsSubGroupCategoryMasterModel() {
	}

	public clsSubGroupCategoryMasterModel(clsSubGroupCategoryMasterModel_ID clsSubGroupCategoryMasterModel_ID) {
		strSGCCode = clsSubGroupCategoryMasterModel_ID.getStrSGCCode();
		strClientCode = clsSubGroupCategoryMasterModel_ID.getStrClientCode();
	}

	@Id
	@AttributeOverrides({ @AttributeOverride(name = "strSGCCode", column = @Column(name = "strSGCCode")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })
	@Column(name = "strSGCCode")
	private String strSGCCode;

	@Column(name = "strSGCode")
	private String strSGCode;

	@Column(name = "strSGCName")
	private String strSGCName;

	@Column(name = "strSGCDesc")
	private String strSGCDesc;

	@Column(name = "strUserCreated", nullable = false, updatable = false)
	private String strUserCreated;

	@Column(name = "strUserModified")
	private String strUserModified;

	@Column(name = "dtCreatedDate", nullable = false, updatable = false)
	private String dtCreatedDate;

	@Column(name = "dtLastModified")
	private String dtLastModified;

	@Column(name = "strClientCode", nullable = false, updatable = false)
	private String strClientCode;

	@Column(name = "intSGCId", nullable = false, updatable = false)
	private long intSGCId;

	

	public String getStrSGCode() {
		return strSGCode;
	}

	public void setStrSGCode(String strSGCode) {
		this.strSGCode = strSGCode;
	}

	
	public String getStrUserCreated() {
		return strUserCreated;
	}

	public void setStrUserCreated(String strUserCreated) {
		this.strUserCreated = strUserCreated;
	}

	public String getStrUserModified() {
		return strUserModified;
	}

	public void setStrUserModified(String strUserModified) {
		this.strUserModified = strUserModified;
	}

	public String getDtCreatedDate() {
		return dtCreatedDate;
	}

	public void setDtCreatedDate(String dtCreatedDate) {
		this.dtCreatedDate = dtCreatedDate;
	}

	public String getDtLastModified() {
		return dtLastModified;
	}

	public void setDtLastModified(String dtLastModified) {
		this.dtLastModified = dtLastModified;
	}

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	public String getStrSGCCode() {
		return strSGCCode;
	}

	public void setStrSGCCode(String strSGCCode) {
		this.strSGCCode = strSGCCode;
	}

	public String getStrSGCName() {
		return strSGCName;
	}

	public void setStrSGCName(String strSGCName) {
		this.strSGCName = strSGCName;
	}

	public String getStrSGCDesc() {
		return strSGCDesc;
	}

	public void setStrSGCDesc(String strSGCDesc) {
		this.strSGCDesc = strSGCDesc;
	}

	public long getIntSGCId() {
		return intSGCId;
	}

	public void setIntSGCId(long intSGCId) {
		this.intSGCId = intSGCId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

}
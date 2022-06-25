package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "tblpurchaseorderhd")
@IdClass(clsCloseOpenPOModel_ID.class)
public class clsCloseOpenPOModel implements Serializable {
	private static final long serialVersionUID = 1L;

	public clsCloseOpenPOModel() {
	}

	public clsCloseOpenPOModel(clsCloseOpenPOModel_ID clsCloseOpenPOModel_ID) {
		strLocCode = clsCloseOpenPOModel_ID.getStrLocCode();
		strClientCode = clsCloseOpenPOModel_ID.getStrClientCode();
	}

	@Id
	@AttributeOverrides({ @AttributeOverride(name = "strLocCode", column = @Column(name = "strLocCode")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })
	
	@Column(name = "strLocCode")
	private String strLocCode;

	@Column(name = "strLocName", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String strLocName;

	@Column(name = "strLocDesc", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String strLocDesc;

	@Column(name = "strUserCreated", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String strUserCreated;

	@Column(name = "strUserModified", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String strUserModified;

	@Column(name = "dtCreatedDate", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String dtCreatedDate;

	@Column(name = "dtLastModified", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String dtLastModified;

	@Column(name = "strClientCode", columnDefinition = "VARCHAR(255) NOT NULL default ''")
	private String strClientCode;

	@Column(name = "intid", nullable = false, updatable = false)
	private long intId;

	
	
	
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

	public String getStrLocDesc() {
		return strLocDesc;
	}

	public void setStrLocDesc(String strLocDesc) {
		this.strLocDesc = strLocDesc;
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

	public long getIntid() {
		return intId;
	}

	public void setIntid(long intId) {
		this.intId = intId;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}

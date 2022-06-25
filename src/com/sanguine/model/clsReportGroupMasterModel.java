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
@Table(name = "tblreportinggroup")
@IdClass(clsReportGroupMaster_ID.class)
public class clsReportGroupMasterModel implements Serializable {
	private static final long serialVersionUID = 1L;
	

	public clsReportGroupMasterModel() {
	}

	public clsReportGroupMasterModel(clsReportGroupMaster_ID clsReportGroupMaster_ID) {
	
		strClientCode = clsReportGroupMaster_ID.getStrClientCode();
		strReportGroupCode= clsReportGroupMaster_ID.getStrReportGroupCode();
	}


	
	@Id
	@AttributeOverrides({ @AttributeOverride(name = "strReportGroupCode", column = @Column(name = "strReportGroupCode")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })
	@Column(name = "strReportGroupCode")
	private String strReportGroupCode;

	@Column(name = "strReportGroupName")
	private String strReportGroupName;
	
	@Column(name = "strPropertyCode")
	private String strPropertyCode;
	
	
    @Column(name = "strClientCode")
	private String strClientCode;
	
	@Column(name = "intRGId", updatable = false)
	private long intRGId;


	public String getStrReportGroupCode() {
		return strReportGroupCode;
	}

	public void setStrReportGroupCode(String strReportGroupCode) {
		this.strReportGroupCode = strReportGroupCode;
	}

	public String getStrReportGroupName() {
		return strReportGroupName;
	}

	public void setStrReportGroupName(String strReportGroupName) {
		this.strReportGroupName = strReportGroupName;
	}

	public String getStrPropertyCode() {
		return strPropertyCode;
	}

	public void setStrPropertyCode(String strPropertyCode) {
		this.strPropertyCode = strPropertyCode;
	}

	
	
	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public long getintRGId() {
		return intRGId;
	}

	public void setintRGId(long intRGId) {
		this.intRGId = intRGId;
	}

	
	

	
}








	

	

	
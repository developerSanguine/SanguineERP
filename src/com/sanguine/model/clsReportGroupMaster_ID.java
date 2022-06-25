package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
@SuppressWarnings("serial")
public class clsReportGroupMaster_ID implements Serializable {

	private String strClientCode;
	private String strReportGroupCode;

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	public String getStrReportGroupCode() {
		return strReportGroupCode;
	}

	public void setStrReportGroupCode(String strReportGroupCode) {
		this.strReportGroupCode = strReportGroupCode;
	}

	public clsReportGroupMaster_ID() {
	}

	public clsReportGroupMaster_ID(String strClientCode, String strReportGroupCode) {
	
		this.strClientCode = strClientCode;
	    this.strReportGroupCode = strReportGroupCode ;
		
		
	}


/*	@Override
	public boolean equals(Object obj) {
		clsReportGroupMaster_ID cp = (clsReportGroupMaster_ID) obj;
		if (this.strPropertyCode.equals(cp.getPropertyCode()) && this.strClientCode.equals(cp.getStrClientCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strPropertyCode.hashCode() + this.strClientCode.hashCode();
	}
*/
	
	
	
	/*public boolean equals1(Object obj) {
		clsReportGroupMaster_ID cp1 = (clsReportGroupMaster_ID) obj;
		if (this.strGCode.equals(cp1.getGroupCode()) && this.strClientCode.equals(cp1.getStrClientCode())) {
			return true;
		} else {
			return false;
		}
	}*/

	public int hashCode1() {
		return this.strReportGroupCode.hashCode() + this.strClientCode.hashCode();
	}


}

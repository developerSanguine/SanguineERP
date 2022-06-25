package com.sanguine.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class clsLocCustMasterModel_ID implements Serializable {
	private String strCustCode;
	private String strLocCode;
	

	private String strClientCode;

	public clsLocCustMasterModel_ID() {
	}

	public clsLocCustMasterModel_ID(String strCustCode, String strLocCode, String strClientCode) {
		this.strCustCode = strCustCode;
		this.strLocCode = strLocCode;
		this.strClientCode = strClientCode;
	}

	
	public String getStrCustCode() {
		return strCustCode;
	}

	public void setStrCustCode(String strCustCode) {
		this.strCustCode = strCustCode;
	}

	public String getStrLocCode() {
		return strLocCode;
	}

	public void setStrLocCode(String strLocCode) {
		this.strLocCode = strLocCode;
	}
	
	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	@Override
	public boolean equals(Object obj) {
		clsLocCustMasterModel_ID cp = (clsLocCustMasterModel_ID) obj;
		if (this.strCustCode.equals(cp.getStrCustCode()) && this.strLocCode.equals(cp.strLocCode) && this.strClientCode.equals(cp.getStrClientCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strCustCode.hashCode() + this.strLocCode.hashCode() + this.strClientCode.hashCode();
	}

}

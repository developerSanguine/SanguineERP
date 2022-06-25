package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@SuppressWarnings("serial")
@Embeddable
public class clsSubGroupCategoryMasterModel_ID implements Serializable {

	private String strSGCCode;
	private String strClientCode;

	public clsSubGroupCategoryMasterModel_ID(String strSGCCode, String strClientCode) {
		this.strSGCCode = strSGCCode;
		this.strClientCode = strClientCode;

	}

	public clsSubGroupCategoryMasterModel_ID() {

	}

	public String getStrSGCCode() {
		return strSGCCode;
	}

	public void setStrSGCCode(String strSGCCode) {
		this.strSGCCode = strSGCCode;
	}

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	@Override
	public boolean equals(Object obj) {
		clsSubGroupCategoryMasterModel_ID cp = (clsSubGroupCategoryMasterModel_ID) obj;
		if (this.strSGCCode.equals(cp.getStrSGCCode()) && this.strClientCode.equals(cp.getStrClientCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strSGCCode.hashCode() + this.strClientCode.hashCode();
	}

}

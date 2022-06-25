package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
@SuppressWarnings("serial")
public class clsAllProductModel_ID implements Serializable {

	private String strClientCode;
	private String strProdCode;

	public clsAllProductModel_ID() {
	}

	public clsAllProductModel_ID(String strClientCode, String strProdCode) {
	
		this.strClientCode = strClientCode;
		this.strProdCode = strProdCode;
	}

	

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	public String getStrProdCode() {
		return strProdCode;
	}

	public void setStrProdCode(String strProdCode) {
		this.strProdCode = strProdCode;
	}

	@Override
	public boolean equals(Object obj) {
		clsAllProductModel_ID cp = (clsAllProductModel_ID) obj;
		if (this.strClientCode.equals(cp.getStrClientCode()) && this.strProdCode.equals(cp.getStrProdCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strClientCode.hashCode() + this.strProdCode.hashCode();
	}
}

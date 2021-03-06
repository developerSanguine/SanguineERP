package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
@SuppressWarnings("serial")
public class clsCloseOpenPOModel_ID implements Serializable {
	private String strLocCode;
	private String strClientCode;

	public clsCloseOpenPOModel_ID() {
	};

	public clsCloseOpenPOModel_ID(String strLocCode, String strClientCode) {
		this.strLocCode = strLocCode;
		this.strClientCode = strClientCode;
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
		clsCloseOpenPOModel_ID cp = (clsCloseOpenPOModel_ID) obj;
		if (this.strLocCode.equals(cp.getStrLocCode()) && this.strClientCode.equals(cp.getStrClientCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strLocCode.hashCode() + this.strClientCode.hashCode();
	}

}
